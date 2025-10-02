-- Kategoriler
INSERT INTO Kategori (ad) VALUES
('Elektronik'),
('Giyim'),
('Kitap'),
('Ev & Mutfak'),
('Spor');

-- Satýcýlar
INSERT INTO Satici (ad, adres) VALUES
('TechWorld','Ýstanbul'),
('ModaShop','Ankara'),
('KitapEvi','Ýzmir'),
('EvDünyasý','Bursa'),
('SporArena','Antalya');

-- Müþteriler (20 kiþi, 3’ü hiç sipariþ vermeyecek)
INSERT INTO Musteri (ad, soyad, email, sehir, kayit_tarihi) VALUES
('Ahmet','Yýlmaz','ahmet@test.com','Ýstanbul','2025-01-01'),
('Ayþe','Demir','ayse@test.com','Ankara','2025-01-02'),
('Mehmet','Kaya','mehmet@test.com','Bursa','2025-01-03'),
('Fatma','Çelik','fatma@test.com','Bursa','2025-01-04'),
('Ali','Þahin','ali@test.com','Antalya','2025-01-05'),
('Elif','Aydýn','elif@test.com','Ankara','2025-01-06'),
('Can','Öztürk','can@test.com','Ýstanbul','2025-01-07'),
('Zeynep','Polat','zeynep@test.com','Antalya','2025-01-08'),
('Merve','Koç','merve@test.com','Bursa','2025-01-09'),
('Deniz','Akar','deniz@test.com','Antalya','2025-01-10'),
('Emre','Güzel','emre@test.com','Ýstanbul','2025-01-11'),   -- hiç sipariþ vermeyecek
('Hülya','Arslan','hulya@test.com','Ankara','2025-01-12'),  -- hiç sipariþ vermeyecek
('Selin','Öz','selin@test.com','Ýzmir','2025-01-13'),        -- hiç sipariþ vermeyecek
('Murat','Demirtaþ','murat@test.com','Bursa','2025-01-14'),
('Serap','Koç','serap@test.com','Antalya','2025-01-15'),
('Volkan','Ak','volkan@test.com','Ýstanbul','2025-01-16'),
('Seda','Kaya','seda@test.com','Ankara','2025-01-17'),
('Ozan','Polat','ozan@test.com','Antalya','2025-01-18'),
('Gizem','Yýlmaz','gizem@test.com','Bursa','2025-01-19'),
('Caner','Çetin','caner@test.com','Antalya','2025-01-20');

-- Ürünler (1 tanesi hiç satýlmayacak)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Laptop',25000,50,1,1),
('Telefon',15000,30,1,1),
('T-shirt',200,200,2,2),
('Kot Pantolon',500,150,2,2),
('Roman Kitap',100,300,3,3),
('Bilim Kitap',120,200,3,3),
('Tencere Seti',800,80,4,4),
('Mutfak Robotu',1500,60,4,4),
('Koþu Ayakkabý',1200,70,5,5),
('Dumbbell Set',600,40,5,5),
('Hediye Sepeti',300,50,4,2);  -- hiç satýlmayacak ürün

-- Sipariþler ve Sipariþ Detaylarý
INSERT INTO Siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES
(1,'2025-01-05',0,'Kredi Kartý'),
(1,'2025-02-10',0,'Kapýda Ödeme'),
(1,'2025-03-15',0,'Kredi Kartý'),
(2,'2025-01-10',0,'Kapýda Ödeme'),
(2,'2025-04-12',0,'Kredi Kartý'),
(3,'2025-02-05',0,'Kapýda Ödeme'),
(4,'2025-03-20',0,'Kredi Kartý'),
(4,'2025-05-01',0,'Kapýda Ödeme'),
(5,'2025-06-15',0,'Kredi Kartý'),
(6,'2025-07-05',0,'Kapýda Ödeme'),
(6,'2025-08-10',0,'Kredi Kartý'),
(7,'2025-09-12',0,'Kapýda Ödeme'),
(8,'2025-09-20',0,'Kredi Kartý'),
(9,'2025-10-01',0,'Kapýda Ödeme'),
(10,'2025-10-15',0,'Kredi Kartý'),
(14,'2025-11-05',0,'Kapýda Ödeme'),
(15,'2025-11-15',0,'Kredi Kartý'),
(16,'2025-12-01',0,'Kapýda Ödeme'),
(17,'2025-12-10',0,'Kredi Kartý'),
(18,'2025-12-20',0,'Kapýda Ödeme'),
(19,'2025-12-25',0,'Kredi Kartý'),
(20,'2025-12-30',0,'Kapýda Ödeme');

INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat) VALUES
(1,1,1,25000),
(2,2,2,15000),
(3,3,1,200),
(4,4,2,500),
(5,1,1,25000),
(6,5,3,100),
(7,6,1,120),
(8,7,2,800),
(9,8,1,1500),
(10,9,1,1200),
(11,10,2,600),
(12,1,1,25000),
(13,2,1,15000),
(14,3,1,200),
(15,4,2,500),
(16,5,1,100),
(17,6,1,120),
(18,7,1,800),
(19,8,1,1500),
(20,9,1,1200);

-- Toplam tutarlarý güncelle
UPDATE Siparis
SET toplam_tutar = (SELECT ISNULL(SUM(adet*fiyat),0) FROM Siparis_Detay WHERE siparis_id=Siparis.id);
