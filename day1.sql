--YORUM SATIRI
---------------------DAY'1----------------------
--1-database oluşturma-DDL
CREATE DATABASE deneme;

--2-database silme-DDL
DROP DATABASE deneme;

--3-tablo oluşturma-DDL
CREATE TABLE students(
id char(4),
name varchar(50),
grade real,
register_date date	
); 

--4-var olan tablodan yeni tablo oluşturma
CREATE TABLE grades AS SELECT name,grade FROM students;

--5-tabloya tüm fieldlarıyla data ekleme
INSERT INTO students VALUES('1001','Sherlock Holmes',99.9,'2023-04-23');
INSERT INTO students VALUES('1002','Jack Sparrow',98,now());

--6-tabloya bazı fieldlarıyla data ekleme
INSERT INTO students(name,grade) VALUES('Harry Potter',99.9);

--7-tablodan tüm kayıtları tüm fieldlarıyla data okuma/çekme
SELECT * FROM students;
--8-tablodan tüm kayıtları belirli fieldlarıyla data okuma/çekme
SELECT name,grade FROM students;

CREATE TABLE tedarikciler(tedarikci_id char(6), 
						  tedarikci_isim varchar(50),
						  tedarikci_adres varchar(100),
						  ulasim_tarihi date);

SELECT * FROM tedarikciler;

CREATE TABLE tedarikci_ziyaret AS SELECT tedarikci_isim, ulasim_tarihi FROM tedarikciler;
						 
SELECT * FROM tedarikci_ziyaret;

--Parctice 02--
CREATE TABLE ogretmenler (
kimlik_no char(11),
isim varchar(20),
brans varchar(20),
cinsiyet varchar(10)
);

SELECT * FROM ogretmenler;

INSERT INTO ogretmenler VALUES('234431223','Ayse Guler','Matematik','kadin');

SELECT * FROM ogretmenler;

INSERT INTO ogretmenler(kimlik_no,isim) VALUES('567597624','Ali Veli');

SELECT * FROM ogretmenler;


