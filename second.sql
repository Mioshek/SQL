--1A
SELECT DISTINCT CustomerID
FROM Orders O
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
WHERE ProductID IN (
SELECT DISTINCT ProductID
FROM Orders O1
JOIN [Order Details] OD1
ON O1.OrderID = OD1.OrderID
WHERE CustomerID = 'FRANR')
--1B
SELECT O.OrderID FROM Orders as O
WHERE DATEDIFF(Day, OrderDate, RequiredDate) =(
SELECT MAX(DATEDIFF(Day, OrderDate, RequiredDate))
FROM Orders)
--1C
SELECT Orderid, OrderDate AS Data, 
    (SELECT TOP 1 OrderDate 
    FROM Orders 
    WHERE OrderID>o.OrderID AND CustomerID=o.CustomerID 
    ORDER BY OrderDate) Nastepny,
    datediff(day,OrderDate,
    (SELECT TOP 1 OrderDate 
    FROM Orders
    WHERE OrderID>o.OrderID AND CustomerID=o.CustomerID 
    ORDER BY OrderDate)) roznica
FROM
customers c join orders o 
on c.customerid = o.customerid 
where datediff(day,OrderDate,
    (SELECT TOP 1 OrderDate 
    FROM Orders 
    WHERE OrderID>o.OrderID AND CustomerID=o.CustomerID 
    ORDER BY OrderDate))>61
ORDER BY o.CustomerId, OrderDate
--1D
SELECT Count(OrderID), EmployeeID
FROM Orders
GROUP BY EmployeeID
HAVING COUNT(OrderID) > (
SELECT COUNT(OrderID)
FROM Orders O JOIN Employees E
ON O.EmployeeID = E.EmployeeID
WHERE O.ShipCountry = E.Country)
--1E
SELECT LastName, FirstName, lower(SUBSTRING(FirstName, 1,1)+SUBSTRING(LastName,1,8)+'@wsiz.pl') AS Email
FROM Employees
--1F
--dzien miesiaca
select day(OrderDate), count(orderid)
from Orders
group by day(OrderDate)
order by 2 desc
--dzien tygodnia
select  Datename(dw,OrderDate), count(orderid)
from Orders
group by Datename(dw,OrderDate)
order by 2 desc
--data
select top 1 with ties OrderDate, count(orderid)
from Orders
group by OrderDate
order by 2 desc
select dzien, ilosc
from (select distinct day(orderdate) dzien,
        (select count(orderid) 
        from orders o1
        where day(o1.orderdate)=day(o2.OrderDate)) ilosc
from Orders o2) wynik
where wynik.ilosc = (select max(ta.ilosc) 
            FROM (select (select count(orderid) 
            from orders o1 
            where day(o1.OrderDate)=day(o2.OrderDate)) ilosc
        from Orders o2) ta)
--1G
WITH DL AS (
select Max(Len(LastName)) AS maksimum
from Employees)
Select *
from Employees
where LEN(LastName) = (select * from DL)
--1H
SELECT COUNT(*),CompanyName  
FROM orders inner join customers
ON orders.CustomerID=customers.CustomerID
--where companyname='Save-a-lot Markets'
GROUP BY CompanyName
ORDER BY 1 DESC
SELECT companyname, Address
FROM Customers k
WHERE  (SELECT COUNT(*) 
        FROM orders o 
        WHERE k.CustomerID=o.CustomerID) >= ALL 
        (SELECT COUNT(*) 
        FROM orders 
        GROUP BY CustomerID)
--1I
SELECT LastName
FROM Employees
WHERE LEN(LastName) = (
SELECT MAX(LEN(LastName))
FROM Employees)
--2A
SELECT orderid, orderdate, custid, empid, DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
FROM Sales.Orders
WHERE orderdate != DATEFROMPARTS(YEAR(orderdate), 12, 31);
--2B
SELECT empid, MAX(orderdate)
FROM Sales.Orders
GROUP BY empid
--2C
SELECT empid, MAX(orderdate), MAX(orderid)
FROM Sales.Orders
GROUP BY empid
ORDER BY empid desc
--2D
SELECT orderid, orderdate, custid, empid, ROW_NUMBER() OVER (ORDER BY [orderid]) as rownum
FROM Sales.Orders
--2E
SELECT orderid, orderdate, custid, empid, a.rownum
FROM (SELECT orderid, orderdate, custid, empid, ROW_NUMBER() OVER (ORDER BY [orderid]) as rownum
FROM Sales.Orders) as a
WHERE  a.rownum > 10 and a.rownum < 21
--2G
CREATE VIEW Sales.VEmpOrders AS
SELECT empid, YEAR(orderdate) as orderyear, SUM(qty) as qty
FROM Sales.Orders O
JOIN Sales.OrderDetails OD
ON O.orderid = OD.orderid
GROUP BY YEAR(orderdate), empid

wyswietlanie Sales.VEmpOrders
select *
from Sales.VEmpOrders
--2H ?
select *, CASE WHEN empid = LEAD(empid,1) OVER (PARTITION BY empid ORDER BY empid) THEN qty + LEAD(qty,0) OVER (PARTITION BY empid ORDER BY empid) ELSE qty END as sumqty
from Sales.VEmpOrders 
--2I
CREATE FUNCTION Production.TopProducts (
    @supid INT,
	@n INT
)
RETURNS TABLE
AS
RETURN
    SELECT TOP (@n)
		productid,
		productname,
		unitprice
    FROM
        Production.Products
    WHERE
        supplierid = @supid
	ORDER BY unitprice DESC;
--2J
SELECT P.supplierid, S.companyname, x.productid, x.productname, x.unitprice
FROM Production.Products P
JOIN Production.Suppliers S
ON S.supplierid = P.supplierid
CROSS APPLY Production.TopProducts(P.supplierid, 2) AS	x;
--3A
; with CTE as  
(  
 select 1 Number  
 union all  
 select Number +1 from CTE where Number<10  
)  
  
select *from CTE  
--3B
SELECT custid, empid, orderdate
FROM Sales.Orders O
WHERE O.orderdate not like '%2016-02%' and O.orderdate like '%2016-01%' and custid not in(
SELECT custid
FROM Sales.Orders S
WHERE O.ORDERDATE like '%2016-02%')
ORDER BY custid
--3C
select *
from (SELECT custid, empid
FROM Sales.Orders O
WHERE O.orderdate like '%2016-01%' ) tab1
inner join (SELECT custid, empid
FROM Sales.Orders O
WHERE O.orderdate like '%2016-02%') tab2
on tab1.custid=tab2.custid
where tab1.custid = tab2.custid and tab1.empid = tab2.empid
--3D
select custid, empid
from Sales.Orders
WHERE not exists (SELECT custid, empid
FROM Sales.Orders O
WHERE O.orderdate like '%2015%' ) 
--3e
SELECT country, region, city
FROM 
(
	SELECT country, region, city,  1 sortby FROM HR.Employees
	UNION ALL 
	SELECT country, region, city, 2 sortby FROM Production.Suppliers
) dum
ORDER BY sortby, country, region, city

