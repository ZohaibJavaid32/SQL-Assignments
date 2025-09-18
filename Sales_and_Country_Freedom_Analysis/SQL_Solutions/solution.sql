CREATE DATABASE Task34;

use task34;

CREATE TABLE country_ab (
    Country VARCHAR(100),
    Edition YEAR,
    Region VARCHAR(100),
    A INT,
    B INT
);

CREATE TABLE country_cd (
    Country VARCHAR(100),
    Edition YEAR,
    Region VARCHAR(100),
    A INT,
    B INT
);


CREATE TABLE country_cl (
    Country VARCHAR(100),
    Edition YEAR,
    CL INT,
    Status VARCHAR(10)
);

CREATE TABLE country_efg (
    Country VARCHAR(100),
    Edition YEAR,
    Region VARCHAR(100),
    E INT,
    F INT,
    G INT
);

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(25) NOT NULL,
    MiddleInitial VARCHAR(25),
    LastName VARCHAR(25) NOT NULL
);

CREATE TABLE Employees(
	EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(25) NOT NULL,
    MiddleInitial VARCHAR(5) NOT NULL,
    LastName VARCHAR(25) NOT NULL
);

CREATE TABLE Products(
	ProductID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Price FLOAT NOT NULL
);

CREATE TABLE Sales1(
	SalesID INT PRIMARY KEY,
    SalesPersonID INT NOT NULL,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT
);



show tables;



-- Question No : 1
-- Find out top 10 countries' which have maximum A and D values.
SELECT t1.country,
       t1.edition,
       t1.A,
       t2.D
FROM country_ab t1
INNER JOIN country_cd t2
ON t1.country = t2.country
	AND t1.edition = t2.edition
ORDER BY t1.A DESC , t2.D DESC
LIMIT 10;

-- Question No : 2
-- Find out highest CL value for 2020 for every region. Also sort the result in descending order. 
-- Also display the CL values in descending order

SELECT t2.region , MAX(t1.cl) as max_cl_value FROM country_cl t1
INNER JOIN country_ab t2
	ON t1.country = t2.country
	AND t1.edition = t2.edition 
WHERE t1.edition = 2020
GROUP BY t2.region
ORDER BY MAX(t1.CL) DESC;


-- Question No : 3
-- Find top-5 most sold products.
SELECT t2.name , t1.ProductID , SUM(t1.Quantity) as Qty_Sold  FROM Sales1 t1
INNER JOIN Products t2
	ON t1.ProductID = t2.ProductID
GROUP BY t1.ProductID
ORDER BY Qty_Sold DESC
LIMIT 5;


-- Question No : 4
-- Find sales man who sold most no of products.

SELECT CONCAT(t2.FirstName , ' ' , t2.LastName) AS sales_man,
       t1.SalesPersonID,
       SUM(Quantity) as products_sold
FROM sales1 t1
INNER JOIN Employees t2
	ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID
LIMIT 1;


-- Question No : 5
-- Sales man name who has most no of unique customer.

SELECT CONCAT(t2.FirstName , ' ' , t2.LastName) AS sales_man,
       COUNT(DISTINCT(t1.CustomerID)) as no_of_unique_customers
FROM sales1 t1
INNER JOIN Employees t2
	ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID
LIMIT 1;

-- Question No : 6
-- Sales man who has generated most revenue. Show top 5.

SELECT s.SalesPersonID,
	   CONCAT(e.firstName , ' ' , e.lastName) as SalesMan,
       ROUND(SUM(s.Quantity * p.Price),2) as TotalRevenue
FROM Sales1 s
JOIN Employees e
ON s.SalesPersonID = e.EmployeeID
JOIN products p
ON s.ProductID = p.ProductID
GROUP BY e.EmployeeID
ORDER BY totalRevenue DESC
LIMIT 5;


-- Question No : 7
-- List all customers who have made more than 10 purchases.

SELECT c.CustomerID, 
       CONCAT(c.FirstName , ' ' , c.LastName) as CustomerName,
       COUNT(s.SalesID) as Purchases
FROM customers c
JOIN sales1 s
ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID
HAVING Purchases > 10
ORDER BY Purchases DESC , c.customerID ASC;



-- Question No : 8
-- List all salespeople who have made sales to more than 5 customers.

SELECT s.SalesPersonID,
	   CONCAT(e.FirstName , ' ' , e.LastName) as SalesPerson,
       COUNT(DISTINCT(s.CustomerID)) as NoOfCustomers
FROM sales1 s 
JOIN employees e 
	ON s.SalesPersonID = e.EmployeeID
GROUP BY s.SalesPersonID
HAVING NoOfCustomers > 5;









