CREATE TABLE dw.dim_cost_center (
    cost_center_key SERIAL PRIMARY KEY,
    cost_center VARCHAR(30) NOT NULL,
    cost_center_name VARCHAR(100),
    department VARCHAR(100),
    company_code VARCHAR(20),
    responsible_person VARCHAR(100),
    CONSTRAINT uq_dim_cost_center UNIQUE (cost_center)
);