create database SklepInternetowy;

use SklepInternetowy;
create table Klienci (
KlientID INT Primary Key,
Imie VARCHAR(50) Not Null,
Nazwisko VARCHAR(50) Not Null,
Email NVARCHAR(100) Unique Not Null,
DataUrodzenia DATE,
DataRejestracji DATETIME Default now()
);

create table Produkty (
ProduktID INT Primary Key,
Nazwa NVARCHAR(100) Not Null,
Cena DECIMAL(10, 2) Not Null,
IloscNaStanie INT CHECK (IloscNaStanie >= 0));

create table Zamowienia (
ZamowienieID INT Primary Key,
KlientID INT,
DataZamowienia DATETIME Default now(),
Status_ VARCHAR(20),
constraint chck_Status CHECK (Status_ IN ('Zlozone', 'Wyslane','Dostarczone', 'Anulowane')),
constraint fk_Klient Foreign Key(KlientID) references Klienci(KlientID));

create table SzczegolyZamowienia (
SzczegolyZamowieniaID INT Primary Key,
ZamowienieID INT, 
ProduktID INT,
Ilosc INT,
Cena DECIMAL(10, 2),
constraint chck_Ilosc CHECK (Ilosc > 0),
constraint fk_Zamowienia Foreign Key(ZamowienieID) references Zamowienia(ZamowienieID),
constraint fk_Produkt Foreign Key(ProduktID) references Produkty(ProduktID));

Insert into Klienci (KlientID, Imie, Nazwisko, Email, DataUrodzenia, DataRejestracji) value
(1, 'Anna', 'Kowalska', 'anna.kowalska@mail.com', '1990-01-10', '2024-02-20'),
(2, 'Krzysztof', 'Ott', 'krzysztof.ott@mail.com', '1975-03-23', '2023-12-12'),
(3, 'Piotr', 'Nowak', 'piotr.nowak@mail.com', '1950-12-24', '2023-07-12'),
(4, 'Krystyna', 'Lesniewska', 'krystyna.lesniewska@mail.com', '1980-10-10', '2024-01-01'),
(5, 'Zofia', 'Zdunska', 'zofia.zdunska@mail.com', '1997-09-26', '2024-05-28');

Insert into Produkty (ProduktID, Nazwa, Cena, IloscNaStanie) value
(10, 'Zeszyt', 5.0, 100),
(20, 'Dlugopis_czarny', 2.5, 200),
(30, 'Dlugopis_niebieski', 2.5, 200),
(40, 'Blok_ryskunkowy', 6.0, 300),
(50, 'Blok_techniczny', 6.5, 250),
(60, 'Farby', 15.0, 150),
(70, 'Plastelina', 12.0, 180),
(80, 'Kredki', 20.0, 210);

Insert into Zamowienia (ZamowienieID, KlientID, DataZamowienia, Status_) values 
(11, 5, '2024-08-08', 'Zlozone'),
(12, 5, '2024-07-08', 'Dostarczone'),
(13, 4, '2024-01-20', 'Dostarczone'),
(14, 4, '2024-08-01', 'Anulowane'),
(15, 3, '2024-08-07', 'Wyslane'),
(16, 3, '2024-08-08', 'Zlozone'),
(17, 2, '2024-02-20', 'Dostarczone'),
(18, 2, '2024-02-21', 'Anulowane'),
(19, 1, '2024-03-03', 'Anulowane'),
(20,1, '2024-03-03', 'Dostarczone'),
(21,1, '2024-08-06', 'Wyslane');

Insert into SzczegolyZamowienia (SzczegolyZamowieniaID, ZamowienieID, ProduktID, Ilosc, Cena) value
(22, 11, 10, 10, 5.0),
(33, 12, 20, 20, 2.5),
(44, 13, 30, 30, 2.5),
(55, 14, 40, 35, 6.0),
(66, 15, 50, 50, 250),
(77, 16, 60, 18, 15.0),
(88, 17, 70, 25, 12.0),
(99, 18, 80, 130, 20.0),
(100, 19, 10, 33, 5.0),
(110, 20, 20, 40, 2.5),
(120, 21, 30, 10, 2.5);

-- Task 2.2 
Select ProduktID, Ilosc, Cena,
RANK() OVER (PARTITION BY ProduktID ORDER BY Ilosc DESC) AS rank_numbers,
lag(Ilosc) OVER (order by ProduktID) as previous_ilosc
from szczegolyzamowienia;

-- Task 2.3 Calculate total product sales over months
Select p.nazwa, p.cena * sz.Ilosc as total_sales_price,  month(DataZamowienia) as miesiac_zamowienia
from produkty as p
join szczegolyzamowienia as sz on p.ProduktID=sz.ProduktID
join zamowienia as z on sz.ZamowienieID= z.ZamowienieID
order by month(DataZamowienia) asc;

-- Task 2.4 Store and query JSON data in the database
create table DaneJson (
ID INT primary key auto_increment,
Dane VARCHAR(100));

INSERT INTO DaneJson (Dane)
VALUES
(N'{"Imie": "Jan", "Nazwisko": "Kowalski", "Wiek": 30}'),
(N'{"Imie": "Anna", "Nazwisko": "Nowak", "Wiek": 25}'),
(N'{"Imie": "Piotr", "Nazwisko": "Zielinski", "Wiek": 40}');

SELECT 
    ID,
    JSON_VALUE(Dane, '$.Imie') AS Imie,
    JSON_VALUE(Dane, '$.Nazwisko') AS Nazwisko,
    JSON_VALUE(Dane, '$.Wiek') AS Wiek
FROM 
    DaneJson;


-- Task 3

-- Index Optimization
create INDEX idx_customer_id on klienci (KlientID);

-- Query Optimization
explain select * from klienci
where KlientID = 1;

-- Limiting Data Return
select * from klienci
where DataUrodzenia between '1970-01-01' and '1990-01-01';

-- Join Optimization
select k.KlientID, k.Imie, k.Nazwisko, z.ZamowienieID, z.DataZamowienia, z.Status_
from ( select * from klienci
where DataUrodzenia between '1970-01-01' and '1990-01-01') as k
join zamowienia as z on k.KlientID= z.KlientID;











