SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_id) AS customer_ids,
    COUNT(customer_unique_id) AS unique_ids,
    COUNT(customer_city) AS cities,
    COUNT(customer_state) AS states
FROM staging.olist_customers;