CREATE TABLE dw.dim_company (
    company_key SERIAL PRIMARY KEY,
    company_code VARCHAR(20) NOT NULL,
    CONSTRAINT uq_dim_company_company_code UNIQUE (company_code)
);