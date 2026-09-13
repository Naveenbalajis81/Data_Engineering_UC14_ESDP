CREATE TABLE dw.dim_vendor (
    vendor_key SERIAL PRIMARY KEY,
    vendor_id VARCHAR(30) NOT NULL,
    vendor_name VARCHAR(150),
    seller_id VARCHAR(50),
    country VARCHAR(100),
    payment_terms VARCHAR(50),
    currency VARCHAR(10),
    CONSTRAINT uq_dim_vendor_vendor_id UNIQUE (vendor_id)
);