CREATE DATABASE [index]
GO

SET quoted_identifier on
GO

SET DATEFORMAT mdy
GO

USE [index]
GO

CREATE TABLE "Opinia Pasazera"  (
    "Id_pasazera"       "int"             NOT NULL,
    "Id_polaczenia"     "int"             NOT NULL,
    "Opinia"            varchar (512)     null,
)

CREATE TABLE "Pasazer"  (
    "Id_pasazera"       "int"             NOT NULL,
    "Imie"              varchar (50)      NOT NULL,
    "Nazwisko"          varchar (50)      NOT NULL,
    "Pesel"             varchar (15)      NOT NULL,
    "Nr Tel"            varchar (20)      NULL,
    "Email"             varchar (50)      NULL,
    "Adres"             varchar (200)     NOT NULL,
)

CREATE TABLE "Kadra" (
    "Id_samolotu"       "int"             NOT NULL,
    "Imie"              varchar (50)      NOT NULL,
    "Nazwisko"          varchar (50)      NOT NULL,
    "Data Urodzenia"    date              NOT NULL,
    "Plec"              varchar (9)       NOT NULL,
)

CREATE TABLE "Pilot" (
    "Id_samolotu"       "int"             NOT NULL,
    "Imie"              varchar (50)      NOT NULL,
    "Nazwisko"          varchar (50)      NOT NULL,
    "Data Urodzenia"    date              NOT NULL,
    "Plec"              varchar (9)       NOT NULL,
    "Doswiadczenie"     "int"             null,
)

CREATE TABLE "Samolot" (
    "Id_samolotu"                   "int"           NOT NULL,
    "Model"                         varchar (50)    NOT NULL,
    "Pojemnosc Zbiornika"           float           NOT NULL,
    "Nosnosc"                       float           NOT NULL,
    "Miejsca Klasy Ekonomicznej"    "int"           NOT NULL,
    "Miejsca Klasy Biznes"          "int"           NULL,
    "Miejsca Pierwszej Klasy"       "int"           NULL,
)

CREATE TABLE "Lotniska" (
    "Id_lotniska"       "int"             NOT NULL,
    "Miasto"            varchar (50)      NOT NULL,
    "Nazwa"             varchar (50)      NOT NULL,
)

CREATE TABLE "Pracownicy" (
    "Id_pracownika"     "int"             NOT NULL,
    "Imie"              varchar (50)      NOT NULL,
    "Nazwisko"          varchar (50)      NOT NULL,
    "Data Urodzenia"    date              NOT NULL,
    "Plec"              varchar (9)       NOT NULL,
    "Email"             varchar (50)      NOT NULL,
    "Stanowisko"        varchar (50)      NOT NULL,
    "Id_lotniska"       "int"             NULL,
)

CREATE TABLE "Hangary" (
    "Id_hangaru"        "int"             NOT NULL,
    "Pojemnosc"         float             NOT NULL,
    "Zajety"            varchar (3)       NOT NULL,
    "Rok Budowy"        "int"             NOT NULL,
    "Id_lotniska"       "int"             NOT NULL,
)

CREATE TABLE "Rezerwacja" (
    "Id_miejsca"        "int"      NOT NULL,
    "Id_polaczenia"     "int"             NOT NULL,
    "Id_pasazera"       "int"             NOT NULL,
)

CREATE TABLE "Polaczenia" (
    "Id_polaczenia"     "int"             NOT NULL,
    "Id_samolotu"       "int"             NOT NULL,
    "Id_odlotu"         "int"             NOT NULL,
    "Id_przylotu"       "int"             NOT NULL,
    "Podstawowa Cena"   "int"             NOT NULL,
)

CREATE TABLE "Odlot" (
    "Id_odlotu"         "int"             NOT NULL,
    "Miasto"            varchar (50)      NOT NULL,
    "Id_lotniska"         "int"             NOT NULL,
    "Godzina"           time(7)           NOT NULL,
)

CREATE TABLE "Przylot" (
    "Id_przylotu"       "int"             NOT NULL,
    "Miasto"            varchar (50)      NOT NULL,
    "Id_lotniska"         "int"             NOT NULL,
    "Godzina"           time(7)           NOT NULL,
)

CREATE TABLE "Klasa Lotu" (
    "Typ Klasy"         varchar (20)      NOT NULL,
    "Id_klasy"          "int"             NOT NULL,
    "Mnoznik ceny"      float             NOT NULL,
)

CREATE TABLE "Posilki" (
    "Id_posilku"        "int"             NOT NULL,
    "Nazwa"             varchar (100)     NOT NULL,
    "Cena"              float             NOT NULL,
    "Typ Diety"         varchar (50)      NULL,
    "Kraj Pochodzenia"  varchar (50)      NULL,
    "Waga"              "int"             NOT NULL,
)

--done
CREATE TABLE "Udogodnienia" (
    "Id_klasy"      "int"                 NOT NULL,
    "Udogodnienie"  varchar (50)          NOT NULL,
)

CREATE TABLE "Miejsce" (
    "Id_miejsca"      "int"                 NOT NULL,
    "Id_klasy"        "int"                 NOT NULL,
    "Symbol Miejsca"   varchar (5)           NOT NULL,
)

ALTER TABLE  "Klasa Lotu" add primary key("Id_klasy")
ALTER TABLE  "Przylot" add primary key("Id_przylotu")
ALTER TABLE  "Odlot" add primary key("Id_odlotu")
ALTER TABLE  "Samolot" add primary key("Id_samolotu")
ALTER TABLE  "Pasazer" add primary key("Id_pasazera")
ALTER TABLE  "Polaczenia" add primary key("Id_polaczenia")
ALTER TABLE  "Miejsce" add primary key("Id_miejsca")
ALTER TABLE  "Lotniska" add primary key("Id_lotniska")

ALTER TABLE [Opinia Pasazera]
   ADD CONSTRAINT "FK_OpiniaPasazera_IdPasazera" FOREIGN KEY ("Id_pasazera")
      REFERENCES Pasazer ("Id_pasazera")

ALTER TABLE [Opinia Pasazera]
   ADD CONSTRAINT "FK_OpiniaPasazera_IdPolaczenia" FOREIGN KEY ("Id_polaczenia")
      REFERENCES Polaczenia ("Id_polaczenia")

ALTER TABLE Kadra
   ADD CONSTRAINT "FK_Kadra_IdSamolotu" FOREIGN KEY ("Id_samolotu")
      REFERENCES Samolot ("Id_samolotu")

ALTER TABLE Pilot
   ADD CONSTRAINT "FK_Pilot_IdSamolotu" FOREIGN KEY ("Id_samolotu")
      REFERENCES Samolot ("Id_samolotu")

ALTER TABLE Hangary
   ADD CONSTRAINT "FK_Hangary_IdLotniska" FOREIGN KEY ("Id_lotniska")
      REFERENCES Lotniska ("Id_lotniska")

ALTER TABLE Rezerwacja
	ADD CONSTRAINT "FK_Rezerwacja_IdMiejsca" FOREIGN KEY ("Id_miejsca") 
		REFERENCES Miejsce ("Id_miejsca")

ALTER TABLE Rezerwacja
   ADD CONSTRAINT "FK_Rezerwacja_IdPolaczenia" FOREIGN KEY ("Id_polaczenia") 
      REFERENCES Polaczenia ("Id_polaczenia")

ALTER TABLE Rezerwacja
   ADD CONSTRAINT "FK_Rezerwacja_IdPasazera" FOREIGN KEY ("Id_pasazera")
      REFERENCES Pasazer ("Id_pasazera")

ALTER TABLE Polaczenia
   ADD CONSTRAINT "FK_Polaczenia_IdSamolotu" FOREIGN KEY ("Id_samolotu")
      REFERENCES Samolot ("Id_samolotu")

ALTER TABLE Polaczenia
   ADD CONSTRAINT "FK_Polaczenia_IdOdlotu" FOREIGN KEY ("Id_odlotu")
       REFERENCES Odlot ("Id_odlotu")

ALTER TABLE Polaczenia
   ADD CONSTRAINT "FK_Polaczenia_IdPrzylotu" FOREIGN KEY ("Id_przylotu")
      REFERENCES Przylot ("Id_przylotu")

ALTER TABLE Odlot
   ADD CONSTRAINT "FK_Odlot_IdLotniska" FOREIGN KEY ("Id_lotniska")
      REFERENCES Lotniska ("Id_lotniska")

ALTER TABLE Przylot
   ADD CONSTRAINT "FK_Przylot_IdLotniska" FOREIGN KEY ("Id_lotniska")
      REFERENCES Lotniska ("Id_lotniska")

ALTER TABLE Miejsce
   ADD CONSTRAINT "FK_Miejsce_IdKlasy" FOREIGN KEY ("Id_klasy")
      REFERENCES [Klasa Lotu] ("Id_klasy")

ALTER TABLE Udogodnienia
   ADD CONSTRAINT "FK_Udogodnienia_IdKlasy" FOREIGN KEY ("Id_klasy")
      REFERENCES [Klasa Lotu] ("Id_klasy")

ALTER TABLE Pracownicy
    ADD CONSTRAINT "FK_Pracownicy_IdLotniska" FOREIGN KEY ("Id_lotniska")
       REFERENCES Lotniska ("Id_lotniska")
 
--Klasa Lotu 
INSERT INTO [Klasa Lotu] VALUES ('Ekonomiczna',1,1.0)
INSERT INTO [Klasa Lotu] VALUES ('Ekonomiczna Plus',2,1.2)
INSERT INTO [Klasa Lotu] VALUES ('Biznes',3,1.7)
INSERT INTO [Klasa Lotu] VALUES ('Pierwsza',4,3.0)

--Udogodnienia
INSERT INTO Udogodnienia
 VALUES (1,'Opaska na oczy')
INSERT INTO Udogodnienia
 VALUES (2,'Poduszka')
INSERT INTO Udogodnienia
 VALUES (2,'Kocyk')
INSERT INTO Udogodnienia
 VALUES (2,'Gniazdko')
INSERT INTO Udogodnienia
 VALUES (3,'Kapcie')
INSERT INTO Udogodnienia
 VALUES (3,'Sluchawki JBL')
INSERT INTO Udogodnienia
 VALUES (3,'Kabina pasazerska')
INSERT INTO Udogodnienia
 VALUES (3,'Regulowany fotel')
INSERT INTO Udogodnienia
 VALUES (3,'Tablet z filmami video')
INSERT INTO Udogodnienia
 VALUES (3,'Osobna bramka wejsciowa')
INSERT INTO Udogodnienia
 VALUES (3,'Skorzane fotele')
INSERT INTO Udogodnienia
 VALUES (3,'Rozkladany stolik 100cmx50cm')
INSERT INTO Udogodnienia
 VALUES (3,'Bezplatne posilki')
INSERT INTO Udogodnienia
 VALUES (4,'Osobne wejscie bramka')
INSERT INTO Udogodnienia
 VALUES (4,'Luksusowa kabina')
INSERT INTO Udogodnienia
 VALUES (4,'Fotele rozkladane do pozycji lozka')
INSERT INTO Udogodnienia
 VALUES (4,'Sluchawki Beats')
INSERT INTO Udogodnienia
 VALUES (4,'Posilki na zyczenie')
INSERT INTO Udogodnienia
 VALUES (4,'Prywatne salon, bar i restauracja na lotnisku')
INSERT INTO Udogodnienia
 VALUES (4,'Obsluga na zyczenie')

--Pasazer
INSERT INTO Pasazer
 VALUES (1,'Zuzanna','Kowalczyk','72091469482','+48 892094212','jjs4r1lnoln3@gmail.com','ul. Bialas 1328, Suite 615, 53-291, Polanica-Zdroj, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (2,'Zuza','Zakrzewska','66073098562','+48 412251711','tvfmzs52ju3r@gmail.com','ul. Siedlecki 49852, Apt. 141, 02-554, Lezajsk, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (3,'Elzbieta','Wroblewska','88092277564','+48 614219999','dqtc9g3dj1ey@gmail.com','ul. Jurek 71569, Apt. 654, 46-828, Krapkowice, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (4,'Marysia','Gorecka','51012861631','+48 178991194','qnzzf5b265ph@gmail.com','al. Napierala 2999, Apt. 887, 48-066, Olkusz, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (5,'Nina','Glowacka','88031057927','+48 212515790','t6huyuoki95m@gmail.com','ul. Kwiatkowski 964, Apt. 715, 79-235, Ksiaz Wielkopolski, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (6,'Roza','Gorska','94021389776','+48 322137323','1sb57j1b422n@gmail.com','al. Klimek 055, Apt. 047, 26-470, Wolsztyn, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (7,'Elzbieta','Kaminska','58072156387','+48 956034747','7tlo8kf5g88j@gmail.com','ul. Krupa 937, Suite 191, 72-952, Kolo, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (8,'Iza','Szulc','91082632311','+48 847914707','6pxbhf45dxux@gmail.com','al. Skalski 7707, Apt. 852, 15-936, Piaseczno, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (9,'Oktawia','Krupa','74101779965','+48 512608563','mvjmjp8s782n@gmail.com','ul. Kwiecinski 1104, Apt. 717, 29-130, Rzepin, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (10,'Miroslawa','Wozniak','71022313489','+48 663672682','v09cy6gx7noi@gmail.com','ul. Grzelak 39968, Suite 529, 26-952, Jedlicze, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (11,'Anatolia','Kubiak','85093012527','+48 642560159','90z8z3leg738@gmail.com','al. Siedlecki 82260, Apt. 761, 08-057, Czaplinek, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (12,'Amalia','Gajewska','00210418891','+48 956815397','u29ws906ox3c@gmail.com','ul. Borkowski 506, Suite 716, 53-255, Kolo, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (13,'Marcela','Szulc','58112298934','+48 554204737','m5x33ly7q5ev@gmail.com','ul. Czajka 5156, Suite 123, 51-214, Milakowo, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (14,'Antonina','Jasinska','56072599348','+48 994128592','67nwsnb38o6s@gmail.com','al. Witczak 43357, Suite 187, 14-756, Bochnia, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (15,'Amalia','Ostrowska','70031241682','+48 890470015','vgxxaq9w9yud@gmail.com','ul. Bialkowski 0668, Apt. 727, 67-364, Czarne, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (16,'Aisha','Blaszczyk','91092272811','+48 119602744','3mzvscipyh4k@gmail.com','al. Wilk 28194, Suite 497, 40-193, Stoczek lukowski, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (17,'Bernadetta','Kozlowska','51121994864','+48 813164197','xyrf9gesrmid@gmail.com','al. Flak 23692, Apt. 559, 31-368, Mragowo, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (18,'Julita','Szewczyk','80100364541','+48 441641340','xoskvt4fxnzz@gmail.com','al. Kopec 5261, Apt. 754, 62-859, Ciechanowiec, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (19,'Ada','Rutkowska','73060824839','+48 539807100','a5o0trt3xmb2@gmail.com','ul. Biernat 689, Suite 863, 49-294, Ostroda, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (20,'Zofia','Walczak','87120495976','+48 385017651','pxe8b8k5fbqn@gmail.com','ul. Ciesielski 6606, Apt. 952, 32-973, lobez, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (21,'Martyna','Pawlak','81011785717','+48 564161164','nyxytksm4oc4@gmail.com','al. Maslowski 92066, Apt. 698, 09-807, Sedziszow, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (22,'Luiza','Duda','70033138717','+48 257722102','743z9wzmabjf@gmail.com','ul. Mielczarek 54318, Suite 911, 82-128, Rypin, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (23,'Adela','Glowacka','05250173694','+48 859557946','vik3nooydl3i@gmail.com','ul. Klimczak 91002, Apt. 960, 47-820, Kolonowskie, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (24,'Eleonora','Szczepanska','58050173694','+48 363621468','mz0yha4jtsmj@gmail.com','al. Kosinski 1648, Suite 930, 04-208, Paslek, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (25,'Daria','Ostrowska','04211041311','+48 169033745','87klko6etsps@gmail.com','ul. Nowaczyk 35027, Apt. 555, 83-326, swidnik, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (26,'zaneta','Jankowska','06210979668','+48 739631856','va1dlm8pk3mz@gmail.com','ul. Bienkowski 149, Suite 691, 98-262, Busko-Zdroj, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (27,'Malgorzata','Zawadzka','63072661445','+48 144778216','89fcotyba2h5@gmail.com','ul. Michalczyk 14745, Suite 603, 38-249, Twardogora, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (28,'Jozefa','Marciniak','79011646983','+48 967489803','r8dgyd1y4ifr@gmail.com','al. lukasiewicz 3001, Suite 567, 90-289, Drezdenko, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (29,'Zuza','Pawlak','89062987232','+48 209479425','8l0h6jc65o0c@gmail.com','al. Przybyla 3075, Apt. 172, 28-326, Lipno, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (30,'Oktawia','Wojciechowska','92061025636','+48 328309252','jf45gxng24uy@gmail.com','ul. Wroblewski 8406, Suite 051, 10-050, Radzionkow, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (31,'Pamela','Bak','73020653785','+48 355409451','rwg4zt7fxw81@gmail.com','al. Szczepanik 76518, Apt. 003, 53-590, Opoczno, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (32,'Diana','Zawadzka','66090827615','+48 739555019','so8tw89k5tiw@gmail.com','ul. Maj 572, Suite 869, 13-878, Mragowo, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (33,'Otylia','Brzezinska','91051849733','+48 283240293','otdfq8z2xq47@gmail.com','al. Glogowski 818, Suite 281, 40-135, Slawno, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (34,'Jowita','Kalinowska','99102373338','+48 225060637','ledcs1kawi78@gmail.com','al. Soltysiak 0731, Suite 264, 13-691, Biala Podlaska, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (35,'Marysia','Nowak','68092565128','+48 831534477','bftyts65cat5@gmail.com','al. zurek 85516, Suite 277, 04-997, Wloszczowa, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (36,'Eleonora','Mazurek','60080864628','+48 760986257','igz12qxb77ig@gmail.com','ul. Florek 159, Apt. 276, 44-211, Sosnowiec, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (37,'Arleta','Walczak','87111092812','+48 533621687','4e7szflo43vh@gmail.com','al. Wypych 77932, Apt. 444, 72-461, Mirsk, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (38,'Celina','Blaszczyk','84101277844','+48 371242473','2usucl8ilw0p@gmail.com','al. Antczak 6597, Suite 109, 33-434, Goniadz, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (39,'Boguslawa','Baran','59121054155','+48 628400236','mzbpebv0mzgy@gmail.com','al. Balcerzak 9363, Suite 815, 57-210, Tychy, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (40,'Zofia','Szewczyk','03241585813','+48 693241805','oxrxy1nvc79u@gmail.com','al. Szczesny 016, Suite 778, 38-169, Szczuczyn, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (41,'Amanda','Pietrzak','57101631633','+48 319015824','dtg386dvhn9i@gmail.com','al. Kolodziejczyk 3614, Apt. 800, 66-991, Starachowice, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (42,'Urszula','Blaszczyk','70073098514','+48 684921500','dxr0lgmkzdbg@gmail.com','ul. Kogut 391, Apt. 583, 57-703, Grybow, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (43,'Julia','Czarnecka','90082454998','+48 359154049','ouc22xs4sxa3@gmail.com','al. Wojtasik 3490, Apt. 144, 99-259, swidnica, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (44,'zaneta','Kozlowska','91062658298','+48 319258356','dxkgxysghf4r@gmail.com','ul. Stachurski 193, Suite 335, 75-604, Radziejow, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (45,'Irena','Wojcik','91111684346','+48 828878370','s9szasjkrt2p@gmail.com','al. Witkowski 493, Apt. 418, 36-895, Dukla, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (46,'Wioletta','Zawadzka','83071614817','+48 650525774','mgckvcxtxz78@gmail.com','al. Gajda 96767, Suite 425, 32-278, Kowal, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (47,'Julianna','Gorska','01271455212','+48 450438838','4ahfnednck7u@gmail.com','al. Rudzki 1701, Apt. 789, 54-070, Dzierzoniow, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (48,'Alicja','Zalewska','94061361318','+48 135597545','a2f4gosookqu@gmail.com','ul. Florczak 1750, Suite 638, 99-134, Konstantynow lodzki, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (49,'Oliwia','Kaczmarczyk','77021894376','+48 838589320','d1n766drc5z2@gmail.com','al. Zareba 3948, Apt. 865, 86-880, scinawa, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (50,'Wiktoria','Gajewska','69081325518','+48 120324858','c2bxspl2h7ri@gmail.com','al. Rybak 8406, Suite 022, 52-008, Wejherowo, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (51,'Paula','Sobczak','89073013555','+48 941643315','gv6zo1sn00ny@gmail.com','al. Kubiak 08972, Apt. 995, 05-374, Mikolow, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (52,'Julita','Malinowska','76120182195','+48 534597246','xywxay07p7uz@gmail.com','ul. Wiacek 40855, Suite 296, 82-596, Chelmza, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (53,'Patrycja','Kazmierczak','86021149843','+48 270012720','jdgh9trccgcs@gmail.com','ul. Bartosik 27217, Suite 078, 58-892, Kruszwica, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (54,'Arleta','Jasinska','78101618141','+48 790492438','ef74gbils2rm@gmail.com','ul. Kubica 965, Suite 712, 47-331, Bolkow, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (55,'Aneta','Sokolowska','47100475927','+48 175244329','smy00j3tyz7j@gmail.com','al. Kula 75879, Apt. 818, 90-356, Alwernia, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (56,'Ada','Zawadzka','65102368373','+48 858396003','6f65t4htfmz6@gmail.com','ul. Wolny 4705, Apt. 882, 90-859, Niepolomice, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (57,'Wioletta','Zakrzewska','73102326763','+48 911146814','xrvqtxph77zb@gmail.com','ul. Serafin 33816, Suite 924, 84-989, Dobrodzien, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (58,'Adriana','Gorecka','84033142599','+48 997493935','rkuusuyls20w@gmail.com','al. Golec 985, Apt. 649, 49-472, Busko-Zdroj, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (59,'Edyta','Kalinowska','79031151858','+48 555001831','kreog2400wb7@gmail.com','al. Rogowski 81248, Suite 444, 01-411, Ryn, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (60,'Kamila','Kolodziej','56092554725','+48 512886571','f6a7kzf4r10n@gmail.com','al. Zagorski 186, Suite 518, 63-436, Tuchow, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (61,'Oliwia','Zawadzka','93041958797','+48 358505915','5p2lejx22s0v@gmail.com','al. Czarnecki 765, Apt. 758, 03-712, zarki, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (62,'Daniela','Sikora','94052687289','+48 495629771','j16kb5tdu5i1@gmail.com','ul. Lis 8769, Apt. 330, 91-153, Tarnogrod, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (63,'Konstancja','Krajewska','89032785998','+48 954441479','rlapkx232lww@gmail.com','al. Baranski 7891, Apt. 412, 98-325, Ksiaz Wielkopolski, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (64,'Ada','Borkowska','59060279664','+48 170022246','jceivwo761lq@gmail.com','al. swierczynski 735, Apt. 578, 69-242, Chojnice, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (65,'Dominika','Szewczyk','81121663327','+48 270525679','lqptkqc3150f@gmail.com','ul. Gruszka 424, Suite 208, 03-405, Lidzbark Warminski, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (66,'Paula','Walczak','59013155485','+48 181712061','xu68yb5trypw@gmail.com','ul. Borkowski 94009, Suite 422, 09-881, Izbica Kujawska, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (67,'Lara','Adamska','02211033279','+48 742069302','x9g8dvet6uj2@gmail.com','al. Slowinski 3089, Suite 902, 95-192, Pleszew, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (68,'Natalia','Szczepanska','49012086527','+48 759948529','5cy3543zsnp8@gmail.com','ul. Flis 857, Apt. 484, 50-964, Reszel, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (69,'Regina','Laskowska','63070688617','+48 697639534','is0psfrlgbm8@gmail.com','al. Januszewski 194, Apt. 206, 52-324, Wlen, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (70,'Andzelika','Szczepanska','95062348643','+48 143565189','urtc35feman4@gmail.com','ul. Zawadzki 76670, Suite 239, 81-210, swiecie, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (71,'Berenika','Borkowska','83030233538','+48 613090853','m5odsez4276j@gmail.com','al. Mika 47367, Suite 359, 95-313, Kcynia, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (72,'Danuta','Marciniak','65052495255','+48 926401185','eiapdok2c8g1@gmail.com','ul. Szewczyk 0584, Apt. 738, 89-122, Tarnow, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (73,'Adriana','Kozlowska','82102178454','+48 324284265','0aif29ao1k1y@gmail.com','ul. Niewiadomski 10710, Suite 206, 80-092, Ksiaz Wielkopolski, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (74,'Ola','Sobczak','00221123584','+48 570375159','qis2l10egajr@gmail.com','al. Sobczak 45556, Apt. 378, 27-016, Zagorow, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (75,'Jolanta','Laskowska','00230658431','+48 154081419','lgqarrbkkg81@gmail.com','ul. Maj 3896, Suite 684, 91-850, Miedzyrzec Podlaski, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (76,'Klara','Zalewska','89122675181','+48 359831789','wz8psewkinp3@gmail.com','ul. Bartkowiak 396, Suite 877, 65-216, Sedziszow Malopolski, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (77,'Matylda','Zalewska','90042514241','+48 437245695','wyar9chgkil0@gmail.com','al. Wojtkowiak 8232, Suite 761, 35-436, Kleszczele, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (78,'Marcela','Kwiatkowska','47060737143','+48 691912729','hhj9j2b67gal@gmail.com','ul. Skrzypek 6979, Apt. 229, 71-158, Sokolka, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (79,'Honorata','Jasinska','72120858131','+48 574054770','drvhspklbxsu@gmail.com','ul. Kosinski 698, Suite 617, 88-099, Siemianowice slaskie, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (80,'Lara','Rutkowska','85122376251','+48 614305994','17kr68y6yvrz@gmail.com','ul. Nawrocki 8215, Suite 228, 99-775, Gorzow Wielkopolski, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (81,'Monika','Jaworska','73122839513','+48 770072476','109i2yk2r861@gmail.com','ul. Drozd 28690, Suite 339, 39-500, Otmuchow, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (82,'Konstancja','Przybylska','85011551145','+48 483215784','v6ahihppfkq1@gmail.com','ul. Dobrzynski 936, Suite 396, 21-799, Makow Mazowiecki, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (83,'Izabela','Szymanska','98081221852','+48 140360818','e2h7v328ok8a@gmail.com','al. Kucharski 89629, Suite 753, 59-353, Wolczyn, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (84,'Lidia','Wysocka','59061851456','+48 969139796','2s2nlf3knrf1@gmail.com','ul. Adamczak 88870, Suite 724, 77-060, Szczekociny, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (85,'Lara','Szczepanska','73031614739','+48 961877827','mcvg5jptfdzm@gmail.com','al. Mrozek 2077, Apt. 686, 19-257, Niemodlin, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (86,'Wiktoria','Kubiak','78102267139','+48 690749448','85flrtqihsg2@gmail.com','ul. Dobrzynski 915, Suite 203, 88-360, Suchan, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (87,'Iga','Wasilewska','49010989242','+48 328132886','ypn5tg4kv6cu@gmail.com','ul. Piotrowski 7436, Suite 415, 33-883, Sierpc, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (88,'zaneta','Kolodziej','84081486418','+48 918168114','7z8hzvx3sz4d@gmail.com','ul. Dziedzic 7001, Apt. 096, 19-987, Lidzbark, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (89,'Cecylia','Rutkowska','53100453296','+48 299601541','ike7tdqi7oq8@gmail.com','al. Klos 827, Apt. 798, 02-574, Paczkow, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (90,'Zofia','Mazurek','58041672177','+48 572920413','qpbl4h3f4kug@gmail.com','ul. Adamus 6640, Apt. 341, 93-615, Swarzedz, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (91,'Lidia','Wojciechowska','00222073321','+48 914055329','lpchjvdplxkv@gmail.com','ul. Szydlowski 7590, Apt. 663, 61-167, swiatniki Gorne, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (92,'Gabriela','Wysocka','00271055422','+48 111508833','hkweuyv76dly@gmail.com','al. Kujawa 86238, Apt. 552, 33-096, Kozmin Wielkopolski, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (93,'Martyna','Walczak','86120584279','+48 411823876','nigg7lglagun@gmail.com','ul. Kurek 3514, Apt. 600, 85-226, Czarnkow, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (94,'Bianka','Jaworska','58091886456','+48 569229108','our9mh80ra8e@gmail.com','al. Kulik 52463, Suite 057, 34-270, Kolonowskie, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (95,'Bernadetta','Gorecka','78121568271','+48 469996843','11ce6mqlg4v9@gmail.com','ul. Warchol 7439, Suite 200, 79-706, Annopol, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (96,'Natasza','Kubiak','54101763364','+48 170866432','doflbflhj16f@gmail.com','al. Debowski 93145, Apt. 684, 90-580, lukow, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (97,'Asia','Pawlak','64080896184','+48 316401513','tnstm7fi8ixr@gmail.com','al. Antczak 703, Apt. 098, 36-448, Dzierzgon, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (98,'Izabela','Wozniak','73102913523','+48 177914854','6kp1uax20y7r@gmail.com','al. Motyka 0283, Apt. 142, 88-483, Myszkow, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (99,'Jadwiga','Krupa','93051916428','+48 559935215','r1i0itxq8e7x@gmail.com','ul. Lipinski 9242, Apt. 922, 70-823, Nowe Skalmierzyce, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (100,'Klaudia','Wasilewska','72122151645','+48 815758105','s8ezldv2i03c@gmail.com','al. Fijalkowski 4659, Apt. 374, 43-656, Sokolow Podlaski, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (101,'Anna','Ziolkowska','53090852466','+48 747985732','qfhy486w8c9p@gmail.com','al. Miller 7939, Suite 764, 63-370, Rawicz, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (102,'Ola','Szymanska','49070717838','+48 833512166','kdcan8xznw3f@gmail.com','ul. swiatek 6409, Apt. 965, 23-272, Mlynary, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (103,'Agnieszka','Laskowska','64122542493','+48 293946936','d5dwp0fgd7tw@gmail.com','ul. Cieslak 34989, Suite 340, 04-003, Nowy Targ, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (104,'Amalia','Szymczak','52102955294','+48 114075437','s5gjod1djpu4@gmail.com','al. Pietras 3172, Apt. 251, 61-048, Dobrzany, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (105,'Magdalena','Blaszczyk','59021645787','+48 517835644','1qhdk1xvvpoa@gmail.com','ul. Grudzien 79299, Suite 454, 24-951, Piastow, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (106,'Adrianna','Rutkowska','92111544467','+48 839220114','3q11oaot8gdm@gmail.com','ul. Januszewski 495, Apt. 681, 31-695, Bobowa, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (107,'Paulina','Zalewska','80070247842','+48 504143485','ssybm15blsv5@gmail.com','al. Dobosz 602, Suite 079, 44-160, Wysokie Mazowieckie, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (108,'Halina','Nowak','75081721698','+48 651512170','e9t4hi41kiks@gmail.com','ul. Niedzwiecki 0789, Suite 230, 42-932, Moryn, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (109,'Miroslawa','Ostrowska','96051699241','+48 641951502','m559iqtua5fg@gmail.com','al. Skrzypczak 892, Apt. 387, 11-633, Pyskowice, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (110,'Otylia','Kaczmarczyk','81121326778','+48 711696061','oabynva86crp@gmail.com','ul. Wiecek 55302, Suite 126, 90-662, Zielonka, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (111,'Joanna','Kucharska','67021172219','+48 415876853','pgv1yg01n3k4@gmail.com','ul. Janicki 4546, Suite 916, 27-627, Koniecpol, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (112,'Adriana','Czarnecka','90052083797','+48 739030977','ali34xr6pmah@gmail.com','al. Jozwiak 848, Apt. 531, 94-448, Marki, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (113,'Kornelia','Wojciechowska','78070385938','+48 205441471','lxo91gou1nxb@gmail.com','ul. Skibinski 200, Apt. 268, 14-127, Piechowice, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (114,'Izyda','Zalewska','69070527125','+48 817363144','p724tvko1gv4@gmail.com','ul. Jaskiewicz 64900, Apt. 820, 80-503, Krosno, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (115,'Julita','Zalewska','47031373163','+48 174850120','8df4mhasazwv@gmail.com','al. Drabik 6594, Suite 228, 31-541, Nowe Miasto Lubawskie, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (116,'Bogna','Szymczak','48112046682','+48 316396488','8sz4nw5eqpie@gmail.com','ul. Marchewka 9736, Apt. 242, 70-609, Katowice, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (117,'Magdalena','Krawczyk','59121634946','+48 927877824','dd27stw6zdm0@gmail.com','ul. Flis 19780, Apt. 055, 05-997, Czerwionka-Leszczyny, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (118,'Krystyna','Wlodarczyk','49070378396','+48 515897289','1p7njt69yfpa@gmail.com','al. Malec 682, Apt. 656, 52-934, Lubawka, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (119,'Jadwiga','Jankowska','50102798437','+48 970543480','r0fnid6zz5cq@gmail.com','ul. Blaszczak 5670, Suite 316, 41-944, Monki, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (120,'Jowita','Gorska','95120712913','+48 886074422','83xzpzntw48b@gmail.com','al. Lipinski 033, Apt. 864, 19-021, lukow, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (121,'Julia','Jakubowska','70011172263','+48 883337970','n1h5np4s1kru@gmail.com','al. Sobczyk 3658, Apt. 124, 08-578, Strzelin, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (122,'Adela','Rutkowska','01261373393','+48 690295606','jp8jqefaa4ri@gmail.com','al. Osinski 89174, Suite 388, 78-481, Sieniawa, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (123,'Katarzyna','Przybylska','56030575964','+48 645434684','cb4p35h3ed7i@gmail.com','al. Stachurski 453, Suite 876, 10-237, Krzepice, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (124,'Elena','Mazurek','03273074693','+48 451668459','830k1ytmz9u8@gmail.com','ul. Stachurski 98678, Suite 589, 26-323, Radymno, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (125,'Aneta','Przybylska','53032395383','+48 428772674','0ld2p17j1hhx@gmail.com','ul. Zaremba 6382, Apt. 383, 97-825, Bochnia, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (126,'Helena','Wasilewska','95120825831','+48 420114769','0fiwpuxgvd4o@gmail.com','ul. Rozycki 4311, Suite 908, 94-367, Krzywin, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (127,'Marcelina','Krajewska','03300432597','+48 274178629','k88d2xjlsxb3@gmail.com','ul. Lasota 002, Apt. 823, 84-172, Skoczow, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (128,'Luiza','Michalak','92100845834','+48 928580565','r3mtotu3q7ch@gmail.com','al. Markowski 2674, Apt. 430, 40-306, Biezun, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (129,'Bernadetta','Chmielewska','03283051985','+48 657455689','zsjngeuipr1n@gmail.com','ul. Przybysz 820, Apt. 528, 18-226, Raciborz, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (130,'Kinga','Szczepanska','55022722878','+48 855021119','8ynykhdqqtg1@gmail.com','al. Domanski 21831, Suite 500, 12-493, Ostrow Lubelski, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (131,'Halina','Szymanska','64022614179','+48 877841800','hlad4vbbxprt@gmail.com','ul. Grabowski 77684, Apt. 936, 59-676, Mlawa, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (132,'Gabriela','Kubiak','72052283261','+48 400861777','7r963lwf9qrr@gmail.com','al. Majcher 73024, Suite 807, 19-898, Skaryszew, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (133,'Adela','Wojciechowska','82070418514','+48 316233709','gah4mkojt4px@gmail.com','ul. Sobczyk 241, Apt. 460, 19-323, Blonie, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (134,'Boguslawa','Glowacka','60100385328','+48 297270283','lkdksn2dcxl8@gmail.com','al. Pietruszka 961, Suite 519, 46-172, Mszczonow, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (135,'Weronika','Szulc','68082874793','+48 247079866','uuq3d2tb8xpo@gmail.com','ul. Drozdz 80607, Suite 965, 13-926, Ozimek, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (136,'Pamela','Makowska','83072714394','+48 298731183','ni6zm0d7hs3u@gmail.com','ul. Michalczyk 59056, Suite 642, 40-199, Wolsztyn, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (137,'Teresa','Sadowska','73122688193','+48 646186780','n9fkfl9u9ulf@gmail.com','ul. Wojtasik 768, Apt. 071, 10-150, Gorlice, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (138,'Jowita','Kubiak','93070577231','+48 825113336','6mqlsaw5s7qk@gmail.com','ul. Baranski 0001, Apt. 509, 49-049, Sulecin, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (139,'Arleta','Lewandowska','76070492139','+48 462263234','kqq83vm2bpsq@gmail.com','ul. Krakowiak 4460, Apt. 999, 53-625, Ostrzeszow, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (140,'Maja','Szymczak','93021051863','+48 241225301','kcbn8glgcysl@gmail.com','ul. Zakrzewski 623, Apt. 160, 02-814, Olesnica, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (141,'Kinga','Urbanska','98122847159','+48 761031784','dittf57dbhny@gmail.com','ul. Czech 8623, Apt. 468, 55-550, Bystrzyca Klodzka, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (142,'Idalia','Stepien','59081718999','+48 482555066','y20hyz8qmw9z@gmail.com','al. Skalski 354, Suite 182, 07-526, Polczyn-Zdroj, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (143,'Milena','Wroblewska','57030898497','+48 117636872','h60uqu0knw3a@gmail.com','al. Bak 498, Apt. 965, 19-841, Rzeszow, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (144,'Jagoda','Kaminska','93111114191','+48 614855975','jufj0b9oylvd@gmail.com','al. Molenda 64531, Apt. 407, 59-123, Tomaszow Mazowiecki, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (145,'Anastazja','Walczak','01312564279','+48 902875100','6b77s6aawy4i@gmail.com','al. Wojcik 8236, Suite 709, 79-608, Staszow, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (146,'Malgorzata','Jasinska','69061668857','+48 706583750','c6fyewylsyeb@gmail.com','al. Wolski 3263, Apt. 114, 70-474, Zwolen, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (147,'Bernadetta','Krawczyk','68012949447','+48 280846966','ll8fi4406dga@gmail.com','al. Zietek 75691, Apt. 878, 90-073, Checiny, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (148,'Andzelika','Glowacka','83042624878','+48 474675597','k99q9unqe37f@gmail.com','ul. Wawrzyniak 7997, Apt. 754, 63-388, Pasym, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (149,'Florentyna','Kalinowska','02231212537','+48 551218048','v92cchtcahe3@gmail.com','al. Majka 825, Suite 747, 35-128, Kozuchow, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (150,'Aniela','Zielinska','52082226339','+48 780743899','otudqok7z68q@gmail.com','al. Duszynski 38514, Suite 627, 85-689, Golub-Dobrzyn, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (151,'Florentyna','Laskowska','04221159372','+48 713886163','0w01cqr23h2q@gmail.com','ul. Maciejewski 25556, Suite 673, 93-405, Suchowola, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (152,'Irena','Zalewska','56120844646','+48 541486961','3vsfwuqjyp4c@gmail.com','al. Lech 41994, Suite 063, 25-649, Biala Piska, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (153,'Antonina','Pietrzak','68061053867','+48 555989618','sw77h0d6ozca@gmail.com','ul. Pytel 83511, Suite 918, 47-621, Skarszewy, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (154,'Katarzyna','Sikorska','76071281772','+48 170221849','syou7m5gmf55@gmail.com','ul. Gorniak 2651, Suite 651, 28-160, Nowe, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (155,'Eleonora','Czerwinska','81102819848','+48 977674739','9d7fty2lh4vh@gmail.com','ul. Adamczak 999, Apt. 427, 54-836, Bedzin, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (156,'Lucyna','Laskowska','76063021142','+48 662919835','cucaymega7ww@gmail.com','ul. Borowski 0921, Suite 866, 99-331, Przeworsk, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (157,'Florentyna','Sikora','68020855497','+48 284489879','8s0p5dk2gkv1@gmail.com','ul. luczak 42224, Suite 012, 68-374, Stronie slaskie, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (158,'Dagmara','Marciniak','98121484748','+48 139996279','9z86kjk41d99@gmail.com','al. Zwolinski 1620, Apt. 049, 11-457, Wasosz, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (159,'Aneta','Stepien','86021824131','+48 956242751','2mf7nymu82qh@gmail.com','al. slusarczyk 038, Apt. 899, 39-725, scinawa, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (160,'Monika','Urbanska','92051438455','+48 282894112','ckawop3xcnks@gmail.com','ul. Wojtasik 1620, Suite 656, 37-250, Radlow, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (161,'Marta','Marciniak','66070118926','+48 545802089','1sdstgq13xlb@gmail.com','al. zuk 710, Apt. 284, 04-216, Bielawa, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (162,'Olimpia','Wysocka','92011938494','+48 192972856','erv7fdjgtmht@gmail.com','ul. Pietras 30608, Suite 222, 10-914, Debica, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (163,'Amelia','Szymanska','66120754559','+48 634726522','xbqxoqqjyng7@gmail.com','ul. Ptak 68451, Suite 805, 98-646, Drzewica, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (164,'Paulina','Kalinowska','61080541823','+48 595231272','tx28wpjlzx8a@gmail.com','al. Orzechowski 236, Suite 470, 45-302, Toszek, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (165,'Elwira','Lewandowska','47041999489','+48 471705275','8js0fz0vm8yp@gmail.com','ul. Slowik 96998, Suite 993, 51-174, Suraz, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (166,'Cecylia','Zakrzewska','76120794666','+48 922385005','pjr4x3l65ny7@gmail.com','al. Kowalski 12957, Apt. 876, 69-578, Pruszcz Gdanski, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (167,'Milena','Mazur','71032219878','+48 245348470','v3jvf0gf1nnn@gmail.com','al. Herman 10207, Suite 664, 84-256, Wyszogrod, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (168,'Czeslawa','Gorecka','88092764679','+48 980725522','z80p85z4odlu@gmail.com','ul. Wypych 644, Suite 066, 49-946, Paslek, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (169,'Boguslawa','Czarnecka','70052091745','+48 573529068','bhovsziir8o0@gmail.com','al. Maciejewski 0625, Apt. 762, 39-196, Ulanow, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (170,'Judyta','Chmielewska','88031411187','+48 976175257','idix3kuj7fdm@gmail.com','al. Kaczorowski 83372, Apt. 270, 29-143, Pieszyce, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (171,'Irena','Wojciechowska','89021524452','+48 564257091','9wlprki0h9fg@gmail.com','ul. Rudnicki 33654, Suite 413, 00-079, Brok, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (172,'Malwina','Malinowska','74032747925','+48 392189043','et9djbrbjxmz@gmail.com','al. Maslowski 01070, Apt. 228, 47-646, Okonek, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (173,'Barbara','Mazurek','92052613358','+48 866798193','q1bn5ys8oir2@gmail.com','al. Milewski 9955, Suite 165, 35-668, Staporkow, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (174,'Bernadetta','Sadowska','85063013914','+48 267305866','sw2ljdpg69xn@gmail.com','ul. Majewski 9247, Suite 126, 37-221, Pszow, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (175,'Amelia','Wojciechowska','97040281362','+48 258579876','tzecwykcfrbx@gmail.com','ul. Flak 445, Suite 924, 14-889, Pakosc, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (176,'Stefania','Kaczmarczyk','98101042157','+48 820841343','pj3b2cpgg1k2@gmail.com','ul. Wolinski 3811, Suite 686, 23-545, Tarnow, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (177,'Zuza','Andrzejewska','04282416748','+48 500295807','a1vp2ou1sl1q@gmail.com','al. Palacz 95561, Apt. 210, 21-334, Miroslawiec, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (178,'Alicja','Wlodarczyk','49110933541','+48 573966155','hzf0d1sehse4@gmail.com','ul. Krukowski 95253, Apt. 206, 99-533, Zawidow, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (179,'Aneta','Glowacka','65020674923','+48 206106602','d27k8v349693@gmail.com','al. Augustyn 483, Suite 219, 38-749, Wiecbork, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (180,'Maja','Krajewska','92050523431','+48 974963972','p8c1ec1n4gqm@gmail.com','ul. Dobrowolski 2401, Suite 717, 52-235, Jarocin, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (181,'Anna','Witkowska','54062536687','+48 131000402','r2f4utalvd8d@gmail.com','ul. Czarnecki 09227, Suite 750, 88-238, Czerniejewo, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (182,'Izabela','Tomaszewska','86011928131','+48 821694606','5xwzpqo2t97o@gmail.com','ul. Knapik 6961, Apt. 794, 00-586, Brzesc Kujawski, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (183,'Eleonora','Jakubowska','92061145141','+48 314021105','esj1rit5ftdn@gmail.com','ul. Skowron 28594, Suite 540, 89-752, Koscian, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (184,'Andzelika','Krawczyk','61012399311','+48 478479980','enmw9aufp5js@gmail.com','ul. Szymanski 966, Apt. 464, 39-892, Jedlicze, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (185,'Franciszka','Stepien','77070716175','+48 325196735','c4hlkz4s1y9v@gmail.com','ul. Krol 193, Suite 217, 05-579, Gniezno, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (186,'Sylwia','Wojciechowska','51070845316','+48 892794578','9roqkyfm3gqm@gmail.com','ul. Paluch 372, Suite 446, 01-283, Wodzislaw slaski, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (187,'Nina','Baranowska','03272139366','+48 504182251','bsw69c5yeb0i@gmail.com','al. Maslanka 506, Apt. 152, 63-753, Nowy Wisnicz, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (188,'Elzbieta','Gorecka','91032279539','+48 158784825','k39pndd5s1ki@gmail.com','al. Maliszewski 817, Apt. 784, 11-045, Zakliczyn, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (189,'Gabriela','Wysocka','85081586153','+48 203163083','f5qsifbmg481@gmail.com','ul. Czyzewski 097, Suite 053, 55-907, Szczawnica, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (190,'Marcela','Brzezinska','04222497617','+48 589001615','1419rtja2n07@gmail.com','al. Kulesza 49215, Suite 404, 27-559, zukowo, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (191,'Balbina','Kaczmarczyk','56021836665','+48 678246730','6pcdqeg4amwe@gmail.com','ul. Trzcinski 2895, Suite 314, 23-019, Gogolin, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (192,'Stefania','Rutkowska','05300567776','+48 445673492','u05e0istrp2e@gmail.com','al. Furman 017, Suite 968, 35-383, Tychowo, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (193,'Anna','Jakubowska','68031624455','+48 833188126','ckzbuzd33rbk@gmail.com','ul. Kasperek 114, Apt. 890, 12-225, Lubraniec, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (194,'Konstancja','Mroz','66120978898','+48 481401948','eebqz2x45j2a@gmail.com','ul. Szafranski 8941, Suite 683, 27-822, Zagorow, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (195,'Oksana','Wroblewska','85050743259','+48 193398549','n7y0v6t6rzvk@gmail.com','al. Serafin 208, Suite 218, 49-289, Zlotoryja, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (196,'Bianka','Michalak','90010265535','+48 575533545','5tiz4sbjxi4p@gmail.com','ul. Rutkowski 660, Apt. 300, 11-027, Barcin, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (197,'Balbina','Sadowska','88100919488','+48 453385452','tb2gxqvlyzra@gmail.com','al. Szczepanski 88919, Suite 447, 83-521, Polaniec, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (198,'Jolanta','Kaminska','04312595553','+48 850496525','zw062wl9h505@gmail.com','ul. Czerwinski 07038, Apt. 710, 34-742, Miedzychod, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (199,'Joanna','Kozlowska','47010557683','+48 958197516','e4fpxwoc3zz7@gmail.com','ul. Kwasniewski 714, Suite 990, 53-364, swidwin, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (200,'Hortensja','Bak','53021675364','+48 985006953','s3w3ws8eixlj@gmail.com','al. Domanski 634, Apt. 744, 80-655, Mikstat, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (201,'Dawid','Wozniak','58040472747','+48 745366069','r0qzsfbsl1pb@gmail.com','al. Kalinowski 3432, Suite 344, 50-945, Sejny, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (202,'Patryk','Baran','86020698829','+48 867429900','efrp3abw81ac@gmail.com','al. Glowacki 6241, Apt. 271, 29-743, Wieruszow, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (203,'Eustachy','Sadowska','90050232957','+48 116370140','cq85smg6fvuw@gmail.com','ul. Adamiak 9704, Apt. 883, 52-440, Nowogrod, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (204,'Ireneusz','Gorecki','53011883238','+48 544572050','l2x1ym2wudbu@gmail.com','ul. Surma 20747, Apt. 846, 64-339, Wielun, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (205,'Jan','Kalinowski','01270915575','+48 390849556','gv5jig1masgo@gmail.com','ul. Wieczorek 0316, Apt. 635, 86-160, Gluszyca, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (206,'Daniel','Mazur','59110871734','+48 174536306','gkmyhs5h42ur@gmail.com','al. Jedrzejewski 797, Apt. 914, 15-199, Kosow Lacki, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (207,'Aureliusz','Krajewska','70040537145','+48 758096479','4mj62f7yeexy@gmail.com','ul. Kolodziejczyk 4053, Suite 477, 32-647, Drzewica, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (208,'Albert','Kalinowski','05252124582','+48 142345389','o5t7xotduaks@gmail.com','al. Andrzejewski 915, Apt. 676, 73-051, Luban, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (209,'Bruno','Urbanska','74042211636','+48 909962053','827px7cn9w45@gmail.com','ul. zurek 0976, Apt. 572, 52-427, Dzialdowo, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (210,'Emil','Jakubowski','80092717169','+48 390530453','vfj2g0yk3kg8@gmail.com','al. Piasecki 462, Apt. 037, 84-415, Radziejow, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (211,'Mieszko','Borkowski','88012559556','+48 523042970','7grtt8r12cw4@gmail.com','ul. Kapusta 377, Apt. 302, 82-106, Skaryszew, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (212,'Marcin','Czarnecki','03230534596','+48 730588338','uau0k6l1nenh@gmail.com','al. Florczak 4412, Apt. 429, 97-874, Skorcz, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (213,'Antoni','Rutkowski','78082149621','+48 466302621','hzc95y8il1jv@gmail.com','ul. Szulc 42156, Suite 670, 48-998, Rabka-Zdroj, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (214,'Artur','Mazur','83122769422','+48 218840153','qtk48igwm9sf@gmail.com','al. Sikorski 0716, Suite 083, 57-016, Gorzow slaski, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (215,'Marcin','Zawadzki','58011462511','+48 508190265','ch67jeub2kkd@gmail.com','ul. Gajda 019, Apt. 260, 20-925, Darlowo, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (216,'Bruno','Rutkowski','99062345143','+48 849116190','56r8og8fuqqj@gmail.com','al. Nowak 8905, Apt. 743, 09-488, Lublin, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (217,'Ludwik','Baranowski','59082685579','+48 589158289','cra8g9xl99rm@gmail.com','ul. Bober 578, Suite 809, 90-024, Bolkow, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (218,'Krzysztof','Kozlowski','01210854665','+48 489749716','pp9ii5zjr3qf@gmail.com','al. Stachura 22261, Suite 275, 43-972, Kleczew, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (219,'Jacek','Kowalski','71012948361','+48 988541824','atajll64s1f7@gmail.com','al. Budzynski 64019, Suite 247, 31-070, Steszew, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (220,'Krystian','Kucharski','59021215827','+48 494411574','l529t6hdw3ql@gmail.com','al. Musial 4003, Suite 311, 52-880, Pasym, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (221,'Jakub','Witkowski','79020114293','+48 440455309','n6ejgdi62jtv@gmail.com','ul. Czaja 8134, Apt. 003, 79-459, Elblag, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (222,'Ireneusz','Krupa','06302559367','+48 589078449','2o5gq5xj93xh@gmail.com','al. Marchewka 39278, Apt. 981, 82-641, Stary Sacz, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (223,'Bogumil','Szymczak','97120574289','+48 610948387','4ud70a8yvau1@gmail.com','ul. Bieniek 5249, Apt. 531, 08-644, Ilawa, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (224,'Franciszek','Wasilewska','51092717954','+48 132794274','u5euu09lovao@gmail.com','ul. Skora 803, Apt. 815, 71-491, Sosnowiec, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (225,'Dorian','Ziolkowska','59120481525','+48 119473726','efnbmocl2prh@gmail.com','al. Cichy 5633, Suite 815, 94-505, Mosina, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (226,'Cezary','Szczepanski','70070957791','+48 264561987','drxuzdd5f5zh@gmail.com','al. Zielonka 18903, Apt. 999, 26-921, Tyczyn, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (227,'Julian','Dabrowski','51072259586','+48 164926436','zr41p20yblax@gmail.com','ul. Witkowski 345, Suite 672, 56-547, Chelmek, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (228,'Cezary','Dabrowski','64120847293','+48 724040940','8hir4abkdvu4@gmail.com','al. Matuszewski 98166, Apt. 707, 78-023, Bojanowo, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (229,'Aureliusz','Marciniak','76062499836','+48 496324943','ukqclm8i1cin@gmail.com','al. swiatek 50635, Suite 623, 66-184, Miedzylesie, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (230,'Oskar','Blaszczyk','04282289724','+48 796673150','jtues3akvu9f@gmail.com','ul. Jarzabek 30311, Apt. 547, 90-391, Kcynia, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (231,'Aureliusz','Jaworski','63080453924','+48 625731070','gmuwfocs2j13@gmail.com','ul. Krajewski 0344, Apt. 088, 67-842, Wisla, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (232,'Maciej','Urbanska','00210465954','+48 406729170','l6e0hdogwb1b@gmail.com','ul. Kus 5125, Suite 956, 14-782, Miloslaw, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (233,'Piotr','Baranowski','96012763354','+48 706700686','nf157l02c8nz@gmail.com','ul. Maciejewski 103, Apt. 504, 80-753, Sedziszow, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (234,'Kacper','Maciejewski','67061295394','+48 963078821','w5qoln9xgofe@gmail.com','al. Paluch 909, Suite 812, 65-475, Czarna Woda, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (235,'Arkadiusz','Baranowski','91031518983','+48 138501416','bytb2s4h66mx@gmail.com','ul. Grabowski 9923, Apt. 672, 95-691, Podkowa Lesna, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (236,'Alan','Wisniewski','71110198341','+48 824144919','c0kq8a44g1n2@gmail.com','ul. Stachura 2426, Apt. 228, 41-290, Lezajsk, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (237,'Kamil','Gajewska','49122932921','+48 928911222','uzklmdn97097@gmail.com','ul. Broda 2970, Apt. 507, 84-526, Drezdenko, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (238,'Aleksy','Zielinski','95070149247','+48 817344022','uzayysjcj0n0@gmail.com','ul. Chojnacki 804, Apt. 897, 54-731, Sulmierzyce, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (239,'Hubert','Zawadzki','81080394931','+48 210789917','xk2ize6x7cgc@gmail.com','ul. Rucinski 54270, Apt. 119, 68-600, Kazimierz Dolny, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (240,'Allan','Zawadzki','49032412171','+48 129716112','9ceuegegfyi0@gmail.com','ul. Przybyl 5779, Apt. 064, 76-699, Pilawa Gorna, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (241,'Ernest','Zalewski','06232814859','+48 570028582','0nfxe1ojouve@gmail.com','al. Frackowiak 7645, Suite 044, 85-744, smigiel, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (242,'Edward','Piotrowski','50070685577','+48 615594764','b4lw0m5xc8t0@gmail.com','ul. Siwek 087, Suite 344, 84-292, Chojna, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (243,'Marek','Czarnecki','03232529329','+48 132761221','1x3k0t77n45m@gmail.com','ul. slusarczyk 282, Suite 305, 66-922, Karczew, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (244,'Adrian','Ostrowski','59102912823','+48 590922791','iix6m7odq4kr@gmail.com','al. Czyz 147, Apt. 368, 13-542, Czerwiensk, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (245,'Kryspin','Glowacka','88020757377','+48 600332578','bi2fyk5vjxak@gmail.com','ul. Wlodarski 885, Apt. 445, 31-101, Braniewo, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (246,'Jaroslaw','Mazurek','91020319928','+48 893939961','vlobqi3dcbdv@gmail.com','ul. Bartczak 34222, Suite 136, 39-931, Lubsko, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (247,'Olgierd','Wroblewski','74072457938','+48 130742116','cy8jl2pd0kvo@gmail.com','al. Szczepaniak 8986, Suite 191, 54-083, Krapkowice, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (248,'Alex','Gorski','52062552784','+48 694086314','kte1xxfnfd1n@gmail.com','al. Bogusz 8111, Suite 065, 97-412, Izbica Kujawska, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (249,'Bartlomiej','Zielinski','98072582683','+48 432498189','70f3dgnvuo4b@gmail.com','ul. Banasiak 2052, Suite 782, 60-980, Olsztynek, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (250,'Ludwik','Wisniewski','79052476127','+48 632943940','kraibf9r9x6b@gmail.com','ul. Konopka 7636, Apt. 523, 94-635, Wiazow, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (251,'Maksymilian','Ostrowski','67041977465','+48 557939560','ketnlo9yer0w@gmail.com','ul. Zdunek 376, Apt. 859, 83-222, Warszawa, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (252,'Kewin','Kowalczyk','67061621823','+48 203108262','81ugb4ymttk7@gmail.com','ul. Majewski 4315, Apt. 491, 92-965, Dobre Miasto, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (253,'Amir','Przybylski','84050299876','+48 698984697','2lsoewmfdf88@gmail.com','al. Szelag 197, Apt. 933, 53-808, Lezajsk, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (254,'Remigiusz','Kalinowski','51101338439','+48 537605263','8bp9la001yn1@gmail.com','al. Szczesny 4038, Apt. 256, 05-136, Brzozow, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (255,'Mieszko','Kubiak','05270447579','+48 310124706','wc22vemc5f02@gmail.com','al. Tracz 324, Apt. 353, 62-632, Lezajsk, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (256,'Janusz','Urbanska','76031765863','+48 246566394','xk6zxupgsmed@gmail.com','al. Prus 14018, Apt. 851, 11-756, Myszkow, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (257,'Kazimierz','Szymanski','48102031935','+48 643020229','6k69wrhgomku@gmail.com','al. Turek 062, Suite 858, 21-350, Rajgrod, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (258,'Adrian','Sikorska','90112492741','+48 982938265','unlbzmb5q607@gmail.com','al. Pawlik 1320, Apt. 821, 62-324, Piotrkow Kujawski, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (259,'Dobromil','Marciniak','94052531496','+48 536467562','bsfq2h0klywn@gmail.com','ul. Gwozdz 606, Suite 422, 47-822, Belzyce, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (260,'Jaroslaw','Kaczmarczyk','70072473529','+48 950736728','gkvcnsh0ku3s@gmail.com','ul. Kowalczyk 36694, Apt. 418, 18-050, Czluchow, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (261,'Jozef','Krajewska','85120273659','+48 518869081','e9c5gkpzfunw@gmail.com','al. Mazur 6515, Apt. 215, 47-547, Czluchow, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (262,'Anastazy','Kalinowski','83080466218','+48 843333703','l8inn3kjeg2q@gmail.com','ul. Wasilewski 22266, Suite 942, 86-033, Orneta, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (263,'Jedrzej','Kowalski','80071184782','+48 851082213','iabu5d19z6nm@gmail.com','al. Jurkiewicz 781, Apt. 607, 91-594, Pelczyce, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (264,'Hubert','Sikorska','04220868879','+48 294179513','dljz546e2i00@gmail.com','al. Furman 7541, Apt. 928, 86-304, Sulmierzyce, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (265,'Emanuel','Zielinski','55040775269','+48 843382326','0962zenrqecg@gmail.com','al. Polak 68178, Suite 878, 56-920, Skala, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (266,'Piotr','Szymczak','76050933586','+48 587928817','aq0h8xwb6yzq@gmail.com','ul. Przybyla 950, Apt. 480, 42-142, Myslowice, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (267,'Jerzy','Malinowski','85122093888','+48 282716053','tbkk2q7k3g33@gmail.com','al. Szelag 980, Suite 354, 52-836, Ilawa, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (268,'Oskar','Mazurek','51062199221','+48 911934044','4c4ugi0xg2dk@gmail.com','ul. Paczkowski 497, Apt. 001, 65-067, Polanow, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (269,'Alfred','Kucharski','51110899749','+48 491931886','r3m9qdjzcp1w@gmail.com','ul. Stec 947, Apt. 581, 31-978, Dynow, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (270,'Andrzej','Lis','05303178267','+48 391950910','65fs3l9o95th@gmail.com','al. Kaczor 154, Suite 468, 01-551, Suchedniow, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (271,'Olaf','Przybylski','66030526242','+48 685684478','q8ohn324x8fr@gmail.com','ul. Rosiak 00616, Suite 977, 39-164, Inowroclaw, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (272,'Eugeniusz','Jasinski','92112297913','+48 676217751','e3176jopykd8@gmail.com','al. Pawlik 79520, Apt. 316, 46-554, Niemcza, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (273,'Ludwik','Kolodziej','81051332142','+48 511850723','9s4lpf0xgdn7@gmail.com','ul. Kuc 5005, Apt. 400, 24-472, Sejny, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (274,'Roman','Kucharski','66120491724','+48 977470096','mpdcxspu198y@gmail.com','al. Drabik 65444, Apt. 966, 93-078, Wodzislaw slaski, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (275,'Kamil','Krupa','63092771126','+48 761600938','tm6izoidxbs4@gmail.com','ul. Kulik 254, Apt. 019, 68-735, Goldap, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (276,'Alex','Makowski','73071468455','+48 773013643','21rddelpb96s@gmail.com','ul. Cieslak 511, Suite 060, 81-708, Szczebrzeszyn, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (277,'Oktawian','Adamska','82070346552','+48 261414017','nuhzan5weh8m@gmail.com','ul. Gorniak 406, Suite 062, 49-628, Katowice, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (278,'Patryk','Maciejewski','67111741145','+48 153593020','p4m1hh143sz8@gmail.com','ul. Kubica 645, Apt. 981, 23-774, Slawkow, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (279,'Jan','Czerwinski','48012614727','+48 672294884','47k5s02a2a3t@gmail.com','ul. Konieczny 6404, Suite 102, 01-501, Brzesc Kujawski, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (280,'Michal','Kaczmarczyk','83072126878','+48 720221838','4da56ks5ld84@gmail.com','ul. Kubica 2347, Apt. 226, 76-270, Kutno, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (281,'Blazej','Urbanska','60040177362','+48 759212568','km282nho5zf6@gmail.com','ul. Sobczyk 133, Apt. 765, 11-958, Gozdnica, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (282,'Leszek','Przybylski','79032864647','+48 446421883','w487uo8k1bde@gmail.com','al. Drozdz 00286, Suite 497, 74-870, Gorzow slaski, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (283,'Boleslaw','Kowalski','96032562559','+48 242916001','2peemuhx91m3@gmail.com','al. Karczewski 374, Apt. 073, 81-978, Blonie, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (284,'Cezary','Krajewska','02232231326','+48 196395382','3gsvtj6hat2d@gmail.com','ul. Czyz 08902, Apt. 243, 10-440, Rydzyna, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (285,'Dominik','Lewandowski','00320669772','+48 518376274','wieabuw8gy42@gmail.com','ul. Tomys 669, Suite 748, 61-803, Osiek, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (286,'Krzysztof','Wlodarczyk','72012917665','+48 321654883','o3bczynivpy7@gmail.com','al. Buczynski 18883, Suite 288, 56-940, Wiazow, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (287,'Jacek','Czarnecki','68022948218','+48 205862079','c60aekaktgdo@gmail.com','ul. Witek 29925, Apt. 315, 26-634, Ploty, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (288,'Aureliusz','Kalinowski','74062478644','+48 567093493','b07hpwe1ccfc@gmail.com','al. Wieckowski 16772, Apt. 952, 77-490, Checiny, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (289,'Bruno','Marciniak','73040364834','+48 592665468','sw61uuj289bv@gmail.com','al. Kopec 7706, Suite 418, 55-296, Kazimierz Dolny, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (290,'Florian','Walczak','92020513756','+48 235763884','tw55k7bqubja@gmail.com','ul. swiatek 8401, Apt. 889, 65-569, Nowy Tomysl, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (291,'Michal','Sawicki','63092968773','+48 965167719','ua7ph1x7qfo4@gmail.com','al. Jedrzejczyk 92116, Suite 082, 37-081, Blachownia, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (292,'Gustaw','Adamska','60031859945','+48 812350604','od1s2ma2l5b7@gmail.com','ul. Adamski 688, Apt. 998, 63-669, Darlowo, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (293,'Kornel','Borkowski','49010847272','+48 825127277','c796y70ja1gh@gmail.com','al. Pytel 494, Apt. 770, 44-916, Jawor, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (294,'Kacper','Glowacka','92021181558','+48 656206088','a3faawb7c6ow@gmail.com','al. Jakubowski 7550, Apt. 326, 94-394, Piaski, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (295,'Fryderyk','Kowalski','56041718536','+48 870546292','tg5k4zf54s9d@gmail.com','al. Ciesielski 506, Apt. 686, 65-466, Michalowo, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (296,'Dobromil','Szczepanski','97071788915','+48 557319617','2158uogd7uuq@gmail.com','al. Kulesza 18521, Apt. 872, 19-123, Gluszyca, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (297,'Leonardo','Kowalczyk','79092396915','+48 654471055','yfuak7nibkh0@gmail.com','al. Cybulski 237, Suite 184, 87-951, Slawkow, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (298,'Marcin','Gorski','02291576185','+48 264292419','m9xssia1m5xd@gmail.com','al. Paluch 530, Apt. 499, 43-239, Olsztyn, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (299,'Gracjan','Walczak','54092663997','+48 589474277','wvg4gidol6s3@gmail.com','al. Juszczak 909, Suite 353, 87-329, Przemkow, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (300,'Ksawery','Kazmierczak','60070985461','+48 697216675','qlkro0omh064@gmail.com','ul. Sikora 004, Apt. 322, 81-198, Miejska Gorka, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (301,'Antoni','Wysocki','00310733483','+48 402549897','69pw2nkien3y@gmail.com','ul. Jarosz 131, Apt. 101, 50-107, Sokolow Malopolski, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (302,'Andrzej','Marciniak','51120597648','+48 371587296','u07w6pt0h5mc@gmail.com','ul. Majcher 12347, Suite 714, 21-349, Grabow nad Prosna, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (303,'Gustaw','Ziolkowska','02242162238','+48 660907589','ly1d8ashrn0t@gmail.com','al. Jaworski 932, Suite 925, 26-269, Tuliszkow, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (304,'Filip','Wasilewska','96032888514','+48 930752671','3a66yw8asnrn@gmail.com','ul. Karwowski 9205, Suite 511, 26-502, Murowana Goslina, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (305,'Adam','Jankowski','55031055347','+48 983490153','b54f7c4g7rq2@gmail.com','al. Ptak 3566, Suite 307, 01-053, Zlocieniec, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (306,'lukasz','Glowacka','93021287312','+48 457280207','yinfexullxit@gmail.com','al. Kot 52648, Suite 009, 18-813, Krosniewice, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (307,'Fabian','Piotrowski','75020736462','+48 915099832','lrzlaw8ozj6f@gmail.com','ul. Jurkowski 64988, Apt. 231, 33-432, Kalisz Pomorski, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (308,'Julian','Makowski','78042178687','+48 735050860','b049iyfpij4j@gmail.com','ul. Mazurkiewicz 1288, Apt. 790, 76-465, Jedlina-Zdroj, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (309,'Ernest','Pietrzak','95061626555','+48 692980443','59agcpbj4y94@gmail.com','al. Zych 0972, Suite 681, 40-994, Ploty, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (310,'Edward','Jasinski','47050931683','+48 856140217','havt6or71svh@gmail.com','al. Rakowski 543, Suite 684, 82-701, Lublin, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (311,'Czeslaw','Wroblewski','80121832447','+48 174532189','4wipy3n99ao0@gmail.com','al. Antczak 007, Suite 696, 11-520, Garwolin, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (312,'Alan','Tomaszewski','71050124446','+48 122788511','l8l3osemmeau@gmail.com','al. Marcinkowski 535, Apt. 777, 21-468, Ilza, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (313,'Marek','Sokolowski','59042024499','+48 368613068','5838bpcqjm8e@gmail.com','ul. Iwanski 903, Suite 863, 84-306, Aleksandrow lodzki, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (314,'Gracjan','Wojciechowski','90042116382','+48 895287159','39dg3ulc1rks@gmail.com','ul. Lesniewski 893, Suite 541, 58-639, Biecz, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (315,'Kuba','Zawadzki','00260424871','+48 841636919','shuy9c66wrgw@gmail.com','ul. Madej 21025, Suite 771, 84-725, Czarne, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (316,'Pawel','Urbanska','56062211719','+48 746042306','v2d8s4qmrdw7@gmail.com','al. Modzelewski 9421, Apt. 648, 01-234, Rozan, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (317,'Arkadiusz','Kucharski','03313078182','+48 290818356','xy6x78gzbnog@gmail.com','ul. Ciszewski 5745, Apt. 298, 70-072, Tykocin, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (318,'Julian','Gajewska','84122478741','+48 690884075','a95og2txcz00@gmail.com','ul. Gil 79023, Suite 030, 28-803, Suchowola, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (319,'Boleslaw','Wojciechowski','86112166663','+48 138459796','dmtsoch07wu9@gmail.com','ul. Wojtczak 2252, Suite 692, 41-650, Obrzycko, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (320,'Jerzy','Sikorska','80112061942','+48 742801202','jl2y8et4nkxv@gmail.com','ul. Szczygiel 087, Apt. 540, 45-885, slesin, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (321,'Emanuel','Szymanski','91100845745','+48 683715489','bc344x0guxwu@gmail.com','ul. Marchewka 8040, Suite 933, 10-650, Ostrorog, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (322,'Maksymilian','Sawicki','73043059979','+48 581310758','jlq1flp6rbkw@gmail.com','al. Markowski 2068, Apt. 943, 32-847, lomianki, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (323,'Alan','Lis','82101037561','+48 121827880','4limcxlsezma@gmail.com','al. Kozak 1373, Apt. 243, 97-777, Pilzno, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (324,'Denis','Kaczmarczyk','52071052637','+48 436527978','i3z26k8zfc5g@gmail.com','ul. Maliszewski 0384, Apt. 595, 93-167, Kisielice, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (325,'Dorian','Makowski','64062935676','+48 858795329','fwx8nofft6ua@gmail.com','al. Malicki 022, Apt. 944, 58-908, Gniewkowo, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (326,'Ernest','Szczepanski','75020841238','+48 592933442','qan2wqfxibob@gmail.com','al. Piatkowski 683, Suite 730, 25-092, Kozmin Wielkopolski, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (327,'Olaf','Krajewska','87042553365','+48 142196690','jgud3xzowpiu@gmail.com','al. Pawlikowski 52035, Suite 728, 07-966, Mszana Dolna, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (328,'Borys','Duda','91022588333','+48 203320142','pffaz96ijk0u@gmail.com','ul. Muszynski 791, Apt. 433, 01-225, Strzyzow, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (329,'Ludwik','Wysocki','68072777323','+48 896601458','4hlwnkrn68zr@gmail.com','al. Wlodarczyk 619, Apt. 907, 08-769, Kargowa, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (330,'Arkadiusz','Tomaszewski','50012323752','+48 201702741','qa6t9f5h81xb@gmail.com','ul. Szulc 1034, Suite 971, 89-957, Grudziadz, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (331,'Ireneusz','Szulc','03220768943','+48 396848960','wxdng6ccf1uz@gmail.com','ul. Gorny 396, Suite 045, 49-922, Pelplin, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (332,'Dariusz','Czarnecki','85072947738','+48 550222737','vt9hct4atwi0@gmail.com','ul. Adamczyk 040, Apt. 798, 96-357, Ropczyce, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (333,'Henryk','Laskowska','85120966542','+48 472176159','8k49zzkmtam1@gmail.com','al. Pilch 1762, Apt. 200, 46-941, Gniewkowo, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (334,'Rafal','Laskowska','49032688561','+48 967520282','74y3iqutmdhd@gmail.com','al. Mazur 2580, Apt. 126, 11-627, Duszniki-Zdroj, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (335,'Jedrzej','Gorski','92120439716','+48 214317591','938zboplndtt@gmail.com','ul. Sowa 999, Apt. 052, 97-514, Nowe Miasto nad Pilica, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (336,'Jacek','Rutkowski','71062781473','+48 439561812','29yj4vuz3lv0@gmail.com','ul. Wilczynski 6813, Apt. 465, 96-158, zary, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (337,'Denis','Tomaszewski','94102029265','+48 339274831','hc4qqc9d5awa@gmail.com','ul. Wnuk 4725, Apt. 586, 98-689, Jablonowo Pomorskie, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (338,'Ludwik','Zielinski','90081159733','+48 361439528','z44su3jqerj2@gmail.com','ul. Piechota 341, Suite 514, 35-368, zary, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (339,'Diego','Zawadzki','05220994953','+48 350257693','mlr0fu83j8qu@gmail.com','al. Stolarski 3757, Suite 959, 82-803, Bolkow, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (340,'Kamil','Wroblewski','00220937779','+48 525367787','n1zoo8cjndxz@gmail.com','ul. Lesniewski 3908, Suite 534, 74-670, Ciechocinek, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (341,'Florian','Kucharski','87103188314','+48 883141298','9b2m1srlicxz@gmail.com','ul. Palacz 76398, Suite 774, 92-910, Witnica, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (342,'Maurycy','Jaworski','77121618788','+48 850318854','ra1gpivik5m5@gmail.com','ul. Kubicki 006, Apt. 699, 20-388, Warka, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (343,'Kacper','Ostrowski','79020363536','+48 257861786','9yvo1prm6bjn@gmail.com','ul. Jakubowski 1825, Apt. 839, 89-048, Gorzow slaski, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (344,'Dobromil','Lewandowski','65082581814','+48 957909271','lt7dgywrnkl5@gmail.com','al. Maslowski 227, Apt. 905, 01-884, Wysoka, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (345,'lukasz','Szymczak','50091163551','+48 543846304','v1wwt4josh0i@gmail.com','al. Mikulski 181, Apt. 548, 63-708, Pszczyna, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (346,'Aleksander','Kucharski','49111134934','+48 327901807','gtr7uewt1a68@gmail.com','ul. Stanek 233, Suite 367, 30-465, Glogow, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (347,'Milosz','Brzezinski','51112477871','+48 464670515','by88fk0zkb8q@gmail.com','ul. Paczkowski 89038, Apt. 016, 08-610, Krosniewice, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (348,'Filip','Sikora','63072539249','+48 668516474','g9kimm2gzq2t@gmail.com','al. Gajda 3114, Suite 345, 41-939, Milomlyn, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (349,'Alexander','Sobczak','94112567148','+48 946352027','ucc2tdi6bchx@gmail.com','al. Grabowski 2903, Apt. 029, 66-419, Zabrze, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (350,'Krystian','Ostrowski','55070653526','+48 613429679','kwchltftagdz@gmail.com','ul. Palka 85714, Suite 223, 40-279, Krasnystaw, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (351,'Michal','Wojciechowski','97060686268','+48 617778242','vfcw4f475tl2@gmail.com','al. Sobolewski 93840, Apt. 843, 46-163, Koniecpol, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (352,'lukasz','Kowalczyk','70122167145','+48 452385837','mnk1z05dy64z@gmail.com','ul. Kulig 424, Suite 707, 62-632, Ryglice, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (353,'Krzysztof','Kucharski','84010474288','+48 120289054','oqrhviv232e8@gmail.com','al. Pajak 2346, Apt. 742, 23-910, Libiaz, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (354,'Daniel','Ziolkowska','73012176847','+48 693898177','jrz8j70to8os@gmail.com','ul. Zawadzki 5065, Suite 595, 45-910, Ilowa, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (355,'Gracjan','Mazurek','64062521756','+48 274725441','yszkbb4puxf9@gmail.com','al. Piechota 737, Apt. 786, 08-898, Grodkow, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (356,'Kewin','Wozniak','76090774688','+48 571434661','14ltsdj5hgk1@gmail.com','ul. Lewicki 226, Apt. 813, 86-194, Janikowo, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (357,'Gracjan','Zalewski','49042456567','+48 964103737','yy33ma1cq50p@gmail.com','ul. Zygmunt 244, Apt. 521, 05-542, Zakliczyn, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (358,'Blazej','Sokolowski','80040397155','+48 695733160','uqdbxeverq8i@gmail.com','ul. Izdebski 02294, Suite 495, 91-278, Klecko, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (359,'Marian','Bak','94111338116','+48 606130899','onrapnbxnpr4@gmail.com','ul. Noga 667, Apt. 353, 60-557, Wojcieszow, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (360,'Anastazy','Maciejewski','99071685964','+48 539604437','f0j5r6vs667y@gmail.com','al. Brzozowski 82534, Apt. 464, 77-219, Alwernia, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (361,'Dorian','Witkowski','84071037422','+48 633384215','2x6b8a4at7a0@gmail.com','al. Grzesiak 2017, Suite 157, 88-067, Wabrzezno, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (362,'Pawel','Jaworski','86081344497','+48 447050047','k252pqcxxyyu@gmail.com','ul. Tkaczyk 216, Apt. 638, 62-696, Bytom, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (363,'Korneliusz','Stepien','71040375124','+48 347746499','uwti7p7m39f1@gmail.com','ul. Mackiewicz 8058, Suite 433, 95-795, Marki, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (364,'Emil','Sobczak','67111028116','+48 886547722','uyzu9y0k74oh@gmail.com','al. Urbanowicz 62291, Suite 349, 98-147, Czeladz, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (365,'Krzysztof','Lewandowski','77102981575','+48 807258534','2ts5ktw0cdsg@gmail.com','al. Karas 23632, Suite 288, 31-406, Radomysl Wielki, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (366,'Antoni','Sikora','47031094718','+48 266810124','bs8o8faeuksh@gmail.com','al. Drabik 085, Suite 796, 23-502, Wiecbork, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (367,'Kamil','Piotrowski','53032259715','+48 813382591','tggqbpqzwr04@gmail.com','al. Kuc 331, Apt. 344, 12-024, Nowe Miasto nad Pilica, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (368,'Janusz','Wozniak','67022659825','+48 294640416','f9wchh8qth78@gmail.com','al. Molenda 7816, Suite 679, 86-262, Alwernia, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (369,'Borys','Zakrzewska','88040784184','+48 446457504','nwrl28y9nzeq@gmail.com','ul. Zareba 065, Apt. 370, 86-925, Katy Wroclawskie, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (370,'Natan','Kozlowski','94042581438','+48 940000611','x13fnxpmnhll@gmail.com','ul. Milewski 301, Apt. 559, 23-747, Zabkowice slaskie, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (371,'Alfred','Sadowska','96092897512','+48 375172589','bwmsb2vpa4ui@gmail.com','al. Kasperek 665, Apt. 593, 84-901, Bobolice, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (372,'Ignacy','Szczepanski','63032297141','+48 448413823','mbyewuz164nl@gmail.com','ul. Klos 28656, Apt. 815, 33-624, Halinow, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (373,'Aleks','Rutkowski','69110391864','+48 641257679','k2mnyyhupfi8@gmail.com','ul. Szczepanski 10611, Apt. 087, 57-370, Makow Podhalanski, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (374,'Adam','Czarnecki','56062615346','+48 675016123','hqhlkz4vr0fn@gmail.com','ul. Zablocki 163, Suite 312, 40-391, Kargowa, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (375,'Dawid','Marciniak','92080765173','+48 710906832','3lvrcscmiui8@gmail.com','ul. zuk 000, Suite 327, 31-889, Chodecz, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (376,'Konstanty','Tomaszewski','88062449193','+48 616402056','1e0cap3hrt92@gmail.com','al. Serafin 38222, Apt. 794, 60-356, Czarna Woda, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (377,'Pawel','Ostrowski','60092759639','+48 367027542','y62lkqt0hx34@gmail.com','al. Lewandowski 0493, Suite 843, 79-584, Wodzislaw slaski, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (378,'Juliusz','Maciejewski','06211385428','+48 297807791','4utbl0xo98me@gmail.com','al. Kobus 65972, Apt. 246, 92-592, Gorowo Ilaweckie, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (379,'Patryk','Kazmierczak','62091457266','+48 542780346','2g0akhclotjk@gmail.com','ul. Prokop 56702, Suite 351, 10-713, Tuchola, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (380,'Maurycy','Gajewska','68121345736','+48 522425571','ngeujb3ilxh5@gmail.com','ul. Stefaniak 204, Suite 136, 90-950, swidwin, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (381,'Miron','Brzezinski','63030837581','+48 982520626','ufs963ipq26k@gmail.com','al. Przybylski 043, Suite 403, 18-038, Kietrz, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (382,'Korneliusz','Przybylski','83050286224','+48 831201687','hz3ig5hkld19@gmail.com','ul. Piatek 9091, Suite 951, 24-618, Maszewo, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (383,'Leszek','Krupa','02291927714','+48 579193083','7tbhx6mrdbkk@gmail.com','ul. Sosnowski 125, Suite 538, 14-063, Trzebinia, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (384,'Olgierd','Kozlowski','99071284958','+48 168443387','cttcxl4koxsh@gmail.com','ul. Baranski 2687, Suite 765, 64-625, Resko, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (385,'Oktawian','Kaminski','78061898593','+48 910204475','4oh415rswtei@gmail.com','ul. Bogucki 1976, Suite 493, 75-832, Drezdenko, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (386,'Aleks','Zawadzki','68021225952','+48 906156017','fcpfplgyvhqr@gmail.com','al. Rozanski 103, Apt. 874, 37-926, lochow, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (387,'Heronim','Zakrzewska','60042085784','+48 177346872','x9u1kkkm1v2k@gmail.com','al. Kalisz 3880, Suite 656, 77-568, sroda Wielkopolska, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (388,'Alfred','Wozniak','54042931619','+48 123633379','v8qtxw2ihjzr@gmail.com','al. Rusin 8532, Apt. 937, 49-240, Lipsk, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (389,'Allan','Krajewska','74062428649','+48 348352573','g2a2nako3j6m@gmail.com','ul. Dobrzynski 7586, Suite 765, 22-177, Sanok, Mazowieckie, Poland')
INSERT INTO Pasazer
 VALUES (390,'Jozef','Maciejewski','55101535919','+48 472120086','w1yemsmos76k@gmail.com','al. Jaworski 003, Suite 965, 14-447, Czyzew, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (391,'Igor','Urbanska','70022179482','+48 481065780','b8y5ws4tzac7@gmail.com','al. Wierzbicki 939, Apt. 981, 18-798, Wieruszow, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (392,'Dorian','Mroz','56100917911','+48 593586235','rx33jm34cx05@gmail.com','ul. Bielak 13440, Apt. 645, 17-785, Klodzko, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (393,'Arkadiusz','Lewandowski','89071667718','+48 623601749','fj90mo5x3k03@gmail.com','al. Modzelewski 19874, Suite 417, 78-588, Bierun, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (394,'Oktawian','Szymanski','53050892679','+48 175556399','kct0lau4qn00@gmail.com','al. Wronski 33477, Apt. 494, 12-429, Pelplin, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (395,'Pawel','Mroz','49113058584','+48 624933992','52e5uitmv0vm@gmail.com','al. Niemiec 13576, Apt. 343, 40-232, Ploty, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (396,'Patryk','Lis','47011946341','+48 952094337','erueyby2uszg@gmail.com','ul. Kruk 632, Suite 227, 54-695, swieradow-Zdroj, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (397,'Dawid','Jankowski','02292846322','+48 334760679','hkguxu2zq5v3@gmail.com','ul. Grzywacz 5642, Apt. 234, 95-465, Skepe, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (398,'Bruno','Baranowski','82091596767','+48 888441660','6btfktjia78p@gmail.com','al. Fraczek 817, Apt. 886, 09-103, Krynica-Zdroj, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (399,'Ryszard','Ziolkowska','98051883479','+48 407118351','oxfdgt95igoh@gmail.com','al. Przybysz 341, Suite 161, 60-091, Zamosc, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (400,'Jaroslaw','Zielinski','57031833868','+48 590889083','p1sg4kgm7z5a@gmail.com','al. Szafranski 786, Suite 766, 17-030, lask, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (401,'Maurycy','Jakubowski','05240278954','+48 620856317','hyu907w8pvh2@gmail.com','al. Osinski 185, Suite 750, 30-141, Bartoszyce, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (402,'Albert','Sadowska','75111211924','+48 297516629','9m2wvhs79bi1@gmail.com','ul. Skalski 777, Suite 981, 18-241, Mlawa, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (403,'Eustachy','Sokolowski','54060691115','+48 539679512','2dslhg0119qo@gmail.com','al. Sosnowski 538, Suite 979, 50-044, Kluczbork, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (404,'Kryspin','Szymanski','81102052335','+48 420459969','n4bfp5smtcxm@gmail.com','ul. Makowski 659, Suite 282, 65-730, Biala Piska, Podlaskie, Poland')
INSERT INTO Pasazer
 VALUES (405,'Borys','Kaczmarczyk','70110769126','+48 192372449','mowtyjb59h89@gmail.com','ul. Pytel 9065, Apt. 026, 66-750, Radzyn Chelminski, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (406,'Boleslaw','Kucharski','00262377498','+48 127367368','gmtmstjudelk@gmail.com','al. Szymczyk 04913, Suite 560, 20-479, Pilzno, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (407,'Ariel','Tomaszewski','72092232375','+48 904078692','b14tmbjennx2@gmail.com','ul. Biernacki 833, Suite 479, 11-735, Ozarow Mazowiecki, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (408,'Milan','Jankowski','04310549981','+48 160295903','8vkw5ljzkl3y@gmail.com','al. Zdunek 62159, Suite 310, 83-907, Jutrosin, Pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (409,'Aleks','Wozniak','98012893255','+48 683184444','nftovqh3zuk7@gmail.com','al. Panek 34097, Apt. 843, 55-749, Bialystok, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (410,'Ariel','Kalinowski','03222046562','+48 736825531','qtau21bbshzl@gmail.com','al. Golec 084, Apt. 080, 23-806, Kutno, Zachodniopomorskie, Poland')
INSERT INTO Pasazer
 VALUES (411,'Piotr','Jasinski','80062014669','+48 663618041','o20mtgjr716b@gmail.com','al. Kolodziejski 82942, Apt. 949, 57-400, Zakroczym, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (412,'Maurycy','Sobczak','68060293819','+48 319365402','g98v2msdzerm@gmail.com','ul. Majcher 91347, Apt. 312, 45-155, Sompolno, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (413,'Aureliusz','Marciniak','00220722593','+48 271415873','8c4x132lr97o@gmail.com','al. Andrzejewski 54437, Apt. 160, 74-068, laszczow, Lubuskie, Poland')
INSERT INTO Pasazer
 VALUES (414,'Mateusz','Baran','06232286881','+48 360546887','qe9tkr8iwarl@gmail.com','al. Wieczorek 27379, Apt. 735, 94-480, laszczow, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (415,'Kornel','Mazurek','80011518893','+48 973778572','yttdvxcndjtw@gmail.com','ul. Bielecki 254, Apt. 809, 15-099, Ruda slaska, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (416,'Ireneusz','Szulc','95090815283','+48 633994543','s1nrw9blowz4@gmail.com','al. Kubicki 2252, Suite 302, 39-397, Proszkow, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (417,'Norbert','Urbanska','59120269431','+48 985931246','t5inxxa8c5ki@gmail.com','ul. Tkaczyk 0147, Apt. 531, 07-930, Niemcza, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (418,'Jaroslaw','Czerwinski','62052644559','+48 399627075','3u5cie465jwl@gmail.com','ul. Debski 6373, Apt. 737, 90-989, Szczecinek, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (419,'Korneliusz','Mroz','02300125728','+48 225801948','8oz187y0amba@gmail.com','al. Gora 6715, Suite 102, 17-443, Mogielnica, Kujawsko-pomorskie, Poland')
INSERT INTO Pasazer
 VALUES (420,'Kazimierz','Lewandowski','52051314124','+48 706247101','0dgwklv87tgv@gmail.com','al. Kurek 154, Apt. 200, 10-270, Piekary slaskie, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (421,'Damian','Krajewska','61042718546','+48 297954320','puiyz9k8wm7y@gmail.com','ul. Brzezinski 60124, Apt. 548, 48-787, swiecie, slaskie, Poland')
INSERT INTO Pasazer
 VALUES (422,'Eugeniusz','Jaworski','02242855169','+48 475636796','h9vn1xs5tzzv@gmail.com','ul. Gorski 72065, Suite 449, 55-879, Koronowo, swietokrzyskie, Poland')
INSERT INTO Pasazer
 VALUES (423,'Kryspin','Laskowska','55050243943','+48 599174162','xs9mz4o9zcnc@gmail.com','ul. Wiecek 23644, Apt. 004, 96-709, Klodawa, Opolskie, Poland')
INSERT INTO Pasazer
 VALUES (424,'Martin','Tomaszewski','91080954282','+48 491192874','i3bp35xzneqm@gmail.com','ul. Mikulski 5897, Apt. 991, 69-806, Oswiecim, Malopolskie, Poland')
INSERT INTO Pasazer
 VALUES (425,'Denis','Szulc','99081977996','+48 858952332','xhwkaj844e3m@gmail.com','al. Kula 253, Apt. 063, 64-147, Ryglice, Warminsko-mazurskie, Poland')
INSERT INTO Pasazer
 VALUES (426,'Patryk','Baran','95100326781','+48 542792508','0ysw9vqtjkh9@gmail.com','ul. Pietras 39955, Suite 775, 33-038, Mirsk, Lubelskie, Poland')
INSERT INTO Pasazer
 VALUES (427,'Bronislaw','Brzezinski','69091415261','+48 634477322','jodbxt0taenl@gmail.com','ul. Matusiak 718, Apt. 605, 51-070, Chmielnik, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (428,'Jakub','Wysocki','89122675594','+48 488886994','eleba1lkucgq@gmail.com','ul. Kolasa 0213, Apt. 991, 69-229, Ruciane-Nida, lodzkie, Poland')
INSERT INTO Pasazer
 VALUES (429,'Dawid','Kolodziej','67041122339','+48 505994430','ienuzb8f96ya@gmail.com','al. Rozanski 39746, Apt. 817, 91-775, Resko, Wielkopolskie, Poland')
INSERT INTO Pasazer
 VALUES (430,'Ariel','Pietrzak','99061238888','+48 798434770','t9b081c1swcj@gmail.com','ul. Ziolkowski 194, Suite 729, 65-269, Pyrzyce, Dolnoslaskie, Poland')
INSERT INTO Pasazer
 VALUES (431,'lukasz','Adamska','77012996434','+48 529616546','ylmnxzzqldqq@gmail.com','al. Sikora 1949, Suite 440, 83-615, Nowe Miasto nad Pilica, Podkarpackie, Poland')
INSERT INTO Pasazer
 VALUES (432,'Gniewomir','Chmielewski','96032911377','+48 517199069','g0fbs9uwj24t@gmail.com','al. Radecki 58793, Suite 021, 18-372, Krakow, lodzkie, Poland')


--Samolot
INSERT INTO Samolot
 VALUES (1,'Boeing 747',223038,395976,387,10,2)
INSERT INTO Samolot
 VALUES (2,'Boeing 747',227596,359101,331,20,4)
INSERT INTO Samolot
 VALUES (3,'Boeing 747',223773,407653,401,4,1)
INSERT INTO Samolot
 VALUES (4,'Boeing 747',198173,376565,396,4,1)
INSERT INTO Samolot
 VALUES (5,'Boeing 747',234683,419839,348,6,1)
INSERT INTO Samolot
 VALUES (6,'Boeing 747',223826,423935,393,4,1)
INSERT INTO Samolot
 VALUES (7,'Boeing 747',201222,375214,399,4,1)
INSERT INTO Samolot
 VALUES (8,'Boeing 747',210816,438301,361,5,1)
INSERT INTO Samolot
 VALUES (9,'Boeing 747',201786,385868,349,7,1)
INSERT INTO Samolot
 VALUES (10,'Boeing 747',194036,392165,374,6,1)
INSERT INTO Samolot
 VALUES (11,'Boeing 737',18078,66075,91,3,1)
INSERT INTO Samolot
 VALUES (12,'Boeing 737',21588,71838,118,1,1)
INSERT INTO Samolot
 VALUES (13,'Boeing 737',24972,74371,99,2,NULL)
INSERT INTO Samolot
 VALUES (14,'Boeing 737',20817,77801,102,2,NULL)
INSERT INTO Samolot
 VALUES (15,'Boeing 737',20286,84910,89,4,NULL)
INSERT INTO Samolot
 VALUES (16,'Boeing 737',19044,58191,82,4,NULL)
INSERT INTO Samolot
 VALUES (17,'Boeing 737',23408,81963,100,2,NULL)
INSERT INTO Samolot
 VALUES (18,'Boeing 737',24608,55772,96,2,NULL)
INSERT INTO Samolot
 VALUES (19,'Boeing 737',23234,81828,103,2,NULL)
INSERT INTO Samolot
 VALUES (20,'Boeing 737',28699,71882,110,2,NULL)

--Miejsce
INSERT INTO Miejsce
 VALUES (1,1,'1ek')
INSERT INTO Miejsce
 VALUES (2,1,'2ek')
INSERT INTO Miejsce
 VALUES (3,1,'3ek')
INSERT INTO Miejsce
 VALUES (4,1,'4ek')
INSERT INTO Miejsce
 VALUES (5,1,'5ek')
INSERT INTO Miejsce
 VALUES (6,1,'6ek')
INSERT INTO Miejsce
 VALUES (7,1,'7ek')
INSERT INTO Miejsce
 VALUES (8,1,'8ek')
INSERT INTO Miejsce
 VALUES (9,1,'9ek')
INSERT INTO Miejsce
 VALUES (10,1,'10ek')
INSERT INTO Miejsce
 VALUES (11,1,'11ek')
INSERT INTO Miejsce
 VALUES (12,1,'12ek')
INSERT INTO Miejsce
 VALUES (13,1,'13ek')
INSERT INTO Miejsce
 VALUES (14,1,'14ek')
INSERT INTO Miejsce
 VALUES (15,1,'15ek')
INSERT INTO Miejsce
 VALUES (16,1,'16ek')
INSERT INTO Miejsce
 VALUES (17,1,'17ek')
INSERT INTO Miejsce
 VALUES (18,1,'18ek')
INSERT INTO Miejsce
 VALUES (19,1,'19ek')
INSERT INTO Miejsce
 VALUES (20,1,'20ek')
INSERT INTO Miejsce
 VALUES (21,1,'21ek')
INSERT INTO Miejsce
 VALUES (22,1,'22ek')
INSERT INTO Miejsce
 VALUES (23,1,'23ek')
INSERT INTO Miejsce
 VALUES (24,1,'24ek')
INSERT INTO Miejsce
 VALUES (25,1,'25ek')
INSERT INTO Miejsce
 VALUES (26,1,'26ek')
INSERT INTO Miejsce
 VALUES (27,1,'27ek')
INSERT INTO Miejsce
 VALUES (28,1,'28ek')
INSERT INTO Miejsce
 VALUES (29,1,'29ek')
INSERT INTO Miejsce
 VALUES (30,1,'30ek')
INSERT INTO Miejsce
 VALUES (31,1,'31ek')
INSERT INTO Miejsce
 VALUES (32,1,'32ek')
INSERT INTO Miejsce
 VALUES (33,1,'33ek')
INSERT INTO Miejsce
 VALUES (34,1,'34ek')
INSERT INTO Miejsce
 VALUES (35,1,'35ek')
INSERT INTO Miejsce
 VALUES (36,1,'36ek')
INSERT INTO Miejsce
 VALUES (37,1,'37ek')
INSERT INTO Miejsce
 VALUES (38,1,'38ek')
INSERT INTO Miejsce
 VALUES (39,1,'39ek')
INSERT INTO Miejsce
 VALUES (40,1,'40ek')
INSERT INTO Miejsce
 VALUES (41,1,'41ek')
INSERT INTO Miejsce
 VALUES (42,1,'42ek')
INSERT INTO Miejsce
 VALUES (43,1,'43ek')
INSERT INTO Miejsce
 VALUES (44,1,'44ek')
INSERT INTO Miejsce
 VALUES (45,1,'45ek')
INSERT INTO Miejsce
 VALUES (46,1,'46ek')
INSERT INTO Miejsce
 VALUES (47,1,'47ek')
INSERT INTO Miejsce
 VALUES (48,1,'48ek')
INSERT INTO Miejsce
 VALUES (49,1,'49ek')
INSERT INTO Miejsce
 VALUES (50,1,'50ek')
INSERT INTO Miejsce
 VALUES (51,1,'51ek')
INSERT INTO Miejsce
 VALUES (52,1,'52ek')
INSERT INTO Miejsce
 VALUES (53,1,'53ek')
INSERT INTO Miejsce
 VALUES (54,1,'54ek')
INSERT INTO Miejsce
 VALUES (55,1,'55ek')
INSERT INTO Miejsce
 VALUES (56,1,'56ek')
INSERT INTO Miejsce
 VALUES (57,1,'57ek')
INSERT INTO Miejsce
 VALUES (58,1,'58ek')
INSERT INTO Miejsce
 VALUES (59,1,'59ek')
INSERT INTO Miejsce
 VALUES (60,1,'60ek')
INSERT INTO Miejsce
 VALUES (61,1,'61ek')
INSERT INTO Miejsce
 VALUES (62,1,'62ek')
INSERT INTO Miejsce
 VALUES (63,1,'63ek')
INSERT INTO Miejsce
 VALUES (64,1,'64ek')
INSERT INTO Miejsce
 VALUES (65,1,'65ek')
INSERT INTO Miejsce
 VALUES (66,1,'66ek')
INSERT INTO Miejsce
 VALUES (67,1,'67ek')
INSERT INTO Miejsce
 VALUES (68,1,'68ek')
INSERT INTO Miejsce
 VALUES (69,1,'69ek')
INSERT INTO Miejsce
 VALUES (70,1,'70ek')
INSERT INTO Miejsce
 VALUES (71,1,'71ek')
INSERT INTO Miejsce
 VALUES (72,1,'72ek')
INSERT INTO Miejsce
 VALUES (73,1,'73ek')
INSERT INTO Miejsce
 VALUES (74,1,'74ek')
INSERT INTO Miejsce
 VALUES (75,1,'75ek')
INSERT INTO Miejsce
 VALUES (76,1,'76ek')
INSERT INTO Miejsce
 VALUES (77,1,'77ek')
INSERT INTO Miejsce
 VALUES (78,1,'78ek')
INSERT INTO Miejsce
 VALUES (79,1,'79ek')
INSERT INTO Miejsce
 VALUES (80,1,'80ek')
INSERT INTO Miejsce
 VALUES (81,1,'81ek')
INSERT INTO Miejsce
 VALUES (82,1,'82ek')
INSERT INTO Miejsce
 VALUES (83,1,'83ek')
INSERT INTO Miejsce
 VALUES (84,1,'84ek')
INSERT INTO Miejsce
 VALUES (85,1,'85ek')
INSERT INTO Miejsce
 VALUES (86,1,'86ek')
INSERT INTO Miejsce
 VALUES (87,1,'87ek')
INSERT INTO Miejsce
 VALUES (88,1,'88ek')
INSERT INTO Miejsce
 VALUES (89,1,'89ek')
INSERT INTO Miejsce
 VALUES (90,1,'90ek')
INSERT INTO Miejsce
 VALUES (91,1,'91ek')
INSERT INTO Miejsce
 VALUES (92,1,'92ek')
INSERT INTO Miejsce
 VALUES (93,1,'93ek')
INSERT INTO Miejsce
 VALUES (94,1,'94ek')
INSERT INTO Miejsce
 VALUES (95,1,'95ek')
INSERT INTO Miejsce
 VALUES (96,1,'96ek')
INSERT INTO Miejsce
 VALUES (97,1,'97ek')
INSERT INTO Miejsce
 VALUES (98,1,'98ek')
INSERT INTO Miejsce
 VALUES (99,1,'99ek')
INSERT INTO Miejsce
 VALUES (100,1,'100ek')
INSERT INTO Miejsce
 VALUES (101,1,'101ek')
INSERT INTO Miejsce
 VALUES (102,1,'102ek')
INSERT INTO Miejsce
 VALUES (103,1,'103ek')
INSERT INTO Miejsce
 VALUES (104,1,'104ek')
INSERT INTO Miejsce
 VALUES (105,1,'105ek')
INSERT INTO Miejsce
 VALUES (106,1,'106ek')
INSERT INTO Miejsce
 VALUES (107,1,'107ek')
INSERT INTO Miejsce
 VALUES (108,1,'108ek')
INSERT INTO Miejsce
 VALUES (109,1,'109ek')
INSERT INTO Miejsce
 VALUES (110,1,'110ek')
INSERT INTO Miejsce
 VALUES (111,1,'111ek')
INSERT INTO Miejsce
 VALUES (112,1,'112ek')
INSERT INTO Miejsce
 VALUES (113,1,'113ek')
INSERT INTO Miejsce
 VALUES (114,1,'114ek')
INSERT INTO Miejsce
 VALUES (115,1,'115ek')
INSERT INTO Miejsce
 VALUES (116,1,'116ek')
INSERT INTO Miejsce
 VALUES (117,1,'117ek')
INSERT INTO Miejsce
 VALUES (118,1,'118ek')
INSERT INTO Miejsce
 VALUES (119,1,'119ek')
INSERT INTO Miejsce
 VALUES (120,1,'120ek')
INSERT INTO Miejsce
 VALUES (121,1,'121ek')
INSERT INTO Miejsce
 VALUES (122,1,'122ek')
INSERT INTO Miejsce
 VALUES (123,1,'123ek')
INSERT INTO Miejsce
 VALUES (124,1,'124ek')
INSERT INTO Miejsce
 VALUES (125,1,'125ek')
INSERT INTO Miejsce
 VALUES (126,1,'126ek')
INSERT INTO Miejsce
 VALUES (127,1,'127ek')
INSERT INTO Miejsce
 VALUES (128,1,'128ek')
INSERT INTO Miejsce
 VALUES (129,1,'129ek')
INSERT INTO Miejsce
 VALUES (130,1,'130ek')
INSERT INTO Miejsce
 VALUES (131,1,'131ek')
INSERT INTO Miejsce
 VALUES (132,1,'132ek')
INSERT INTO Miejsce
 VALUES (133,1,'133ek')
INSERT INTO Miejsce
 VALUES (134,1,'134ek')
INSERT INTO Miejsce
 VALUES (135,1,'135ek')
INSERT INTO Miejsce
 VALUES (136,1,'136ek')
INSERT INTO Miejsce
 VALUES (137,1,'137ek')
INSERT INTO Miejsce
 VALUES (138,1,'138ek')
INSERT INTO Miejsce
 VALUES (139,1,'139ek')
INSERT INTO Miejsce
 VALUES (140,1,'140ek')
INSERT INTO Miejsce
 VALUES (141,1,'141ek')
INSERT INTO Miejsce
 VALUES (142,1,'142ek')
INSERT INTO Miejsce
 VALUES (143,1,'143ek')
INSERT INTO Miejsce
 VALUES (144,1,'144ek')
INSERT INTO Miejsce
 VALUES (145,1,'145ek')
INSERT INTO Miejsce
 VALUES (146,1,'146ek')
INSERT INTO Miejsce
 VALUES (147,1,'147ek')
INSERT INTO Miejsce
 VALUES (148,1,'148ek')
INSERT INTO Miejsce
 VALUES (149,1,'149ek')
INSERT INTO Miejsce
 VALUES (150,1,'150ek')
INSERT INTO Miejsce
 VALUES (151,2,'1epk')
INSERT INTO Miejsce
 VALUES (152,2,'2epk')
INSERT INTO Miejsce
 VALUES (153,2,'3epk')
INSERT INTO Miejsce
 VALUES (154,2,'4epk')
INSERT INTO Miejsce
 VALUES (155,2,'5epk')
INSERT INTO Miejsce
 VALUES (156,2,'6epk')
INSERT INTO Miejsce
 VALUES (157,2,'7epk')
INSERT INTO Miejsce
 VALUES (158,2,'8epk')
INSERT INTO Miejsce
 VALUES (159,2,'9epk')
INSERT INTO Miejsce
 VALUES (160,2,'10epk')
INSERT INTO Miejsce
 VALUES (161,2,'11epk')
INSERT INTO Miejsce
 VALUES (162,2,'12epk')
INSERT INTO Miejsce
 VALUES (163,2,'13epk')
INSERT INTO Miejsce
 VALUES (164,2,'14epk')
INSERT INTO Miejsce
 VALUES (165,2,'15epk')
INSERT INTO Miejsce
 VALUES (166,2,'16epk')
INSERT INTO Miejsce
 VALUES (167,2,'17epk')
INSERT INTO Miejsce
 VALUES (168,2,'18epk')
INSERT INTO Miejsce
 VALUES (169,2,'19epk')
INSERT INTO Miejsce
 VALUES (170,2,'20epk')
INSERT INTO Miejsce
 VALUES (171,2,'21epk')
INSERT INTO Miejsce
 VALUES (172,2,'22epk')
INSERT INTO Miejsce
 VALUES (173,2,'23epk')
INSERT INTO Miejsce
 VALUES (174,2,'24epk')
INSERT INTO Miejsce
 VALUES (175,2,'25epk')
INSERT INTO Miejsce
 VALUES (176,2,'26epk')
INSERT INTO Miejsce
 VALUES (177,2,'27epk')
INSERT INTO Miejsce
 VALUES (178,2,'28epk')
INSERT INTO Miejsce
 VALUES (179,2,'29epk')
INSERT INTO Miejsce
 VALUES (180,2,'30epk')
INSERT INTO Miejsce
 VALUES (181,2,'31epk')
INSERT INTO Miejsce
 VALUES (182,2,'32epk')
INSERT INTO Miejsce
 VALUES (183,2,'33epk')
INSERT INTO Miejsce
 VALUES (184,2,'34epk')
INSERT INTO Miejsce
 VALUES (185,2,'35epk')
INSERT INTO Miejsce
 VALUES (186,2,'36epk')
INSERT INTO Miejsce
 VALUES (187,2,'37epk')
INSERT INTO Miejsce
 VALUES (188,2,'38epk')
INSERT INTO Miejsce
 VALUES (189,2,'39epk')
INSERT INTO Miejsce
 VALUES (190,2,'40epk')
INSERT INTO Miejsce
 VALUES (191,2,'41epk')
INSERT INTO Miejsce
 VALUES (192,2,'42epk')
INSERT INTO Miejsce
 VALUES (193,2,'43epk')
INSERT INTO Miejsce
 VALUES (194,2,'44epk')
INSERT INTO Miejsce
 VALUES (195,2,'45epk')
INSERT INTO Miejsce
 VALUES (196,2,'46epk')
INSERT INTO Miejsce
 VALUES (197,2,'47epk')
INSERT INTO Miejsce
 VALUES (198,2,'48epk')
INSERT INTO Miejsce
 VALUES (199,2,'49epk')
INSERT INTO Miejsce
 VALUES (200,2,'50epk')
INSERT INTO Miejsce
 VALUES (201,2,'51epk')
INSERT INTO Miejsce
 VALUES (202,2,'52epk')
INSERT INTO Miejsce
 VALUES (203,2,'53epk')
INSERT INTO Miejsce
 VALUES (204,2,'54epk')
INSERT INTO Miejsce
 VALUES (205,2,'55epk')
INSERT INTO Miejsce
 VALUES (206,2,'56epk')
INSERT INTO Miejsce
 VALUES (207,2,'57epk')
INSERT INTO Miejsce
 VALUES (208,2,'58epk')
INSERT INTO Miejsce
 VALUES (209,2,'59epk')
INSERT INTO Miejsce
 VALUES (210,2,'60epk')
INSERT INTO Miejsce
 VALUES (211,2,'61epk')
INSERT INTO Miejsce
 VALUES (212,2,'62epk')
INSERT INTO Miejsce
 VALUES (213,2,'63epk')
INSERT INTO Miejsce
 VALUES (214,2,'64epk')
INSERT INTO Miejsce
 VALUES (215,2,'65epk')
INSERT INTO Miejsce
 VALUES (216,2,'66epk')
INSERT INTO Miejsce
 VALUES (217,2,'67epk')
INSERT INTO Miejsce
 VALUES (218,2,'68epk')
INSERT INTO Miejsce
 VALUES (219,2,'69epk')
INSERT INTO Miejsce
 VALUES (220,2,'70epk')
INSERT INTO Miejsce
 VALUES (221,2,'71epk')
INSERT INTO Miejsce
 VALUES (222,2,'72epk')
INSERT INTO Miejsce
 VALUES (223,2,'73epk')
INSERT INTO Miejsce
 VALUES (224,2,'74epk')
INSERT INTO Miejsce
 VALUES (225,2,'75epk')
INSERT INTO Miejsce
 VALUES (226,2,'76epk')
INSERT INTO Miejsce
 VALUES (227,2,'77epk')
INSERT INTO Miejsce
 VALUES (228,2,'78epk')
INSERT INTO Miejsce
 VALUES (229,2,'79epk')
INSERT INTO Miejsce
 VALUES (230,2,'80epk')
INSERT INTO Miejsce
 VALUES (231,2,'81epk')
INSERT INTO Miejsce
 VALUES (232,2,'82epk')
INSERT INTO Miejsce
 VALUES (233,2,'83epk')
INSERT INTO Miejsce
 VALUES (234,2,'84epk')
INSERT INTO Miejsce
 VALUES (235,2,'85epk')
INSERT INTO Miejsce
 VALUES (236,2,'86epk')
INSERT INTO Miejsce
 VALUES (237,2,'87epk')
INSERT INTO Miejsce
 VALUES (238,2,'88epk')
INSERT INTO Miejsce
 VALUES (239,2,'89epk')
INSERT INTO Miejsce
 VALUES (240,2,'90epk')
INSERT INTO Miejsce
 VALUES (241,2,'91epk')
INSERT INTO Miejsce
 VALUES (242,2,'92epk')
INSERT INTO Miejsce
 VALUES (243,2,'93epk')
INSERT INTO Miejsce
 VALUES (244,2,'94epk')
INSERT INTO Miejsce
 VALUES (245,2,'95epk')
INSERT INTO Miejsce
 VALUES (246,2,'96epk')
INSERT INTO Miejsce
 VALUES (247,2,'97epk')
INSERT INTO Miejsce
 VALUES (248,2,'98epk')
INSERT INTO Miejsce
 VALUES (249,2,'99epk')
INSERT INTO Miejsce
 VALUES (250,2,'100epk')
INSERT INTO Miejsce
 VALUES (251,3,'1bk')
INSERT INTO Miejsce
 VALUES (252,3,'2bk')
INSERT INTO Miejsce
 VALUES (253,3,'3bk')
INSERT INTO Miejsce
 VALUES (254,3,'4bk')
INSERT INTO Miejsce
 VALUES (255,3,'5bk')
INSERT INTO Miejsce
 VALUES (256,3,'6bk')
INSERT INTO Miejsce
 VALUES (257,3,'7bk')
INSERT INTO Miejsce
 VALUES (258,3,'8bk')
INSERT INTO Miejsce
 VALUES (259,3,'9bk')
INSERT INTO Miejsce
 VALUES (260,3,'10bk')
INSERT INTO Miejsce
 VALUES (261,3,'11bk')
INSERT INTO Miejsce
 VALUES (262,3,'12bk')
INSERT INTO Miejsce
 VALUES (263,3,'13bk')
INSERT INTO Miejsce
 VALUES (264,3,'14bk')
INSERT INTO Miejsce
 VALUES (265,3,'15bk')
INSERT INTO Miejsce
 VALUES (266,3,'16bk')
INSERT INTO Miejsce
 VALUES (267,3,'17bk')
INSERT INTO Miejsce
 VALUES (268,3,'18bk')
INSERT INTO Miejsce
 VALUES (269,3,'19bk')
INSERT INTO Miejsce
 VALUES (270,3,'20bk')
INSERT INTO Miejsce
 VALUES (271,3,'21bk')
INSERT INTO Miejsce
 VALUES (272,3,'22bk')
INSERT INTO Miejsce
 VALUES (273,3,'23bk')
INSERT INTO Miejsce
 VALUES (274,3,'24bk')
INSERT INTO Miejsce
 VALUES (275,3,'25bk')
INSERT INTO Miejsce
 VALUES (276,3,'26bk')
INSERT INTO Miejsce
 VALUES (277,3,'27bk')
INSERT INTO Miejsce
 VALUES (278,3,'28bk')
INSERT INTO Miejsce
 VALUES (279,3,'29bk')
INSERT INTO Miejsce
 VALUES (280,3,'30bk')
INSERT INTO Miejsce
 VALUES (281,3,'31bk')
INSERT INTO Miejsce
 VALUES (282,3,'32bk')
INSERT INTO Miejsce
 VALUES (283,3,'33bk')
INSERT INTO Miejsce
 VALUES (284,3,'34bk')
INSERT INTO Miejsce
 VALUES (285,3,'35bk')
INSERT INTO Miejsce
 VALUES (286,3,'36bk')
INSERT INTO Miejsce
 VALUES (287,3,'37bk')
INSERT INTO Miejsce
 VALUES (288,3,'38bk')
INSERT INTO Miejsce
 VALUES (289,3,'39bk')
INSERT INTO Miejsce
 VALUES (290,3,'40bk')
INSERT INTO Miejsce
 VALUES (291,4,'1pk')
INSERT INTO Miejsce
 VALUES (292,4,'2pk')
INSERT INTO Miejsce
 VALUES (293,4,'3pk')
INSERT INTO Miejsce
 VALUES (294,4,'4pk')
INSERT INTO Miejsce
 VALUES (295,4,'5pk')
INSERT INTO Miejsce
 VALUES (296,4,'6pk')
INSERT INTO Miejsce
 VALUES (297,4,'7pk')
INSERT INTO Miejsce
 VALUES (298,4,'8pk')
INSERT INTO Miejsce
 VALUES (299,4,'9pk')
INSERT INTO Miejsce
 VALUES (300,4,'10pk')
INSERT INTO Miejsce
 VALUES (301,4,'11pk')
INSERT INTO Miejsce
 VALUES (302,4,'12pk')
INSERT INTO Miejsce
 VALUES (303,4,'13pk')
INSERT INTO Miejsce
 VALUES (304,4,'14pk')
INSERT INTO Miejsce
 VALUES (305,4,'15pk')
INSERT INTO Miejsce
 VALUES (306,4,'16pk')
INSERT INTO Miejsce
 VALUES (307,4,'17pk')
INSERT INTO Miejsce
 VALUES (308,4,'18pk')
INSERT INTO Miejsce
 VALUES (309,4,'19pk')
INSERT INTO Miejsce
 VALUES (310,4,'20pk')

--Lotniska
INSERT INTO Lotniska
 VALUES (1,'Rzeszow','Jasionka')
INSERT INTO Lotniska
 VALUES (2,'Krakow','Balice')
INSERT INTO Lotniska
 VALUES (3,'Katowice','Pyrzowice')
INSERT INTO Lotniska
 VALUES (4,'Wroclaw','Stachowice')
INSERT INTO Lotniska
 VALUES (5,'Zielona Gora','Babimost IEG')
INSERT INTO Lotniska
 VALUES (6,'Szczecin','Goleniow')
INSERT INTO Lotniska
 VALUES (7,'Poznan','Lawica')
INSERT INTO Lotniska
 VALUES (8,'Lodz','Lublinek')
INSERT INTO Lotniska
 VALUES (9,'Radom','Sadkow')
INSERT INTO Lotniska
 VALUES (10,'Lublin','Swidnik')
INSERT INTO Lotniska
 VALUES (11,'Warszawa','Okecie')
INSERT INTO Lotniska
 VALUES (12,'Warszawa','Modlin')
INSERT INTO Lotniska
 VALUES (13,'Olsztyn','Szymany')
INSERT INTO Lotniska
 VALUES (14,'Bydgoszcz','Szwederowo')
INSERT INTO Lotniska
 VALUES (15,'Gdansk','Rebiechowo')

--Pilot
INSERT INTO Pilot VALUES (15,'Kamil','Witkowski','1960-02-14','Mezczyzna',21165)
INSERT INTO Pilot VALUES (2,'Mikolaj','Cieslak','1961-03-13','Mezczyzna',20410)    
INSERT INTO Pilot VALUES (19,'Kajetan','Mazur','1963-10-27','Mezczyzna',18915)      
INSERT INTO Pilot VALUES (17,'Eustachy','Sobczak','1965-08-14','Mezczyzna',17484)   
INSERT INTO Pilot VALUES (18,'Joachim','Wroblewski','1965-09-28','Mezczyzna',13706) 
INSERT INTO Pilot VALUES (8,'Adrian','Zakrzewska','1968-04-13','Mezczyzna',1369)  
INSERT INTO Pilot VALUES (11,'Artur','Rutkowski','1969-09-05','Mezczyzna',13097)    
INSERT INTO Pilot VALUES (4,'Emanuel','Makowski','1970-07-04','Mezczyzna',12287)   
INSERT INTO Pilot VALUES (1,'Patryk','Wasilewska','1973-04-02','Mezczyzna',12280)  
INSERT INTO Pilot VALUES (9,'Fabian','Kaminski','1976-07-04','Mezczyzna',11834)    
INSERT INTO Pilot VALUES (3,'Robert','Pietrzak','1978-11-23','Mezczyzna',10713)    
INSERT INTO Pilot VALUES (12,'Jacek','Andrzejewski','1979-02-15','Mezczyzna',9667)  
INSERT INTO Pilot VALUES (20,'Adam','Gorecki','1981-05-05','Mezczyzna',8656)        
INSERT INTO Pilot VALUES (6,'Kazimierz','Walczak','1982-04-12','Mezczyzna',7537)   
INSERT INTO Pilot VALUES (5,'Miroslaw','Szczepanski','1985-06-07','Mezczyzna',7348)
INSERT INTO Pilot VALUES (16,'Igor','Szymanski','1986-04-15','Mezczyzna',6488)      
INSERT INTO Pilot VALUES (7,'Emanuel','Kalinowski','1986-04-20','Mezczyzna',5408)  
INSERT INTO Pilot VALUES (14,'Ignacy','Gajewska','1987-04-01','Mezczyzna',5396)     
INSERT INTO Pilot VALUES (13,'Konstanty','Glowacka','1989-04-13','Mezczyzna',4879)  
INSERT INTO Pilot VALUES (10,'Ryszard','Zielinski','1992-02-06','Mezczyzna',3084)
INSERT INTO Pilot VALUES (1,'Amadeusz','Jasinski','1961-11-20','Mezczyzna',21284)
INSERT INTO Pilot VALUES (2,'Anastazy','Zawadzki','1962-11-04','Mezczyzna',21110)
INSERT INTO Pilot VALUES (3,'Julian','Przybylski','1963-06-20','Mezczyzna',20307)
INSERT INTO Pilot VALUES (4,'Marcin','Szymanski','1965-12-30','Mezczyzna',20050)
INSERT INTO Pilot VALUES (5,'Lucjan','Andrzejewski','1966-11-12','Mezczyzna',18064)
INSERT INTO Pilot VALUES (6,'Krystian','Baranowski','1967-06-22','Mezczyzna',17932)
INSERT INTO Pilot VALUES (7,'Bogumil','Tomaszewski','1970-05-31','Mezczyzna',16034)
INSERT INTO Pilot VALUES (8,'Ksawery','Sawicki','1970-06-18','Mezczyzna',14197)
INSERT INTO Pilot VALUES (9,'Michal','Kozlowski','1970-09-20','Mezczyzna',11328)
INSERT INTO Pilot VALUES (10,'Cyprian','Makowski','1971-07-26','Mezczyzna',10513)
INSERT INTO Pilot VALUES (11,'Ariel','Duda','1974-10-13','Mezczyzna',8994)
INSERT INTO Pilot VALUES (12,'Aleksander','Gorecki','1975-08-08','Mezczyzna',8947)
INSERT INTO Pilot VALUES (13,'Denis','Kolodziej','1978-01-09','Mezczyzna',8644)
INSERT INTO Pilot VALUES (14,'Bruno','Czerwinski','1979-01-25','Mezczyzna',8172)
INSERT INTO Pilot VALUES (15,'Alojzy','Adamska','1981-01-30','Mezczyzna',8011)
INSERT INTO Pilot VALUES (16,'Andrzej','Lewandowski','1983-12-19','Mezczyzna',6638)
INSERT INTO Pilot VALUES (17,'Klaudiusz','Malinowski','1984-10-06','Mezczyzna',4651)
INSERT INTO Pilot VALUES (18,'Aleks','Mazurek','1986-12-16','Mezczyzna',3886)
INSERT INTO Pilot VALUES (19,'Rafal','Kozlowski','1990-12-06','Mezczyzna',2838)

--Pracownicy
INSERT INTO Pracownicy
 VALUES (1,'Oktawian','Krawczyk','1963-02-06','Mezczyzna','4uyk5zf8gvkz@gmail.com','Rozladunek bagazu',15)
INSERT INTO Pracownicy
 VALUES (2,'Marian','Sikora','1963-07-06','Mezczyzna','zwabbq9av428@gmail.com','Operator maszyn nakierowywujacych',3)
INSERT INTO Pracownicy
 VALUES (3,'Albert','Blaszczyk','1967-10-12','Mezczyzna','fxn4q7dsfhhj@gmail.com','Sternik plyty lotniska',5)
INSERT INTO Pracownicy
 VALUES (4,'Marek','Krajewska','1968-03-12','Mezczyzna','0nipeh4zve2s@gmail.com','Operator wozka bagazowego',3)
INSERT INTO Pracownicy
 VALUES (5,'Przemyslaw','Sobczak','1970-09-15','Mezczyzna','7crd2p60qvqw@gmail.com','Ochrona',2)
INSERT INTO Pracownicy
 VALUES (6,'Jan','Laskowska','1973-05-23','Mezczyzna','114pon4otwvl@gmail.com','Mechanik lotniczy',7)
INSERT INTO Pracownicy
 VALUES (7,'Dawid','Kazmierczak','1973-12-19','Mezczyzna','7gmuc294ctj1@gmail.com','Nadzor obslugi naziemnej',11)
INSERT INTO Pracownicy
 VALUES (8,'Mikolaj','Dabrowski','1977-12-18','Mezczyzna','b9jp5huq7vyz@gmail.com','Ochrona terminala',11)
INSERT INTO Pracownicy
 VALUES (9,'Ryszard','Tomaszewski','1979-07-28','Mezczyzna','wudj6p4c83b6@gmail.com','Obsluga odprawy bagazowej',1)
INSERT INTO Pracownicy
 VALUES (10,'Mariusz','Wlodarczyk','1979-10-02','Mezczyzna','78pucg1ypd8s@gmail.com','Rozladunek bagazu',9)
INSERT INTO Pracownicy
 VALUES (11,'Damian','Makowski','1981-03-13','Mezczyzna','ql84kvwym0zm@gmail.com','Operator maszyn nakierowywujacych',9)
INSERT INTO Pracownicy
 VALUES (12,'Alexander','Jasinski','1984-01-18','Mezczyzna','ogjnmoslc6gs@gmail.com','Sternik plyty lotniska',4)
INSERT INTO Pracownicy
 VALUES (13,'Damian','Jaworski','1985-07-24','Mezczyzna','2xlywaqgqlyg@gmail.com','Operator wozka bagazowego',10)
INSERT INTO Pracownicy
 VALUES (14,'Boleslaw','Sobczak','1987-06-26','Mezczyzna','xor6o4j22y2o@gmail.com','Ochrona',7)
INSERT INTO Pracownicy
 VALUES (15,'Gabriel','Kaczmarczyk','1989-03-15','Mezczyzna','wfkoqxpbz74x@gmail.com','Mechanik lotniczy',12)
INSERT INTO Pracownicy
 VALUES (16,'Alex','Kowalczyk','1990-05-04','Mezczyzna','ymq4mnea0smt@gmail.com','Nadzor obslugi naziemnej',14)
INSERT INTO Pracownicy
 VALUES (17,'Leonardo','Kaczmarczyk','1991-01-06','Mezczyzna','lx5e0xrf9b35@gmail.com','Ochrona terminala',9)
INSERT INTO Pracownicy
 VALUES (18,'Adrian','Przybylski','1991-08-26','Mezczyzna','3bzrsizsykc4@gmail.com','Obsluga odprawy bagazowej',10)
INSERT INTO Pracownicy
 VALUES (19,'Blazej','Dabrowski','1992-01-17','Mezczyzna','ht3q6phw1zna@gmail.com','Rozladunek bagazu',6)
INSERT INTO Pracownicy
 VALUES (20,'Marek','Ziolkowska','1993-07-10','Mezczyzna','gdzmfj39e33h@gmail.com','Operator maszyn nakierowywujacych',12)
INSERT INTO Pracownicy
 VALUES (21,'Natan','Borkowski','1994-05-19','Mezczyzna','k7mbmbnlzxnl@gmail.com','Sternik plyty lotniska',11)
INSERT INTO Pracownicy
 VALUES (22,'Anastazy','Wisniewski','1995-10-21','Mezczyzna','ya8k9dowg8q5@gmail.com','Operator wozka bagazowego',4)
INSERT INTO Pracownicy
 VALUES (23,'Mariusz','Andrzejewski','1997-11-24','Mezczyzna','k3r53o6rmfu9@gmail.com','Ochrona',14)
INSERT INTO Pracownicy
 VALUES (24,'Anastazy','Szewczyk','2000-12-08','Mezczyzna','krtrn5ula1s8@gmail.com','Mechanik lotniczy',6)
INSERT INTO Pracownicy
 VALUES (25,'Bruno','Wroblewski','1964-02-21','Mezczyzna','ej8uqj8cp7vk@gmail.com','Nadzor obslugi naziemnej',12)
INSERT INTO Pracownicy
 VALUES (26,'Allan','Zalewski','1965-05-13','Mezczyzna','miupvbr2nyqd@gmail.com','Ochrona terminala',9)
INSERT INTO Pracownicy
 VALUES (27,'Filip','Nowak','1966-05-04','Mezczyzna','5z9w3x51fbsu@gmail.com','Obsluga odprawy bagazowej',11)
INSERT INTO Pracownicy
 VALUES (28,'Igor','Kolodziej','1968-09-12','Mezczyzna','s3hlw43c2z8u@gmail.com','Rozladunek bagazu',13)
INSERT INTO Pracownicy
 VALUES (29,'Aleksy','Walczak','1971-04-23','Mezczyzna','1qxhlo6o28l6@gmail.com','Operator maszyn nakierowywujacych',9)
INSERT INTO Pracownicy
 VALUES (30,'Olaf','Kwiatkowski','1972-08-02','Mezczyzna','dpbbzrkxoiel@gmail.com','Sternik plyty lotniska',10)
INSERT INTO Pracownicy
 VALUES (31,'Kajetan','Baran','1973-08-13','Mezczyzna','58hprbcmui4j@gmail.com','Operator wozka bagazowego',2)
INSERT INTO Pracownicy
 VALUES (32,'Olgierd','Jakubowski','1975-07-04','Mezczyzna','bfgflwn371lw@gmail.com','Ochrona',8)
INSERT INTO Pracownicy
 VALUES (33,'Ernest','Wisniewski','1975-08-31','Mezczyzna','jp1kpgi871lm@gmail.com','Mechanik lotniczy',4)
INSERT INTO Pracownicy
 VALUES (34,'Oskar','Zawadzki','1977-07-09','Mezczyzna','awenidp8vlz5@gmail.com','Nadzor obslugi naziemnej',15)
INSERT INTO Pracownicy
 VALUES (35,'Jan','Piotrowski','1981-06-14','Mezczyzna','yli368tz9v0r@gmail.com','Ochrona terminala',5)
INSERT INTO Pracownicy
 VALUES (36,'Artur','Sawicki','1982-02-22','Mezczyzna','13hlffvibr7e@gmail.com','Obsluga odprawy bagazowej',12)
INSERT INTO Pracownicy
 VALUES (37,'Kryspin','Wlodarczyk','1982-11-20','Mezczyzna','3mbfv4261trt@gmail.com','Rozladunek bagazu',8)
INSERT INTO Pracownicy
 VALUES (38,'Henryk','Kubiak','1985-10-08','Mezczyzna','aotbs2kg8byb@gmail.com','Operator maszyn nakierowywujacych',5)
INSERT INTO Pracownicy
 VALUES (39,'Jacek','Makowski','1986-04-17','Mezczyzna','0ho22wtzjdi8@gmail.com','Sternik plyty lotniska',2)
INSERT INTO Pracownicy
 VALUES (40,'Miroslaw','Jankowski','1986-11-10','Mezczyzna','3c89v749k8i8@gmail.com','Operator wozka bagazowego',6)
INSERT INTO Pracownicy
 VALUES (41,'Michal','Szulc','1989-05-14','Mezczyzna','l8ocvnp8jdtq@gmail.com','Ochrona',14)
INSERT INTO Pracownicy
 VALUES (42,'Fryderyk','Sobczak','1990-01-05','Mezczyzna','6potxnxlfpfn@gmail.com','Mechanik lotniczy',2)
INSERT INTO Pracownicy
 VALUES (43,'Boleslaw','Gajewska','1992-04-12','Mezczyzna','e0dlhace41h3@gmail.com','Nadzor obslugi naziemnej',8)
INSERT INTO Pracownicy
 VALUES (44,'Alexander','Gorecki','1996-10-18','Mezczyzna','3mbl34fpx1sa@gmail.com','Ochrona terminala',12)
INSERT INTO Pracownicy
 VALUES (45,'Alojzy','Wasilewska','1997-12-03','Mezczyzna','xc9v3x3kccgq@gmail.com','Obsluga odprawy bagazowej',7)
INSERT INTO Pracownicy
 VALUES (46,'lukasz','Krupa','1998-12-31','Mezczyzna','fgyewdtnm7gs@gmail.com','Rozladunek bagazu',3)
INSERT INTO Pracownicy
 VALUES (47,'Amir','Wojciechowski','2000-03-09','Mezczyzna','a70ahq6137gn@gmail.com','Operator maszyn nakierowywujacych',13)
INSERT INTO Pracownicy
 VALUES (48,'Olgierd','Gorecki','2000-05-11','Mezczyzna','8r8j85ybdqsv@gmail.com','Sternik plyty lotniska',5)
INSERT INTO Pracownicy
 VALUES (49,'Denis','Wisniewski','2000-10-04','Mezczyzna','35txlsf57mk5@gmail.com','Operator wozka bagazowego',5)
INSERT INTO Pracownicy
 VALUES (50,'Remigiusz','Wozniak','1965-08-25','Mezczyzna','gbqo1def9mdh@gmail.com','Ochrona',3)
INSERT INTO Pracownicy
 VALUES (51,'Jacek','Ostrowski','1966-10-29','Mezczyzna','2pgx6wu6380v@gmail.com','Mechanik lotniczy',10)
INSERT INTO Pracownicy
 VALUES (52,'Ryszard','Duda','1968-10-30','Mezczyzna','9yfumusy59iz@gmail.com','Nadzor obslugi naziemnej',13)
INSERT INTO Pracownicy
 VALUES (53,'Maurycy','Gorecki','1972-06-30','Mezczyzna','900z564j5jr1@gmail.com','Ochrona terminala',7)
INSERT INTO Pracownicy
 VALUES (54,'Czeslaw','Szewczyk','1974-05-13','Mezczyzna','c74h8ps0o1ov@gmail.com','Obsluga odprawy bagazowej',14)
INSERT INTO Pracownicy
 VALUES (55,'Hubert','Kaczmarczyk','1975-09-03','Mezczyzna','47c5gtulqhpk@gmail.com','Rozladunek bagazu',8)
INSERT INTO Pracownicy
 VALUES (56,'Krzysztof','Wozniak','1978-08-09','Mezczyzna','lbna1b49imhz@gmail.com','Operator maszyn nakierowywujacych',11)
INSERT INTO Pracownicy
 VALUES (57,'Fabian','Szymanski','1978-11-25','Mezczyzna','ysddgln2qlxz@gmail.com','Sternik plyty lotniska',11)
INSERT INTO Pracownicy
 VALUES (58,'Adrian','Brzezinski','1979-04-07','Mezczyzna','ccdccde7fqlw@gmail.com','Operator wozka bagazowego',14)
INSERT INTO Pracownicy
 VALUES (59,'Eugeniusz','Ostrowski','1980-10-03','Mezczyzna','px3cpk8qgvla@gmail.com','Ochrona',8)
INSERT INTO Pracownicy
 VALUES (60,'Boleslaw','Jakubowski','1984-04-25','Mezczyzna','5fkont3c1ph8@gmail.com','Mechanik lotniczy',11)
INSERT INTO Pracownicy
 VALUES (61,'Alek','Kazmierczak','1984-05-19','Mezczyzna','d17wgyzcsxix@gmail.com','Nadzor obslugi naziemnej',1)
INSERT INTO Pracownicy
 VALUES (62,'Kewin','Maciejewski','1984-12-29','Mezczyzna','g0t816u3yo3i@gmail.com','Ochrona terminala',5)
INSERT INTO Pracownicy
 VALUES (63,'Klaudiusz','Kubiak','1986-10-19','Mezczyzna','h6rns2qccz4g@gmail.com','Obsluga odprawy bagazowej',5)
INSERT INTO Pracownicy
 VALUES (64,'Leszek','Czerwinski','1993-07-17','Mezczyzna','n6u63uazxrdz@gmail.com','Rozladunek bagazu',4)
INSERT INTO Pracownicy
 VALUES (65,'Piotr','Kowalski','1995-05-10','Mezczyzna','jptuo6p3bnrq@gmail.com','Operator maszyn nakierowywujacych',8)
INSERT INTO Pracownicy
 VALUES (66,'Kamil','Lis','1995-11-15','Mezczyzna','q2lsusk5pm9u@gmail.com','Sternik plyty lotniska',2)
INSERT INTO Pracownicy
 VALUES (67,'Kajetan','Maciejewski','1996-08-20','Mezczyzna','k0l72q4xng2q@gmail.com','Operator wozka bagazowego',14)
INSERT INTO Pracownicy
 VALUES (68,'Daniel','Brzezinski','1996-08-28','Mezczyzna','4m3lahesuwya@gmail.com','Ochrona',1)
INSERT INTO Pracownicy
 VALUES (69,'Jan','Kucharski','1998-09-27','Mezczyzna','9fvj480loayd@gmail.com','Mechanik lotniczy',3)
INSERT INTO Pracownicy
 VALUES (70,'Alex','Blaszczyk','1998-11-08','Mezczyzna','zpez2x8mb9v8@gmail.com','Nadzor obslugi naziemnej',12)
INSERT INTO Pracownicy
 VALUES (71,'Ignacy','Wroblewski','1999-07-16','Mezczyzna','w5v525x39rwt@gmail.com','Ochrona terminala',8)
INSERT INTO Pracownicy
 VALUES (72,'Borys','Mroz','1999-09-17','Mezczyzna','7fqlhkvh448g@gmail.com','Obsluga odprawy bagazowej',13)
INSERT INTO Pracownicy
 VALUES (73,'Kamil','Blaszczyk','1999-10-11','Mezczyzna','xe03cm6df45t@gmail.com','Rozladunek bagazu',2)
INSERT INTO Pracownicy
 VALUES (74,'Kryspin','Szymczak','2000-05-04','Mezczyzna','xln9q48v7bpp@gmail.com','Operator maszyn nakierowywujacych',11)
INSERT INTO Pracownicy
 VALUES (75,'Natan','Kowalczyk','1961-09-22','Mezczyzna','kfypreknqedl@gmail.com','Sternik plyty lotniska',6)
INSERT INTO Pracownicy
 VALUES (76,'Borys','Marciniak','1962-10-21','Mezczyzna','4u96pbuyc0as@gmail.com','Operator wozka bagazowego',4)
INSERT INTO Pracownicy
 VALUES (77,'Patryk','Sokolowski','1969-04-27','Mezczyzna','bjzn1ywt99gv@gmail.com','Ochrona',9)
INSERT INTO Pracownicy
 VALUES (78,'Jaroslaw','Zielinski','1971-02-10','Mezczyzna','j2olxdo08nin@gmail.com','Mechanik lotniczy',2)
INSERT INTO Pracownicy
 VALUES (79,'Amadeusz','Czarnecki','1973-05-07','Mezczyzna','fdguupvzwcg7@gmail.com','Nadzor obslugi naziemnej',14)
INSERT INTO Pracownicy
 VALUES (80,'Gniewomir','Tomaszewski','1974-05-12','Mezczyzna','wbsjugxb1y7l@gmail.com','Ochrona terminala',11)
INSERT INTO Pracownicy
 VALUES (81,'Elena','Ziolkowska','1979-05-15','Kobieta','zfgootlvhkvz@gmail.com','Obsluga odprawy bagazowej',11)
INSERT INTO Pracownicy
 VALUES (82,'Julianna','Glowacka','1981-04-13','Kobieta','z0jm90q3o1j4@gmail.com','Rozladunek bagazu',9)
INSERT INTO Pracownicy
 VALUES (83,'Balbina','Wisniewska','1981-09-02','Kobieta','d9d5y7tn6ek7@gmail.com','Operator maszyn nakierowywujacych',8)
INSERT INTO Pracownicy
 VALUES (84,'Teresa','Witkowska','1982-12-08','Kobieta','nr2ejlx9krzg@gmail.com','Sternik plyty lotniska',4)
INSERT INTO Pracownicy
 VALUES (85,'Marcela','Szulc','1990-11-26','Kobieta','l81bqwuv7p67@gmail.com','Operator wozka bagazowego',13)
INSERT INTO Pracownicy
 VALUES (86,'Ida','Kubiak','1992-02-29','Kobieta','woo4f6cpjexh@gmail.com','Ochrona',8)
INSERT INTO Pracownicy
 VALUES (87,'Felicja','Walczak','1992-08-21','Kobieta','6jtlm5581v53@gmail.com','Mechanik lotniczy',8)
INSERT INTO Pracownicy
 VALUES (88,'Miroslawa','Urbanska','1993-03-04','Kobieta','vq1kplshpecy@gmail.com','Nadzor obslugi naziemnej',10)
INSERT INTO Pracownicy
 VALUES (89,'Klara','Wozniak','1994-02-25','Kobieta','6wj4tatiem0m@gmail.com','Ochrona terminala',6)
INSERT INTO Pracownicy
 VALUES (90,'Amalia','Jasinska','1994-10-21','Kobieta','s0i3tk3b9k9k@gmail.com','Obsluga odprawy bagazowej',6)
INSERT INTO Pracownicy
 VALUES (91,'Idalia','Szewczyk','1997-02-18','Kobieta','3j86u90loat8@gmail.com','Rozladunek bagazu',4)
INSERT INTO Pracownicy
 VALUES (92,'Berenika','Malinowska','1998-03-31','Kobieta','vklqnjyj52cq@gmail.com','Operator maszyn nakierowywujacych',6)
INSERT INTO Pracownicy
 VALUES (93,'Bogda','Laskowska','1998-07-01','Kobieta','wdwyune28h8d@gmail.com','Sternik plyty lotniska',9)
INSERT INTO Pracownicy
 VALUES (94,'Elena','Borkowska','1999-12-01','Kobieta','iozzn9jqkxii@gmail.com','Operator wozka bagazowego',6)
INSERT INTO Pracownicy
 VALUES (95,'Sylwia','Dabrowska','1999-12-27','Kobieta','87ylbzeljw30@gmail.com','Ochrona',11)
INSERT INTO Pracownicy
 VALUES (96,'Zofia','Kaminska','2000-02-03','Kobieta','8m24w6j8k6pj@gmail.com','Mechanik lotniczy',13)
INSERT INTO Pracownicy
 VALUES (97,'Florencja','Wlodarczyk','2000-02-22','Kobieta','3bunjmqhlf2l@gmail.com','Nadzor obslugi naziemnej',11)
INSERT INTO Pracownicy
 VALUES (98,'Marysia','Kubiak','2000-11-07','Kobieta','c8jsemaxaqj1@gmail.com','Ochrona terminala',5)
INSERT INTO Pracownicy
 VALUES (99,'Ewelina','Walczak','2000-11-08','Kobieta','ervqiprmgs2c@gmail.com','Obsluga odprawy bagazowej',10)
INSERT INTO Pracownicy
 VALUES (100,'Felicja','Wojcik','1960-09-26','Kobieta','nmycnijc0yxh@gmail.com','Rozladunek bagazu',1)
INSERT INTO Pracownicy
 VALUES (101,'Aisha','Jakubowska','1962-05-30','Kobieta','4rf57bvbd5x1@gmail.com','Operator maszyn nakierowywujacych',12)
INSERT INTO Pracownicy
 VALUES (102,'Agnieszka','Gorska','1963-06-17','Kobieta','xhyt4kvpe9px@gmail.com','Sternik plyty lotniska',12)
INSERT INTO Pracownicy
 VALUES (103,'Asia','Jasinska','1964-11-04','Kobieta','tbjs06vs9njw@gmail.com','Operator wozka bagazowego',2)
INSERT INTO Pracownicy
 VALUES (104,'Franciszka','Kubiak','1965-10-12','Kobieta','g7m9w8vqv4ax@gmail.com','Ochrona',13)
INSERT INTO Pracownicy
 VALUES (105,'Jola','Szulc','1968-03-10','Kobieta','607baubzx60p@gmail.com','Mechanik lotniczy',7)
INSERT INTO Pracownicy
 VALUES (106,'Katarzyna','Kaminska','1973-01-25','Kobieta','sc7m0rjtxgcw@gmail.com','Nadzor obslugi naziemnej',6)
INSERT INTO Pracownicy
 VALUES (107,'Jozefa','Wisniewska','1980-06-03','Kobieta','robag7vj5st0@gmail.com','Ochrona terminala',3)
INSERT INTO Pracownicy
 VALUES (108,'Balbina','Piotrowska','1980-09-22','Kobieta','3a3e66o0s4l7@gmail.com','Obsluga odprawy bagazowej',13)
INSERT INTO Pracownicy
 VALUES (109,'Martyna','Mazurek','1980-10-09','Kobieta','b2zxn87d56he@gmail.com','Rozladunek bagazu',10)
INSERT INTO Pracownicy
 VALUES (110,'Olga','Szczepanska','1982-07-07','Kobieta','sz0geu3g9nve@gmail.com','Operator maszyn nakierowywujacych',11)
INSERT INTO Pracownicy
 VALUES (111,'Zuzanna','Mroz','1984-12-23','Kobieta','y01n6az0x3mr@gmail.com','Sternik plyty lotniska',5)
INSERT INTO Pracownicy
 VALUES (112,'Magda','Zakrzewska','1986-06-30','Kobieta','3w60smexo3l8@gmail.com','Operator wozka bagazowego',14)
INSERT INTO Pracownicy
 VALUES (113,'Lila','Sikorska','1987-03-24','Kobieta','htn5nqr7ersv@gmail.com','Ochrona',9)
INSERT INTO Pracownicy
 VALUES (114,'Julianna','Kucharska','1987-09-10','Kobieta','nvczkt9q9g2z@gmail.com','Mechanik lotniczy',8)
INSERT INTO Pracownicy
 VALUES (115,'Regina','Wisniewska','1989-08-10','Kobieta','eo0z5kgouiwd@gmail.com','Nadzor obslugi naziemnej',2)
INSERT INTO Pracownicy
 VALUES (116,'Alina','Zalewska','1990-01-11','Kobieta','ilvp6cjnad5k@gmail.com','Ochrona terminala',14)
INSERT INTO Pracownicy
 VALUES (117,'Jadwiga','Kozlowska','1991-08-01','Kobieta','vmmbgwkti6kx@gmail.com','Obsluga odprawy bagazowej',9)
INSERT INTO Pracownicy
 VALUES (118,'Diana','Jaworska','1991-10-26','Kobieta','16krt7jbdl4p@gmail.com','Rozladunek bagazu',13)
INSERT INTO Pracownicy
 VALUES (119,'Ewelina','Krupa','1992-02-01','Kobieta','32ynl3bsoon5@gmail.com','Operator maszyn nakierowywujacych',4)
INSERT INTO Pracownicy
 VALUES (120,'lucja','Sikorska','1993-06-15','Kobieta','vlubrfgz4jh1@gmail.com','Sternik plyty lotniska',7)
INSERT INTO Pracownicy
 VALUES (121,'Marcela','Andrzejewska','1994-01-31','Kobieta','mqv14i52fxct@gmail.com','Operator wozka bagazowego',13)
INSERT INTO Pracownicy
 VALUES (122,'Maja','Nowak','1994-03-05','Kobieta','8vagyyguxhj0@gmail.com','Ochrona',4)
INSERT INTO Pracownicy
 VALUES (123,'Elena','Jakubowska','1997-06-02','Kobieta','hoswzpg6wbcq@gmail.com','Mechanik lotniczy',6)
INSERT INTO Pracownicy
 VALUES (124,'Malwina','Piotrowska','1998-09-26','Kobieta','ano2g7stvpr6@gmail.com','Nadzor obslugi naziemnej',9)
INSERT INTO Pracownicy
 VALUES (125,'Celina','Kwiatkowska','1960-06-29','Kobieta','f8i4c1mxm9nx@gmail.com','Ochrona terminala',11)
INSERT INTO Pracownicy
 VALUES (126,'Franciszka','Szulc','1962-01-27','Kobieta','ex2svx0mfmxm@gmail.com','Obsluga odprawy bagazowej',8)
INSERT INTO Pracownicy
 VALUES (127,'Oliwia','Nowak','1963-08-15','Kobieta','tmorzz6cgut3@gmail.com','Rozladunek bagazu',10)
INSERT INTO Pracownicy
 VALUES (128,'Alana','Szymczak','1965-05-06','Kobieta','korqialdmgil@gmail.com','Operator maszyn nakierowywujacych',4)
INSERT INTO Pracownicy
 VALUES (129,'Emilia','Mazurek','1965-07-04','Kobieta','vncovkvp19pm@gmail.com','Sternik plyty lotniska',1)
INSERT INTO Pracownicy
 VALUES (130,'Milena','Gorska','1965-11-04','Kobieta','4r8wc9whno8r@gmail.com','Operator wozka bagazowego',7)
INSERT INTO Pracownicy
 VALUES (131,'Lidia','Makowska','1966-04-08','Kobieta','hrqxsqkubr5d@gmail.com','Ochrona',9)
INSERT INTO Pracownicy
 VALUES (132,'Lara','Kolodziej','1966-04-19','Kobieta','xui8cwtw5ffv@gmail.com','Mechanik lotniczy',3)
INSERT INTO Pracownicy
 VALUES (133,'Faustyna','Kozlowska','1968-11-11','Kobieta','bdq5s6grp6kn@gmail.com','Nadzor obslugi naziemnej',6)
INSERT INTO Pracownicy
 VALUES (134,'Aniela','Ostrowska','1971-05-19','Kobieta','k10wbjysqa56@gmail.com','Ochrona terminala',6)
INSERT INTO Pracownicy
 VALUES (135,'Magda','Kolodziej','1971-08-07','Kobieta','v05xlysj2q4r@gmail.com','Obsluga odprawy bagazowej',7)
INSERT INTO Pracownicy
 VALUES (136,'Pamela','Szymanska','1972-05-19','Kobieta','46axknrpmocu@gmail.com','Rozladunek bagazu',14)
INSERT INTO Pracownicy
 VALUES (137,'Blanka','Witkowska','1972-07-01','Kobieta','ni406941jdtd@gmail.com','Operator maszyn nakierowywujacych',1)
INSERT INTO Pracownicy
 VALUES (138,'Roksana','Ziolkowska','1974-01-31','Kobieta','1mr47kwq7olt@gmail.com','Sternik plyty lotniska',2)
INSERT INTO Pracownicy
 VALUES (139,'Agata','Jankowska','1975-02-12','Kobieta','y3uj4p30365a@gmail.com','Operator wozka bagazowego',15)
INSERT INTO Pracownicy
 VALUES (140,'Joanna','Maciejewska','1975-03-28','Kobieta','n9uxh2hctb6f@gmail.com','Ochrona',14)
INSERT INTO Pracownicy
 VALUES (141,'Jadwiga','Sadowska','1979-12-05','Kobieta','o022us8mhwqf@gmail.com','Mechanik lotniczy',9)
INSERT INTO Pracownicy
 VALUES (142,'Arleta','Zalewska','1983-07-16','Kobieta','9lolzumfaldh@gmail.com','Nadzor obslugi naziemnej',4)
INSERT INTO Pracownicy
 VALUES (143,'Faustyna','Ostrowska','1986-07-25','Kobieta','stctkzgg0z93@gmail.com','Ochrona terminala',3)
INSERT INTO Pracownicy
 VALUES (144,'Anita','Czarnecka','1987-11-29','Kobieta','17wybe5366et@gmail.com','Obsluga odprawy bagazowej',1)
INSERT INTO Pracownicy
 VALUES (145,'Magdalena','Ziolkowska','1989-09-29','Kobieta','kpil7o7cf9rs@gmail.com','Rozladunek bagazu',2)
INSERT INTO Pracownicy
 VALUES (146,'Lara','Adamska','1991-11-25','Kobieta','e8al4g8cvovj@gmail.com','Operator maszyn nakierowywujacych',8)
INSERT INTO Pracownicy
 VALUES (147,'Lucyna','Pawlak','1994-08-05','Kobieta','sq9w7mwq2tf9@gmail.com','Sternik plyty lotniska',9)
INSERT INTO Pracownicy
 VALUES (148,'Iga','Jankowska','1998-09-09','Kobieta','6jyrfv07ymud@gmail.com','Operator wozka bagazowego',15)
INSERT INTO Pracownicy
 VALUES (149,'Ola','Szymczak','1999-02-22','Kobieta','6rz6294ss2ee@gmail.com','Ochrona',14)
--Hangary
INSERT INTO Hangary
 VALUES (1,188714,'TAK',2016,7)
INSERT INTO Hangary
 VALUES (2,212330,'NIE',2013,10)
INSERT INTO Hangary
 VALUES (3,198774,'TAK',1966,9)
INSERT INTO Hangary
 VALUES (4,213043,'TAK',1950,6)
INSERT INTO Hangary
 VALUES (5,213081,'TAK',1953,8)
INSERT INTO Hangary
 VALUES (6,205266,'NIE',2005,14)
INSERT INTO Hangary
 VALUES (7,188691,'NIE',2019,12)
INSERT INTO Hangary
 VALUES (8,176305,'NIE',1989,11)
INSERT INTO Hangary
 VALUES (9,219136,'NIE',1986,1)
INSERT INTO Hangary
 VALUES (10,211578,'NIE',2002,2)
INSERT INTO Hangary
 VALUES (11,206081,'NIE',1989,4)
INSERT INTO Hangary
 VALUES (12,221896,'NIE',1997,15)
INSERT INTO Hangary
 VALUES (13,209610,'TAK',2018,3)
INSERT INTO Hangary
 VALUES (14,194773,'NIE',2011,5)
INSERT INTO Hangary
 VALUES (15,240625,'TAK',1997,13)
INSERT INTO Hangary
 VALUES (16,205106,'TAK',2012,1)
INSERT INTO Hangary
 VALUES (17,243697,'NIE',2009,6)
INSERT INTO Hangary
 VALUES (18,181987,'TAK',1979,10)
INSERT INTO Hangary
 VALUES (19,215813,'TAK',2014,10)
INSERT INTO Hangary
 VALUES (20,222211,'NIE',2009,13)
INSERT INTO Hangary
 VALUES (21,201867,'TAK',2005,10)
INSERT INTO Hangary
 VALUES (22,194198,'TAK',2003,7)
INSERT INTO Hangary
 VALUES (23,178546,'NIE',2001,3)
INSERT INTO Hangary
 VALUES (24,213052,'TAK',2008,5)
INSERT INTO Hangary
 VALUES (25,194796,'TAK',2020,3)
INSERT INTO Hangary
 VALUES (26,239626,'TAK',1957,2)
INSERT INTO Hangary
 VALUES (27,180458,'TAK',2004,1)
INSERT INTO Hangary
 VALUES (28,205099,'NIE',2008,13)
INSERT INTO Hangary
 VALUES (29,234028,'TAK',1991,13)
INSERT INTO Hangary
 VALUES (30,236958,'TAK',1978,12)
INSERT INTO Hangary
 VALUES (31,220575,'TAK',1967,10)
INSERT INTO Hangary
 VALUES (32,248944,'NIE',1979,11)
INSERT INTO Hangary
 VALUES (33,182472,'TAK',2014,2)
INSERT INTO Hangary
 VALUES (34,196601,'TAK',1964,11)
INSERT INTO Hangary
 VALUES (35,226482,'TAK',1990,5)
INSERT INTO Hangary
 VALUES (36,193075,'NIE',1970,1)
INSERT INTO Hangary
 VALUES (37,231723,'TAK',2009,11)
INSERT INTO Hangary
 VALUES (38,218474,'NIE',2004,14)
INSERT INTO Hangary
 VALUES (39,223217,'TAK',2013,8)
INSERT INTO Hangary
 VALUES (40,215196,'TAK',1974,13)
INSERT INTO Hangary
 VALUES (41,231618,'TAK',2016,3)
INSERT INTO Hangary
 VALUES (42,217959,'NIE',2011,1)
INSERT INTO Hangary
 VALUES (43,196868,'NIE',2016,10)
INSERT INTO Hangary
 VALUES (44,225693,'NIE',1977,2)
INSERT INTO Hangary
 VALUES (45,235582,'NIE',2007,5)
INSERT INTO Hangary
 VALUES (46,192332,'NIE',1992,3)
INSERT INTO Hangary
 VALUES (47,236341,'NIE',1995,11)
INSERT INTO Hangary
 VALUES (48,183959,'NIE',1977,9)
INSERT INTO Hangary
 VALUES (49,175601,'TAK',1956,15)
INSERT INTO Hangary
 VALUES (50,196308,'NIE',1994,6)
INSERT INTO Hangary
 VALUES (51,227704,'TAK',1973,7)
INSERT INTO Hangary
 VALUES (52,233841,'TAK',2007,6)
INSERT INTO Hangary
 VALUES (53,184735,'NIE',2007,15)
INSERT INTO Hangary
 VALUES (54,172834,'TAK',1982,12)
INSERT INTO Hangary
 VALUES (55,195910,'TAK',1951,7)
INSERT INTO Hangary
 VALUES (56,178960,'NIE',1971,5)
INSERT INTO Hangary
 VALUES (57,187201,'TAK',1998,10)
INSERT INTO Hangary
 VALUES (58,188445,'TAK',2018,7)
INSERT INTO Hangary
 VALUES (59,218797,'NIE',1979,1)
INSERT INTO Hangary
 VALUES (60,218705,'TAK',1978,9)
INSERT INTO Hangary
 VALUES (61,239928,'TAK',2011,9)
INSERT INTO Hangary
 VALUES (62,218616,'TAK',2020,11)
INSERT INTO Hangary
 VALUES (63,193362,'TAK',1999,12)
INSERT INTO Hangary
 VALUES (64,206615,'NIE',2017,5)
INSERT INTO Hangary
 VALUES (65,188322,'TAK',1981,13)
INSERT INTO Hangary
 VALUES (66,215599,'TAK',1963,15)
INSERT INTO Hangary
 VALUES (67,207288,'TAK',2016,14)
INSERT INTO Hangary
 VALUES (68,248667,'NIE',1990,13)
INSERT INTO Hangary
 VALUES (69,213090,'TAK',1988,4)
INSERT INTO Hangary
 VALUES (70,241466,'TAK',1992,10)
INSERT INTO Hangary
 VALUES (71,176429,'TAK',2009,4)
INSERT INTO Hangary
 VALUES (72,189606,'NIE',2009,10)
INSERT INTO Hangary
 VALUES (73,238455,'TAK',2005,3)
INSERT INTO Hangary
 VALUES (74,213433,'NIE',1983,14)
INSERT INTO Hangary
 VALUES (75,236803,'TAK',1968,10)
INSERT INTO Hangary
 VALUES (76,209925,'TAK',2020,3)
INSERT INTO Hangary
 VALUES (77,202757,'TAK',2011,14)
INSERT INTO Hangary
 VALUES (78,246357,'NIE',2009,1)
INSERT INTO Hangary
 VALUES (79,212011,'NIE',1995,7)
INSERT INTO Hangary
 VALUES (80,204604,'NIE',1970,12)
INSERT INTO Hangary
 VALUES (81,190094,'NIE',1969,7)
INSERT INTO Hangary
 VALUES (82,218240,'NIE',2015,2)
INSERT INTO Hangary
 VALUES (83,222921,'NIE',2019,2)
INSERT INTO Hangary
 VALUES (84,211369,'NIE',1989,3)
INSERT INTO Hangary
 VALUES (85,238501,'TAK',2011,5)
INSERT INTO Hangary
 VALUES (86,240696,'NIE',1970,13)
INSERT INTO Hangary
 VALUES (87,247144,'TAK',2001,2)
INSERT INTO Hangary
 VALUES (88,173321,'TAK',1985,3)
INSERT INTO Hangary
 VALUES (89,189337,'NIE',2003,15)
INSERT INTO Hangary
 VALUES (90,191721,'TAK',2019,7)
INSERT INTO Hangary
 VALUES (91,232620,'TAK',1976,9)
INSERT INTO Hangary
 VALUES (92,191035,'NIE',1958,3)
INSERT INTO Hangary
 VALUES (93,181377,'TAK',2022,1)
INSERT INTO Hangary
 VALUES (94,227524,'TAK',2003,13)
INSERT INTO Hangary
 VALUES (95,225869,'NIE',1960,15)
INSERT INTO Hangary
 VALUES (96,194998,'TAK',1950,14)
INSERT INTO Hangary
 VALUES (97,217599,'TAK',2013,1)
INSERT INTO Hangary
 VALUES (98,185244,'TAK',2013,6)
INSERT INTO Hangary
 VALUES (99,214996,'TAK',1983,10)
INSERT INTO Hangary
 VALUES (100,246182,'NIE',1975,3)
--Kadra
INSERT INTO Kadra
 VALUES (19,'Fabian','Kowalski','1980-01-06','Mezczyzna')
INSERT INTO Kadra
 VALUES (17,'Klaudiusz','Lewandowski','1981-10-28','Mezczyzna')
INSERT INTO Kadra
 VALUES (11,'Maurycy','Lewandowski','1983-10-29','Mezczyzna')
INSERT INTO Kadra
 VALUES (7,'Florian','Głowacka','1984-03-16','Mezczyzna')
INSERT INTO Kadra
 VALUES (8,'Aleksander','Andrzejewski','1984-04-25','Mezczyzna')
INSERT INTO Kadra
 VALUES (13,'Klaudiusz','Stępień','1985-06-09','Mezczyzna')
INSERT INTO Kadra
 VALUES (6,'Ireneusz','Kwiatkowski','1985-07-01','Mezczyzna')
INSERT INTO Kadra
 VALUES (9,'Aureliusz','Głowacka','1985-09-26','Mezczyzna')
INSERT INTO Kadra
 VALUES (2,'Przemysław','Zawadzki','1987-01-13','Mezczyzna')
INSERT INTO Kadra
 VALUES (18,'Bartłomiej','Szymański','1987-09-04','Mezczyzna')
INSERT INTO Kadra
 VALUES (10,'Amadeusz','Andrzejewski','1987-09-06','Mezczyzna')
INSERT INTO Kadra
 VALUES (16,'Dobromił','Kowalski','1988-01-06','Mezczyzna')
INSERT INTO Kadra
 VALUES (4,'Robert','Wiśniewski','1991-07-28','Mezczyzna')
INSERT INTO Kadra
 VALUES (1,'Andrzej','Włodarczyk','1991-08-25','Mezczyzna')
INSERT INTO Kadra
 VALUES (12,'Bartłomiej','Baran','1991-11-14','Mezczyzna')
INSERT INTO Kadra
 VALUES (14,'Leszek','Gajewska','1992-04-16','Mezczyzna')
INSERT INTO Kadra
 VALUES (3,'Dariusz','Szymański','1992-08-31','Mezczyzna')
INSERT INTO Kadra
 VALUES (15,'Amir','Cieślak','1993-05-10','Mezczyzna')
INSERT INTO Kadra
 VALUES (5,'Alfred','Kowalczyk','1993-08-03','Mezczyzna')
INSERT INTO Kadra
 VALUES (20,'Alojzy','Maciejewski','1995-04-01','Mezczyzna')
INSERT INTO Kadra
 VALUES (19,'Eugeniusz','Walczak','1995-11-15','Mezczyzna')
INSERT INTO Kadra
 VALUES (17,'Aleksy','Kozłowski','1997-06-18','Mezczyzna')
INSERT INTO Kadra
 VALUES (11,'Cyprian','Lis','1998-03-09','Mezczyzna')
INSERT INTO Kadra
 VALUES (7,'Oskar','Lis','1999-03-18','Mezczyzna')
INSERT INTO Kadra
 VALUES (8,'Henryk','Krupa','2000-05-30','Mezczyzna')
INSERT INTO Kadra
 VALUES (13,'Błażej','Marciniak','1980-10-06','Mezczyzna')
INSERT INTO Kadra
 VALUES (6,'Przemysław','Lewandowski','1981-01-11','Mezczyzna')
INSERT INTO Kadra
 VALUES (9,'Gracjan','Włodarczyk','1981-10-11','Mezczyzna')
INSERT INTO Kadra
 VALUES (2,'Julian','Sikora','1982-07-05','Mezczyzna')
INSERT INTO Kadra
 VALUES (18,'Eugeniusz','Głowacki','1982-07-23','Mezczyzna')
INSERT INTO Kadra
 VALUES (10,'Małgorzata','Chmielewska','1983-02-15','Kobieta')
INSERT INTO Kadra
 VALUES (16,'Ilona','Marciniak','1983-09-12','Kobieta')
INSERT INTO Kadra
 VALUES (4,'Oksana','Baran','1985-08-14','Kobieta')
INSERT INTO Kadra
 VALUES (1,'Barbara','Andrzejewska','1986-01-23','Kobieta')
INSERT INTO Kadra
 VALUES (12,'Żaneta','Baran','1986-06-24','Kobieta')
INSERT INTO Kadra
 VALUES (14,'Józefa','Kołodziej','1986-07-04','Kobieta')
INSERT INTO Kadra
 VALUES (3,'Roksana','Wróblewska','1986-09-08','Kobieta')
INSERT INTO Kadra
 VALUES (15,'Milena','Sikora','1986-12-27','Kobieta')
INSERT INTO Kadra
 VALUES (5,'Maja','Kowalczyk','1987-09-20','Kobieta')
INSERT INTO Kadra
 VALUES (20,'Mirosława','Wysocka','1987-12-29','Kobieta')
INSERT INTO Kadra
 VALUES (19,'Izyda','Krajewska','1990-08-12','Kobieta')
INSERT INTO Kadra
 VALUES (17,'Żaneta','Górecka','1991-06-27','Kobieta')
INSERT INTO Kadra
 VALUES (11,'Anatolia','Kaźmierczak','1991-11-26','Kobieta')
INSERT INTO Kadra
 VALUES (7,'Oksana','Zalewska','1993-03-08','Kobieta')
INSERT INTO Kadra
 VALUES (8,'Oktawia','Zielińska','1994-04-03','Kobieta')
INSERT INTO Kadra
 VALUES (13,'Angelika','Kołodziej','1994-06-25','Kobieta')
INSERT INTO Kadra
 VALUES (6,'Jola','Maciejewska','1995-11-11','Kobieta')
INSERT INTO Kadra
 VALUES (9,'Anatolia','Mazur','1997-12-03','Kobieta')
INSERT INTO Kadra
 VALUES (2,'Natalia','Szewczyk','1999-06-03','Kobieta')
INSERT INTO Kadra
 VALUES (18,'Milena','Marciniak','1999-11-29','Kobieta')
INSERT INTO Kadra
 VALUES (10,'Konstancja','Kaźmierczak','1980-02-14','Kobieta')
INSERT INTO Kadra
 VALUES (16,'Berenika','Chmielewska','1982-11-11','Kobieta')
INSERT INTO Kadra
 VALUES (4,'Ada','Błaszczyk','1983-04-10','Kobieta')
INSERT INTO Kadra
 VALUES (1,'Natalia','Lis','1985-06-15','Kobieta')
INSERT INTO Kadra
 VALUES (12,'Bianka','Kozłowska','1985-12-03','Kobieta')
INSERT INTO Kadra
 VALUES (14,'Gabriela','Sawicka','1986-02-06','Kobieta')
INSERT INTO Kadra
 VALUES (3,'Agnieszka','Przybylska','1986-10-11','Kobieta')
INSERT INTO Kadra
 VALUES (15,'Asia','Chmielewska','1986-12-22','Kobieta')
INSERT INTO Kadra
 VALUES (5,'Czesława','Sikorska','1987-02-01','Kobieta')
INSERT INTO Kadra
 VALUES (20,'Otylia','Ostrowska','1989-12-25','Kobieta')
INSERT INTO Kadra
 VALUES (3,'Martyna','Michalak','1990-01-01','Kobieta')
INSERT INTO Kadra
 VALUES (11,'Józefa','Włodarczyk','1990-08-07','Kobieta')
INSERT INTO Kadra
 VALUES (19,'Judyta','Ziółkowska','1990-11-10','Kobieta')
INSERT INTO Kadra
 VALUES (9,'Irena','Borkowska','1991-05-11','Kobieta')
INSERT INTO Kadra
 VALUES (4,'Monika','Krupa','1992-02-09','Kobieta')
INSERT INTO Kadra
 VALUES (10,'Bernadetta','Wysocka','1993-04-19','Kobieta')
INSERT INTO Kadra
 VALUES (5,'Andrea','Sikorska','1993-10-06','Kobieta')
INSERT INTO Kadra
 VALUES (16,'Zofia','Sobczak','1994-03-01','Kobieta')
INSERT INTO Kadra
 VALUES (11,'Kaja','Zalewska','1996-08-10','Kobieta')
INSERT INTO Kadra
 VALUES (3,'Luiza','Głowacka','1998-09-23','Kobieta')
INSERT INTO Kadra
 VALUES (18,'Helena','Sikorska','1998-12-21','Kobieta')
INSERT INTO Kadra
 VALUES (14,'Róża','Wysocka','1999-02-12','Kobieta')
INSERT INTO Kadra
 VALUES (7,'Angelika','Błaszczyk','1999-12-11','Kobieta')
INSERT INTO Kadra
 VALUES (4,'Elżbieta','Gajewska','2000-11-28','Kobieta')
INSERT INTO Kadra
 VALUES (17,'Jadwiga','Kowalska','2000-11-29','Kobieta')
INSERT INTO Kadra
 VALUES (19,'Alisa','Gajewska','1980-02-16','Kobieta')
INSERT INTO Kadra
 VALUES (18,'Idalia','Włodarczyk','1980-07-12','Kobieta')
INSERT INTO Kadra
 VALUES (10,'Klementyna','Jakubowska','1981-11-08','Kobieta')
INSERT INTO Kadra
 VALUES (17,'Cecylia','Sokołowska','1982-09-05','Kobieta')
INSERT INTO Kadra
 VALUES (10,'Luiza','Kwiatkowska','1983-05-25','Kobieta')
INSERT INTO Kadra
 VALUES (1,'Lara','Adamska','1985-09-27','Kobieta')
INSERT INTO Kadra
 VALUES (10,'Magdalena','Baranowska','1986-02-08','Kobieta')
INSERT INTO Kadra
 VALUES (20,'Pamela','Marciniak','1986-08-27','Kobieta')
INSERT INTO Kadra
 VALUES (8,'Zuzanna','Mazurek','1988-04-19','Kobieta')
INSERT INTO Kadra
 VALUES (20,'Mirosława','Woźniak','1988-05-06','Kobieta')
INSERT INTO Kadra
 VALUES (2,'Regina','Kołodziej','1989-04-03','Kobieta')
INSERT INTO Kadra
 VALUES (14,'Barbara','Kwiatkowska','1990-07-04','Kobieta')
INSERT INTO Kadra
 VALUES (10,'Alisa','Rutkowska','1990-10-27','Kobieta')
INSERT INTO Kadra
 VALUES (13,'Eliza','Kowalczyk','1991-08-26','Kobieta')
INSERT INTO Kadra
 VALUES (8,'Amalia','Woźniak','1993-01-10','Kobieta')
INSERT INTO Kadra
 VALUES (20,'Adrianna','Wysocka','1994-01-13','Kobieta')
INSERT INTO Kadra
 VALUES (6,'Marysia','Sokołowska','1995-01-30','Kobieta')
INSERT INTO Kadra
 VALUES (14,'Felicja','Włodarczyk','1995-03-02','Kobieta')
INSERT INTO Kadra
 VALUES (6,'Klara','Przybylska','1995-10-20','Kobieta')
INSERT INTO Kadra
 VALUES (5,'Liliana','Górska','1995-12-06','Kobieta')
INSERT INTO Kadra
 VALUES (17,'Cecylia','Zakrzewska','1996-08-30','Kobieta')
INSERT INTO Kadra
 VALUES (12,'Lila','Szewczyk','1997-05-18','Kobieta')
INSERT INTO Kadra
 VALUES (11,'Zofia','Błaszczyk','1998-11-09','Kobieta')
INSERT INTO Kadra
 VALUES (7,'Barbara','Sikora','1998-11-17','Kobieta')
INSERT INTO Kadra
 VALUES (20,'Agata','Kowalska','1999-10-30','Kobieta')
--Odlot
INSERT INTO Odlot
 VALUES (1,'Rzeszow',1,'05:05')
INSERT INTO Odlot
 VALUES (2,'Krakow',2,'05:30')
INSERT INTO Odlot
 VALUES (3,'Wroclaw',4,'05:40')
INSERT INTO Odlot
 VALUES (4,'Katowice',3,'05:50')
INSERT INTO Odlot
 VALUES (5,'Zielona Gora',5,'06:00')
INSERT INTO Odlot
 VALUES (6,'Szczecin',6,'06:05')
INSERT INTO Odlot
 VALUES (7,'Poznan',7,'06:10')
INSERT INTO Odlot
 VALUES (8,'Lodz',8,'06:30')
INSERT INTO Odlot
 VALUES (9,'Lublin',10,'07:00')
INSERT INTO Odlot
 VALUES (10,'Warszawa',12,'07:20')
INSERT INTO Odlot
 VALUES (11,'Warszawa',12,'07:25')
INSERT INTO Odlot
 VALUES (12,'Olsztyn',13,'07:30')
INSERT INTO Odlot
 VALUES (13,'Bydgoszcz',14,'07:45')
INSERT INTO Odlot
 VALUES (14,'Gdansk',15,'07:50')
INSERT INTO Odlot
 VALUES (15,'Gdansk',15,'07:55')
INSERT INTO Odlot
 VALUES (16,'Radom',9,'08:10')
INSERT INTO Odlot
 VALUES (17,'Rzeszow',1,'08:25')
INSERT INTO Odlot
 VALUES (18,'Krakow',2,'08:35')
INSERT INTO Odlot
 VALUES (19,'Wroclaw',4,'09:00')
INSERT INTO Odlot
 VALUES (20,'Katowice',3,'09:10')
INSERT INTO Odlot
 VALUES (21,'Zielona Gora',5,'09:30')
INSERT INTO Odlot
 VALUES (22,'Szczecin',6,'09:35')
INSERT INTO Odlot
 VALUES (23,'Poznan',7,'09:40')
INSERT INTO Odlot
 VALUES (24,'Lodz',8,'10:10')
INSERT INTO Odlot
 VALUES (25,'Lublin',10,'10:35')
INSERT INTO Odlot
 VALUES (26,'Warszawa',11,'10:45')
INSERT INTO Odlot
 VALUES (27,'Warszawa',11,'10:50')
INSERT INTO Odlot
 VALUES (28,'Olsztyn',13,'10:55')
INSERT INTO Odlot
 VALUES (29,'Bydgoszcz',14,'11:05')
INSERT INTO Odlot
 VALUES (30,'Gdansk',15,'11:15')
INSERT INTO Odlot
 VALUES (31,'Gdansk',15,'11:25')
INSERT INTO Odlot
 VALUES (32,'Radom',9,'11:30')
INSERT INTO Odlot
 VALUES (33,'Rzeszow',1,'12:00')
INSERT INTO Odlot
 VALUES (34,'Krakow',2,'12:05')
INSERT INTO Odlot
 VALUES (35,'Wroclaw',4,'12:25')
INSERT INTO Odlot
 VALUES (36,'Katowice',3,'12:35')
INSERT INTO Odlot
 VALUES (37,'Zielona Gora',5,'13:15')
INSERT INTO Odlot
 VALUES (38,'Szczecin',6,'13:20')
INSERT INTO Odlot
 VALUES (39,'Poznan',7,'13:45')
INSERT INTO Odlot
 VALUES (40,'Lodz',8,'13:50')
INSERT INTO Odlot
 VALUES (41,'Lublin',10,'13:55')
INSERT INTO Odlot
 VALUES (42,'Warszawa',11,'14:05')
INSERT INTO Odlot
 VALUES (43,'Warszawa',11,'14:30')
INSERT INTO Odlot
 VALUES (44,'Olsztyn',13,'14:40')
INSERT INTO Odlot
 VALUES (45,'Bydgoszcz',14,'14:45')
INSERT INTO Odlot
 VALUES (46,'Gdansk',15,'14:50')
INSERT INTO Odlot
 VALUES (47,'Gdansk',15,'14:55')
INSERT INTO Odlot
 VALUES (48,'Radom',9,'15:00')
INSERT INTO Odlot
 VALUES (49,'Rzeszow',1,'15:10')
INSERT INTO Odlot
 VALUES (50,'Krakow',2,'15:15')
INSERT INTO Odlot
 VALUES (51,'Wroclaw',4,'15:30')
INSERT INTO Odlot
 VALUES (52,'Katowice',3,'15:45')
INSERT INTO Odlot
 VALUES (53,'Zielona Gora',5,'16:05')
INSERT INTO Odlot
 VALUES (54,'Szczecin',6,'16:10')
INSERT INTO Odlot
 VALUES (55,'Poznan',7,'16:20')
INSERT INTO Odlot
 VALUES (56,'Lodz',8,'16:35')
INSERT INTO Odlot
 VALUES (57,'Lublin',10,'16:45')
INSERT INTO Odlot
 VALUES (58,'Warszawa',11,'16:50')
INSERT INTO Odlot
 VALUES (59,'Warszawa',11,'16:55')
INSERT INTO Odlot
 VALUES (60,'Olsztyn',13,'17:05')
INSERT INTO Odlot
 VALUES (61,'Bydgoszcz',14,'17:10')
INSERT INTO Odlot
 VALUES (62,'Gdansk',15,'17:20')
INSERT INTO Odlot
 VALUES (63,'Gdansk',15,'17:25')
INSERT INTO Odlot
 VALUES (64,'Radom',9,'17:30')
INSERT INTO Odlot
 VALUES (65,'Rzeszow',1,'17:35')
INSERT INTO Odlot
 VALUES (66,'Krakow',2,'17:50')
INSERT INTO Odlot
 VALUES (67,'Wroclaw',4,'17:55')
INSERT INTO Odlot
 VALUES (68,'Katowice',3,'18:00')
INSERT INTO Odlot
 VALUES (69,'Zielona Gora',5,'18:15')
INSERT INTO Odlot
 VALUES (70,'Szczecin',6,'18:40')
INSERT INTO Odlot
 VALUES (71,'Poznan',7,'18:55')
INSERT INTO Odlot
 VALUES (72,'Lodz',8,'19:10')
INSERT INTO Odlot
 VALUES (73,'Lublin',10,'19:20')
INSERT INTO Odlot
 VALUES (74,'Warszawa',11,'19:30')
INSERT INTO Odlot
 VALUES (75,'Warszawa',12,'19:35')
INSERT INTO Odlot
 VALUES (76,'Olsztyn',13,'19:40')
INSERT INTO Odlot
 VALUES (77,'Bydgoszcz',14,'19:45')
INSERT INTO Odlot
 VALUES (78,'Gdansk',15,'20:00')
INSERT INTO Odlot
 VALUES (79,'Gdansk',15,'20:05')
INSERT INTO Odlot
 VALUES (80,'Radom',9,'20:15')
INSERT INTO Odlot
 VALUES (81,'Rzeszow',1,'20:35')
INSERT INTO Odlot
 VALUES (82,'Krakow',2,'20:40')
INSERT INTO Odlot
 VALUES (83,'Wroclaw',4,'20:55')
INSERT INTO Odlot
 VALUES (84,'Lublin',10,'21:10')
INSERT INTO Odlot
 VALUES (85,'Warszawa',12,'21:20')
INSERT INTO Odlot
 VALUES (86,'Warszawa',12,'21:25')
INSERT INTO Odlot
 VALUES (87,'Olsztyn',13,'21:40')
INSERT INTO Odlot
 VALUES (88,'Bydgoszcz',14,'21:55')
INSERT INTO Odlot
 VALUES (89,'Gdansk',15,'22:00')
INSERT INTO Odlot
 VALUES (90,'Gdansk',15,'22:05')
INSERT INTO Odlot
 VALUES (91,'Radom',9,'22:20')
INSERT INTO Odlot
 VALUES (92,'Rzeszow',1,'22:25')
INSERT INTO Odlot
 VALUES (93,'Krakow',2,'22:30')
INSERT INTO Odlot
 VALUES (94,'Wroclaw',4,'22:45')
INSERT INTO Odlot
 VALUES (95,'Katowice',3,'22:50')
INSERT INTO Odlot
 VALUES (96,'Zielona Gora',5,'23:05')
INSERT INTO Odlot
 VALUES (97,'Szczecin',6,'23:15')
INSERT INTO Odlot
 VALUES (98,'Poznan',7,'23:25')
INSERT INTO Odlot
 VALUES (99,'Lodz',8,'23:35')
INSERT INTO Odlot
 VALUES (100,'Lublin',10,'23:50')
--Przylot
INSERT INTO Przylot
 VALUES (1,'Rzeszow',1,'05:05')
INSERT INTO Przylot
 VALUES (2,'Krakow',2,'05:30')
INSERT INTO Przylot
 VALUES (3,'Wroclaw',4,'05:40')
INSERT INTO Przylot
 VALUES (4,'Katowice',3,'05:50')
INSERT INTO Przylot
 VALUES (5,'Zielona Gora',5,'06:00')
INSERT INTO Przylot
 VALUES (6,'Szczecin',6,'06:05')
INSERT INTO Przylot
 VALUES (7,'Poznan',7,'06:10')
INSERT INTO Przylot
 VALUES (8,'Lodz',8,'06:30')
INSERT INTO Przylot
 VALUES (9,'Lublin',10,'07:00')
INSERT INTO Przylot
 VALUES (10,'Warszawa',12,'07:20')
INSERT INTO Przylot
 VALUES (11,'Warszawa',12,'07:25')
INSERT INTO Przylot
 VALUES (12,'Olsztyn',13,'07:30')
INSERT INTO Przylot
 VALUES (13,'Bydgoszcz',14,'07:45')
INSERT INTO Przylot
 VALUES (14,'Gdansk',15,'07:50')
INSERT INTO Przylot
 VALUES (15,'Gdansk',15,'07:55')
INSERT INTO Przylot
 VALUES (16,'Radom',9,'08:10')
INSERT INTO Przylot
 VALUES (17,'Rzeszow',1,'08:25')
INSERT INTO Przylot
 VALUES (18,'Krakow',2,'08:35')
INSERT INTO Przylot
 VALUES (19,'Wroclaw',4,'09:00')
INSERT INTO Przylot
 VALUES (20,'Katowice',3,'09:10')
INSERT INTO Przylot
 VALUES (21,'Zielona Gora',5,'09:30')
INSERT INTO Przylot
 VALUES (22,'Szczecin',6,'09:35')
INSERT INTO Przylot
 VALUES (23,'Poznan',7,'09:40')
INSERT INTO Przylot
 VALUES (24,'Lodz',8,'10:10')
INSERT INTO Przylot
 VALUES (25,'Lublin',10,'10:35')
INSERT INTO Przylot
 VALUES (26,'Warszawa',11,'10:45')
INSERT INTO Przylot
 VALUES (27,'Warszawa',11,'10:50')
INSERT INTO Przylot
 VALUES (28,'Olsztyn',13,'10:55')
INSERT INTO Przylot
 VALUES (29,'Bydgoszcz',14,'11:05')
INSERT INTO Przylot
 VALUES (30,'Gdansk',15,'11:15')
INSERT INTO Przylot
 VALUES (31,'Gdansk',15,'11:25')
INSERT INTO Przylot
 VALUES (32,'Radom',9,'11:30')
INSERT INTO Przylot
 VALUES (33,'Rzeszow',1,'12:00')
INSERT INTO Przylot
 VALUES (34,'Krakow',2,'12:05')
INSERT INTO Przylot
 VALUES (35,'Wroclaw',4,'12:25')
INSERT INTO Przylot
 VALUES (36,'Katowice',3,'12:35')
INSERT INTO Przylot
 VALUES (37,'Zielona Gora',5,'13:15')
INSERT INTO Przylot
 VALUES (38,'Szczecin',6,'13:20')
INSERT INTO Przylot
 VALUES (39,'Poznan',7,'13:45')
INSERT INTO Przylot
 VALUES (40,'Lodz',8,'13:50')
INSERT INTO Przylot
 VALUES (41,'Lublin',10,'13:55')
INSERT INTO Przylot
 VALUES (42,'Warszawa',11,'14:05')
INSERT INTO Przylot
 VALUES (43,'Warszawa',11,'14:30')
INSERT INTO Przylot
 VALUES (44,'Olsztyn',13,'14:40')
INSERT INTO Przylot
 VALUES (45,'Bydgoszcz',14,'14:45')
INSERT INTO Przylot
 VALUES (46,'Gdansk',15,'14:50')
INSERT INTO Przylot
 VALUES (47,'Gdansk',15,'14:55')
INSERT INTO Przylot
 VALUES (48,'Radom',9,'15:00')
INSERT INTO Przylot
 VALUES (49,'Rzeszow',1,'15:10')
INSERT INTO Przylot
 VALUES (50,'Krakow',2,'15:15')
INSERT INTO Przylot
 VALUES (51,'Wroclaw',4,'15:30')
INSERT INTO Przylot
 VALUES (52,'Katowice',3,'15:45')
INSERT INTO Przylot
 VALUES (53,'Zielona Gora',5,'16:05')
INSERT INTO Przylot
 VALUES (54,'Szczecin',6,'16:10')
INSERT INTO Przylot
 VALUES (55,'Poznan',7,'16:20')
INSERT INTO Przylot
 VALUES (56,'Lodz',8,'16:35')
INSERT INTO Przylot
 VALUES (57,'Lublin',10,'16:45')
INSERT INTO Przylot
 VALUES (58,'Warszawa',11,'16:50')
INSERT INTO Przylot
 VALUES (59,'Warszawa',11,'16:55')
INSERT INTO Przylot
 VALUES (60,'Olsztyn',13,'17:05')
INSERT INTO Przylot
 VALUES (61,'Bydgoszcz',14,'17:10')
INSERT INTO Przylot
 VALUES (62,'Gdansk',15,'17:20')
INSERT INTO Przylot
 VALUES (63,'Gdansk',15,'17:25')
INSERT INTO Przylot
 VALUES (64,'Radom',9,'17:30')
INSERT INTO Przylot
 VALUES (65,'Rzeszow',1,'17:35')
INSERT INTO Przylot
 VALUES (66,'Krakow',2,'17:50')
INSERT INTO Przylot
 VALUES (67,'Wroclaw',4,'17:55')
INSERT INTO Przylot
 VALUES (68,'Katowice',3,'18:00')
INSERT INTO Przylot
 VALUES (69,'Zielona Gora',5,'18:15')
INSERT INTO Przylot
 VALUES (70,'Szczecin',6,'18:40')
INSERT INTO Przylot
 VALUES (71,'Poznan',7,'18:55')
INSERT INTO Przylot
 VALUES (72,'Lodz',8,'19:10')
INSERT INTO Przylot
 VALUES (73,'Lublin',10,'19:20')
INSERT INTO Przylot
 VALUES (74,'Warszawa',11,'19:30')
INSERT INTO Przylot
 VALUES (75,'Warszawa',12,'19:35')
INSERT INTO Przylot
 VALUES (76,'Olsztyn',13,'19:40')
INSERT INTO Przylot
 VALUES (77,'Bydgoszcz',14,'19:45')
INSERT INTO Przylot
 VALUES (78,'Gdansk',15,'20:00')
INSERT INTO Przylot
 VALUES (79,'Gdansk',15,'20:05')
INSERT INTO Przylot
 VALUES (80,'Radom',9,'20:15')
INSERT INTO Przylot
 VALUES (81,'Rzeszow',1,'20:35')
INSERT INTO Przylot
 VALUES (82,'Krakow',2,'20:40')
INSERT INTO Przylot
 VALUES (83,'Wroclaw',4,'20:55')
INSERT INTO Przylot
 VALUES (84,'Lublin',10,'21:10')
INSERT INTO Przylot
 VALUES (85,'Warszawa',12,'21:20')
INSERT INTO Przylot
 VALUES (86,'Warszawa',12,'21:25')
INSERT INTO Przylot
 VALUES (87,'Olsztyn',13,'21:40')
INSERT INTO Przylot
 VALUES (88,'Bydgoszcz',14,'21:55')
INSERT INTO Przylot
 VALUES (89,'Gdansk',15,'22:00')
INSERT INTO Przylot
 VALUES (90,'Gdansk',15,'22:05')
INSERT INTO Przylot
 VALUES (91,'Radom',9,'22:20')
INSERT INTO Przylot
 VALUES (92,'Rzeszow',1,'22:25')
INSERT INTO Przylot
 VALUES (93,'Krakow',2,'22:30')
INSERT INTO Przylot
 VALUES (94,'Wroclaw',4,'22:45')
INSERT INTO Przylot
 VALUES (95,'Katowice',3,'22:50')
INSERT INTO Przylot
 VALUES (96,'Zielona Gora',5,'23:05')
INSERT INTO Przylot
 VALUES (97,'Szczecin',6,'23:15')
INSERT INTO Przylot
 VALUES (98,'Poznan',7,'23:25')
INSERT INTO Przylot
 VALUES (99,'Lodz',8,'23:35')
INSERT INTO Przylot
 VALUES (100,'Lublin',10,'23:50')
--Posilki
INSERT INTO Posilki
 VALUES (1,'Kotlet schabowy z puree i buraczkami',29.0,'Miesna','Polska',450)
INSERT INTO Posilki
 VALUES (2,'Kotlet de volaille z zapiekanymi ziemniaczkami',31.5,'Miesna','Francuska',350)
INSERT INTO Posilki
 VALUES (3,'Rosol z makaronem',11.5,NULL,'Polska',350)
INSERT INTO Posilki
 VALUES (4,'Podwojny cheeseburger z wolowina 100%',44.1,'Miesna','Amerykanska',250)
INSERT INTO Posilki
 VALUES (5,'Makaron primavera z kurczakiem',27.1,'Miesna','Wloska',350)
INSERT INTO Posilki
 VALUES (6,'Pieczone bruschetty z lososia',42.1,'Miesna','Wloska',250)
INSERT INTO Posilki
 VALUES (7,'Wrap z pomidorem, salatka, serkiem i tofu',29.9,'Vegetarianska',NULL,350)
INSERT INTO Posilki
 VALUES (8,'Zestaw wędlin z dodatkami',44.5,'Miesna',NULL,250)
INSERT INTO Posilki
 VALUES (9,'Hummus z warzywami',15.8,'Weganska',NULL,350)
INSERT INTO Posilki
 VALUES (10,'Owsianka z owocami',44.7,'Vegetarianska',NULL,250)
INSERT INTO Posilki
 VALUES (11,'Koktajl owocowo-warzywny',20.0,'Weganska',NULL,450)
INSERT INTO Posilki
 VALUES (12,' sałatka warzywna z mozzarellą',24.5,'Vegetarianska',NULL,450)
INSERT INTO Posilki
 VALUES (13,'Makaron w sosie pomidorowym z serem i nuggetsy z kurczaka',47.5,'Miesna',NULL,250)
INSERT INTO Posilki
 VALUES (14,'Mini pizza z kurczakiem',20.4,'Miesna','Wloska',350)
INSERT INTO Posilki
 VALUES (15,' sałatka z pęczakiem w sosie pesto z pomidorkami koktajlowymi i papryką pieczoną',40.8,'Weganska','Grecka',250)
INSERT INTO Posilki
 VALUES (16,'sałatka ziemniaczana, tatar ze śledzia, roastbef i jajko na twardo',37.6,'Miesna','Angielska',450)
INSERT INTO Posilki
 VALUES (17,'Zestaw śniadaniowy z wędlinami i serami z dodatkami, roladką z łososia i owocami',22.9,'Miesna',NULL,250)
INSERT INTO Posilki
 VALUES (18,'Pełnoziarnista bułka z serami radamer i mozzarella, czerwoną papryką, rukolą i oliwkami',38.1,'Vegetarianska',NULL,250)
INSERT INTO Posilki
 VALUES (19,'Kanapka ze schabem',42.8,'Miesna',NULL,350)
--Polaczenia

INSERT INTO Polaczenia
 VALUES (1,1,40,6,93)
INSERT INTO Polaczenia
 VALUES (2,2,8,44,63)
INSERT INTO Polaczenia
 VALUES (3,3,80,100,78)
INSERT INTO Polaczenia
 VALUES (4,4,41,54,106)
INSERT INTO Polaczenia
 VALUES (5,5,61,91,58)
INSERT INTO Polaczenia
 VALUES (6,6,55,22,78)
INSERT INTO Polaczenia
 VALUES (7,7,97,24,80)
INSERT INTO Polaczenia
 VALUES (8,8,36,93,51)
INSERT INTO Polaczenia
 VALUES (9,9,15,55,68)
INSERT INTO Polaczenia
 VALUES (10,10,99,39,74)
INSERT INTO Polaczenia
 VALUES (11,11,51,57,135)
INSERT INTO Polaczenia
 VALUES (12,12,82,5,141)
INSERT INTO Polaczenia
 VALUES (13,13,93,87,113)
INSERT INTO Polaczenia
 VALUES (14,14,69,8,100)
INSERT INTO Polaczenia
 VALUES (15,15,76,20,106)
INSERT INTO Polaczenia
 VALUES (16,16,98,34,61)
INSERT INTO Polaczenia
 VALUES (17,17,71,38,51)
INSERT INTO Polaczenia
 VALUES (18,18,83,98,114)
INSERT INTO Polaczenia
 VALUES (19,19,6,25,53)
INSERT INTO Polaczenia
 VALUES (20,20,35,99,123)
INSERT INTO Polaczenia
 VALUES (21,1,12,83,58)
INSERT INTO Polaczenia
 VALUES (22,2,50,79,142)
INSERT INTO Polaczenia
 VALUES (23,3,28,64,56)
INSERT INTO Polaczenia
 VALUES (24,4,72,26,52)
INSERT INTO Polaczenia
 VALUES (25,5,75,95,81)
INSERT INTO Polaczenia
 VALUES (26,6,31,59,118)
INSERT INTO Polaczenia
 VALUES (27,7,90,40,63)
INSERT INTO Polaczenia
 VALUES (28,8,56,21,144)
INSERT INTO Polaczenia
 VALUES (29,9,38,4,99)
INSERT INTO Polaczenia
 VALUES (30,10,96,30,141)
INSERT INTO Polaczenia
 VALUES (31,11,91,90,51)
INSERT INTO Polaczenia
 VALUES (32,12,65,46,149)
INSERT INTO Polaczenia
 VALUES (33,13,62,50,133)
INSERT INTO Polaczenia
 VALUES (34,14,63,49,142)
INSERT INTO Polaczenia
 VALUES (35,15,16,94,150)
INSERT INTO Polaczenia
 VALUES (36,16,5,18,96)
INSERT INTO Polaczenia
 VALUES (37,17,64,35,57)
INSERT INTO Polaczenia
 VALUES (38,18,68,2,103)
INSERT INTO Polaczenia
 VALUES (39,19,18,48,132)
INSERT INTO Polaczenia
 VALUES (40,20,4,60,67)
INSERT INTO Polaczenia
 VALUES (41,1,54,19,107)
INSERT INTO Polaczenia
 VALUES (42,2,2,29,109)
INSERT INTO Polaczenia
 VALUES (43,3,26,33,105)
INSERT INTO Polaczenia
 VALUES (44,4,59,53,66)
INSERT INTO Polaczenia
 VALUES (45,5,52,92,55)
INSERT INTO Polaczenia
 VALUES (46,6,57,72,92)
INSERT INTO Polaczenia
 VALUES (47,7,81,42,53)
INSERT INTO Polaczenia
 VALUES (48,8,77,3,127)
INSERT INTO Polaczenia
 VALUES (49,9,45,66,96)
INSERT INTO Polaczenia
 VALUES (50,10,19,97,123)
INSERT INTO Polaczenia
 VALUES (51,11,73,81,119)
INSERT INTO Polaczenia
 VALUES (52,12,39,16,117)
INSERT INTO Polaczenia
 VALUES (53,13,29,17,102)
INSERT INTO Polaczenia
 VALUES (54,14,33,75,56)
INSERT INTO Polaczenia
 VALUES (55,15,78,88,57)
INSERT INTO Polaczenia
 VALUES (56,16,92,10,101)
INSERT INTO Polaczenia
 VALUES (57,17,20,56,111)
INSERT INTO Polaczenia
 VALUES (58,18,27,65,116)
INSERT INTO Polaczenia
 VALUES (59,19,42,12,140)
INSERT INTO Polaczenia
 VALUES (60,20,88,43,146)
INSERT INTO Polaczenia
 VALUES (61,1,58,7,63)
INSERT INTO Polaczenia
 VALUES (62,2,95,89,79)
INSERT INTO Polaczenia
 VALUES (63,3,10,67,126)
INSERT INTO Polaczenia
 VALUES (64,4,17,27,66)
INSERT INTO Polaczenia
 VALUES (65,5,34,41,95)
INSERT INTO Polaczenia
 VALUES (66,6,53,36,117)
INSERT INTO Polaczenia
 VALUES (67,7,87,74,65)
INSERT INTO Polaczenia
 VALUES (68,8,60,14,81)
INSERT INTO Polaczenia
 VALUES (69,9,94,11,90)
INSERT INTO Polaczenia
 VALUES (70,10,44,78,115)
INSERT INTO Polaczenia
 VALUES (71,11,86,32,53)
INSERT INTO Polaczenia
 VALUES (72,12,21,61,65)
INSERT INTO Polaczenia
 VALUES (73,13,84,80,60)
INSERT INTO Polaczenia
 VALUES (74,14,9,45,110)
INSERT INTO Polaczenia
 VALUES (75,15,3,37,108)
INSERT INTO Polaczenia
 VALUES (76,16,47,76,103)
INSERT INTO Polaczenia
 VALUES (77,17,13,52,50)
INSERT INTO Polaczenia
 VALUES (78,18,11,31,73)
INSERT INTO Polaczenia
 VALUES (79,19,32,28,58)
INSERT INTO Polaczenia
 VALUES (80,20,23,73,62)
INSERT INTO Polaczenia
 VALUES (81,1,37,70,75)
INSERT INTO Polaczenia
 VALUES (82,2,1,15,56)
INSERT INTO Polaczenia
 VALUES (83,3,46,85,58)
INSERT INTO Polaczenia
 VALUES (84,4,43,51,131)
INSERT INTO Polaczenia
 VALUES (85,5,74,47,115)
INSERT INTO Polaczenia
 VALUES (86,6,89,9,64)
INSERT INTO Polaczenia
 VALUES (87,7,22,13,77)
INSERT INTO Polaczenia
 VALUES (88,8,24,58,64)
INSERT INTO Polaczenia
 VALUES (89,9,25,96,107)
INSERT INTO Polaczenia
 VALUES (90,10,14,69,78)
INSERT INTO Polaczenia
 VALUES (91,11,30,62,91)
INSERT INTO Polaczenia
 VALUES (92,12,100,68,87)
INSERT INTO Polaczenia
 VALUES (93,13,79,86,108)
INSERT INTO Polaczenia
 VALUES (94,14,66,63,142)
INSERT INTO Polaczenia
 VALUES (95,15,49,84,140)
INSERT INTO Polaczenia
 VALUES (96,16,67,23,54)
INSERT INTO Polaczenia
 VALUES (97,17,70,82,81)
INSERT INTO Polaczenia
 VALUES (98,18,85,77,79)
INSERT INTO Polaczenia
 VALUES (99,19,48,71,108)
INSERT INTO Polaczenia
 VALUES (100,20,7,1,100)
--Opinia Pasazera
INSERT INTO [Opinia Pasazera]
 VALUES (114, 22,'Jestem zadowolony')
INSERT INTO [Opinia Pasazera]
 VALUES (322,43,'Nareszcie po kilkunastu lotach tanimi liniami lotniczymi nie czułem się jak przedmiot w samolocie tylko osoba:)')
INSERT INTO [Opinia Pasazera]
 VALUES (33,23,'Nie mam żadnych zastrzeżeń, sprawnie i miło.')
INSERT INTO [Opinia Pasazera]
 VALUES (138,35,'Sam lot samolotem przebiegł bardzo dobrze. Problemem było opóźnienie lotu o 2,5 godziny.')
INSERT INTO [Opinia Pasazera]
 VALUES (205,59,'slabo na styk')
INSERT INTO [Opinia Pasazera]
 VALUES (420,88,'Miła obsługa, polecam')
INSERT INTO [Opinia Pasazera]
 VALUES (300,98,'Super, szybko, bezproblemowo')
INSERT INTO [Opinia Pasazera]
 VALUES (403,28,'obsługa bardzo miła, ale przeloty opóźnione, zegar pokładowy opóźniony o godzinę do rzeczywistego czasu, co przy transferze było ogromnym utrudnieniem')
INSERT INTO [Opinia Pasazera]
 VALUES (249,73,'Podróż uważam za swoje najgorsze przeżycie lotnicze. Samolot uległ drobnej usterce (wg. obsługi samolotu), które naprawianie zabrało kilka godzin. Poinformowanie o tym pasażerów zajęło personelowi 2 godziny. Dalej było już tylko gorzej. Sytuację ratowała część obsługi włoskiego lotniska (Marco Polo Airport). Samolot odleciał z prawie jednodniowym opóźnieniem a chaos informacyjny trwał do ostatnich chwil przed odlotem.')
INSERT INTO [Opinia Pasazera]
 VALUES (250,55,'Wszystko byliby dobrze gdyby nie godzinne opoznienie wylotu. Samolot wystartował o 00.00')
INSERT INTO [Opinia Pasazera]
 VALUES (378,36,'Obsługa bardzo miła i pomocna, podróż w wygodnych warunkach, serwowane posiłki smaczne')
INSERT INTO [Opinia Pasazera]
 VALUES (63,76,'Był o ok. Punktualnie i miło.')
INSERT INTO [Opinia Pasazera]
 VALUES (417,10,'Kulturalna obsługa. Przyjazna atmosfera.')
INSERT INTO [Opinia Pasazera]
 VALUES (371,58,'Wszystko było w porządku.')
INSERT INTO [Opinia Pasazera]
 VALUES (207,57,'Profesjonalna obsługa.')
INSERT INTO [Opinia Pasazera]
 VALUES (404,16,'Fatalny lot')
INSERT INTO [Opinia Pasazera]
 VALUES (192,18,'opieka nad pasażerem b dobra, dużo uśmiechu, przyjemna podróż, polskie dziewczyny super')
INSERT INTO [Opinia Pasazera]
 VALUES (65,15,'Super')
--Rezerwacja
INSERT INTO Rezerwacja
 VALUES (64,20,13)
INSERT INTO Rezerwacja
 VALUES (118,5,223)
INSERT INTO Rezerwacja
 VALUES (227,14,118)
INSERT INTO Rezerwacja
 VALUES (297,3,398)
INSERT INTO Rezerwacja
 VALUES (24,59,381)
INSERT INTO Rezerwacja
 VALUES (181,41,65)
INSERT INTO Rezerwacja
 VALUES (50,76,319)
INSERT INTO Rezerwacja
 VALUES (282,69,120)
INSERT INTO Rezerwacja
 VALUES (97,65,281)
INSERT INTO Rezerwacja
 VALUES (204,19,246)
INSERT INTO Rezerwacja
 VALUES (287,18,163)
INSERT INTO Rezerwacja
 VALUES (201,23,23)
INSERT INTO Rezerwacja
 VALUES (111,57,414)
INSERT INTO Rezerwacja
 VALUES (99,72,425)
INSERT INTO Rezerwacja
 VALUES (88,24,149)
INSERT INTO Rezerwacja
 VALUES (66,52,28)
INSERT INTO Rezerwacja
 VALUES (140,89,377)
INSERT INTO Rezerwacja
 VALUES (175,60,44)
INSERT INTO Rezerwacja
 VALUES (81,83,7)
INSERT INTO Rezerwacja
 VALUES (308,27,4)
INSERT INTO Rezerwacja
 VALUES (172,32,391)
INSERT INTO Rezerwacja
 VALUES (158,91,298)
INSERT INTO Rezerwacja
 VALUES (68,17,427)
INSERT INTO Rezerwacja
 VALUES (282,56,271)
INSERT INTO Rezerwacja
 VALUES (247,88,284)
INSERT INTO Rezerwacja
 VALUES (57,78,378)
INSERT INTO Rezerwacja
 VALUES (142,87,384)
INSERT INTO Rezerwacja
 VALUES (223,22,422)
INSERT INTO Rezerwacja
 VALUES (277,80,264)
INSERT INTO Rezerwacja
 VALUES (287,61,199)
INSERT INTO Rezerwacja
 VALUES (18,16,105)
INSERT INTO Rezerwacja
 VALUES (62,21,125)
INSERT INTO Rezerwacja
 VALUES (6,48,326)
INSERT INTO Rezerwacja
 VALUES (283,96,154)
INSERT INTO Rezerwacja
 VALUES (156,93,338)
INSERT INTO Rezerwacja
 VALUES (212,13,161)
INSERT INTO Rezerwacja
 VALUES (164,42,110)
INSERT INTO Rezerwacja
 VALUES (138,49,366)
INSERT INTO Rezerwacja
 VALUES (35,70,121)
INSERT INTO Rezerwacja
 VALUES (66,97,173)
INSERT INTO Rezerwacja
 VALUES (63,66,307)
INSERT INTO Rezerwacja
 VALUES (259,7,316)
INSERT INTO Rezerwacja
 VALUES (262,6,259)
INSERT INTO Rezerwacja
 VALUES (101,11,133)
INSERT INTO Rezerwacja
 VALUES (202,4,244)
INSERT INTO Rezerwacja
 VALUES (48,44,222)
INSERT INTO Rezerwacja
 VALUES (217,26,52)
INSERT INTO Rezerwacja
 VALUES (58,86,351)
INSERT INTO Rezerwacja
 VALUES (133,45,106)
INSERT INTO Rezerwacja
 VALUES (47,100,357)
INSERT INTO Rezerwacja
 VALUES (204,47,360)
INSERT INTO Rezerwacja
 VALUES (76,40,167)
INSERT INTO Rezerwacja
 VALUES (1,94,177)
INSERT INTO Rezerwacja
 VALUES (255,51,409)
INSERT INTO Rezerwacja
 VALUES (307,10,261)
INSERT INTO Rezerwacja
 VALUES (19,98,21)
INSERT INTO Rezerwacja
 VALUES (209,82,254)
INSERT INTO Rezerwacja
 VALUES (85,50,228)
INSERT INTO Rezerwacja
 VALUES (248,12,192)
INSERT INTO Rezerwacja
 VALUES (66,31,194)
INSERT INTO Rezerwacja
 VALUES (42,33,220)
INSERT INTO Rezerwacja
 VALUES (183,30,309)
INSERT INTO Rezerwacja
 VALUES (204,2,250)
INSERT INTO Rezerwacja
 VALUES (96,1,210)
INSERT INTO Rezerwacja
 VALUES (118,77,394)
INSERT INTO Rezerwacja
 VALUES (107,67,404)
INSERT INTO Rezerwacja
 VALUES (276,8,30)
INSERT INTO Rezerwacja
 VALUES (249,29,327)
INSERT INTO Rezerwacja
 VALUES (241,35,216)
INSERT INTO Rezerwacja
 VALUES (21,79,283)
INSERT INTO Rezerwacja
 VALUES (177,36,241)
INSERT INTO Rezerwacja
 VALUES (210,85,175)
INSERT INTO Rezerwacja
 VALUES (268,84,392)
INSERT INTO Rezerwacja
 VALUES (60,37,224)
INSERT INTO Rezerwacja
 VALUES (71,75,143)
INSERT INTO Rezerwacja
 VALUES (236,74,119)
INSERT INTO Rezerwacja
 VALUES (295,39,239)
INSERT INTO Rezerwacja
 VALUES (183,62,147)
INSERT INTO Rezerwacja
 VALUES (37,68,187)
INSERT INTO Rezerwacja
 VALUES (35,55,57)
INSERT INTO Rezerwacja
 VALUES (42,28,389)
INSERT INTO Rezerwacja
 VALUES (243,9,108)
INSERT INTO Rezerwacja
 VALUES (68,15,134)
INSERT INTO Rezerwacja
 VALUES (4,43,417)
INSERT INTO Rezerwacja
 VALUES (237,92,109)
INSERT INTO Rezerwacja
 VALUES (79,25,361)
INSERT INTO Rezerwacja
 VALUES (21,54,408)
INSERT INTO Rezerwacja
 VALUES (35,58,340)
INSERT INTO Rezerwacja
 VALUES (73,99,97)
INSERT INTO Rezerwacja
 VALUES (20,64,314)
INSERT INTO Rezerwacja
 VALUES (119,34,179)
INSERT INTO Rezerwacja
 VALUES (178,38,3)
INSERT INTO Rezerwacja
 VALUES (255,71,72)
INSERT INTO Rezerwacja
 VALUES (68,63,274)
INSERT INTO Rezerwacja
 VALUES (279,95,303)
INSERT INTO Rezerwacja
 VALUES (209,53,273)
INSERT INTO Rezerwacja
 VALUES (250,90,256)
INSERT INTO Rezerwacja
 VALUES (40,73,282)
INSERT INTO Rezerwacja
 VALUES (97,46,90)
INSERT INTO Rezerwacja
 VALUES (142,81,275)
INSERT INTO Rezerwacja
 VALUES (99,20,299)
INSERT INTO Rezerwacja
 VALUES (100,5,12)
INSERT INTO Rezerwacja
 VALUES (62,14,240)
INSERT INTO Rezerwacja
 VALUES (20,3,127)
INSERT INTO Rezerwacja
 VALUES (158,59,69)
INSERT INTO Rezerwacja
 VALUES (189,41,195)
INSERT INTO Rezerwacja
 VALUES (18,76,116)
INSERT INTO Rezerwacja
 VALUES (39,69,290)
INSERT INTO Rezerwacja
 VALUES (261,65,421)
INSERT INTO Rezerwacja
 VALUES (47,19,104)
INSERT INTO Rezerwacja
 VALUES (295,18,396)
INSERT INTO Rezerwacja
 VALUES (70,23,67)
INSERT INTO Rezerwacja
 VALUES (51,57,58)
INSERT INTO Rezerwacja
 VALUES (184,72,66)
INSERT INTO Rezerwacja
 VALUES (266,24,185)
INSERT INTO Rezerwacja
 VALUES (164,52,218)
INSERT INTO Rezerwacja
 VALUES (61,89,47)
INSERT INTO Rezerwacja
 VALUES (197,60,390)
INSERT INTO Rezerwacja
 VALUES (44,83,56)
INSERT INTO Rezerwacja
 VALUES (144,27,83)
INSERT INTO Rezerwacja
 VALUES (277,32,36)
INSERT INTO Rezerwacja
 VALUES (217,91,59)
INSERT INTO Rezerwacja
 VALUES (199,17,230)
INSERT INTO Rezerwacja
 VALUES (287,56,211)
INSERT INTO Rezerwacja
 VALUES (15,88,423)
INSERT INTO Rezerwacja
 VALUES (76,78,50)
INSERT INTO Rezerwacja
 VALUES (24,87,123)
INSERT INTO Rezerwacja
 VALUES (24,22,323)
INSERT INTO Rezerwacja
 VALUES (57,80,170)
INSERT INTO Rezerwacja
 VALUES (237,61,401)
INSERT INTO Rezerwacja
 VALUES (221,16,5)
INSERT INTO Rezerwacja
 VALUES (102,21,41)
INSERT INTO Rezerwacja
 VALUES (71,48,100)
INSERT INTO Rezerwacja
 VALUES (90,96,430)
INSERT INTO Rezerwacja
 VALUES (283,93,245)
INSERT INTO Rezerwacja
 VALUES (179,13,136)
INSERT INTO Rezerwacja
 VALUES (107,42,339)
INSERT INTO Rezerwacja
 VALUES (260,49,208)
INSERT INTO Rezerwacja
 VALUES (19,70,416)
INSERT INTO Rezerwacja
 VALUES (298,97,74)
INSERT INTO Rezerwacja
 VALUES (58,66,84)
INSERT INTO Rezerwacja
 VALUES (224,7,35)
INSERT INTO Rezerwacja
 VALUES (20,6,54)
INSERT INTO Rezerwacja
 VALUES (94,11,46)
INSERT INTO Rezerwacja
 VALUES (195,4,428)
INSERT INTO Rezerwacja
 VALUES (43,44,132)
INSERT INTO Rezerwacja
 VALUES (171,26,151)
INSERT INTO Rezerwacja
 VALUES (42,86,382)
INSERT INTO Rezerwacja
 VALUES (246,45,343)
INSERT INTO Rezerwacja
 VALUES (160,100,49)
INSERT INTO Rezerwacja
 VALUES (186,47,236)
INSERT INTO Rezerwacja
 VALUES (29,40,6)
INSERT INTO Rezerwacja
 VALUES (53,94,359)
INSERT INTO Rezerwacja
 VALUES (251,51,113)
INSERT INTO Rezerwacja
 VALUES (231,10,186)
INSERT INTO Rezerwacja
 VALUES (10,98,209)
INSERT INTO Rezerwacja
 VALUES (87,82,86)
INSERT INTO Rezerwacja
 VALUES (280,50,182)
INSERT INTO Rezerwacja
 VALUES (270,12,276)
INSERT INTO Rezerwacja
 VALUES (111,31,403)
INSERT INTO Rezerwacja
 VALUES (263,33,201)
INSERT INTO Rezerwacja
 VALUES (30,30,262)
INSERT INTO Rezerwacja
 VALUES (40,2,214)
INSERT INTO Rezerwacja
 VALUES (6,1,354)
INSERT INTO Rezerwacja
 VALUES (100,77,342)
INSERT INTO Rezerwacja
 VALUES (220,67,219)
INSERT INTO Rezerwacja
 VALUES (250,8,126)
INSERT INTO Rezerwacja
 VALUES (128,29,372)
INSERT INTO Rezerwacja
 VALUES (186,35,93)
INSERT INTO Rezerwacja
 VALUES (305,79,48)
INSERT INTO Rezerwacja
 VALUES (306,36,128)
INSERT INTO Rezerwacja
 VALUES (228,85,331)
INSERT INTO Rezerwacja
 VALUES (227,84,231)
INSERT INTO Rezerwacja
 VALUES (76,37,107)
INSERT INTO Rezerwacja
 VALUES (180,75,130)
INSERT INTO Rezerwacja
 VALUES (42,74,85)
INSERT INTO Rezerwacja
 VALUES (203,39,413)
INSERT INTO Rezerwacja
 VALUES (256,62,221)
INSERT INTO Rezerwacja
 VALUES (36,68,407)
INSERT INTO Rezerwacja
 VALUES (51,55,176)
INSERT INTO Rezerwacja
 VALUES (239,28,77)
INSERT INTO Rezerwacja
 VALUES (118,9,198)
INSERT INTO Rezerwacja
 VALUES (190,15,184)
INSERT INTO Rezerwacja
 VALUES (194,43,26)
INSERT INTO Rezerwacja
 VALUES (276,92,159)
INSERT INTO Rezerwacja
 VALUES (280,25,399)
INSERT INTO Rezerwacja
 VALUES (307,54,376)
INSERT INTO Rezerwacja
 VALUES (228,58,142)
INSERT INTO Rezerwacja
 VALUES (270,99,191)
INSERT INTO Rezerwacja
 VALUES (40,64,313)
INSERT INTO Rezerwacja
 VALUES (243,34,346)
INSERT INTO Rezerwacja
 VALUES (156,38,302)
INSERT INTO Rezerwacja
 VALUES (248,71,363)
INSERT INTO Rezerwacja
 VALUES (182,63,166)
INSERT INTO Rezerwacja
 VALUES (42,95,172)
INSERT INTO Rezerwacja
 VALUES (86,53,365)
INSERT INTO Rezerwacja
 VALUES (210,90,317)
INSERT INTO Rezerwacja
 VALUES (197,73,8)
INSERT INTO Rezerwacja
 VALUES (246,46,146)
INSERT INTO Rezerwacja
 VALUES (217,81,168)
INSERT INTO Rezerwacja
 VALUES (269,20,135)
INSERT INTO Rezerwacja
 VALUES (29,5,358)
INSERT INTO Rezerwacja
 VALUES (143,14,344)
INSERT INTO Rezerwacja
 VALUES (307,3,33)
INSERT INTO Rezerwacja
 VALUES (24,59,190)
INSERT INTO Rezerwacja
 VALUES (220,41,38)
INSERT INTO Rezerwacja
 VALUES (51,76,296)
INSERT INTO Rezerwacja
 VALUES (101,69,16)
INSERT INTO Rezerwacja
 VALUES (261,65,114)
INSERT INTO Rezerwacja
 VALUES (141,19,420)
INSERT INTO Rezerwacja
 VALUES (7,18,103)
INSERT INTO Rezerwacja
 VALUES (19,23,431)
INSERT INTO Rezerwacja
 VALUES (249,57,81)
INSERT INTO Rezerwacja
 VALUES (283,72,180)
INSERT INTO Rezerwacja
 VALUES (29,24,153)
INSERT INTO Rezerwacja
 VALUES (128,52,234)
INSERT INTO Rezerwacja
 VALUES (27,89,89)
INSERT INTO Rezerwacja
 VALUES (71,60,288)
INSERT INTO Rezerwacja
 VALUES (56,83,249)
INSERT INTO Rezerwacja
 VALUES (276,27,294)
INSERT INTO Rezerwacja
 VALUES (116,32,315)
INSERT INTO Rezerwacja
 VALUES (7,91,10)
INSERT INTO Rezerwacja
 VALUES (136,17,229)
INSERT INTO Rezerwacja
 VALUES (265,56,202)
INSERT INTO Rezerwacja
 VALUES (234,88,24)
INSERT INTO Rezerwacja
 VALUES (201,78,171)
INSERT INTO Rezerwacja
 VALUES (237,87,189)
INSERT INTO Rezerwacja
 VALUES (196,22,101)
INSERT INTO Rezerwacja
 VALUES (225,80,287)
INSERT INTO Rezerwacja
 VALUES (212,61,280)
INSERT INTO Rezerwacja
 VALUES (212,16,22)
INSERT INTO Rezerwacja
 VALUES (180,21,429)
INSERT INTO Rezerwacja
 VALUES (267,48,324)
INSERT INTO Rezerwacja
 VALUES (211,96,402)
INSERT INTO Rezerwacja
 VALUES (64,93,61)
INSERT INTO Rezerwacja
 VALUES (176,13,112)
INSERT INTO Rezerwacja
 VALUES (150,42,345)
INSERT INTO Rezerwacja
 VALUES (234,49,207)
INSERT INTO Rezerwacja
 VALUES (130,70,217)
INSERT INTO Rezerwacja
 VALUES (253,97,63)
INSERT INTO Rezerwacja
 VALUES (44,66,178)
INSERT INTO Rezerwacja
 VALUES (261,7,341)
INSERT INTO Rezerwacja
 VALUES (64,6,355)
INSERT INTO Rezerwacja
 VALUES (12,11,76)
INSERT INTO Rezerwacja
 VALUES (167,4,213)
INSERT INTO Rezerwacja
 VALUES (221,44,19)
INSERT INTO Rezerwacja
 VALUES (190,26,75)
INSERT INTO Rezerwacja
 VALUES (132,86,301)
INSERT INTO Rezerwacja
 VALUES (84,45,162)
INSERT INTO Rezerwacja
 VALUES (241,100,131)
INSERT INTO Rezerwacja
 VALUES (13,47,140)
INSERT INTO Rezerwacja
 VALUES (29,40,91)
INSERT INTO Rezerwacja
 VALUES (10,94,197)
INSERT INTO Rezerwacja
 VALUES (146,51,265)
INSERT INTO Rezerwacja
 VALUES (308,10,181)
INSERT INTO Rezerwacja
 VALUES (100,98,169)
INSERT INTO Rezerwacja
 VALUES (41,82,383)
INSERT INTO Rezerwacja
 VALUES (253,50,32)
INSERT INTO Rezerwacja
 VALUES (100,12,297)
INSERT INTO Rezerwacja
 VALUES (236,31,258)
INSERT INTO Rezerwacja
 VALUES (194,33,291)
INSERT INTO Rezerwacja
 VALUES (247,30,34)
INSERT INTO Rezerwacja
 VALUES (27,2,43)
INSERT INTO Rezerwacja
 VALUES (305,1,11)
INSERT INTO Rezerwacja
 VALUES (63,77,337)
INSERT INTO Rezerwacja
 VALUES (33,67,278)
INSERT INTO Rezerwacja
 VALUES (179,8,293)
INSERT INTO Rezerwacja
 VALUES (163,29,415)
INSERT INTO Rezerwacja
 VALUES (150,35,17)
INSERT INTO Rezerwacja
 VALUES (167,79,156)
INSERT INTO Rezerwacja
 VALUES (67,36,203)
INSERT INTO Rezerwacja
 VALUES (51,85,111)
INSERT INTO Rezerwacja
 VALUES (86,84,411)
INSERT INTO Rezerwacja
 VALUES (272,37,255)
INSERT INTO Rezerwacja
 VALUES (120,75,347)
INSERT INTO Rezerwacja
 VALUES (96,74,92)
INSERT INTO Rezerwacja
 VALUES (10,39,115)
INSERT INTO Rezerwacja
 VALUES (170,62,305)
INSERT INTO Rezerwacja
 VALUES (55,68,94)
INSERT INTO Rezerwacja
 VALUES (90,55,99)
INSERT INTO Rezerwacja
 VALUES (191,28,160)
INSERT INTO Rezerwacja
 VALUES (106,9,386)
INSERT INTO Rezerwacja
 VALUES (180,15,385)
INSERT INTO Rezerwacja
 VALUES (131,43,70)
INSERT INTO Rezerwacja
 VALUES (277,92,356)
INSERT INTO Rezerwacja
 VALUES (294,25,73)
INSERT INTO Rezerwacja
 VALUES (248,54,387)
INSERT INTO Rezerwacja
 VALUES (24,58,260)
INSERT INTO Rezerwacja
 VALUES (81,99,51)
INSERT INTO Rezerwacja
 VALUES (288,64,367)
INSERT INTO Rezerwacja
 VALUES (270,34,393)
INSERT INTO Rezerwacja
 VALUES (277,38,318)
INSERT INTO Rezerwacja
 VALUES (207,71,55)
INSERT INTO Rezerwacja
 VALUES (178,63,2)
INSERT INTO Rezerwacja
 VALUES (19,95,277)
INSERT INTO Rezerwacja
 VALUES (152,53,40)
INSERT INTO Rezerwacja
 VALUES (137,90,405)
INSERT INTO Rezerwacja
 VALUES (270,73,235)
INSERT INTO Rezerwacja
 VALUES (233,46,349)
INSERT INTO Rezerwacja
 VALUES (65,81,418)
INSERT INTO Rezerwacja
 VALUES (50,20,322)
INSERT INTO Rezerwacja
 VALUES (188,5,29)
INSERT INTO Rezerwacja
 VALUES (73,14,335)
INSERT INTO Rezerwacja
 VALUES (233,3,14)
INSERT INTO Rezerwacja
 VALUES (282,59,155)
INSERT INTO Rezerwacja
 VALUES (280,41,37)
INSERT INTO Rezerwacja
 VALUES (175,76,68)
INSERT INTO Rezerwacja
 VALUES (60,69,117)
INSERT INTO Rezerwacja
 VALUES (180,65,87)
INSERT INTO Rezerwacja
 VALUES (281,19,395)
INSERT INTO Rezerwacja
 VALUES (87,18,410)
INSERT INTO Rezerwacja
 VALUES (233,23,158)
INSERT INTO Rezerwacja
 VALUES (14,57,152)
INSERT INTO Rezerwacja
 VALUES (203,72,124)
INSERT INTO Rezerwacja
 VALUES (121,24,286)
INSERT INTO Rezerwacja
 VALUES (121,52,82)
INSERT INTO Rezerwacja
 VALUES (229,89,279)
INSERT INTO Rezerwacja
 VALUES (259,60,368)
INSERT INTO Rezerwacja
 VALUES (46,83,336)
INSERT INTO Rezerwacja
 VALUES (80,27,397)
INSERT INTO Rezerwacja
 VALUES (121,32,138)
INSERT INTO Rezerwacja
 VALUES (241,91,268)
INSERT INTO Rezerwacja
 VALUES (148,17,215)
INSERT INTO Rezerwacja
 VALUES (8,56,102)
INSERT INTO Rezerwacja
 VALUES (141,88,9)
INSERT INTO Rezerwacja
 VALUES (266,78,205)
INSERT INTO Rezerwacja
 VALUES (301,87,242)
INSERT INTO Rezerwacja
 VALUES (86,22,325)
INSERT INTO Rezerwacja
 VALUES (94,80,266)
INSERT INTO Rezerwacja
 VALUES (42,61,196)
INSERT INTO Rezerwacja
 VALUES (194,16,272)
INSERT INTO Rezerwacja
 VALUES (86,21,122)
INSERT INTO Rezerwacja
 VALUES (277,48,304)
INSERT INTO Rezerwacja
 VALUES (122,96,129)
INSERT INTO Rezerwacja
 VALUES (207,93,424)
INSERT INTO Rezerwacja
 VALUES (201,13,426)
INSERT INTO Rezerwacja
 VALUES (208,42,42)
INSERT INTO Rezerwacja
 VALUES (309,49,247)
INSERT INTO Rezerwacja
 VALUES (293,70,352)
INSERT INTO Rezerwacja
 VALUES (308,97,27)
INSERT INTO Rezerwacja
 VALUES (242,66,248)
INSERT INTO Rezerwacja
 VALUES (105,7,364)
INSERT INTO Rezerwacja
 VALUES (305,6,400)
INSERT INTO Rezerwacja
 VALUES (37,11,206)
INSERT INTO Rezerwacja
 VALUES (8,4,144)
INSERT INTO Rezerwacja
 VALUES (105,44,289)
INSERT INTO Rezerwacja
 VALUES (92,26,257)
INSERT INTO Rezerwacja
 VALUES (115,86,369)
INSERT INTO Rezerwacja
 VALUES (188,45,212)
INSERT INTO Rezerwacja
 VALUES (236,100,64)
INSERT INTO Rezerwacja
 VALUES (134,47,232)
INSERT INTO Rezerwacja
 VALUES (209,40,379)
INSERT INTO Rezerwacja
 VALUES (203,94,373)
INSERT INTO Rezerwacja
 VALUES (275,51,308)
INSERT INTO Rezerwacja
 VALUES (57,10,137)
INSERT INTO Rezerwacja
 VALUES (119,98,350)
INSERT INTO Rezerwacja
 VALUES (237,82,320)
INSERT INTO Rezerwacja
 VALUES (200,50,252)
INSERT INTO Rezerwacja
 VALUES (140,12,362)
INSERT INTO Rezerwacja
 VALUES (50,31,204)
INSERT INTO Rezerwacja
 VALUES (151,33,310)
INSERT INTO Rezerwacja
 VALUES (74,30,39)
INSERT INTO Rezerwacja
 VALUES (277,2,321)
INSERT INTO Rezerwacja
 VALUES (104,1,251)
INSERT INTO Rezerwacja
 VALUES (167,77,226)
INSERT INTO Rezerwacja
 VALUES (243,67,312)
INSERT INTO Rezerwacja
 VALUES (277,8,375)
INSERT INTO Rezerwacja
 VALUES (225,29,238)
INSERT INTO Rezerwacja
 VALUES (11,35,193)
INSERT INTO Rezerwacja
 VALUES (145,79,348)
INSERT INTO Rezerwacja
 VALUES (180,36,225)
INSERT INTO Rezerwacja
 VALUES (184,85,174)
INSERT INTO Rezerwacja
 VALUES (300,84,292)
INSERT INTO Rezerwacja
 VALUES (206,37,78)
INSERT INTO Rezerwacja
 VALUES (71,75,328)
INSERT INTO Rezerwacja
 VALUES (258,74,60)
INSERT INTO Rezerwacja
 VALUES (164,39,237)
INSERT INTO Rezerwacja
 VALUES (87,62,388)
INSERT INTO Rezerwacja
 VALUES (153,68,31)
INSERT INTO Rezerwacja
 VALUES (263,55,370)
INSERT INTO Rezerwacja
 VALUES (224,28,380)
INSERT INTO Rezerwacja
 VALUES (122,9,333)
INSERT INTO Rezerwacja
 VALUES (8,15,253)
INSERT INTO Rezerwacja
 VALUES (162,43,20)
INSERT INTO Rezerwacja
 VALUES (277,92,188)
INSERT INTO Rezerwacja
 VALUES (270,25,45)
INSERT INTO Rezerwacja
 VALUES (278,54,71)
INSERT INTO Rezerwacja
 VALUES (63,58,329)
INSERT INTO Rezerwacja
 VALUES (173,99,96)
INSERT INTO Rezerwacja
 VALUES (216,64,25)
INSERT INTO Rezerwacja
 VALUES (138,34,79)
INSERT INTO Rezerwacja
 VALUES (236,38,285)
INSERT INTO Rezerwacja
 VALUES (213,71,141)
INSERT INTO Rezerwacja
 VALUES (234,63,145)
INSERT INTO Rezerwacja
 VALUES (97,95,330)
INSERT INTO Rezerwacja
 VALUES (280,53,165)
INSERT INTO Rezerwacja
 VALUES (309,90,412)
INSERT INTO Rezerwacja
 VALUES (271,73,432)
INSERT INTO Rezerwacja
 VALUES (116,46,233)
INSERT INTO Rezerwacja
 VALUES (214,81,269)
INSERT INTO Rezerwacja
 VALUES (192,20,263)
INSERT INTO Rezerwacja
 VALUES (125,5,353)
INSERT INTO Rezerwacja
 VALUES (292,14,371)
INSERT INTO Rezerwacja
 VALUES (286,3,374)
INSERT INTO Rezerwacja
 VALUES (204,59,311)
INSERT INTO Rezerwacja
 VALUES (37,41,164)
INSERT INTO Rezerwacja
 VALUES (74,76,306)
INSERT INTO Rezerwacja
 VALUES (166,69,243)
INSERT INTO Rezerwacja
 VALUES (253,65,18)
INSERT INTO Rezerwacja
 VALUES (192,19,53)
INSERT INTO Rezerwacja
 VALUES (3,18,80)
INSERT INTO Rezerwacja
 VALUES (259,23,267)
INSERT INTO Rezerwacja
 VALUES (70,57,15)
INSERT INTO Rezerwacja
 VALUES (189,72,148)
INSERT INTO Rezerwacja
 VALUES (47,24,183)
INSERT INTO Rezerwacja
 VALUES (120,52,98)
INSERT INTO Rezerwacja
 VALUES (308,89,95)
INSERT INTO Rezerwacja
 VALUES (39,60,200)
INSERT INTO Rezerwacja
 VALUES (99,83,334)
INSERT INTO Rezerwacja
 VALUES (164,27,62)
INSERT INTO Rezerwacja
 VALUES (242,32,295)
INSERT INTO Rezerwacja
 VALUES (165,91,157)
INSERT INTO Rezerwacja
 VALUES (11,17,1)
INSERT INTO Rezerwacja
 VALUES (267,56,150)
INSERT INTO Rezerwacja
 VALUES (185,88,406)
INSERT INTO Rezerwacja
 VALUES (177,78,419)
INSERT INTO Rezerwacja
 VALUES (287,87,88)
INSERT INTO Rezerwacja
 VALUES (73,22,270)
INSERT INTO Rezerwacja
 VALUES (175,80,227)
INSERT INTO Rezerwacja
 VALUES (224,61,332)
INSERT INTO Rezerwacja
 VALUES (226,16,139)
INSERT INTO Rezerwacja
 VALUES (48,21,300)

