SELECT
    (SELECT COUNT(*) FROM staging.olist_customers) AS staging_count,
    (SELECT COUNT(*) FROM dw.dim_customer) AS dimension_count;