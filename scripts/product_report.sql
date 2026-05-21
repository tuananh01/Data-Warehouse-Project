CREATE VIEW gold.report_product AS
WITH product_summary AS (
SELECT 
	fs.product_key,
	dp.product_number,
	dp.product_name,
	dp.category,
	dp.sub_category,
	dp.product_cost,
	SUM(sale_amount) total_product_sale,
	COUNT(DISTINCT order_number) total_order,
	COUNT(quantity) total_quantity,
	COUNT(DISTINCT customer_key) total_customer,
	DATEDIFF(MONTH,MIN(order_date), MAX(order_date)) product_lifetime,
	DATEDIFF(MONTH,MAX(order_date), GETDATE()) time_since_last_order
FROM gold.dim_products dp
LEFT JOIN gold.fact_sales fs
ON dp.product_key = fs.product_key
WHERE order_date IS NOT NULL
GROUP BY 
	fs.product_key,
    dp.product_number,
	dp.product_name,
	dp.category,
	dp.sub_category,
	dp.product_cost
)

SELECT 
	*,
	CASE 
		WHEN product_lifetime >= 12 AND total_product_sale > 100000 THEN 'High-Performer'
		WHEN product_lifetime >= 12 AND total_product_sale <= 100000 THEN 'Mid-Range'
		ELSE 'Low-Performer' 
	END product_rank,
	CASE 
		WHEN total_order = 0 THEN 0
		ELSE total_product_sale/total_order
	END avg_order_revenue,
	CASE 
		WHEN product_lifetime = 0 THEN 0
		ELSE total_product_sale/product_lifetime
	END avg_monthly_revenue
FROM product_summary

SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold' 
  AND TABLE_NAME = 'fact_sales';