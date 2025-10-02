DROP TABLE IF EXISTS Siparis_Detay;
DROP TABLE IF EXISTS Siparis;
DROP TABLE IF EXISTS Urun;
DROP TABLE IF EXISTS Musteri;
DROP TABLE IF EXISTS Satici;
DROP TABLE IF EXISTS Kategori;

CREATE TABLE Kategori (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(50) NOT NULL
);

CREATE TABLE Satici (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(50) NOT NULL,
    adres NVARCHAR(100)
);

CREATE TABLE Musteri (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(50) NOT NULL,
    soyad NVARCHAR(50),
    email NVARCHAR(50) UNIQUE,
    sehir NVARCHAR(50),
    kayit_tarihi DATE
);

CREATE TABLE Urun (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(50) NOT NULL,
    fiyat DECIMAL(10,2),
    stok INT,
    kategori_id INT FOREIGN KEY REFERENCES Kategori(id),
    satici_id INT FOREIGN KEY REFERENCES Satici(id)
);

CREATE TABLE Siparis (
    id INT IDENTITY(1,1) PRIMARY KEY,
    musteri_id INT FOREIGN KEY REFERENCES Musteri(id),
    tarih DATE,
    toplam_tutar DECIMAL(10,2),
    odeme_turu NVARCHAR(20)
);

CREATE TABLE Siparis_Detay (
    id INT IDENTITY(1,1) PRIMARY KEY,
    siparis_id INT FOREIGN KEY REFERENCES Siparis(id),
    urun_id INT FOREIGN KEY REFERENCES Urun(id),
    adet INT,
    fiyat DECIMAL(10,2)
);
