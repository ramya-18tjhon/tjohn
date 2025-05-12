USE BDEMPLOYEE;
--1. Which shippers do we have?

SELECT * 
FROM [dbo].[Shippers]


--2. Certain fields from Categories
SELECT CATEGORYNAME, DESCRIPTION
FROM
[dbo].[Categories]
   
--3. Sales Representatives
SELECT * FROM [dbo].[Employees] WHERE TITLE='SALES REPRESENTATIVE'

--4. Sales Representatives in the United States
SELECT FIRSTNAME,LASTNAME,HIREDATE FROM [dbo].[Employees] WHERE TITLE='SALES REPRESENTATIVE' AND COUNTRY='USA'

--5. Orders placed by specific EmployeeID
SELECT ORDERID,ORDERDATE FROM [dbo].[Orders] WHERE EMPLOYEEID=5
 

--6. Suppliers and ContactTitle
SELECT SUPPLIERID,CONTACTNAME,CONTACTTITLE FROM [dbo].[Suppliers]  WHERE CONTACTTITLE!='MARKETING MANAGER'

--7. Products with “queso” in ProductName
SELECT PRODUCTID , PRODUCTNAME FROM [dbo].[Products] WHERE PRODUCTNAME LIKE 'QUESO %%%'

--8. Orders shipping to France or Belgium
 SELECT CUSTOMERID,ORDERID,SHIPCOUNTRY FROM [dbo].[Orders] WHERE SHIPCOUNTRY= 'FRANCE' OR SHIPCOUNTRY='BELGIUM'

 --9. Orders shipping to any country in Latin America
  SELECT CUSTOMERID,ORDERID,SHIPCOUNTRY FROM [dbo].[Orders] WHERE SHIPCOUNTRY IN ('BRAZIL','MEXICO','ARGENTINA','VENEZUELA')


 --10. Employees, in order of age
 SELECT FIRSTNAME,LASTNAME,BIRTHDATE FROM [dbo].[Employees] ORDER BY BIRTHDATE ASC;

 --11. Showing only the Date with a DateTime field
 SELECT FIRSTNAME,LASTNAME,TITLE,CAST(BIRTHDATE AS DATE)AS NEWDATE FROM [dbo].[Employees]  

 --12. Employees full name
 SELECT FIRSTNAME,LASTNAME, FIRSTNAME +' '+ LASTNAME  AS FULLNAME  FROM [dbo].[Employees] 
 SELECT * FROM [dbo].[Employees]
 

 --13. OrderDetails amount per line item
SELECT ORDERID,PRODUCTID,UNITPRICE,QUANTITY,(UNITPRICE*QUANTITY) AS TOTALPRICE
FROM  [dbo].[OrderDetails] ORDER BY ORDERID,PRODUCTID;

---14. How many customers?
 SELECT COUNT(*) AS TOTALCUSTOMER FROM [dbo].[Customers]


 --15. When was the first order?
 SELECT * FROM [dbo].[Orders]
 SELECT MIN(ORDERDATE) AS FIRSTDATEOFORDER FROM [dbo].[Orders]

 
--16. Countries where there are customers
SELECT  DISTINCT COUNTRY FROM [dbo].[Customers]  GROUP BY COUNTRY;
SELECT * FROM  [dbo].[Customers]


--17. Contact titles for customers
 SELECT CONTACTTITLE, COUNT(*) AS TOTALCOUNT FROM  [dbo].[Customers] GROUP BY CONTACTTITLE ORDER BY TOTALCOUNT DESC;
 

 --21. Total customers per country/city
 SELECT CITY,COUNTRY,COUNT(*) AS TOTAL_CUSTOMERS FROM [dbo].[Customers]  GROUP BY CITY,COUNTRY ORDER BY TOTAL_CUSTOMERS DESC;

 
--22. Products that need reordering
SELECT * FROM [dbo].[Products]
SELECT PRODUCTID,PRODUCTNAME,UNITSINSTOCK,REORDERLEVEL FROM [dbo].[Products] WHERE UnitsInStock < ReorderLevel



--23. Products that need reordering, continued
SELECT PRODUCTID,PRODUCTNAME,UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued 
FROM [dbo].[Products]  WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel AND DISCONTINUED=0 ORDER BY PRODUCTID


--25. High freight charges
 SELECT * FROM [dbo].[Orders]
 SELECT TOP 3 SHIPCOUNTRY,AVG(FREIGHT) AS AVERAGEFREIGHT FROM [dbo].[Orders] GROUP BY SHIPCOUNTRY ORDER BY  AVERAGEFREIGHT DESC

 
--18. products with associated supplier names
select * from suppliers
select [dbo].[Products].PRODUCTID,[dbo].[Products].PRODUCTNAME,[dbo].[Suppliers].COMPANYNAME AS SUPPLIER FROM [dbo].[Products]
INNER JOIN [dbo].[Suppliers] ON [dbo].[Products].PRODUCTID= [dbo].[Suppliers].SUPPLIERID;

--19. Orders and the Shipper that was used
SELECT O.ORDERID,CAST(O.ORDERDATE AS DATE) AS ORDERDATE,S.COMPANYNAME AS SHIPPER
FROM [dbo].[Orders] AS O 
INNER JOIN  [dbo].[Shippers] AS S
ON O.SHIPVIA=S.SHIPPERID
WHERE O.ORDERID<10300
ORDER BY ORDERID ASC;


--20. Categories, and the total products in each category

SELECT * FROM [dbo].[Categories] 
SELECT C.CATEGORYNAME ,COUNT(*)  AS TOTALPRODUCT FROM Categories AS C
INNER JOIN [dbo].[Products] AS P  ON C.CATEGORYID = P.CATEGORYID 
GROUP BY C. CATEGORYNAME
ORDER BY TOTALPRODUCT DESC;


--