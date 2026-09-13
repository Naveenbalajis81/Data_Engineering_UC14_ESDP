SELECT
    'Sales → Customer' AS check_name,
    COUNT(*) AS invalid_rows
FROM dw.fact_sales f
LEFT JOIN dw.dim_customer c
    ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL

UNION ALL

SELECT
    'Sales → Product',
    COUNT(*)
FROM dw.fact_sales f
LEFT JOIN dw.dim_product p
    ON f.product_key = p.product_key
WHERE p.product_key IS NULL

UNION ALL

SELECT
    'Sales → Vendor',
    COUNT(*)
FROM dw.fact_sales f
LEFT JOIN dw.dim_vendor v
    ON f.vendor_key = v.vendor_key
WHERE f.vendor_key IS NOT NULL
  AND v.vendor_key IS NULL

UNION ALL

SELECT
    'Sales → Date',
    COUNT(*)
FROM dw.fact_sales f
LEFT JOIN dw.dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL;