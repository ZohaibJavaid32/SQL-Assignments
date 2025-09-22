use classicmodels;

show tables;

-- Question No : 1 
-- Update the phone number of a customer whose customerNumber is 103.

UPDATE customers
SET phone = '41.34.56222'
WHERE customerNumber = 103;

-- Question No: 2
-- Remove a product with a specific productCode.


ALTER TABLE orderdetails
DROP FOREIGN KEY orderdetails_ibfk_2;

ALTER TABLE orderdetails
ADD CONSTRAINT orderdetails_ibfk_2
	FOREIGN KEY (productCode) REFERENCES products(productCode)
    ON DELETE CASCADE;
    
DELETE FROM products
WHERE productCode = 'S10_2016';

-- Question No : 3 
-- Create a review table.
-- NOTE : In MySQL AUTO column must be a primary or a part of a composite primary key.

CREATE TABLE review(
	review_id INT AUTO_INCREMENT PRIMARY KEY, 
    customerNumber INT NOT NULL, 
    productCode VARCHAR(20) NOT NULL, 
    reviewText VARCHAR(120) , 
    rating VARCHAR(20)
);

-- Question No : 4
-- Add a new column email to the employees table

ALTER TABLE employees
ADD COLUMN email VARCHAR(30);

-- Question No : 5
-- Drop the reviews table you created.
DROP TABLE review;

-- Question No : 6
-- Employees with salary > 50000

SELECT * FROM employees
WHERE salary > 50000;

-- Question No : 7
-- Retrieve customers in USA or Canada with credit limit greater than 100,000

SELECT * FROM customers
WHERE country IN ('USA','Canada')
AND creditLimit > 100000;

-- Question No : 8
-- Find products with a buyPrice between 50 and 100.

SELECT * FROM products
WHERE buyPrice BETWEEN 50 AND 100;

-- Question No : 9
-- Get the names of customers located in cities: ‘Paris’, ‘Madrid’, or ‘Berlin’.

SELECT customerName FROM customers
WHERE city IN ('Paris', 'Madrid' , 'Berlin');

-- Question No : 10
-- List all customers whose names start with ‘T’.
SELECT customerName FROM customers
WHERE customerName LIKE 'T%';

-- Question No : 11
-- Find all orders where the shippedDate is null.

SELECT * FROM orders
WHERE shippedDate IS NULL;

-- Question No: 12
-- Show the buyPrice as Price, and productName as Product.

SELECT buyPrice as Price , productName as Product
FROM products;

-- Question No : 13
-- Use aliases c for customers and o for orders to join both tables and display customer names with their order dates.

SELECT c.customerName,
	   o.orderDate
FROM customers c 
JOIN orders o 
	ON c.customerNumber = o.customerNumber