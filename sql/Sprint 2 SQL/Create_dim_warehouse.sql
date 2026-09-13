CREATE TABLE dw.dim_warehouse (
    warehouse_key SERIAL PRIMARY KEY,
    warehouse_id VARCHAR(20) NOT NULL,
    warehouse_name VARCHAR(100),
    plant VARCHAR(20),
    city VARCHAR(100),
    state VARCHAR(20),
    CONSTRAINT uq_dim_warehouse_warehouse_id UNIQUE (warehouse_id)
);