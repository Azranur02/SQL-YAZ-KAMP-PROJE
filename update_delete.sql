-- Sipariş Detay ekleme örneği
INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat) VALUES (1, 1, 2, 25000);
UPDATE Siparis
SET toplam_tutar = (SELECT SUM(adet*fiyat) FROM Siparis_Detay WHERE siparis_id=1)
WHERE id=1;

--  Sipariş Detay güncelleme
UPDATE Siparis_Detay SET adet = 3 WHERE siparis_id=1 AND urun_id=1;
UPDATE Siparis
SET toplam_tutar = (SELECT SUM(adet*fiyat) FROM Siparis_Detay WHERE siparis_id=1)
WHERE id=1;

--  Sipariş Detay silme
DELETE FROM Siparis_Detay WHERE siparis_id=1 AND urun_id=1;
UPDATE Siparis
SET toplam_tutar = (SELECT ISNULL(SUM(adet*fiyat),0) FROM Siparis_Detay WHERE siparis_id=1)
WHERE id=1;

--  Ürün stok güncelleme
UPDATE u
SET u.stok = u.stok - sd.adet
FROM Urun u
JOIN Siparis_Detay sd ON u.id = sd.urun_id
WHERE sd.siparis_id = 3;

--  Müşteri silme örneği
DELETE sd
FROM Siparis_Detay sd
JOIN Siparis s ON sd.siparis_id = s.id
WHERE s.musteri_id = 5;

DELETE FROM Siparis WHERE musteri_id = 5;
DELETE FROM Musteri WHERE id = 5;

-- =========================
-- Raporlama sorguları

-- a) En çok sipariş veren 5 müşteri
SELECT TOP 5 m.id, m.ad, m.soyad, COUNT(s.id) AS siparis_sayisi
FROM Musteri m
JOIN Siparis s ON m.id = s.musteri_id
GROUP BY m.id, m.ad, m.soyad
ORDER BY COUNT(s.id) DESC;

-- b) En çok satılan ürünler
SELECT TOP 5 u.id, u.ad, SUM(sd.adet) AS toplam_adet
FROM Urun u
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY u.id, u.ad
ORDER BY SUM(sd.adet) DESC;

-- c) En yüksek cirosu olan satıcılar
SELECT TOP 5 s.id, s.ad, SUM(sd.adet * sd.fiyat) AS toplam_ciro
FROM Satici s
JOIN Urun u ON s.id = u.satici_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY s.id, s.ad
ORDER BY SUM(sd.adet * sd.fiyat) DESC;

-- d) Şehirlere göre müşteri sayısı
SELECT sehir, COUNT(*) AS musteri_sayisi
FROM Musteri
GROUP BY sehir;

-- e) Kategori bazlı toplam satışlar
SELECT k.ad AS kategori, SUM(sd.adet * sd.fiyat) AS toplam_satis
FROM Kategori k
JOIN Urun u ON k.id = u.kategori_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY k.ad;

-- f) Aylara göre sipariş sayısı
SELECT YEAR(tarih) AS yil, MONTH(tarih) AS ay, COUNT(*) AS siparis_sayisi
FROM Siparis
GROUP BY YEAR(tarih), MONTH(tarih)
ORDER BY yil, ay;

-- g) Siparişlerde müşteri bilgisi + ürün bilgisi + satıcı bilgisi
SELECT s.id AS siparis_id, m.ad + ' ' + m.soyad AS musteri,
       u.ad AS urun, sd.adet, sd.fiyat, sat.ad AS satici
FROM Siparis s
JOIN Musteri m ON s.musteri_id = m.id
JOIN Siparis_Detay sd ON s.id = sd.siparis_id
JOIN Urun u ON sd.urun_id = u.id
JOIN Satici sat ON u.satici_id = sat.id
ORDER BY s.id;

-- h) Hiç satılmamış ürünler
SELECT u.id, u.ad
FROM Urun u
LEFT JOIN Siparis_Detay sd ON u.id = sd.urun_id
WHERE sd.id IS NULL;

-- i) Hiç sipariş vermemiş müşteriler
SELECT m.id, m.ad, m.soyad
FROM Musteri m
LEFT JOIN Siparis s ON m.id = s.musteri_id
WHERE s.id IS NULL;



-- 1) En çok kazanç sağlayan ilk 3 kategori
SELECT TOP 3 k.ad AS kategori, SUM(sd.adet * sd.fiyat) AS toplam_ciro
FROM Kategori k
JOIN Urun u ON k.id = u.kategori_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY k.ad
ORDER BY toplam_ciro DESC;

-- 2) Ortalama sipariş tutarını geçen siparişler
SELECT *
FROM Siparis
WHERE toplam_tutar > (SELECT AVG(toplam_tutar) FROM Siparis);

-- 3) En az bir kez elektronik ürün satın alan müşteriler
SELECT DISTINCT m.id, m.ad, m.soyad
FROM Musteri m
JOIN Siparis s ON m.id = s.musteri_id
JOIN Siparis_Detay sd ON s.id = sd.siparis_id
JOIN Urun u ON sd.urun_id = u.id
WHERE u.kategori_id = (SELECT id FROM Kategori WHERE ad='Elektronik');
