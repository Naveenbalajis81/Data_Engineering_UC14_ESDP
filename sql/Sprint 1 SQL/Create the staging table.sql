CREATE TABLE staging.olist_order_items (
    order_id VARCHAR(100),
    order_item_id INTEGER,
    product_id VARCHAR(100),
    seller_id VARCHAR(100),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(12,2),
    freight_value NUMERIC(12,2)
);