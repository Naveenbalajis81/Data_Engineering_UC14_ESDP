SELECT
    (SELECT COUNT(*)
     FROM staging.olist_order_items) AS source_rows,
    (SELECT COUNT(*)
     FROM dw.fact_sales) AS fact_rows;