SELECT
    COUNT(*) FILTER (WHERE date_key IS NULL) AS missing_date,
    COUNT(*) FILTER (WHERE customer_key IS NULL) AS missing_customer,
    COUNT(*) FILTER (WHERE product_key IS NULL) AS missing_product
FROM dw.fact_sales;