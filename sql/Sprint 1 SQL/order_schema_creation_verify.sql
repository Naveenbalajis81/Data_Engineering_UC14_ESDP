SELECT
    COUNT(*) AS total_orders,
    COUNT(order_delivered_customer_date) AS delivered_orders,
    COUNT(*) - COUNT(order_delivered_customer_date) AS missing_delivery_dates
FROM staging.olist_orders;