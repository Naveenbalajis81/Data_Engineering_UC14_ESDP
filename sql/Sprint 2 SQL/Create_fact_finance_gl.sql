CREATE TABLE dw.fact_finance_gl (
    finance_gl_key BIGSERIAL PRIMARY KEY,

    document_number VARCHAR(30) NOT NULL,
    line_item INTEGER NOT NULL,

    date_key INTEGER NOT NULL,
    company_key INTEGER NOT NULL,
    cost_center_key INTEGER,

    gl_account VARCHAR(20),
    debit_credit_indicator VARCHAR(5),
    amount NUMERIC(14,2),

    profit_center VARCHAR(30),
    order_id VARCHAR(30),
    currency VARCHAR(10),
    document_type VARCHAR(20),

    CONSTRAINT uq_fact_finance_gl
        UNIQUE (document_number, line_item)
);