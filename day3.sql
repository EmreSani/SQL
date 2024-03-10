--------- DAY'3 NT ---------------
---- PK ve FK uygulaması ------------

CREATE TABLE calisanlar(
id char(5) PRIMARY KEY,--unique,not null,bu sütun için kimlik bilgisi
isim varchar(50) UNIQUE,
maas int NOT NULL,
ise_baslama date
);

CREATE TABLE adresler(
adres_id char(5),
sokak varchar(30),
cadde varchar(30),
sehir varchar(20),
FOREIGN KEY(adres_id) REFERENCES calisanlar(id) 
);

INSERT INTO calisanlar VALUES('10002', 'Donatello' ,12000, '2018-04-14');--başarılı
INSERT INTO calisanlar VALUES('10003', null, 5000, '2018-04-14');--+
INSERT INTO calisanlar VALUES('10004', 'Donatello', 5000, '2018-04-14');--isim:UNIQUE
INSERT INTO calisanlar VALUES('10005', 'Michelangelo', 5000, '2018-04-14');--+
INSERT INTO calisanlar VALUES('10006', 'Leonardo', null, '2019-04-12'); --maas: NOT NULL

INSERT INTO calisanlar VALUES('10007', 'Raphael', '', '2018-04-14');--geçersiz giriş
INSERT INTO calisanlar VALUES('', 'April', 2000, '2018-04-14');--empty NULL değil
INSERT INTO calisanlar VALUES('', 'Ms.April', 2000, '2018-04-14');--PK:unique
INSERT INTO calisanlar VALUES('10002', 'Splinter' ,12000, '2018-04-14');--PK:unique
INSERT INTO calisanlar VALUES( null, 'Fred' ,12000, '2018-04-14');--PK:not null
INSERT INTO calisanlar VALUES('10008', 'Barnie' ,10000, '2018-04-14');--+
INSERT INTO calisanlar VALUES('10009', 'Wilma' ,11000, '2018-04-14');--+
INSERT INTO calisanlar VALUES('10010', 'Betty' ,12000, '2018-04-14');--+

INSERT INTO adresler VALUES('10003','Ninja Sok', '40.Cad.','IST');--+
INSERT INTO adresler VALUES('10003','Kaya Sok', '50.Cad.','Ankara');--+
INSERT INTO adresler VALUES('10002','Taş Sok', '30.Cad.','Konya');--+
INSERT INTO adresler VALUES('10012','Taş Sok', '30.Cad.','Konya');--parentta yok

INSERT INTO adresler VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');


SELECT * FROM calisanlar;
SELECT * FROM adresler;

--13-tabloya CHECK constrainti ekleme
CREATE TABLE person(
id INTEGER,
name VARCHAR(20),	
salary REAL CHECK(salary>5000),
age INTEGER	CHECK(age>0)
);

INSERT INTO person VALUES(10,'Ali Can',2000,-9);--age>0
INSERT INTO person VALUES(10,'Ali Can',7000,9);

SELECT * FROM person;

--14-WHERE condition(koşul)
--calisanlar tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
SELECT * FROM calisanlar WHERE isim='Donatello';
--calisanlar tablosundan maaşı 5000den fazla olanların tüm bilgilerini listeleyelim
SELECT * FROM calisanlar WHERE maas>5000;
--calisanlar tablosundan maaşı 1000den az olanların tüm bilgilerini listeleyelim
SELECT * FROM calisanlar WHERE maas<1000;

--adresler tablosundan sehiri 'Konya' ve 
--adres_id si 10002 olan kaydın tüm verileri getirelim
SELECT * FROM adresler WHERE sehir='Konya' AND adres_id='10002' 

--sehiri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getirelim.
SELECT cadde,sehir FROM adresler 
WHERE sehir='Konya' OR sehir='Bursa'; 

--15-DELETE FROM... : tablodan kayıt silme

CREATE TABLE ogrenciler1
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);

INSERT INTO ogrenciler1 VALUES(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM ogrenciler1;

--id=123 olan kaydı silelim.
DELETE FROM ogrenciler1 WHERE id=123;
--ismi Kemal Tan olan kaydı silelim
DELETE FROM ogrenciler1 WHERE isim='Kemal Tan';
--ismi Ahmet Ran veya Veli Han olan kayıtları silelim
DELETE FROM ogrenciler1 WHERE isim='Ahmet Ran' OR isim='Veli Han';

SELECT * FROM students;
--16-a-tablodaki tüm kayıtları silelim
--DELETE FROM komutunu koşul belirtmeden kullanabiliriz--DML
DELETE FROM students;--aynı zamanda WHERE komutu ile kullanılabilir. 

--16-b-tablodaki tüm kayıtları silelim
--TRUNCATE TABLE: daha hızlı--DDL
SELECT * FROM doctors;
TRUNCATE TABLE doctors;-- WHERE komutu ile KULLANILAMAZ.

--17-parent-child ilişkisi olan tablolarda silme işlemi
SELECT * FROM calisanlar;--parent
SELECT * FROM adresler;--child

DELETE FROM calisanlar;
--ref alınan kayıtlar old için silme işlemi tamamlanmaz
DELETE FROM calisanlar WHERE id='10003';
--10003 satırı ref alındığı için silme işlemi tamamlanmaz
--FK constrainti ref alınan kayıtların silinmesini engeller

DELETE FROM adresler WHERE adres_id='10002';
--10002 id li calisan artık ref alınmıyor
DELETE FROM calisanlar WHERE id='10002';
--artık bu satır başka tabloda ref alınmıyor

DELETE FROM adresler;
DELETE FROM calisanlar;
--calisanlar tablosunu ref alan tüm kayıtlar silinince
--ilişki koparıldığı için tüm kayıtların silinmesine izin verdi


