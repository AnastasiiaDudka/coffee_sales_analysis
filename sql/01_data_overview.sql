--01_data_overview
-- Initial exploration and validation of the dataset

--1. Check all orders data
SELECT *
FROM orders o 
LIMIT 5;

SELECT *
FROM customers c 
LIMIT 5;

SELECT *
FROM products p 
LIMIT 5;


--2. Count total data
SELECT 
	COUNT(*) as total_orders
FROM orders o ;

SELECT 
	COUNT(*) as total_customers
FROM customers c ;

SELECT 
	COUNT(*) as total_products
FROM products p ;


--3. Check date range of orders
SELECT 
	MIN("Order Date") as earlier_date,
	MAX("Order Date") as latest_date
FROM orders o ;


--4. Check country
SELECT 
	Country,
	COUNT(*) as customers_count
FROM customers c 
GROUP BY 1
ORDER BY customers_count;


--5. Check coffee type
SELECT 
	"Coffee Type",
	COUNT(*) as product_count
FROM products p 
GROUP BY 1
ORDER BY product_count;
