-- Kategoriler
INSERT INTO Kategori (ad) VALUES
('Elektronik'),
('Giyim'),
('Kitap'),
('Ev & Mutfak'),
('Spor');

-- Sat�c�lar
INSERT INTO Satici (ad, adres) VALUES
('TechWorld','�stanbul'),
('ModaShop','Ankara'),
('KitapEvi','�zmir'),
('EvD�nyas�','Bursa'),
('SporArena','Antalya');

-- M��teriler (20 ki�i, 3�� hi� sipari� vermeyecek)
INSERT INTO Musteri (ad, soyad, email, sehir, kayit_tarihi) VALUES
('Ahmet','Y�lmaz','ahmet@test.com','�stanbul','2025-01-01'),
('Ay�e','Demir','ayse@test.com','Ankara','2025-01-02'),
('Mehmet','Kaya','mehmet@test.com','Bursa','2025-01-03'),
('Fatma','�elik','fatma@test.com','Bursa','2025-01-04'),
('Ali','�ahin','ali@test.com','Antalya','2025-01-05'),
('Elif','Ayd�n','elif@test.com','Ankara','2025-01-06'),
('Can','�zt�rk','can@test.com','�stanbul','2025-01-07'),
('Zeynep','Polat','zeynep@test.com','Antalya','2025-01-08'),
('Merve','Ko�','merve@test.com','Bursa','2025-01-09'),
('Deniz','Akar','deniz@test.com','Antalya','2025-01-10'),
('Emre','G�zel','emre@test.com','�stanbul','2025-01-11'),   -- hi� sipari� vermeyecek
('H�lya','Arslan','hulya@test.com','Ankara','2025-01-12'),  -- hi� sipari� vermeyecek
('Selin','�z','selin@test.com','�zmir','2025-01-13'),        -- hi� sipari� vermeyecek
('Murat','Demirta�','murat@test.com','Bursa','2025-01-14'),
('Serap','Ko�','serap@test.com','Antalya','2025-01-15'),
('Volkan','Ak','volkan@test.com','�stanbul','2025-01-16'),
('Seda','Kaya','seda@test.com','Ankara','2025-01-17'),
('Ozan','Polat','ozan@test.com','Antalya','2025-01-18'),
('Gizem','Y�lmaz','gizem@test.com','Bursa','2025-01-19'),
('Caner','�etin','caner@test.com','Antalya','2025-01-20');

-- �r�nler (1 tanesi hi� sat�lmayacak)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Laptop',25000,50,1,1),
('Telefon',15000,30,1,1),
('T-shirt',200,200,2,2),
('Kot Pantolon',500,150,2,2),
('Roman Kitap',100,300,3,3),
('Bilim Kitap',120,200,3,3),
('Tencere Seti',800,80,4,4),
('Mutfak Robotu',1500,60,4,4),
('Ko�u Ayakkab�',1200,70,5,5),
('Dumbbell Set',600,40,5,5),
('Hediye Sepeti',300,50,4,2);  -- hi� sat�lmayacak �r�n

-- Sipari�ler ve Sipari� Detaylar�
INSERT INTO Siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES
(1,'2025-01-05',0,'Kredi Kart�'),
(1,'2025-02-10',0,'Kap�da �deme'),
(1,'2025-03-15',0,'Kredi Kart�'),
(2,'2025-01-10',0,'Kap�da �deme'),
(2,'2025-04-12',0,'Kredi Kart�'),
(3,'2025-02-05',0,'Kap�da �deme'),
(4,'2025-03-20',0,'Kredi Kart�'),
(4,'2025-05-01',0,'Kap�da �deme'),
(5,'2025-06-15',0,'Kredi Kart�'),
(6,'2025-07-05',0,'Kap�da �deme'),
(6,'2025-08-10',0,'Kredi Kart�'),
(7,'2025-09-12',0,'Kap�da �deme'),
(8,'2025-09-20',0,'Kredi Kart�'),
(9,'2025-10-01',0,'Kap�da �deme'),
(10,'2025-10-15',0,'Kredi Kart�'),
(14,'2025-11-05',0,'Kap�da �deme'),
(15,'2025-11-15',0,'Kredi Kart�'),
(16,'2025-12-01',0,'Kap�da �deme'),
(17,'2025-12-10',0,'Kredi Kart�'),
(18,'2025-12-20',0,'Kap�da �deme'),
(19,'2025-12-25',0,'Kredi Kart�'),
(20,'2025-12-30',0,'Kap�da �deme');

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

-- Toplam tutarlar� g�ncelle
UPDATE Siparis
SET toplam_tutar = (SELECT ISNULL(SUM(adet*fiyat),0) FROM Siparis_Detay WHERE siparis_id=Siparis.id);
