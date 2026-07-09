--03_customer_analysis

--1. Customer Overview. How many customers do we have, and how are they distributed across countries?
SELECT 
	Country,
	COUNT("Customer ID") as number_of_customers,
	ROUND(COUNT ("Customer ID")*100.0/(
		SELECT COUNT("Customer ID") FROM customers),2) as customer_percentage
FROM customers 
GROUP BY Country
ORDER BY number_of_customers DESC;


--2. Customer Revenue. Which customers generate the highest revenue?
SELECT 
	c."Customer ID",
	c."Customer Name",
	c.Country,
	COUNT(o."Order ID") as number_of_orders,
	ROUND(SUM(o.Quantity * p."Unit Price"),2) as total_revenue,
	ROUND(AVG(o.Quantity * p."Unit Price"),2) as average_order_value
FROM orders o
INNER JOIN customers c 
	ON o."Customer ID" = c."Customer ID"
INNER JOIN products p 
	ON o."Product ID" = p."Product ID"
GROUP BY 1, 2, 3
ORDER BY total_revenue desc
LIMIT 10;
	

--3. Loyalty Card Analysis. Do customers with a loyalty card spend more than customers without one?
WITH order_revenue as (
	SELECT 
		c."Loyalty Card",
		c."Customer ID",
		o."Order ID",
		o.Quantity * p."Unit Price" as revenue
	FROM orders o  
	INNER JOIN customers c 
		ON o."Customer ID" = c."Customer ID"
	INNER JOIN products p 
		ON o."Product ID" = p."Product ID" 
)
SELECT 
	"Loyalty Card",
	COUNT(DISTINCT "Customer ID") as number_of_customers,
	COUNT("Order ID") as number_of_orders,
	ROUND(SUM(revenue),2) as total_revenue,
	ROUND(AVG(revenue),2) as average_order_value
FROM order_revenue r
GROUP BY "Loyalty Card" 
ORDER BY total_revenue desc;


--4. Customer Lifetime Value. How much revenue has each customer generated over the entire period?
WITH order_revenue as (
	SELECT 
		c."Customer ID",
		c."Customer Name",
		c.Country,
		o."Order ID",
		o.Quantity,
		o.Quantity * p."Unit Price" as revenue
	FROM orders o  
	INNER JOIN customers c 
		ON o."Customer ID" = c."Customer ID"
	INNER JOIN products p 
		ON o."Product ID" = p."Product ID" 
)
SELECT 
	"Customer ID",
	"Customer Name",
	Country,
	SUM(revenue) as lifetime_revenue,
	COUNT("Order ID") as lifetime_orders,
	SUM(Quantity) as lifetime_units
FROM order_revenue o 
GROUP BY 1,2,3
ORDER BY lifetime_revenue desc;

	

--5. Can we identify customers who placed only one order, but that order was worth more than the average order value?
WITH order_revenue as (
	SELECT 
		o."Order ID",
		c."Customer ID",
		c."Customer Name",
		o.Quantity * p."Unit Price" as revenue
	FROM orders o 
	INNER JOIN customers c 
		ON o."Customer ID" = c."Customer ID" 
	INNER JOIN products p 
		ON o."Product ID" = p."Product ID" 
),

customer_orders AS (
	SELECT 
		"Customer ID",
		"Customer Name",
		COUNT("Order ID") as number_of_orders,
		SUM(revenue) as customer_revenue
	FROM order_revenue
	GROUP BY 1,2
),

avg_order_value AS (
	SELECT 
		AVG(revenue) as avg_revenue
	FROM order_revenue
)

SELECT 
	co."Customer ID",
	co."Customer Name",
	co.number_of_orders,
	ROUND(co.customer_revenue,2) as order_value,
	ROUND(aov.avg_revenue,2) as avg_order_value
FROM customer_orders co
CROSS JOIN avg_order_value aov
WHERE co.number_of_orders = 1
	AND co.customer_revenue > aov.avg_revenue
ORDER BY co.customer_revenue desc;
