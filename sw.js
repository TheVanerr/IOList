/* IO Listesi - Service Worker
   Amac: PWA kurulabilirligi + uygulama kabugunun offline acilmasi.
   ONEMLI: Supabase API istekleri ASLA cache'lenmez (her zaman canli veri). */

const VERSION = 'io-listesi-v1';
const APP_SHELL = 'app-shell-' + VERSION;
const RUNTIME = 'runtime-' + VERSION;

// Ayni klasordeki temel dosyalar (GitHub Pages alt yolu ./ ile calisir)
const SHELL_ASSETS = [
  './',
  'index.html',
  'io.html',
  'manifest.webmanifest',
  'icons/icon-192.png',
  'icons/icon-512.png',
  'icons/apple-touch-icon.png',
  'icons/favicon-32.png'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(APP_SHELL).then((cache) =>
      // Tek tek ekle; biri 404 olsa bile kurulum patlamasin
      Promise.allSettled(SHELL_ASSETS.map((url) => cache.add(url)))
    ).then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys
          .filter((k) => k !== APP_SHELL && k !== RUNTIME)
          .map((k) => caches.delete(k))
      )
    ).then(() => self.clients.claim())
  );
});

self.addEventListener('message', (event) => {
  if (event.data === 'SKIP_WAITING') self.skipWaiting();
});

function isSupabase(url) {
  return url.hostname.endsWith('.supabase.co');
}

self.addEventListener('fetch', (event) => {
  const req = event.request;

  // Sadece GET; POST/PATCH/DELETE dokunma
  if (req.method !== 'GET') return;

  const url = new URL(req.url);

  // Supabase (veri, auth, storage) -> her zaman ag, cache yok
  if (isSupabase(url)) return;

  // Sayfa gezinmeleri -> once ag, offline'da cache'e dus
  if (req.mode === 'navigate') {
    event.respondWith(
      fetch(req)
        .then((res) => {
          const copy = res.clone();
          caches.open(APP_SHELL).then((c) => c.put(req, copy)).catch(() => {});
          return res;
        })
        .catch(() =>
          caches.match(req).then((r) => r || caches.match('io.html'))
        )
    );
    return;
  }

  // Ayni origin statik dosyalar -> cache-first
  if (url.origin === self.location.origin) {
    event.respondWith(
      caches.match(req).then((cached) => {
        if (cached) return cached;
        return fetch(req).then((res) => {
          const copy = res.clone();
          caches.open(RUNTIME).then((c) => c.put(req, copy)).catch(() => {});
          return res;
        });
      })
    );
    return;
  }

  // CDN / fontlar (cross-origin GET) -> stale-while-revalidate
  event.respondWith(
    caches.match(req).then((cached) => {
      const network = fetch(req)
        .then((res) => {
          if (res && (res.ok || res.type === 'opaque')) {
            const copy = res.clone();
            caches.open(RUNTIME).then((c) => c.put(req, copy)).catch(() => {});
          }
          return res;
        })
        .catch(() => cached);
      return cached || network;
    })
  );
});
