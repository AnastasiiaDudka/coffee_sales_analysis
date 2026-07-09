--02_sales_analysis
--Sales KPIs and revenue analysis

--1. Total Revenue
WITH orders_revenue as (
	SELECT 
		o."Order ID",
		o.Quantity,
		p."Unit Price",
		o.Quantity*p."Unit Price" as revenue
	FROM orders o 
	INNER JOIN products p 
		ON o."Product ID" = p."Product ID" 
)

SELECT 
	SUM(revenue) as total_revenue
FROM orders_revenue;


--2. Total Units Sold
SELECT 
	SUM(Quantity) as total_units_sold
FROM orders o ;


--3. Average, Highest and Lowest Order Value
WITH orders_revenue as (
	SELECT 
		o."Order ID",
		o.Quantity,
		p."Unit Price",
		o.Quantity*p."Unit Price" as sales
	FROM orders o 
	INNER JOIN products p 
		ON o."Product ID" = p."Product ID" 
)
SELECT 
	ROUND(AVG(sales),2) as avg_sales,
	MAX(sales) as max_sales,
	MIN(sales) as min_sales
FROM orders_revenue;


--4. Number of Orders by Year
SELECT 
	SUBSTR("Order Date", -4) as order_year,
	COUNT("Order Date") as number_of_orders
FROM orders
GROUP BY 1;
