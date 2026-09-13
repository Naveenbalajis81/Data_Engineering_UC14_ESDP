SELECT
    order_id,
    order_item_id,
    COUNT(*) AS duplicate_count
FROM dw.fact_sales
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;