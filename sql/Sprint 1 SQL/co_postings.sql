CREATE TABLE staging.co_postings (
    posting_id VARCHAR(30),
    cost_center VARCHAR(30),
    gl_account VARCHAR(30),
    fiscal_year INTEGER,
    period INTEGER,
    amount NUMERIC(14,2),
    posting_date TIMESTAMP
);