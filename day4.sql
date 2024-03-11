--------------DAY 4 DT-------------------
--18-ON DELETE CASCADE:kademeli silme işlemini otomatik gerçekleştirir

CREATE TABLE talebeler
(
id int primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);--parent

CREATE TABLE notlar( 
talebe_id int,
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id) 
ON DELETE CASCADE
);--child

INSERT INTO talebeler VALUES(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO notlar VALUES ('123','kimya',75),
 ('124', 'fizik',65),
 ('125', 'tarih',90),
 ('126', 'Matematik',90),
 ('127', 'Matematik',90),
 (null, 'tarih',90);

SELECT * FROM talebeler;
SELECT * FROM notlar;

--notlar tablosunda id=123 olan kaydı silelim
DELETE FROM notlar WHERE talebe_id=123;
--talebeler tablosunda id=126 kaydı silelim
DELETE FROM talebeler WHERE id=126;
--ON DELETE CASCADE ref alınan kaydı parenttan silmek istediğimizde
--önce childdan referansı siler, ardından parenttan silme işlemi yapar

DELETE FROM talebeler;
--FK: on delete cascade:notlar tablosundan refli kayıtları sildi
DELETE FROM notlar;


--19-tabloyu SCHEMAdan silme:
DROP TABLE talebeler;
DROP TABLE talebeler CASCADE;--FK constrainti kaldırır

SELECT * FROM notlar;

DROP TABLE IF EXISTS talebeler1;--tablo varsa siler yoksa sorguyu atlar

--CREATE TABLE IF NOT EXISTS students...


--20-IN condition

CREATE TABLE musteriler  (
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler;

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.

SELECT * 
FROM musteriler
WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

--2.yol
SELECT * 
FROM musteriler
WHERE urun_isim IN ('Orange','Apple','Apricot');

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' ve 'Apricot' olmayan verileri listeleyiniz.
SELECT * 
FROM musteriler
WHERE urun_isim NOT IN ('Orange','Apple','Apricot');


--21-BETWEEN .. AND ... komutu

--Müşteriler tablosunda urun_id 20 ile 30(dahil) arasinda olan 
--urunlerin tum bilgilerini listeleyiniz
SELECT *
FROM musteriler
WHERE urun_id>=20 AND urun_id<=30;

--2.yol
SELECT *
FROM musteriler
WHERE urun_id BETWEEN 20 AND 30;

--Müşteriler tablosunda urun_id 20den küçük veya 
--30dan büyük olan urunlerin tum bilgilerini listeleyiniz
SELECT *
FROM musteriler
WHERE urun_id NOT BETWEEN 20 AND 30;


--22-AGGREGATE Fonk.:toplamsal fonk

CREATE TABLE calisanlar3 (
id INT, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas INT, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
marka_id INT UNIQUE, 
marka_isim VARCHAR(20), 
calisan_sayisi INT
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM markalar;
SELECT * FROM calisanlar3;

--calisanlar3 tablosunda max maaşı görüntüleyelim.
SELECT MAX(maas) FROM calisanlar3;
--calisanlar3 tablosunda min maaşı görüntüleyelim.
SELECT MIN(maas) FROM calisanlar3;
--calisanlar3 tablosunda ortalama maaşı görüntüleyelim.
SELECT AVG(maas) FROM calisanlar3;
SELECT ROUND(AVG(maas),2) FROM calisanlar3;

--calisanlar3 tablosunda toplam maaşı görüntüleyelim.
SELECT SUM(maas) FROM calisanlar3;
--calisanlar3 tablosundaki kayıt sayısını görüntüleyelim.
SELECT COUNT(*) FROM calisanlar3;

--calisanlar3 tablosundaki maaşı 2500 olanların sayısını görüntüleyiniz
SELECT COUNT(*) FROM calisanlar3 WHERE maas=2500;


--23-ALIASES:rumuz/etiket/takma isim:tablo veya sütunlara geçici isim verebiliriz.

CREATE TABLE workers(
calisan_id CHAR(9),
calisan_isim VARCHAR(50),
calisan_dogdugu_sehir VARCHAR(50)
);
SELECT * FROM workers;
--bu sorguda geçici olarak takma isim kullanalım.
SELECT calisan_id AS id FROM workers AS w;
SELECT calisan_isim isim FROM workers w;

--24-SUBQUERY--NESTED QUERY
--24-a-SUBQUERY: WHERE ile kullanımı

--marka_id si 100 olan markada çalışanları listeleyiniz.
SELECT marka_isim FROM markalar WHERE marka_id=100;--Vakko
SELECT * FROM calisanlar3 WHERE isyeri='Vakko';

--2.yol: dinamik çözüm

SELECT * --outer query
FROM calisanlar3
WHERE isyeri= (SELECT marka_isim 
			   FROM markalar 
			   WHERE marka_id=100);--nested query, subquery

--INTERVIEW QUESTION:calisanlar3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz. 

SELECT * 
FROM calisanlar3
WHERE maas=(SELECT MAX(maas) 
			FROM calisanlar3);

--calisanlar3 tablosunda max veya min maaşı alan çalışanların
-- tüm fieldlarını gösteriniz.ÖDEV

--Interview Question:calisanlar3 tablosunda ikinci en yüksek maaşı gösteriniz.ÖDEV

-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.

SELECT marka_id,calisan_sayisi
FROM markalar
WHERE marka_isim IN (SELECT isyeri
					 FROM calisanlar3
					 WHERE sehir='Ankara')

--marka_id’si 101’den büyük olan marka çalişanlarinin tüm bilgilerini listeleyiniz.

SELECT * 
FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim 
				 FROM markalar
				 WHERE marka_id>101);

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.ÖDEV


--24-b-SUBQUERY: SELECT komutundan sonra kullanımı

-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
SELECT marka_id, marka_isim, (SELECT COUNT(DISTINCT(sehir)) 
							  FROM calisanlar3
							 WHERE isyeri=marka_isim)
FROM markalar;

--DISTINCT farklı olanları seçer
SELECT DISTINCT(sehir) FROM calisanlar3



