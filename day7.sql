--------------DAY'7 NT---------------------
--JOINS--BİRLEŞTİRME
--JOIN:ilişkili tablolarda ortak bir sütun baz alınarak(tipik olarak PK ve FK)
--bir veya daha fazla tablodaki sütunların birleştirilmesini sağlar.


CREATE TABLE companies  (
company_id int,  
company_name varchar(20)
);
INSERT INTO companies VALUES(100, 'IBM');
INSERT INTO companies VALUES(101, 'GOOGLE');
INSERT INTO companies VALUES(102, 'MICROSOFT');
INSERT INTO companies VALUES(103, 'APPLE');

CREATE TABLE orders (
order_id int,
company_id int,
order_date date
);
INSERT INTO orders VALUES(11, 101, '2023-02-17');  
INSERT INTO orders VALUES(22, 102, ' 2023-02-18');  
INSERT INTO orders VALUES(33, 103, ' 2023-01-19');  
INSERT INTO orders VALUES(44, 104, ' 2023-01-20');  
INSERT INTO orders VALUES(55, 105, ' 2022-12-21');


--33-INNER JOIN:baz aldığımız sütundaki sadece ortak olan kayıtları getirir

--iki tablodaki company_id'si aynı olanların company_id,company_name,
--order_date,order_id sini  listeleyiniz.
--(sipariş veren şirketlerin id,name,sipariş tarihi,sipariş idlerini görüntüleyiniz.)

SELECT c.company_id,company_name,order_id,order_date,o.company_id
FROM companies AS c INNER JOIN orders AS o
ON c.company_id=o.company_id

SELECT c.company_id,company_name,order_id,order_date,o.company_id
FROM orders AS o  INNER JOIN companies AS c
ON c.company_id=o.company_id

--INNER JOIN de ortak değerler olduğu için tablo sırası farketmez


--34-LEFT JOIN:baz aldığımız sütundaki, SOL(ilk) tablodaki tüm kayıtları getirir.
   --RIGHT JOIN:baz aldığımız sütundaki, SAĞ(ikinci) tablodaki tüm kayıtları getirir.
  
--companies tablosundaki tüm kayıtların company_id,company_name,
--order_date,order_idsini  listeleyiniz.
--(tüm şirketlerin bilgilerini ve siparişlerini listeleyiniz.)

SELECT c.company_id,company_name,order_id,order_date,o.company_id
FROM companies c LEFT JOIN orders o
ON c.company_id=o.company_id;
  
--orders tablosundaki tüm kayıtların company_id,company_name,
--order_date,order_idsini  listeleyiniz.  
--(tüm siparişleri ve sipariş veren şirket bilgilerini görüntüleyiniz)  
SELECT o.company_id,company_name,order_id,order_date
FROM companies c RIGHT JOIN orders o
ON c.company_id=o.company_id;  
  
SELECT o.company_id,company_name,order_id,order_date,c.company_id
FROM orders o LEFT JOIN companies c
ON c.company_id=o.company_id;
    
--LEFT/RIGHT JOIN tablo sıraları değiştirilerek alternatif olarak kullanılabilir. 

--35-FULL JOIN:baz aldığımız sütundaki, her iki tablodaki tüm kayıtları getirir.

SELECT c.company_id,company_name,order_id,order_date,o.company_id
FROM orders o FULL JOIN companies c
ON c.company_id=o.company_id;

SELECT *
FROM orders o FULL JOIN companies c
ON c.company_id=o.company_id;


--36-SELF JOIN : tablonun kendi içindeki bir sütunu baz alarak INNER JOIN yapılmasını sağlar. 

CREATE TABLE personeller  (
id int,
isim varchar(20),  
title varchar(60), 
yonetici_id int
);
INSERT INTO personeller VALUES(1, 'Ali Can', 'SDET',     2);
INSERT INTO personeller VALUES(2, 'Veli Cem', 'QA',      3);
INSERT INTO personeller VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personeller VALUES(4, 'Fatma Can', 'CEO',    null);

SELECT * FROM personeller;
--yöneticisi olan personelin ismi ile birlikte yöneticisinin ismini de veren bir sorgu oluşturunuz.

SELECT p.isim personel,m.isim yonetici
FROM personeller p INNER JOIN personeller m
ON p.yonetici_id=m.id

SELECT *
FROM personeller p INNER JOIN personeller m
ON p.yonetici_id=m.id


--37-LIKE Cond.:WHERE komutu ile birlikte kullanılır
--sorgularda belirli bir karakter deseni(pattern-dizisi) kullanarak filtreleme yapmayı sağlar
--ILIKE:LIKE gibi çalışır, CASE-INSENSITIVE dir.


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

SELECT * FROM words;


SELECT * FROM developers WHERE name='Enes Can' 
--SELECT * FROM developers WHERE name 'Enes ....'

--wildcard(joker-%):0 veya daha fazla karakteri temsil eder

SELECT * 
FROM developers
WHERE name LIKE 'A%'; --A,Ab,Abc,...
--küçük/büyük harf duyarlılığı olmasın

SELECT * 
FROM developers
WHERE name ILIKE 'a%';---a,A

--Ismi T ile başlayıp n harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin

SELECT name,salary 
FROM developers
WHERE name LIKE 'T%n';

--Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin

SELECT name,salary 
FROM developers
WHERE name LIKE '%an%';--anıl

--Ismi içinde e ve a olan devlerin tüm bilgilerini yazdiran QUERY yazin
--kemal,hande

SELECT *
FROM developers
WHERE name LIKE '%e%a%' OR name LIKE '%a%e%';
--veya
SELECT *
FROM developers
WHERE name LIKE '%a%' AND name LIKE '%e%';

--underscore(_):sadece 1 karakteri temsil eder
--Isminin ikinci harfi ü olan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM developers
WHERE name LIKE '_ü%'

--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM developers
WHERE prog_lang LIKE '__v_' 


--38-REGEXP_LIKE(~):belirli bir karakter deseni(regex) içeren kayıtları filtrelemeyi sağlar
--words ile devam edelim

--[] :içerisindeki karakterlerden sadece 1 ini temsil eder

--h harfinden sonra a veya i harfini sonra ise t harfini 
--içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.

SELECT * FROM words;

SELECT word
FROM words
WHERE word ~ 'h[ai]t';--hat,hit
--CASE-INSENSITIVE
SELECT word
FROM words
WHERE word ~* 'h[ai]t';--hat,hit gelir, hait gelmez

--[-] : bu iki karakter arasındaki tüm karakterlerden sadece 1 tanesini temsil eder

 --h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin tum bilgilerini  yazdiran QUERY yaziniz.
SELECT *
FROM words
WHERE word ~* 'h[a-k]t';--hat,hbt,hct,hkt gelir hlt gelmez

-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT *
FROM words
WHERE word ~* '[mi]'

--^:başlangıcı gösterir
--$:bitişi gösterir

--a ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^a'

--m ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* 'm$'

--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin.ÖDEV

--(.*) : 0 veya daha fazla karakter
--(.)  :sadece 1 tane karakter

--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^y(.*)f$';--yf,yaf,yulaf

--y ile başlayıp f ile biten 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin.ÖDEV


