CREATE TABLE staging.fi_journal_entries (
    document_number VARCHAR(30),
    company_code VARCHAR(20),
    fiscal_year INTEGER,
    posting_date TIMESTAMP,
    document_date TIMESTAMP,
    document_type VARCHAR(20),
    currency VARCHAR(10),
    reference VARCHAR(100),
    created_by VARCHAR(100)
);