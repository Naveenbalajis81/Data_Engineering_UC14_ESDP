SELECT
    m.product_id,
    COUNT(*) AS orphan_count
FROM staging.mm_material_master m
LEFT JOIN staging.olist_products p
    ON m.product_id = p.product_id
WHERE m.product_id IS NOT NULL
  AND p.product_id IS NULL
GROUP BY m.product_id
ORDER BY m.product_id;