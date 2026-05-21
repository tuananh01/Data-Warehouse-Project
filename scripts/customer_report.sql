--Customer Report 

CREATE VIEW gold.report_customer AS
WITH customer_summary AS (
SELECT
	dc.customer_key,
	dc.firstname,
	dc.lastname,
	dc.gender,
	(DATEPART(YEAR,GETDATE()) - DATEPART(YEAR,birthday)) age,
	order_number,
	SUM(quantity) OVER(PARTITION BY fs.customer_key) total_quantity,
	COUNT(product_key) OVER(PARTITION BY fs.customer_key) total_product,
	SUM(sale_amount) OVER(PARTITION BY fs.customer_key) total_spending,
	DATEDIFF(MONTH,MIN(order_date) OVER(PARTITION BY fs.customer_key),
	MAX(order_date) OVER(PARTITION BY fs.customer_key)) customer_lifetime,
	(DATEDIFF(MONTH,MAX(order_date) OVER(PARTITION BY fs.customer_key),
	GETDATE())) time_since_last_order
FROM gold.dim_customers dc
LEFT JOIN gold.fact_sales fs
ON dc.customer_key = fs.customer_key
WHERE order_date IS NOT NULL
)

SELECT 
	customer_key,
	firstname,
	lastname,
	gender,
	age, 
	COUNT(DISTINCT order_number) total_orders,
	total_quantity,
	total_product,
	CASE
		WHEN COUNT(DISTINCT order_number) = 0 THEN 0
		ELSE total_spending/COUNT(DISTINCT order_number) 
	END avg_order_value,
	CASE
		WHEN customer_lifetime = 0 THEN 0
		ELSE total_spending/customer_lifetime
	END avg_monthly_spend,
	total_spending,

	customer_lifetime,
	time_since_last_order,
	CASE 
		WHEN customer_lifetime >= 12 AND total_spending > 5000 THEN 'VIP'
		WHEN customer_lifetime >= 12 AND total_spending <= 5000 THEN 'Regular'
		ELSE 'NEW' 
	END customer_rank,
	CASE 
		WHEN age BETWEEN 18 AND 25 THEN '18-25'
		WHEN age BETWEEN 26 AND 35 THEN '26-35'
		WHEN age BETWEEN 35 AND 50 THEN '35-50'
		WHEN age BETWEEN 51 AND 70 THEN '51-70'
		WHEN age > 70 THEN 'Above 70'
		ELSE 'N/A'
	END age_range
FROM customer_summary
GROUP BY 
	customer_key,
	firstname,
	lastname,
	gender,
	age, 
	total_quantity,
	total_product,
	total_spending,
	customer_lifetime,
	time_since_last_order
