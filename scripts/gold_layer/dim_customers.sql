CREATE VIEW gold.dim_customers AS

SELECT 
	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key, --Create a surrogate key 
	ci.cst_id customer_id,
	ci.cst_key customer_number,
	ci.cst_firstname firstname,
	ci.cst_lastname lastname,
	CASE 
		WHEN ci.cst_gndr != 'N/A' THEN ci.cst_gndr  --CRM is the Master table of genders
		ELSE COALESCE(ca.gen, 'N/A')
	END gender,
	ca.bdate birthday,
	ci.cst_marital_status marital_status,
	la.country, 
	ci.cst_create_date create_date

FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca 
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid


SELECT DISTINCT gender FROM gold.dim_customers