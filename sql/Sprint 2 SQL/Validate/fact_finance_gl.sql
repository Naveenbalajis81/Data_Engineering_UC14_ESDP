SELECT
    'Finance GL → Date' AS check_name,
    COUNT(*) AS invalid_rows
FROM dw.fact_finance_gl f
LEFT JOIN dw.dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL

UNION ALL

SELECT
    'Finance GL → Company',
    COUNT(*)
FROM dw.fact_finance_gl f
LEFT JOIN dw.dim_company c
    ON f.company_key = c.company_key
WHERE c.company_key IS NULL

UNION ALL

SELECT
    'Finance GL → Cost Center',
    COUNT(*)
FROM dw.fact_finance_gl f
LEFT JOIN dw.dim_cost_center c
    ON f.cost_center_key = c.cost_center_key
WHERE f.cost_center_key IS NOT NULL
  AND c.cost_center_key IS NULL;