# Pano 2D Yerleşim Çizimleri

**Amaç:** DIN ray üzerinde komponentlerin **ön görünüş ayak izini** teknik çizim olarak kullanmak.

## Ölçek

- **1:1 mm** — `viewBox="0 0 W H"` ve `width="Wmm" height="Hmm"`
- 1 SVG birimi = 1 mm (datasheet ön yüz W×H)
- Boyut metadata: `data-width-mm` / `data-height-mm`

## Teknik çizim kuralları

- **Şeffaf zemin** — arka plan rengi yok
- **Sınır dışı öğe yok** — alt başlık, ölçü yazısı, kılavuz çizgisi yok
- `viewBox` = tam ayak izi; CAD/layout'a doğrudan yerleştirilebilir

## Dosyalar

| Dosya | Seri | Ayak izi (G×Y mm) |
|---|---|---|
| `mks/schneider-gv2me.svg` | GV2ME MKŞ | 45 × 89 |
| `mks/siemens-3rv2.svg` | 3RV2 MKŞ | 45 × 97 |
| `kontaktor/schneider-lc1k.svg` | TeSys K | 45 × 58 |
| `kontaktor/schneider-lc1d-09-18.svg` | TeSys D (küçük) | 45 × 77 |
| `kontaktor/schneider-lc1d-25-32.svg` | TeSys D (büyük) | 45 × 85 |
| `kontaktor/siemens-3rt2-s00.svg` | 3RT2 S00 | 45 × 58 |
| `kontaktor/siemens-3rt2-s0.svg` | 3RT2 S0 | 45 × 85 |
| `sigorta/schneider-a9f741.svg` | Acti9 iC60N **1P** | 18 × 85 |
| `sigorta/schneider-a9f742.svg` | Acti9 iC60N **2P** | 36 × 85 |
| `sigorta/schneider-a9f743.svg` | Acti9 iC60N **3P** | 54 × 85 |
| `sigorta/schneider-a9r414.svg` | Acti9 iID **4P RCCB** | 72 × 91 |
| `invertor/delta-vfd-el21w-a1.svg` | Delta VFD-EL-W Frame A1 | 92 × 162 |

Model eşlemesi: `index.json`

## Yeniden üret

```bash
python drawings/generate_drawings.py
```
