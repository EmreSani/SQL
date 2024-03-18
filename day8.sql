--------------DAY'8 DT-----------------
CREATE TABLE words
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);
INSERT INTO words VALUES (1011, 'ahata', 3);

-- NOT LIKE :belirli bir karakter desenine benzemeyenleri getirir
--  !~(REGEXP_LIKE) :belirli bir regex i içermeyenleri getirir

-- ilk harfi h veya H olmayan kelimelerin tum bilgilerini yazdiran QUERY yaziniz.

SELECT *
FROM words
WHERE word NOT ILIKE 'h%'
--
SELECT *
FROM words
WHERE word !~* '^h'


--39-String Fonksiyonlar

CREATE TABLE teachers(
id int,
firstname varchar(50),
lastname varchar(50),
age int,	
city varchar(20),
course_name varchar(20),
salary real	
);
INSERT INTO teachers VALUES(111,'AhmeT  ','  Han',35,'Istanbul','SpringMVC',5000);
INSERT INTO teachers VALUES(112,'Mehmet','Ran ',33,'Van','HTML',4000);
INSERT INTO teachers VALUES(113,' Bilal','Fan ',34,'Bursa','SQL',3000);
INSERT INTO teachers VALUES(114,'Celal',' San',30,'Bursa','Java',3000);
INSERT INTO teachers VALUES(115,'Deniz',' Can',30,'Istanbul','SQL',3500);
INSERT INTO teachers VALUES(116,'ekreM','Demir',36,'Istanbul','Java',4000.5);
INSERT INTO teachers VALUES(117,'Fatma','Celik',38,'Van','SpringBOOT',5550);
INSERT INTO teachers VALUES(118,'Hakan','Cetin',44,'Izmir','Java',3999.5);
INSERT INTO teachers VALUES(119,'mert','Cetin',32,'Izmir','HTML',2999.5);
INSERT INTO teachers VALUES(120,'Nilay','Cetin',32,'Izmir','CSS',2999.5);
INSERT INTO teachers VALUES(121,'Selma','Celik',40,'Ankara','SpringBOOT',5550);
INSERT INTO teachers VALUES(122,'fatiH','Can',32,'Ankara','HTML',2550.22);
INSERT INTO teachers VALUES(123,'Nihat','Keskin',32,'Izmir','CSS',3000.5);
INSERT INTO teachers VALUES(124,'Hasan','Temel',37,'Istanbul','S.Security',3000.5);

SELECT * FROM teachers;

--teachers tablosundaki tüm kayıtların 
--firstname değerlerini büyük harfe 
-- lastname değerlerinin küçük harfe çevirerek 
--uzunlukları ile birlikte listeleyiniz.

SELECT UPPER(firstname) fname,LENGTH(firstname) fname_length,
       LOWER(lastname) lname,LENGTH(lastname) lname_length
FROM teachers;

--teachers tablosunda firstname ve lastname değerlerindeki 
--başlangıç ve sondaki boşlukları kaldırınız.

UPDATE teachers
SET firstname=TRIM(firstname),lastname=TRIM(lastname)


--teachers tablosunda tüm kayıtların firstname değerlerini
-- ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.

SELECT INITCAP(firstname)
FROM teachers;

--teachers tablosunda firstname değerlerinde 'Celal' kelimesini 'Cemal' ile değiştiririnz.

UPDATE teachers
SET firstname=REPLACE(firstname,'Celal','Cemal')

--teachers tablosunda tüm kayıtların city değerlerinin
-- ilk 3 harfini görüntüleyiniz.

SELECT SUBSTRING(city,1,3)
FROM teachers;

--calisanlar4 tablosunda Vakkonun sehir sütununda son şubesi ifadesini kaldıralım
SELECT * FROM calisanlar4

UPDATE calisanlar4
SET sehir=SUBSTRING(sehir,1,LENGTH(sehir)-7)
WHERE isyeri='Vakko'


--40-FETCH NEXT n ROW ONLY:sadece sıradaki ilk n satırı getirir--SQL standardı
--                  LIMIT n:sadece sıradaki ilk n satırı getirir--PostgreSQL ve bazı DBMS
--                  OFFSET n: n satırı atlayıp sonrakileri getirir


--developers tablosundan ekleme sırasına göre ilk 3 kaydı getiriniz.

SELECT * 
FROM developers
FETCH NEXT 3 ROW ONLY
--veya
SELECT * 
FROM developers
LIMIT 3

--developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.
SELECT *
FROM developers
OFFSET 2 ROW--ROW zorunlu değil
LIMIT 3

--developers tablosundan maaşı(salary) en düşük ilk 3 kaydı getiriniz.

SELECT *
FROM developers
ORDER BY salary ASC
FETCH NEXT 3 ROW ONLY;

--developers tablosundan yaşı daha küçük
--maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.

SELECT *
FROM developers
ORDER BY salary DESC, age ASC
OFFSET 1
LIMIT 1


--41-ALTER TABLE:tabloyu güncellemek için kullanılır:DDL
/*
add column ==> yeni sutun ekler
drop column ==> mevcut olan sutunu siler
rename column.. to.. ==> sutunun ismini degistirir      
rename.. to.. ==> tablonun ismini degistirir
*/


--calisanlar4 tablosuna yas (int) seklinde yeni sutun ekleyiniz.

ALTER TABLE calisanlar4
ADD COLUMN yas INTEGER

--calisanlar4 tablosuna remote (boolean) seklinde yeni sutun ekleyiniz.
--varsayılan olarak remote değeri TRUE olsun

ALTER TABLE calisanlar4
ADD COLUMN remote BOOLEAN DEFAULT TRUE

--örnek bir satır ekleyelim
INSERT INTO calisanlar4(isim,isyeri) VALUES('Jack Sparrow','Trendyol');

--calisanlar4 tablosunda yas sutununu siliniz.
ALTER TABLE calisanlar4
DROP COLUMN yas

--calisanlar4 tablosundaki maas sutununun data tipini real olarak güncelleyiniz.

ALTER TABLE calisanlar4
ALTER COLUMN maas TYPE REAL

--calisanlar4 tablosundaki maas sutununun ismini gelir olarak güncelleyiniz.
ALTER TABLE calisanlar4
RENAME COLUMN maas TO gelir

--calisanlar4 tablosunun ismini employees olarak güncelleyiniz.
ALTER TABLE calisanlar4 RENAME TO employees

--employees tablosunda id sütunun data tipini varchar(20) olarak güncelleyiniz.
ALTER TABLE employees
ALTER COLUMN id TYPE VARCHAR(20)

--employees tablosunda id sütunun data tipini int olarak güncelleyiniz.

ALTER TABLE employees
ALTER COLUMN id TYPE INTEGER USING id::integer

--employees tablosunda isim sütununa NOT NULL constrainti ekleyiniz.

ALTER TABLE employees
ALTER COLUMN isim SET NOT NULL


--NOT:içinde kayıtlar bulunan bir tabloya constraint eklemek
--istersek, sütündaki datalar eklenen constrainti sağlıyor olmalı. 

--companies tablosunda company_id sütununa PRIMARY KEY constrainti ekleyiniz.
ALTER TABLE companies
ADD /*CONSTRAINT c_pk*/ PRIMARY KEY(company_id)


--companies tablosunda company_name sütununa UNIQUE constrainti ekleyiniz.
ALTER TABLE companies
ADD UNIQUE(company_name)

--orders tablosunda company_id sütununa FOREIGN KEY constrainti ekleyiniz.
DELETE FROM orders WHERE company_id IN (104,105)

ALTER TABLE orders
ADD FOREIGN KEY(company_id) REFERENCES companies(company_id)

--orders tablosundaki FK constrainti kaldırınız.
ALTER TABLE orders
DROP CONSTRAINT orders_company_id_fkey

--employees tablosunda isim sütununda NOT NULL constraintini kaldırınız.
ALTER TABLE employees
ALTER COLUMN isim DROP NOT NULL


--42-TRANSACTION:databasede en küçük işlem birimi 
--       BEGIN:transactionı başlatır
--       COMMIT:transactionı onaylar ve sonlandırır
--       SAVEPOINT: kayıt noktası oluşturur
--       ROLLBACK:değişikleri mevcut duruma geri döndürür,transactionı sonlandırır

--PGADMIN:auto-commit

CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);--hesaplar tablosu 1 transactionda oluşturulur,auto-commit

INSERT INTO hesaplar VALUES(123,'Barnie',10000.3),
(124,'Fred',9000.5),
(125,'Wilma',8000.5),
(126,'Betty',7000.5)
;

DELETE FROM hesaplar WHERE hesap_no=123;
DELETE FROM hesaplar WHERE hesap_no=124;

UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=126;
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=125;

SELECT * FROM hesaplar;

------------------------------------------------------------------
BEGIN;
CREATE TABLE hesaplar2
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

INSERT INTO hesaplar2 VALUES(123,'Barnie',10000.3),
(124,'Fred',9000.5),
(125,'Wilma',8000.5),
(126,'Betty',7000.5)
;

BEGIN;--yeni transaction

DELETE FROM hesaplar2 WHERE hesap_no=123;
DELETE FROM hesaplar2 WHERE hesap_no=124;

ROLLBACK;
--NEGATİF SENARYO
BEGIN;
UPDATE hesaplar2 SET bakiye=bakiye-1000 WHERE hesap_no=126;
--sistemde problem oluştu
UPDATE hesaplar2 SET bakiye=bakiye+1000 WHERE hesap_no=125;

ROLLBACK;



--POZİTİF SENARYO
--try{
BEGIN;
UPDATE hesaplar2 SET bakiye=bakiye-1000 WHERE hesap_no=126;
UPDATE hesaplar2 SET bakiye=bakiye+1000 WHERE hesap_no=125;

COMMIT;
--}catch(){
ROLLBACK;--en son commitlenmiş haline döner
--}

SELECT * FROM hesaplar2;

------------------------------
BEGIN;
CREATE TABLE hesaplar3
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);--hesaplar tablosu 1 transactionda oluşturulur,auto-commit

INSERT INTO hesaplar3 VALUES(123,'Barnie',10000.3),
(124,'Fred',9000.5),
(125,'Wilma',8000.5),
(126,'Betty',7000.5)
;
SAVEPOINT x; 

DELETE FROM hesaplar3 WHERE hesap_no=123;
DELETE FROM hesaplar3 WHERE hesap_no=124;

UPDATE hesaplar3 SET bakiye=bakiye-1000 WHERE hesap_no=126;
UPDATE hesaplar3 SET bakiye=bakiye+1000 WHERE hesap_no=125;

ROLLBACK TO x;--x noktasına döner
ROLLBACK;--en son commite döner

SELECT * FROM hesaplar3;
















