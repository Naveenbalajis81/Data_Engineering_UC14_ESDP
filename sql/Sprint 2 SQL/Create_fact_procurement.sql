CREATE TABLE dw.fact_procurement (
    procurement_key BIGSERIAL PRIMARY KEY,
    po_id VARCHAR(30),
    po_item INTEGER,
    date_key INTEGER,
    vendor_key INTEGER,
    product_key INTEGER,
    company_key INTEGER,
    plant VARCHAR(30),
    quantity INTEGER,
    unit_price NUMERIC(14,2),
    total_amount NUMERIC(14,2),
    currency VARCHAR(10)
);