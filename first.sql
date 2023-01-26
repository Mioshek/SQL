--1a
select CompanyName
from (select * 
from Customers
where City = 'London') as AA
where CompanyName < 'D'
--1b
select OD.OrderID, avg(OD.UnitPrice * OD.Quantity)
from [Order Details] as OD inner join Orders as O
on OD.OrderID = O.OrderID inner join Customers as C
on O.CustomerID = C.CustomerID
where MONTH(O.OrderDate) = 6 -- and year(O.OrderDate) = 1996
group by OD.OrderID
having avg(OD.UnitPrice * OD.Quantity) >
    (select avg(OD1.UnitPrice * OD1.Quantity) as AAA
    from [Order Details]as OD1);
--1c
SELECT ProductName, CategoryName, UnitPrice 
FROM Categories c join Products p on c.CategoryID = p.CategoryID
WHERE UnitPrice IN (SELECT MIN(unitprice) as 'cena_minimalna' 
FROM Categories c join Products p on c.CategoryID = p.CategoryID
Group by CategoryName)
Order by Unitprice
--1d
SELECT SUM(C.[Liczba Pracownikow]) AS [Tylu pracownikow]
FROM (SELECT City , COUNT(EmployeeID) as 'Liczba Pracownikow'
FROM Employees 
GROUP BY City 
HAVING COUNT(EmployeeID) > 1)
AS C
--1e
SELECT ProductName
FROM Products
WHERE ProductID NOT IN 
(
SELECT ProductID
FROM [Order Details])
--1f
SELECT C.ContactName, b.Count 
FROM Customers C
INNER JOIN
(SELECT TOP 10 WITH TIES CustomerID, COUNT(distinct OrderID) as Count
FROM Orders
GROUP BY CustomerID
ORDER BY Count DESC) b ON c.CustomerID = b.CustomerID
--1g
Select Suppliers.City,  Customers.City
From Suppliers inner join Customers
on Suppliers.City = Customers.City
Group by Suppliers.City, Customers.City
--2a
SELECT empid, firstname, lastname, n
FROM HR.Employees, Nums
WHERE nums.n <=5
ORDER BY n,empid
--2b
SELECT E.empid, DATEADD(day, N.n-1, CAST('20160612' AS date)) AS DT
FROM hr.Employees E CROSS JOIN Nums N
WHERE N.n <= DATEDIFF(day, '20160612', '20160616') + 1 ORDER BY 1, 2
--2c
SELECT C.custid, C.companyname, O.orderid, O.orderdate 
FROM Sales.Customers AS C INNER JOIN Sales.Orders AS O 
ON C.custid = O.custid
--2d
--2e
SELECT C.custid, C.companyname, O.orderid, O.orderdate 
FROM Sales.Customers AS C 
LEFT OUTER JOIN Sales.Orders AS O 
ON C.custid = O.custid
--2f
SELECT C.custid, C.companyname, O.orderid, O.orderdate 
FROM Sales.Customers AS C 
LEFT OUTER JOIN Sales.Orders AS O 
ON C.custid = O.custid
WHERE O.orderid IS NULL
--2g
select C.custid, C.companyname, O.orderid, O.orderdate
from Sales.Customers C inner join Sales.Orders as O
on C.custid = O.custid
where O.orderdate = '20160212'
--2h
SELECT C.custid , C.companyname , O.orderid, O.orderdate
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O
ON O.custid = C.custid
WHERE O.orderdate = '20160212' OR O.orderid IS NULL
UNION
SELECT C.custid, min(C.companyname), NULL, NULL
FROM Sales.Customers as C
JOIN Sales.Orders AS O
ON O.custid = C.custid
WHERE '20160212' != O.orderdate
GROUP BY C.custid, orderdate, orderid
--2i
Wyjaśnij, dlaczego poniższe zapytanie nie jest poprawnym rozwiązaniem dla poprzedniego zadania
SELECT C.custid , C.companyname , O.orderid, O.orderdate
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
ON O.custid = C.custid
WHERE O. orderdate = ’ 20160212 ’ OR O.orderid IS NULL;
Ponieważ, jest sprawdzane czy order id jest NULLem a nie czy data jest równa podanej. Zwracamy więc tylko te, które się zgadzają plus te, które zawierają NULL, zamiast zwracania wszystkich Customers
--2j
SELECT C.custid , C.companyname, 'YES' AS HasOrderOn20160212  
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O
ON O.custid = C.custid
WHERE O.orderdate = '20160212'
UNION
SELECT C.custid, min(C.companyname), 'NO' AS HasOrderOn20160212 
FROM Sales.Customers as C
LEFT JOIN Sales.Orders AS O
ON O.custid = C.custid
WHERE '20160212' != O.orderdate or O.orderid IS NULL
GROUP BY C.custid, orderdate
--3a
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate =
(SELECT MAX(O.orderdate)
FROM Sales.orders as O)
ORDER BY 1
--3b
SELECT orderid, orderdate, custid, empid 
FROM Sales.Orders 
WHERE custid IN 
( select top 1 with ties O.custid 
from Sales.Orders AS O 
group by O.custid 
ORDER BY Count(O.custid)
)
--3c
select E.empid, E.firstname, E.lastname
from HR.Employees as E
join Sales.Orders as O
on E.empid = O.empid
where E.empid NOT IN (
SELECT E.empid
from HR.Employees as E
join Sales.Orders as O
on E.empid = O.empid
where O.orderdate != '20160501' and O.orderdate > '20160501')
group by E.empid, E.firstname, E.lastname
--3d
SELECT distinct C.country 
FROM Sales.Customers C 
WHERE C.country NOT IN (SELECT distinct E.country FROM HR.Employees E)
--3e
--3f
SELECT custid, companyname
FROM Sales.Customers C
WHERE EXISTS  
(
SELECT *
FROM Sales.Orders AS O
WHERE  O.orderdate between '20150101' and '20151231'
AND O.custid = C.custid
)
AND NOT EXISTS
(
SELECT *
FROM Sales.Orders AS O
WHERE  O.orderdate between '20160101' and '20161231'
AND O.custid = C.custid
)
--3g
select C.custid, C.companyname
from Sales.Customers C 
join Sales.Orders as O on O.custid = C.custid 
join Sales.OrderDetails as OD
on OD.orderid = O.orderid
where OD.productid = '12'
order by C.companyname