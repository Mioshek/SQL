--1b
INSERT INTO DEPARTMENT VALUES ( 10, 'Ksiegowosc' , 'Rzeszow') ;
INSERT INTO DEPARTMENT VALUES ( 20, 'Badan', 'Krakow') ;
INSERT INTO DEPARTMENT VALUES ( 30, 'Sprzedaz' , 'Zamosc' ) ;
INSERT INTO DEPARTMENT VALUES ( 40, 'Innowacji' , 'Wroclaw' ) ;
--1c
INSERT INTO PRACOWNICY VALUES (1,'Kowalski','Jan','Prezes',NULL,'2002-01-01',7000.20,NULL,10);
INSERT INTO PRACOWNICY VALUES (2,'Głowacki','Mateusz','Kierownik',1,'2002-05-01',3210,150,40);
INSERT INTO PRACOWNICY VALUES (3,'Sikorski','Adam','Kierownik',1,'2002-05-01',3210,250,20);
INSERT INTO PRACOWNICY VALUES (4,'Nowak','Stanislaw','Kierownik',1,'2002-05-01',3210,350,30);
INSERT INTO PRACOWNICY VALUES (5,'Wisniewski','Marcin','Sprzedawca',4,'2007-06-27',1210,250,30);
INSERT INTO PRACOWNICY VALUES (6,'Kochanowski','Juliusz','Sprzedawca',4,'2005-11-22',1210,260,30);
INSERT INTO PRACOWNICY VALUES (7,'Charysz','Szczepan','Sprzedawca',4,'2006-12-01',1210,200,30);
INSERT INTO PRACOWNICY VALUES (8,'Kordecki','Adam','Laborant',3,'2002-12-11',2210,150,20);
INSERT INTO PRACOWNICY VALUES (9,'Kopacz','Ewa','Laborant',3,'2003-04-21',2110,150,20);
INSERT INTO PRACOWNICY VALUES (10,'Ziolkowska','Krystyna','Laborant',3,'2002-07-10',2510,100,20);
INSERT INTO PRACOWNICY VALUES (11,'Szela','Katarzyna', 'Konsultant', 2, '2002−05−10', 2810, 100, 40);
INSERT INTO PRACOWNICY VALUES(12, 'Kedzior', 'Jakub', 'Analityk', 2, '2002−05−10', 2710, 120, 40);
INSERT INTO PRACOWNICY VALUES(13, 'Ziobro', 'Marlena', 'Konsultant', 2, '2003-02-13', 2610, 200, 40);
INSERT INTO PRACOWNICY VALUES(14, 'Pigwa', 'Genowefa', 'Ksiegowa', 1, '2002−01−02', 2000, NULL, 10);
--1d
ALTER TABLE dbo.PRACOWNICY
ADD Adres nvarchar(16)
--1e
ALTER TABLE PRACOWNICY DROP COLUMN Adres;
--1f
Update pracownicy set zarobki=zarobki+100 where id_depart=10;
--1g
EXEC sp_rename 'dbo.DEPARTMENT.id_depart', 'kod_dzialu';
--1h
EXEC sp_rename 'dbo.DEPARTMENT', 'DZIAL';
--1i
DELETE FROM Pracownicy where id_pracownika=14
--1j
ALTER TABLE PRACOWNICY ADD CONSTRAINT minimalna_krajowa CHECK (Zarobki>=1200);
--1k
INSERT INTO PRACOWNICY VALUES(14, 'Pigwa', 'Genowefa', 'Ksiegowa', 1, '2002−01−02', 1000, NULL, 10);
--1l
CREATE VIEW [Maksymalne Zarobki] AS
SELECT MAX(Zarobki) as MaxZarobki, Stanowisko
FROM Pracownicy
GROUP BY Stanowisko
select *
from [Maksymalne Zarobki]
--2a
DROP TABLE IF EXISTS dbo.Customers ;
CREATE TABLE dbo.Customers
(
custid INT NOT NULL PRIMARY KEY,
companyname NVARCHAR( 40 ) NOT NULL,
country NVARCHAR( 15 ) NOT NULL,
region NVARCHAR( 15 ) NULL,
city NVARCHAR( 15 ) NOT NULL
) ;
--2b
INSERT INTO Customers VALUES (100, 'Coho Winery', 'USA', 'WA', 'Redmont')



