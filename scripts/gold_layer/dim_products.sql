CREATE VIEW gold.dim_products AS 

SELECT 
	ROW_NUMBER() OVER(ORDER BY pd.prd_start_dt, pd.prd_key) AS product_key,
	pd.prd_id product_id,
	pd.prd_key product_number,
	pd.cat_id category_id,
	pd.prd_nm product_name,
	pc.cat category,
	pc.subcat sub_category,
	pd.prd_line product_line,
	pc.maintenance,
	pd.prd_cost product_cost,
	pd.product_key_sales,
	pd.prd_start_dt
FROM silver.crm_prd_info pd
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pd.cat_id = pc.id
WHERE pd.prd_end_dt IS NULL AND pd.cat_id != 'CO_PE'