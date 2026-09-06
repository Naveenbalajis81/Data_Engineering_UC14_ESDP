CREATE TABLE staging.fi_ap_invoices (
    invoice_id VARCHAR(30),
    po_id VARCHAR(30),
    vendor_id VARCHAR(30),
    invoice_date TIMESTAMP,
    due_date TIMESTAMP,
    amount NUMERIC(14,2),
    currency VARCHAR(10),
    payment_status VARCHAR(30)
);