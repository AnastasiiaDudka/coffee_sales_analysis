--04_product_analysis

--1. Product Revenue Overview. Which products generate the highest revenue?
SELECT 
	p."Product ID",
	p."Coffee Type",
	p."Roast Type",
	p."Size",
	COUNT(o."Order ID") as number_of_orders,
	SUM(o.Quantity) as total_units_sold,
	ROUND(SUM(o.Quantity * p."Unit Price"),2) as total_revenue,
	ROUND(AVG(o.Quantity * p."Unit Price"),2) as average_order_value
FROM orders o
JOIN products p 
	ON o."Product ID" = p."Product ID" 
GROUP BY 1,2,3,4
ORDER BY total_revenue desc;


--2. Which coffee type performs best overall?
SELECT 
	p."Coffee Type",
	COUNT(o."Order ID") as number_of_orders,
	SUM(o.Quantity) as total_units_sold,
	ROUND(SUM(o.Quantity * p."Unit Price"),2) as total_revenue,
	ROUND(AVG(o.Quantity * p."Unit Price"),2) as average_order_value
FROM orders o
JOIN products p 
	ON o."Product ID" = p."Product ID" 
GROUP BY 1
ORDER BY total_revenue desc;

--Exc generated the highest total revenue ($12,306.44), making it the best-performing coffee type by revenue.
--Ara sold the largest number of units (947), indicating the strongest customer demand.
--Exc achieved the highest average order value ($49.82), suggesting customers spend more per order on this coffee type.


--3. Which roast type performs best across all key sales metrics?
SELECT
	p."Roast Type",
	COUNT(o."Order ID") as number_of_orders,
	SUM(o.Quantity) as total_units_sold,
	ROUND(SUM(o.Quantity * p."Unit Price"),2) as total_revenue,
	ROUND(AVG(o.Quantity * p."Unit Price"),2) as average_order_value
FROM orders o
JOIN products p 
	ON o."Product ID" = p."Product ID" 
GROUP BY 1
ORDER BY total_revenue desc;
--Light roast is the best-performing roast type across all key sales metrics. 
--It generated the highest total revenue, sold the largest number of units, and achieved the highest average order value. 
--Although all roast types received a similar number of orders, customers purchasing Light roast tended to spend more per order, making it the strongest overall performer.


--4. Which package size performs best, and should the company prioritize larger or smaller packages?
SELECT
	p.Size, 
	COUNT(o."Order ID") as number_of_orders,
	SUM(o.Quantity) as total_units_sold,
	ROUND(SUM(o.Quantity * p."Unit Price"),2) as total_revenue,
	ROUND(AVG(o.Quantity * p."Unit Price"),2) as average_order_value
FROM orders o
JOIN products p 
	ON o."Product ID" = p."Product ID" 
GROUP BY 1
ORDER BY total_revenue desc;
--The 2.5 kg package is the strongest performer by revenue, generating $23,785.57, which exceeds the combined revenue of all smaller package sizes. 
--Although the 0.5 kg package receives the highest number of orders, customers purchasing the 2.5 kg package spend significantly more per transaction, resulting in the highest average order value ($96.30). 
--Based on these findings, the company should prioritize maintaining sufficient inventory of the 2.5 kg package while continuing to offer smaller sizes to satisfy higher order frequency.


--5. Which products are the most profitable, and does the highest-revenue product also generate the highest profit?
WITH total_counts AS (
	SELECT 
		p."Product ID",
		p."Coffee Type",
		p."Roast Type",
		p.Size,
		COUNT(o."Order ID") as number_of_orders,
		SUM(o.Quantity * p."Unit Price") as total_revenue,
		SUM(o.Quantity * p.Profit) as total_profit
	FROM orders o 
	JOIN products p 
		ON o."Product ID" = p."Product ID"
	GROUP BY 1,2,3,4
)

SELECT 
	"Product ID",
	"Coffee Type",		
	"Roast Type",
	Size,
	number_of_orders,
	ROUND(total_revenue,2) as t_revenue,
	ROUND(total_profit,2) as t_profit,
	ROUND(((total_profit/total_revenue)*100.0),1) AS  profit_margin_percent
FROM total_counts
ORDER BY t_profit desc;
