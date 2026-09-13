CREATE TABLE dw.dim_department (
    department_key SERIAL PRIMARY KEY,
    department_id VARCHAR(30) NOT NULL,
    department_name VARCHAR(100),
    company_code VARCHAR(20),
    cost_center VARCHAR(30),
    CONSTRAINT uq_dim_department_department_id UNIQUE (department_id)
);