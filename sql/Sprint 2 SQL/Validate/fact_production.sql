SELECT
    'Production → Material' AS check_name,
    COUNT(*) AS invalid_rows
FROM dw.fact_production f
LEFT JOIN dw.dim_material m
    ON f.material_key = m.material_key
WHERE m.material_key IS NULL

UNION ALL

SELECT
    'Production → Work Center',
    COUNT(*)
FROM dw.fact_production f
LEFT JOIN dw.dim_work_center w
    ON f.work_center_key = w.work_center_key
WHERE w.work_center_key IS NULL

UNION ALL

SELECT
    'Production → Date',
    COUNT(*)
FROM dw.fact_production f
LEFT JOIN dw.dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL;