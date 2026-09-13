CREATE TABLE dw.fact_sales (
    sales_key BIGSERIAL PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL,
    order_item_id INTEGER NOT NULL,
    date_key INTEGER NOT NULL,
    customer_key INTEGER NOT NULL,
    product_key INTEGER NOT NULL,
    vendor_key INTEGER NOT NULL,
    price NUMERIC(14,2),
    freight_value NUMERIC(14,2),
    CONSTRAINT uq_fact_sales_order_item
        UNIQUE (order_id, order_item_id)
);