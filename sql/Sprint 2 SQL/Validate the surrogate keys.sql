SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_key) AS populated_keys,
    COUNT(DISTINCT customer_key) AS unique_keys
FROM dw.dim_customer;