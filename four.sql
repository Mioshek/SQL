--Przykladowe 1
DECLARE @NAZWISKO VARCHAR (50)
SELECT @NAZWISKO = NAZWISKO FROM PRACOWNICY ORDER BY Data_zatrud DESC
PRINT 'Najwczesniej zatrudniona osoba to: '+ @NAZWISKO
--Przykladowe 2
DECLARE @LICZBA INT
SELECT @LICZBA = COUNT ( Id_pracownika ) FROM PRACOWNICY
WHERE Stanowisko = 'Sprzedawca '
PRINT 'Jest'+ CAST ( @LICZBA AS VARCHAR (2) ) +' sprzedawcow '
--Przykladowe 3
DECLARE @nazwisko VARCHAR (50)
SELECT @nazwisko = NAZWISKO FROM PRACOWNICY ORDER BY Zarobki DESC
IF LEFT ( @nazwisko ,1) ='K'
BEGIN
PRINT 'NAZWISKO NAJMNIEJ ZARABIAJACEGO PRACOWNIKA ZACZYNA SIE NA K'
PRINT 'JEST TO: '+ @NAZWISKO
END
ELSE
PRINT 'NAZWISKO NAJMNIEJ ZARABIAJECEGO PRACOWNIKA NIE ZACZYNA SIE NA K'
--Przykladowe 4
SELECT nazwisko ,
CASE
WHEN id_depart =10 THEN 'pracuje w ksiegowosci'
WHEN id_depart =20 THEN 'pracuje w badaniach'
WHEN id_depart =30 THEN 'pracuje w sprzedazy'
--WHEN id_depart =40 then ’pracuje w innowacjach ’
ELSE 'pracuje w innowacjach'
END AS [ Przypisanie ]
FROM Pracownicy
--Przykladowe 5
CREATE PROCEDURE p_NajwczesniejZatrudniony
( @IDdepart int = 0 ,
@Data date OUTPUT
)
AS
SELECT @Data = max( Data_zatrud )
FROM PRACOWNICY
WHERE Id_depart = @IDdepart
GO
Declare @D date
EXEC p_NajwczesniejZatrudniony 20 , @D OUTPUT
Select @D
--Przykladowe 6
CREATE VIEW widok ( stanowisko , najwyzsze_zarobki )
AS SELECT stanowisko , max( zarobki ) FROM pracownicy
GROUP BY stanowisko
GO
-- sprawdzenie
SELECT * FROM widok
--Przykladowe 7
CREATE TRIGGER zakaz ON PRACOWNICY
after UPDATE
AS
BEGIN
IF update ( zarobki )
begin
update PRACOWNICY set Zarobki = deleted . zarobki
from deleted join PRACOWNICY
on PRACOWNICY . Id_pracownika = deleted . Id_pracownika
where deleted . zarobki > PRACOWNICY . Zarobki
end
end
go
-- sprawdzenie
update PRACOWNICY set Zarobki = Zarobki -1000 where id_pracownika =2
--Przykladowe 8
CREATE TABLE Produkty (
ID_produktu int NOT NULL PRIMARY KEY autoincrement ,
Ilosc int NOT NULL ,
Nr_magazynu int NOT NULL
)
INSERT INTO Produkty ( Ilosc , Nr_magazynu )
VALUES (100 , 1)
INSERT INTO Produkty ( Ilosc , Nr_magazynu )
VALUES (450 , 2)
INSERT INTO Produkty ( Ilosc , Nr_magazynu )
VALUES (200 , 3)
begin transaction
save transaction zamiana
update Produkty set nr_magazynu =2 where nr_magazynu =1
if ( select SUM( ilosc ) from produkty where nr_magazynu =2) >500
begin
rollback transaction zamiana
update produkty set nr_magazynu =3 where nr_magazynu =1
end
commit transaction


--Zad1
DECLARE @ZAROBKI decimal(10,2)
SELECT @ZAROBKI = MAX(Zarobki) FROM Pracownicy
PRINT 'Najwyższe zarobki w firmie: ' + CAST(@ZAROBKI AS Varchar(10))
--Zad2
DECLARE @ZAROBKI decimal(10,2), @NAZWISKO varchar(20), @DATA_ZATRUD char(10)
SELECT @ZAROBKI = Zarobki,
    @NAZWISKO = Nazwisko,
    @DATA_ZATRUD = Data_zatrud
FROM Pracownicy
ORDER BY Data_zatrud DESC
PRINT 'Pracownik ' + @NAZWISKO + ' został zatrudniony w dniu ' + @DATA_ZATRUD + ' i zarabia ' + CAST(@ZAROBKI as varchar(10));
--Zad3
DECLARE @srednia int
SELECT @srednia = AVG(Zarobki) FROM PRACOWNICY 
IF @srednia < 1600
BEGIN
PRINT 'Zarobki sa za male'
PRINT 'JEST TO: ' 
PRINT @srednia
END
ELSE
PRINT 'Zarobki sa w porzadku'
PRINT 'JEST TO: ' 
PRINT @srednia
---Zad4
DECLARE @zamowienia int
SELECT @zamowienia = COUNT(OrderID) FROM Orders
WHERE EmployeeID = 6
IF (@zamowienia > 0)
    PRINT 'Klient o podanym identyfikatorze obsługiwał: ' + CAST(@zamowienia as varchar(20)) + ' zamówień.'
ELSE
    PRINT 'Klient o podanym identyfikatorze nie obsługiwał żadnych zamówień.'
--Zad5
UPDATE Pracownicy
SET Zarobki =
CASE
    WHEN Zarobki < 3000 THEN  Zarobki * 1.2
    ELSE Zarobki - 100
END
SELECT * FROM Pracownicy
--Zad 6
SELECT imie, nazwisko, stanowisko, CASE
    WHEN Zarobki < 1500 THEN 'Niskie zarobki'
    WHEN Zarobki > 1500 and Zarobki <3000 THEN 'Srednie zarobki'
    ELSE 'Wysokie zarobki'
END as 'Pensja'
from Pracownicy