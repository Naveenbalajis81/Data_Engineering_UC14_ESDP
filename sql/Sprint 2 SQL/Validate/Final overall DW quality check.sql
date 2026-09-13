SELECT
    'DIMENSIONS' AS object_type,
    COUNT(*) AS object_count
FROM information_schema.tables
WHERE table_schema = 'dw'
  AND table_name LIKE 'dim_%'

UNION ALL

SELECT
    'FACTS',
    COUNT(*)
FROM information_schema.tables
WHERE table_schema = 'dw'
  AND table_name LIKE 'fact_%'

UNION ALL

SELECT
    'TOTAL FACT ROWS',
    SUM(row_count)
FROM (
    SELECT COUNT(*) AS row_count FROM dw.fact_sales
    UNION ALL
    SELECT COUNT(*) FROM dw.fact_finance_gl
    UNION ALL
    SELECT COUNT(*) FROM dw.fact_procurement
    UNION ALL
    SELECT COUNT(*) FROM dw.fact_production
    UNION ALL
    SELECT COUNT(*) FROM dw.fact_inventory_movement
    UNION ALL
    SELECT COUNT(*) FROM dw.fact_payroll
) x;