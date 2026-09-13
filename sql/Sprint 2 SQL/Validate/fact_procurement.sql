SELECT
    'Procurement → Vendor' AS check_name,
    COUNT(*) AS invalid_rows
FROM dw.fact_procurement f
LEFT JOIN dw.dim_vendor v
    ON f.vendor_key = v.vendor_key
WHERE v.vendor_key IS NULL

UNION ALL

SELECT
    'Procurement → Product',
    COUNT(*)
FROM dw.fact_procurement f
LEFT JOIN dw.dim_product p
    ON f.product_key = p.product_key
WHERE p.product_key IS NULL

UNION ALL

SELECT
    'Procurement → Company',
    COUNT(*)
FROM dw.fact_procurement f
LEFT JOIN dw.dim_company c
    ON f.company_key = c.company_key
WHERE c.company_key IS NULL

UNION ALL

SELECT
    'Procurement → Date',
    COUNT(*)
FROM dw.fact_procurement f
LEFT JOIN dw.dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL;