-- =====================================================
-- urun_katalogu — Global ürün kataloğu tablosu
-- Fiyatlar sayfasındaki tüm ürün/model tanımları
-- buradan yönetilir. Fiyatlar kullanıcı başına
-- 'prices' ve 'stok_kodlari' tablolarında saklanır.
-- =====================================================

CREATE TABLE IF NOT EXISTS urun_katalogu (
  id          BIGSERIAL PRIMARY KEY,
  grup_sira   INTEGER NOT NULL DEFAULT 0,
  grup_adi    TEXT    NOT NULL,
  grup_renk   TEXT    NOT NULL DEFAULT '#94a3b8',
  model_sira  INTEGER NOT NULL DEFAULT 0,
  model       TEXT    NOT NULL,
  aciklama    TEXT    NOT NULL DEFAULT '',
  UNIQUE (grup_adi, model)
);

-- Herkes okuyabilir (global katalog)
ALTER TABLE urun_katalogu ENABLE ROW LEVEL SECURITY;
CREATE POLICY "katalog_herkese_acik" ON urun_katalogu
  FOR SELECT USING (true);

-- Sadece admin yazabilir
CREATE POLICY "katalog_admin_yazabilir" ON urun_katalogu
  FOR ALL USING (
    auth.email() IN ('fatihgural80@gmail.com', 'tuncaycinici@gmail.com')
  );

-- =====================================================
-- Başlangıç Verileri (FIYAT_GRUPLARI'ndan migrate)
-- =====================================================

INSERT INTO urun_katalogu (grup_sira, grup_adi, grup_renk, model_sira, model, aciklama) VALUES

-- Grup 0: MKŞ — Schneider GV2ME
(0,'MKŞ — Schneider GV2ME','#22d3ee', 0,'GV2ME02', 'Motor Koruma Şalteri 0.16A – 0.25A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee', 1,'GV2ME03', 'Motor Koruma Şalteri 0.25A – 0.40A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee', 2,'GV2ME04', 'Motor Koruma Şalteri 0.40A – 0.63A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee', 3,'GV2ME05', 'Motor Koruma Şalteri 0.63A – 1.00A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee', 4,'GV2ME06', 'Motor Koruma Şalteri 1.00A – 1.60A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee', 5,'GV2ME07', 'Motor Koruma Şalteri 1.60A – 2.50A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee', 6,'GV2ME08', 'Motor Koruma Şalteri 2.50A – 4.00A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee', 7,'GV2ME10', 'Motor Koruma Şalteri 4.00A – 6.30A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee', 8,'GV2ME14', 'Motor Koruma Şalteri 6.00A – 10.00A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee', 9,'GV2ME16', 'Motor Koruma Şalteri 9.00A – 14.00A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee',10,'GV2ME20', 'Motor Koruma Şalteri 13.00A – 18.00A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee',11,'GV2ME21', 'Motor Koruma Şalteri 17.00A – 23.00A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee',12,'GV2ME22', 'Motor Koruma Şalteri 20.00A – 25.00A'),
(0,'MKŞ — Schneider GV2ME','#22d3ee',13,'GV2ME32', 'Motor Koruma Şalteri 24.00A – 32.00A'),

-- Grup 1: MKŞ — Siemens 3RV2
(1,'MKŞ — Siemens 3RV2','#22d3ee', 0,'3RV2011-0CA10','Motor Koruma Şalteri 0.18A – 0.25A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee', 1,'3RV2011-0EA10','Motor Koruma Şalteri 0.28A – 0.40A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee', 2,'3RV2011-0GA10','Motor Koruma Şalteri 0.45A – 0.63A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee', 3,'3RV2011-0JA10','Motor Koruma Şalteri 0.70A – 1.00A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee', 4,'3RV2011-1AA10','Motor Koruma Şalteri 1.10A – 1.60A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee', 5,'3RV2011-1CA10','Motor Koruma Şalteri 1.80A – 2.50A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee', 6,'3RV2011-1EA10','Motor Koruma Şalteri 2.80A – 4.00A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee', 7,'3RV2011-1GA10','Motor Koruma Şalteri 4.50A – 6.30A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee', 8,'3RV2011-1JA10','Motor Koruma Şalteri 7.00A – 10.00A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee', 9,'3RV2021-4AA10','Motor Koruma Şalteri 11.00A – 16.00A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee',10,'3RV2021-4BA10','Motor Koruma Şalteri 14.00A – 20.00A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee',11,'3RV2021-4CA10','Motor Koruma Şalteri 17.00A – 25.00A'),
(1,'MKŞ — Siemens 3RV2','#22d3ee',12,'3RV2031-4EA10','Motor Koruma Şalteri 22.00A – 32.00A'),

-- Grup 2: Kontaktör — Schneider LC1
(2,'Kontaktör — Schneider LC1','#34d399',0,'LC1K0610M7','Kontaktör 6A 220V AC'),
(2,'Kontaktör — Schneider LC1','#34d399',1,'LC1K0910M7','Kontaktör 9A 220V AC'),
(2,'Kontaktör — Schneider LC1','#34d399',2,'LC1D16M7',  'Kontaktör 16A 220V AC'),
(2,'Kontaktör — Schneider LC1','#34d399',3,'LC1D25M7',  'Kontaktör 25A 220V AC'),
(2,'Kontaktör — Schneider LC1','#34d399',4,'LC1D32M7',  'Kontaktör 32A 220V AC'),

-- Grup 3: Kontaktör — Siemens 3RT2 (Motor)
(3,'Kontaktör — Siemens 3RT2 (Motor)','#34d399',0,'3RT2015-1AP01','Kontaktör 7A 220V AC'),
(3,'Kontaktör — Siemens 3RT2 (Motor)','#34d399',1,'3RT2016-1AP01','Kontaktör 9A 220V AC'),
(3,'Kontaktör — Siemens 3RT2 (Motor)','#34d399',2,'3RT2018-1AP01','Kontaktör 16A 220V AC'),
(3,'Kontaktör — Siemens 3RT2 (Motor)','#34d399',3,'3RT2026-1AP01','Kontaktör 25A 220V AC'),

-- Grup 4: Kontaktör — Siemens 3RT2 (Rezistans)
(4,'Kontaktör — Siemens 3RT2 (Rezistans)','#34d399',0,'3RT2015-1AM61','Kontaktör 7A 220V AC'),
(4,'Kontaktör — Siemens 3RT2 (Rezistans)','#34d399',1,'3RT2016-1AM61','Kontaktör 9A 220V AC'),
(4,'Kontaktör — Siemens 3RT2 (Rezistans)','#34d399',2,'3RT2018-1AM61','Kontaktör 16A 220V AC'),
(4,'Kontaktör — Siemens 3RT2 (Rezistans)','#34d399',3,'3RT2026-1AM61','Kontaktör 25A 220V AC'),
(4,'Kontaktör — Siemens 3RT2 (Rezistans)','#34d399',4,'3RT2034-1AM61','Kontaktör 32A 220V AC'),

-- Grup 5: Yardımcı Kontak
(5,'Yardımcı Kontak','#a78bfa',0,'GVAE11',    'Schneider — GV2ME Serisi Yardımcı Kontak'),
(5,'Yardımcı Kontak','#a78bfa',1,'3RV2901-1E','Siemens — 3RV2 Serisi Yardımcı Kontak'),

-- Grup 6: Sigorta 3P — Schneider iC60N
(6,'Sigorta 3P — Schneider iC60N','#f97316',0,'A9F74306','3P 6A  — Rezistans Koruma'),
(6,'Sigorta 3P — Schneider iC60N','#f97316',1,'A9F74310','3P 10A — Rezistans Koruma'),
(6,'Sigorta 3P — Schneider iC60N','#f97316',2,'A9F74316','3P 16A — Rezistans Koruma'),
(6,'Sigorta 3P — Schneider iC60N','#f97316',3,'A9F74325','3P 25A — Rezistans Koruma'),
(6,'Sigorta 3P — Schneider iC60N','#f97316',4,'A9F74332','3P 32A — Rezistans Koruma'),
(6,'Sigorta 3P — Schneider iC60N','#f97316',5,'A9F74340','3P 40A — Rezistans Koruma'),

-- Grup 7: Sigorta 1P — Schneider iC60N (İnvertör)
(7,'Sigorta 1P — Schneider iC60N (İnvertör)','#f97316',0,'A9F74106','1P 6A'),
(7,'Sigorta 1P — Schneider iC60N (İnvertör)','#f97316',1,'A9F74110','1P 10A'),
(7,'Sigorta 1P — Schneider iC60N (İnvertör)','#f97316',2,'A9F74116','1P 16A'),
(7,'Sigorta 1P — Schneider iC60N (İnvertör)','#f97316',3,'A9F74125','1P 25A'),
(7,'Sigorta 1P — Schneider iC60N (İnvertör)','#f97316',4,'A9F74132','1P 32A'),
(7,'Sigorta 1P — Schneider iC60N (İnvertör)','#f97316',5,'A9F74140','1P 40A'),
(7,'Sigorta 1P — Schneider iC60N (İnvertör)','#f97316',6,'A9F74150','1P 50A'),
(7,'Sigorta 1P — Schneider iC60N (İnvertör)','#f97316',7,'A9F74163','1P 63A'),

-- Grup 8: Sigorta — Siemens 5SL4
(8,'Sigorta — Siemens 5SL4','#f97316',0,'5SL4106-7','6A'),
(8,'Sigorta — Siemens 5SL4','#f97316',1,'5SL4110-7','10A'),
(8,'Sigorta — Siemens 5SL4','#f97316',2,'5SL4116-7','16A'),
(8,'Sigorta — Siemens 5SL4','#f97316',3,'5SL4125-7','25A'),
(8,'Sigorta — Siemens 5SL4','#f97316',4,'5SL4132-7','32A'),
(8,'Sigorta — Siemens 5SL4','#f97316',5,'5SL4140-7','40A'),
(8,'Sigorta — Siemens 5SL4','#f97316',6,'5SL4150-7','50A'),
(8,'Sigorta — Siemens 5SL4','#f97316',7,'5SL4163-7','63A'),

-- Grup 9: RCCB (Kaçak Akım) — Schneider iID
(9,'RCCB (Kaçak Akım) — Schneider iID','#f43f5e',0,'A9R41416', '2P 16A  30mA'),
(9,'RCCB (Kaçak Akım) — Schneider iID','#f43f5e',1,'A9R41425', '2P 25A  30mA'),
(9,'RCCB (Kaçak Akım) — Schneider iID','#f43f5e',2,'A9R41440', '2P 40A  30mA'),
(9,'RCCB (Kaçak Akım) — Schneider iID','#f43f5e',3,'A9R41463', '2P 63A  30mA'),
(9,'RCCB (Kaçak Akım) — Schneider iID','#f43f5e',4,'A9R41480', '2P 80A  30mA'),
(9,'RCCB (Kaçak Akım) — Schneider iID','#f43f5e',5,'A9R414100','2P 100A 30mA'),

-- Grup 10: RCCB (Kaçak Akım) — Siemens 5SV3
(10,'RCCB (Kaçak Akım) — Siemens 5SV3','#f43f5e',0,'5SV3312-6','2P 16A  30mA'),
(10,'RCCB (Kaçak Akım) — Siemens 5SV3','#f43f5e',1,'5SV3314-6','2P 25A  30mA'),
(10,'RCCB (Kaçak Akım) — Siemens 5SV3','#f43f5e',2,'5SV3316-6','2P 40A  30mA'),
(10,'RCCB (Kaçak Akım) — Siemens 5SV3','#f43f5e',3,'5SV3322-6','2P 63A  30mA'),
(10,'RCCB (Kaçak Akım) — Siemens 5SV3','#f43f5e',4,'5SV3324-6','2P 80A  30mA'),
(10,'RCCB (Kaçak Akım) — Siemens 5SV3','#f43f5e',5,'5SV3326-6','2P 100A 30mA'),

-- Grup 11: İnvertör — Delta VFD-EL
(11,'İnvertör — Delta VFD-EL','#60a5fa', 0,'VFD002EL21W-1','0.20kW  1.6A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa', 1,'VFD004EL21W-1','0.40kW  2.5A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa', 2,'VFD007EL21W-1','0.75kW  5.0A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa', 3,'VFD015EL21W-1','1.50kW  7.0A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa', 4,'VFD022EL21W-1','2.20kW  11.0A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa', 5,'VFD037EL21W-1','3.70kW  16.0A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa', 6,'VFD055EL21W-1','5.50kW  24.0A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa', 7,'VFD075EL21W-1','7.50kW  33.0A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa', 8,'VFD110EL43A-1','11.0kW  25.0A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa', 9,'VFD150EL43A-1','15.0kW  32.0A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa',10,'VFD185EL43A-1','18.5kW  38.0A'),
(11,'İnvertör — Delta VFD-EL','#60a5fa',11,'VFD220EL43A-1','22.0kW  45.0A'),

-- Grup 12: TMŞ — Schneider Compact CVS
(12,'TMŞ — Schneider Compact CVS','#a78bfa',0,'LV510337','CVS100F TM100D 3P3D 100A'),
(12,'TMŞ — Schneider Compact CVS','#a78bfa',1,'LV510405','CVS160F TM160D 3P3D 160A'),
(12,'TMŞ — Schneider Compact CVS','#a78bfa',2,'LV521001','CVS250F TM250D 3P3D 250A'),
(12,'TMŞ — Schneider Compact CVS','#a78bfa',3,'LV540306','CVS400F TM400D 3P3D 400A'),
(12,'TMŞ — Schneider Compact CVS','#a78bfa',4,'LV540316','CVS630F TM630D 3P3D 630A'),

-- Grup 13: TMŞ — Siemens SENTRON 3VA
(13,'TMŞ — Siemens SENTRON 3VA','#a78bfa',0,'3VA1110-4ED32-0AA0','3VA1 100A TM210 3P'),
(13,'TMŞ — Siemens SENTRON 3VA','#a78bfa',1,'3VA1116-4ED32-0AA0','3VA1 160A TM210 3P'),
(13,'TMŞ — Siemens SENTRON 3VA','#a78bfa',2,'3VA1225-4ED32-0AA0','3VA1 250A TM210 3P'),
(13,'TMŞ — Siemens SENTRON 3VA','#a78bfa',3,'3VA2340-5ED32-0AA0','3VA2 400A TM220 3P'),
(13,'TMŞ — Siemens SENTRON 3VA','#a78bfa',4,'3VA2363-5ED32-0AA0','3VA2 630A TM220 3P'),

-- Grup 14: TMŞ Kolu — Schneider
(14,'TMŞ Kolu — Schneider','#a78bfa',0,'LV510394','CVS100-160 Kapı Kolonu (Siyah)'),
(14,'TMŞ Kolu — Schneider','#a78bfa',1,'LV521326','CVS250 Kapı Kolonu (Siyah)'),
(14,'TMŞ Kolu — Schneider','#a78bfa',2,'LV540491','CVS400-630 Kapı Kolonu (Siyah)'),
(14,'TMŞ Kolu — Schneider','#a78bfa',3,'LV540492','CVS400-630 Kapı Kolonu (Kırmızı)'),

-- Grup 15: TMŞ Kolu — Siemens
(15,'TMŞ Kolu — Siemens','#a78bfa',0,'3VA9977-0PK20','3VA1 Serisi Kapı Kolonu'),
(15,'TMŞ Kolu — Siemens','#a78bfa',1,'3VA9988-0PK20','3VA2 Serisi Kapı Kolonu'),

-- Grup 16: NSX Devre Kesici Kolu — Schneider
(16,'NSX Devre Kesici Kolu — Schneider','#a78bfa',0,'LV429338','NSX 100-250A Döner Kapı Kolu'),
(16,'NSX Devre Kesici Kolu — Schneider','#a78bfa',1,'LV429339','NSX 100-250A Uzun Döner Kapı Kolu'),

-- Grup 17: MKŞ — Schneider GV2MF
(17,'MKŞ — Schneider GV2MF','#22d3ee', 0,'GV2MF02','Motor Koruma Şalteri 0.16A – 0.25A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee', 1,'GV2MF03','Motor Koruma Şalteri 0.25A – 0.40A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee', 2,'GV2MF04','Motor Koruma Şalteri 0.40A – 0.63A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee', 3,'GV2MF05','Motor Koruma Şalteri 0.63A – 1.00A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee', 4,'GV2MF06','Motor Koruma Şalteri 1.00A – 1.60A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee', 5,'GV2MF07','Motor Koruma Şalteri 1.60A – 2.50A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee', 6,'GV2MF08','Motor Koruma Şalteri 2.50A – 4.00A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee', 7,'GV2MF10','Motor Koruma Şalteri 4.00A – 6.30A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee', 8,'GV2MF14','Motor Koruma Şalteri 6.00A – 10.00A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee', 9,'GV2MF16','Motor Koruma Şalteri 9.00A – 14.00A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee',10,'GV2MF20','Motor Koruma Şalteri 13.00A – 18.00A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee',11,'GV2MF21','Motor Koruma Şalteri 17.00A – 23.00A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee',12,'GV2MF22','Motor Koruma Şalteri 20.00A – 25.00A'),
(17,'MKŞ — Schneider GV2MF','#22d3ee',13,'GV2MF32','Motor Koruma Şalteri 24.00A – 32.00A'),

-- Grup 18: İnvertör — Delta VFD-EL (3-Faz Giriş)
(18,'İnvertör — Delta VFD-EL (3-Faz Giriş)','#60a5fa',0,'VFD004EL23W-1','0.40kW  2.5A  (3-Faz Giriş)'),
(18,'İnvertör — Delta VFD-EL (3-Faz Giriş)','#60a5fa',1,'VFD007EL23W-1','0.75kW  5.0A  (3-Faz Giriş)'),
(18,'İnvertör — Delta VFD-EL (3-Faz Giriş)','#60a5fa',2,'VFD015EL23W-1','1.50kW  7.0A  (3-Faz Giriş)'),
(18,'İnvertör — Delta VFD-EL (3-Faz Giriş)','#60a5fa',3,'VFD022EL23W-1','2.20kW  11.0A (3-Faz Giriş)'),

-- Grup 19: Faz Koruma Rölesi — Entes
(19,'Faz Koruma Rölesi — Entes','#fb923c',0,'MKS-03','Faz Koruma Rölesi 3-Faz 380V (Faz Sırası + Kesme)'),
(19,'Faz Koruma Rölesi — Entes','#fb923c',1,'MKS-05','Faz & Gerilim Koruma Rölesi 380V'),
(19,'Faz Koruma Rölesi — Entes','#fb923c',2,'MR-C3', 'Çok Fonksiyonlu Faz Koruma Rölesi 380V'),

-- Grup 20: Kumanda Butonu
(20,'Kumanda Butonu','#fbbf24',0,'B100DY','Start Butonu — Sarı Çıkık Kafa'),
(20,'Kumanda Butonu','#fbbf24',1,'B100DM','Reset / Mavi Butonu — Mavi Çıkık Kafa'),
(20,'Kumanda Butonu','#fbbf24',2,'B100DK','Stop Butonu — Siyah Çıkık Kafa'),
(20,'Kumanda Butonu','#fbbf24',3,'B200FE','Acil Stop Butonu — Mantarlı Kırmızı'),

-- Grup 21: Kontak Blok & Sinyal Lamba
(21,'Kontak Blok & Sinyal Lamba','#fbbf24',0,'Kontak Blok NO B1',    'Normalde Açık (NO) Kontak Blok'),
(21,'Kontak Blok & Sinyal Lamba','#fbbf24',1,'Kontak Blok NC B2',    'Normalde Kapalı (NC) Kontak Blok'),
(21,'Kontak Blok & Sinyal Lamba','#fbbf24',2,'B7 8 LED LI BLOK MAVİ','Sinyal Lamba Mavi LED 12-30V AC/DC'),

-- Grup 22: Tepe Lambası
(22,'Tepe Lambası','#fbbf24',0,'1004905','Tepe Lambası 3 Renkli (Yeşil / Sarı / Kırmızı)'),

-- Grup 23: Pano Aydınlatma & Priz
(23,'Pano Aydınlatma & Priz','#94a3b8',0,'CT-2467', 'Pano Lambası'),
(23,'Pano Aydınlatma & Priz','#94a3b8',1,'851012',  'Anahtar Ani Hareketi 1NA+1NK'),
(23,'Pano Aydınlatma & Priz','#94a3b8',2,'EPREU2G', 'Priz Raya Montaj Topraklı'),

-- Grup 24: Yaprak Röle & Soket
(24,'Yaprak Röle & Soket','#a3e635',0,'APF30324-VDS-KK','Yaprak Röle Soket 1C/O 24VDC'),
(24,'Yaprak Röle & Soket','#a3e635',1,'TCC 6.4/51 OR',  'Weidmüller Röle Köprüsü (24 ds)'),

-- Grup 25: Güç Kaynağı — Mean Well LRS
(25,'Güç Kaynağı — Mean Well LRS','#67e8f9',0,'LRS-350-24','Güç Kaynağı 350W  24VDC 14.6A'),
(25,'Güç Kaynağı — Mean Well LRS','#67e8f9',1,'LRS-200-24','Güç Kaynağı 200W  24VDC  8.8A'),
(25,'Güç Kaynağı — Mean Well LRS','#67e8f9',2,'LRS-100-24','Güç Kaynağı 100W  24VDC  4.5A'),
(25,'Güç Kaynağı — Mean Well LRS','#67e8f9',3,'LRS-50-24', 'Güç Kaynağı  50W  24VDC  2.2A'),

-- Grup 26: Güvenlik Rölesi — Omron G9SX
(26,'Güvenlik Rölesi — Omron G9SX','#f0abfc',0,'G9SX-GS226-T15-RC DC24','Safety Relay 2 NO + 1 NC Çıkış'),
(26,'Güvenlik Rölesi — Omron G9SX','#f0abfc',1,'G9SX-NSA222-T15 DC24',  'Safety Relay 2 NO + 2 NC Çıkış'),
(26,'Güvenlik Rölesi — Omron G9SX','#f0abfc',2,'G9SP-N20S',              'Güvenlik Kontrolcüsü 20 Güvenlik Girişi'),

-- Grup 27: PLC CPU — Siemens SIMATIC S7-1200
(27,'PLC CPU — Siemens SIMATIC S7-1200','#86efac',0,'6ES7215-1AG40-0XB0','CPU 1215C DC/DC/DC  14DI / 10DO / 2AI / 2AO'),
(27,'PLC CPU — Siemens SIMATIC S7-1200','#86efac',1,'6ES7214-1AG40-0XB0','CPU 1214C DC/DC/DC  14DI / 10DO / 2AI'),
(27,'PLC CPU — Siemens SIMATIC S7-1200','#86efac',2,'6ES7212-1AE40-0XB0','CPU 1212C DC/DC/DC   8DI /  6DO / 2AI'),

-- Grup 28: PLC Genişletme Modül — Siemens S7-1200
(28,'PLC Genişletme Modül — Siemens S7-1200','#86efac',0,'6ES7223-1BL32-0XB0','SM 1223 DC/DC  16DI / 16DO'),
(28,'PLC Genişletme Modül — Siemens S7-1200','#86efac',1,'6ES7223-1BH32-0XB0','SM 1223 DC/DC   8DI /  8DO'),
(28,'PLC Genişletme Modül — Siemens S7-1200','#86efac',2,'6ES7231-5QF32-0XB0','SM 1231 TC   4× Termokupl Analog Giriş'),
(28,'PLC Genişletme Modül — Siemens S7-1200','#86efac',3,'6ES7221-1BF32-0XB0','SM 1221 DC   8DI'),
(28,'PLC Genişletme Modül — Siemens S7-1200','#86efac',4,'6ES7222-1BF32-0XB0','SM 1222 DC   8DO'),

-- Grup 29: PLC — Delta DVP Serisi
(29,'PLC — Delta DVP Serisi','#86efac',0,'DVP14SS211R','DVP-14SS RS-485   8DI /  6DO (Röle)'),
(29,'PLC — Delta DVP Serisi','#86efac',1,'DVP16SP11R', 'DVP-16SP          8DI /  8DO (Röle)'),
(29,'PLC — Delta DVP Serisi','#86efac',2,'DVP32ES200R','DVP-32P          16DI / 16DO (Röle)'),
(29,'PLC — Delta DVP Serisi','#86efac',3,'DVP04TC-S',  'DVP TC Modül 4-Kanal Termokupl Analog Giriş'),

-- Grup 30: HMI / Operatör Paneli
(30,'HMI / Operatör Paneli','#86efac',0,'6AV2123-2JB03-0XB0','Siemens KTP900 BASIC 9" TFT Dokunmatik Panel'),
(30,'HMI / Operatör Paneli','#86efac',1,'DOP-107BV',         'Delta DOP-107BV 7" TFT Dokunmatik Panel'),

-- Grup 31: Bara — GWEST
(31,'Bara — GWEST','#94a3b8',0,'GWEST 4×7MM','Bara 4×7 mm (Adet)'),
(31,'Bara — GWEST','#94a3b8',1,'GWEST 2×7MM','Bara 2×7 mm (Adet)')

ON CONFLICT (grup_adi, model) DO UPDATE SET
  grup_sira  = EXCLUDED.grup_sira,
  grup_renk  = EXCLUDED.grup_renk,
  model_sira = EXCLUDED.model_sira,
  aciklama   = EXCLUDED.aciklama;
