drop table ogrenciler;
create table ogrenciler(
ogr_no int PRIMARY key, 
ogr_isim VARCHAR(30),
sinif int,
ders_id int)

insert into ogrenciler values(12,'Enes Erdem', 10, 1);
insert into ogrenciler values(33,'Melek Maden', 9, 3);
insert into ogrenciler values(54,'Burcu Deniz', 10, 8);
insert into ogrenciler values(18,'Polat Yildirim', 11, 2);
insert into ogrenciler values(42,'Defne Gumus', 12, 1);
insert into ogrenciler values(23,'Serpil Ates', 11, 4);
insert into ogrenciler values(45,'Mehmet Gunes', 9, 7);
insert into ogrenciler values(32,'Demet Bulut', 12, 6);
insert into ogrenciler values(68,'Fikret Yavuz', 10, 9);

drop table ogretmenler;
create table ogretmenler(
ogrt_id int PRIMARY key,
ogrt_isim VARCHAR(30),
ders_id int
)

insert into ogretmenler values(101,'Adem Alan',6);
insert into ogretmenler values(102,'Filiz Denge',2);
insert into ogretmenler values(103,'Gulsen Basar',3);
insert into ogretmenler values(104,'Osman Kok',4);
insert into ogretmenler values(105,'Mustafa Altin',8);
insert into ogretmenler values(106,'Mine Mutlu',1);
insert into ogretmenler values(107,'Hale Haktan',5);

drop table dersler;
create table dersler(
ders_id int PRIMARY key,
ders_isim VARCHAR(30),
ders_saati INT)


insert into dersler values(1, 'Matemateik', 8);
insert into dersler values(2, 'Fizik', 6);
insert into dersler values(3, 'Kimya', 6);
insert into dersler values(4, 'Biyoloji', 4);
insert into dersler values(5, 'Edebiyat', 4);
insert into dersler values(6, 'Cografya', 2);
insert into dersler values(7, 'Tarih', 2);

--SORU1: tum dersleri ve varsa bu dersleri
--alan ogrencilerın isimlerini listeleyiniz
--esas tablo nedir : dersler
--left join
--ders isimleri ve ogr isimleri
select ders_isim,ogr_isim from dersler d
left join ogrenciler ogr on ogr.ders_id=d.ders_id;


--SORU2: tum ogrencileri ve varsa bu ogrencilerin aldıkları dersleri listeleyiniz
--esas tablo nedir : ogrenciler
--left join
--ogr_isim,ders_isim
select ogr_isim,ders_isim from ogrenciler ogr left join dersler d on ogr.ders_id=d.ders_id

--SORU3: tum ogretmenleri ve varsa bu ogretmenlerin derslerini listeleyiniz
--esas tablo nedir : ogretmenler
--right join
--ogrt_isim ders_isim
select ogrt_isim,ders_isim from dersler d right join ogretmenler ogrt on ogrt.ders_id=d.ders_id;
select ogrt_isim, ders_isim from ogretmenler o left join dersler d on o.ders_id = d.ders_id;


--SORU4: tum dersleri ve varsa bu derslerin ogretmenlerini listeleyiniz
--esas tablo nedir : dersler
--left join
--ders_isim,ogrt_isim
select ders_isim,ogrt_isim from dersler d left join ogretmenler ogrt on ogrt.ders_id=d.ders_id;

--SORU5: tum ogretmenleri ve varsa  bu ogretmenlerin 
--verdiği dersi alan ogrencilerin isimlerini listeleyiniz
--esas tablomuz nedir : ogretmenler
--left join
--ogrt_isim ve ogr_isim
select ogrt_isim,ogr_isim from ogretmenler left join ogrenciler on ogretmenler.ders_id=ogrenciler.ders_id; 

--SORU6: ogrenciler tablosundaki ogrencilerden sadece
--dersler tablosundaki derslerden herhangi birini 
--alan ogrenci isimlerini listeleyiniz
--esas tablo nedir : yoktur
--inner join
--ogr_isim
select ogr_isim,ders_isim from ogrenciler 
inner join dersler on dersler.ders_id=ogrenciler.ders_id;

--SORU7: tum dersleri ve tum ogrenci isimlerini listeleyiniz
--full join
--ders_isim ve ogr_isim
select ders_isim,ogr_isim from ogrenciler full join dersler on ogrenciler.ders_id=dersler.ders_id

drop table memurlar2;
create table memurlar2(
memur_id int PRIMARY key,
memur_isim VARCHAR(50),
memur_maas int
);

Insert into memurlar2 VALUES(1,'çiğdem',100000);
INSERT into memurlar2 VALUES(2,'Duygu',150000);
Insert into memurlar2 values(3,'Aykut',110000);
INSERT into memurlar2 values(4,'Sıla');
--sila hanima maas degeri atamasi yapalim
update memurlar2 set memur_maas=200000 where memur_isim='Sıla';

--En dusuk veya en yuksek maas degerlerinin oldugu kayıtları listeleyin
--1. yol
select * from memurlar2 where
memur_maas=(select max(memur_maas)from memurlar2)
or memur_maas=(select min(memur_maas)from memurlar2)
--2.yol union
select * from memurlar2 where memur_maas=(select max(memur_maas)from memurlar2)
union
select * from memurlar2 where memur_maas=(select min(memur_maas)from memurlar2);


















