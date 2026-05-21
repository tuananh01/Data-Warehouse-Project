CREATE VIEW gold.fact_sales AS


SELECT 
	sd.sls_ord_num order_number,
	pr.product_key,
	dc.customer_key,                    --Replace with surrogate keys
	--sd.sls_cust_id,
	sd.sls_order_dt order_date,
	sd.sls_ship_dt shipping_date,
	sd.sls_due_dt due_date,
	sd.sls_sales sale_amount,
	sd.sls_quantity quantity,
	sd.sls_price price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_product_key = pr.product_key_sales
LEFT JOIN gold.dim_customers dc
ON sd.sls_cust_id = dc.customer_id