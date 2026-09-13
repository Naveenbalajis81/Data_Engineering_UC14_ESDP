SELECT 'fact_sales' AS fact_table, COUNT(*) AS row_count
FROM dw.fact_sales

UNION ALL

SELECT 'fact_finance_gl', COUNT(*)
FROM dw.fact_finance_gl

UNION ALL

SELECT 'fact_procurement', COUNT(*)
FROM dw.fact_procurement

UNION ALL

SELECT 'fact_production', COUNT(*)
FROM dw.fact_production

UNION ALL

SELECT 'fact_inventory_movement', COUNT(*)
FROM dw.fact_inventory_movement

UNION ALL

SELECT 'fact_payroll', COUNT(*)
FROM dw.fact_payroll

ORDER BY fact_table;