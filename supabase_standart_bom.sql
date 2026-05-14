-- ============================================================
-- Standart Makine BOM Tablosu
-- Supabase SQL Editor'da çalıştır
-- ============================================================

CREATE TABLE IF NOT EXISTS standart_bom (
  id         bigserial PRIMARY KEY,
  model      text NOT NULL,           -- örn: "PYT 40"
  grup       text NOT NULL,           -- örn: "SİGORTA GRUBU"
  stok_kodu  text NOT NULL,           -- örn: "10 04703"
  urun_adi   text NOT NULL,
  adet       integer NOT NULL DEFAULT 1,
  sira       integer NOT NULL DEFAULT 0  -- tablodaki görünüm sırası
);

-- Model + sıra indeksi (hızlı çekim için)
CREATE INDEX IF NOT EXISTS idx_standart_bom_model ON standart_bom (model, sira);

-- Row Level Security: herkes okuyabilir, sadece admin yazabilir
ALTER TABLE standart_bom ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public read standart_bom"
  ON standart_bom FOR SELECT
  USING (true);

CREATE POLICY "admin write standart_bom"
  ON standart_bom FOR ALL
  USING (
    auth.email() IN ('fatihgural80@gmail.com', 'tuncaycinici@gmail.com')
  );

-- ============================================================
-- Mevcut verileri aktar (standart.json içeriğinden)
-- ============================================================

INSERT INTO standart_bom (model, grup, stok_kodu, urun_adi, adet, sira) VALUES
-- PYT 40
('PYT 40', 'SİGORTA GRUBU',           '10 04703', 'PAKO ŞALTER PSA025AK331S 3*25',             1,  1),
('PYT 40', 'SİGORTA GRUBU',           '10 16894', 'SİGORTA KAÇAK AKIMLI A9R41225 2''Li 30MA',  1,  2),
('PYT 40', 'SİGORTA GRUBU',           '10 00302', 'SİGORTA A9F74103 1*3',                      1,  3),
('PYT 40', 'RÖLE GRUBU',              '10 00294', 'MİNYATÜR RÖLE RXM4AB1P7 220V',              2,  4),
('PYT 40', 'RÖLE GRUBU',              '10 01398', 'MİNYATÜR RÖLE RXM4AB1BD 24V 16 PİNLİ',     1,  5),
('PYT 40', 'RÖLE GRUBU',              '10 00295', 'RÖLE SOKETİ RXZE2M114M',                    3,  6),
('PYT 40', 'KONTAK GRUBU',            '10 02314', 'KONTAKTÖR LC1K0610M7 220V',                 1,  7),
('PYT 40', 'KONTAK GRUBU',            '10 01332', 'KONTAKTÖR LC1K1610M7 220V',                 1,  8),
('PYT 40', 'GÜÇ KONTROL GRUBU',       '10 02491', 'GÜÇ KAYNAĞI MDR 20/24',                    1,  9),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 00266', 'BUTON İKİZ LAMBALI B102K20KY',              1, 10),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 00273', 'BUTON START B100DY',                        1, 11),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 03445', 'BUTON ACİL STOP MANTAR B200EE',             1, 12),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 00237', 'TERMOSTAT DİJİTAL DT 481 GEMO',             1, 13),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 10465', 'ZAMAN ROLESİ DZ 482 DİJİTAL GEMO',         1, 14),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 00263', 'BUTON MANDAL B100SL20Y',                    1, 15),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 00272', 'BUTON START B100DM',                        1, 16),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 00278', 'SİNYAL LAMBASI S14K KIRMIZI 220V',          1, 17),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 00273', 'KONTAK BLOK NC B2',                         3, 18),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 00267', 'KONTAK BLOK NO B1',                         3, 19),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 00276', 'SİNYAL LAMBA BY YEŞİL LEYLİ IŞIK',         1, 20),
('PYT 40', 'PANO ETİKET BUTON GRUBU', '10 00275', 'SİNYAL LAMBA BM MAVİ LEYLİ IŞIK',          1, 21),
('PYT 40', 'KUTU GRUBU',              '10 05817', 'PANO 35*50*19 PLASTİK',                     1, 22),

-- PYT 90
('PYT 90', 'SİGORTA GRUBU',           '10 04703', 'PAKO ŞALTER PSA025AK331S 3*25',             1,  1),
('PYT 90', 'SİGORTA GRUBU',           '10 16894', 'SİGORTA KAÇAK AKIMLI A9R41225 2''Li 30MA',  1,  2),
('PYT 90', 'SİGORTA GRUBU',           '10 00302', 'SİGORTA A9F74103 1*3',                      1,  3),
('PYT 90', 'RÖLE GRUBU',              '10 00294', 'MİNYATÜR RÖLE RXM4AB1P7 220V',              2,  4),
('PYT 90', 'RÖLE GRUBU',              '10 01398', 'MİNYATÜR RÖLE RXM4AB1BD 24V 16 PİNLİ',     1,  5),
('PYT 90', 'RÖLE GRUBU',              '10 00295', 'RÖLE SOKETİ RXZE2M114M',                    3,  6),
('PYT 90', 'KONTAK GRUBU',            '10 02314', 'KONTAKTÖR LC1K0610M7 220V',                 1,  7),
('PYT 90', 'KONTAK GRUBU',            '10 01332', 'KONTAKTÖR LC1K1610M7 220V',                 1,  8),
('PYT 90', 'GÜÇ KONTROL GRUBU',       '10 02491', 'GÜÇ KAYNAĞI MDR 20/24',                    1,  9),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 00266', 'BUTON İKİZ LAMBALI B102K20KY',              1, 10),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 00273', 'BUTON START B100DY',                        1, 11),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 03445', 'BUTON ACİL STOP MANTAR B200EE',             1, 12),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 00237', 'TERMOSTAT DİJİTAL DT 481 GEMO',             1, 13),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 10465', 'ZAMAN ROLESİ DZ 482 DİJİTAL GEMO',         1, 14),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 00263', 'BUTON MANDAL B100SL20Y',                    1, 15),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 00272', 'BUTON START B100DM',                        1, 16),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 00278', 'SİNYAL LAMBASI S14K KIRMIZI 220V',          1, 17),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 00273', 'KONTAK BLOK NC B2',                         3, 18),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 00267', 'KONTAK BLOK NO B1',                         3, 19),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 00276', 'SİNYAL LAMBA BY YEŞİL LEYLİ IŞIK',         1, 20),
('PYT 90', 'PANO ETİKET BUTON GRUBU', '10 00275', 'SİNYAL LAMBA BM MAVİ LEYLİ IŞIK',          1, 21),
('PYT 90', 'KUTU GRUBU',              '10 05817', 'PANO 35*50*19 PLASTİK',                     1, 22),

-- PYT 750
('PYT 750', 'SİGORTA GRUBU',           '10 00286', 'PAKO ŞALTER YKL301M40 3*40 KÜÇÜK KASALI',  1,  1),
('PYT 750', 'SİGORTA GRUBU',           '10 00304', 'SİGORTA KAÇAK AKIMLI A9R41440 4''LÜ',      1,  2),
('PYT 750', 'SİGORTA GRUBU',           '10 02664', 'SİGORTA A9F74440 SCHNEİDER 40A',            1,  3),
('PYT 750', 'SİGORTA GRUBU',           '10 00302', 'SİGORTA A9F74103 1*3',                      1,  4),
('PYT 750', 'RÖLE GRUBU',              '10 00294', 'MİNYATÜR RÖLE RXM4AB1P7 220V',              2,  5),
('PYT 750', 'RÖLE GRUBU',              '10 01398', 'MİNYATÜR RÖLE RXM4AB1BD 24V 16 PİNLİ',     1,  6),
('PYT 750', 'RÖLE GRUBU',              '10 00295', 'RÖLE SOKETİ RXZE2M114M',                    3,  7),
('PYT 750', 'KONTAK GRUBU',            '10 01331', 'KONTAKTÖR LC1K0910M7 220V',                 1,  8),
('PYT 750', 'KONTAK GRUBU',            '10 01332', 'KONTAKTÖR LC1K1610M7 220V',                 2,  9),
('PYT 750', 'GÜÇ KONTROL GRUBU',       '10 02491', 'GÜÇ KAYNAĞI MDR 20/24',                    1, 10),
('PYT 750', 'GÜÇ KONTROL GRUBU',       '10 00258', 'FAZ KORUMA RÖLESİ MKS-03',                 1, 11),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 00266', 'BUTON İKİZ LAMBALI B102K20KY',              1, 12),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 00273', 'BUTON START B100DY',                        1, 13),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 03445', 'BUTON ACİL STOP MANTAR B200EE',             1, 14),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 00237', 'TERMOSTAT DİJİTAL DT 481 GEMO',             1, 15),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 10465', 'ZAMAN ROLESİ DZ 482 DİJİTAL GEMO',         1, 16),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 00263', 'BUTON MANDAL B100SL20Y',                    1, 17),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 00272', 'BUTON START B100DM',                        1, 18),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 00278', 'SİNYAL LAMBASI S14K KIRMIZI 220V',          1, 19),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 00268', 'KONTAK BLOK NC B2',                         3, 20),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 00267', 'KONTAK BLOK NO B1',                         3, 21),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 00276', 'SİNYAL LAMBA BY YEŞİL LEDLİ IŞIK',         1, 22),
('PYT 750', 'PANO ETİKET BUTON GRUBU', '10 00275', 'SİNYAL LAMBA BM MAVİ LEDLİ IŞIK',          1, 23),
('PYT 750', 'KUTU GRUBU',              '10 16545', 'PANO 40*60*20 PLASTİK',                     1, 24),

-- PYT 800
('PYT 800', 'SİGORTA GRUBU',           '10 00286', 'PAKO ŞALTER YKL301M40 3*40 KÜÇÜK KASALI',  1,  1),
('PYT 800', 'SİGORTA GRUBU',           '10 00304', 'SİGORTA KAÇAK AKIMLI A9R41440 4''LÜ',      1,  2),
('PYT 800', 'SİGORTA GRUBU',           '10 02664', 'SİGORTA A9F74440 SCHNEİDER 40A',            1,  3),
('PYT 800', 'SİGORTA GRUBU',           '10 00302', 'SİGORTA A9F74103 1*3',                      1,  4),
('PYT 800', 'RÖLE GRUBU',              '10 00294', 'MİNYATÜR RÖLE RXM4AB1P7 220V',              2,  5),
('PYT 800', 'RÖLE GRUBU',              '10 01398', 'MİNYATÜR RÖLE RXM4AB1BD 24V 16 PİNLİ',     1,  6),
('PYT 800', 'RÖLE GRUBU',              '10 00295', 'RÖLE SOKETİ RXZE2M114M',                    3,  7),
('PYT 800', 'KONTAK GRUBU',            '10 01331', 'KONTAKTÖR LC1K0910M7 220V',                 1,  8),
('PYT 800', 'KONTAK GRUBU',            '10 01332', 'KONTAKTÖR LC1K1610M7 220V',                 2,  9),
('PYT 800', 'GÜÇ KONTROL GRUBU',       '10 02491', 'GÜÇ KAYNAĞI MDR 20/24',                    1, 10),
('PYT 800', 'GÜÇ KONTROL GRUBU',       '10 00258', 'FAZ KORUMA RÖLESİ MKS-03',                 1, 11),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 00266', 'BUTON İKİZ LAMBALI B102K20KY',              1, 12),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 00273', 'BUTON START B100DY',                        1, 13),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 03445', 'BUTON ACİL STOP MANTAR B200EE',             1, 14),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 00237', 'TERMOSTAT DİJİTAL DT 481 GEMO',             1, 15),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 10465', 'ZAMAN ROLESİ DZ 482 DİJİTAL GEMO',         1, 16),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 00263', 'BUTON MANDAL B100SL20Y',                    1, 17),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 00272', 'BUTON START B100DM',                        1, 18),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 00278', 'SİNYAL LAMBASI S14K KIRMIZI 220V',          1, 19),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 00268', 'KONTAK BLOK NC B2',                         3, 20),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 00267', 'KONTAK BLOK NO B1',                         3, 21),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 00276', 'SİNYAL LAMBA BY YEŞİL LEDLİ IŞIK',         1, 22),
('PYT 800', 'PANO ETİKET BUTON GRUBU', '10 00275', 'SİNYAL LAMBA BM MAVİ LEDLİ IŞIK',          1, 23),
('PYT 800', 'KUTU GRUBU',              '10 16545', 'PANO 40*60*20 PLASTİK',                     1, 24);
