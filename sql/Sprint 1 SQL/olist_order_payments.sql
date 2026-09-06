CREATE TABLE staging.olist_order_payments (
    order_id VARCHAR(100),
    payment_sequential INTEGER,
    payment_type VARCHAR(50),
    payment_installments INTEGER,
    payment_value NUMERIC(12,2)
);