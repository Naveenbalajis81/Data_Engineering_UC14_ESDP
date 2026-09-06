CREATE TABLE staging.fi_ar_invoices (
    invoice_id VARCHAR(30),
    order_id VARCHAR(30),
    customer_id VARCHAR(30),
    invoice_date TIMESTAMP,
    due_date TIMESTAMP,
    amount NUMERIC(14,2),
    currency VARCHAR(10),
    payment_status VARCHAR(30)
);