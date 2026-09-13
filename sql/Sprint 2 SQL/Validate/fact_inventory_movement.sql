SELECT
    'Inventory → Warehouse' AS check_name,
    COUNT(*) AS invalid_rows
FROM dw.fact_inventory_movement f
LEFT JOIN dw.dim_warehouse w
    ON f.warehouse_key = w.warehouse_key
WHERE w.warehouse_key IS NULL

UNION ALL

SELECT
    'Inventory → Product',
    COUNT(*)
FROM dw.fact_inventory_movement f
LEFT JOIN dw.dim_product p
    ON f.product_key = p.product_key
WHERE p.product_key IS NULL

UNION ALL

SELECT
    'Inventory → Date',
    COUNT(*)
FROM dw.fact_inventory_movement f
LEFT JOIN dw.dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL;