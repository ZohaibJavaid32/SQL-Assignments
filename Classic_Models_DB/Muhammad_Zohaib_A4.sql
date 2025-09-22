use classicmodels;

-- Q:1 Show customer names in uppercase.
SELECT UPPER(customerName) FROM customers;

-- Q:2  Display the first 5 characters of each product name.

SELECT SUBSTRING(productName , 1,5) as first_five_chars FROM products;

-- Q:3 Replace all spaces in customer names with underscores.

SELECT REPLACE(customerName , ' ', '_') AS formatted_name FROM customers;

-- Q:4 	Show today’s date

SELECT current_date() as curr_date;

-- Q:5 Find the number of days between order date and shipped date
SELECT * FROM orders;
SELECT DATEDIFF(shippedDate , orderDate) AS days_btw_order_shipped_date FROM orders;

-- Q:6 Find all customers whose names start with ‘A’.

SELECT * FROM customers WHERE customerName LIKE 'A%';

-- Q : 7 Find all products whose names contain a number.

SELECT * FROM products WHERE productName REGEXP '[0-9]';

-- Q:8 Find customers whose phone numbers match the pattern (###) ###-####

SELECT * FROM customers
WHERE phone REGEXP '^\\([0-9]{3}\\) ?[0-9]{3}-[0-9]{4}$';

-- Q:9 Show orders placed in the last 90 days with their formatted order date (DD-Mon-YYYY)

SELECT
	orderNumber,
	DATE_FORMAT(orderDate ,  '%d-%b-%Y') AS formatted_order_date
FROM orders
WHERE orderDate >=CURDATE() - INTERVAL 90 DAY
ORDER BY orderDate DESC;

