CREATE TABLE staging.fi_journal_entry_items (
    document_number VARCHAR(30),
    line_item INTEGER,
    gl_account VARCHAR(20),
    debit_credit_indicator VARCHAR(5),
    amount NUMERIC(14,2),
    cost_center VARCHAR(30),
    profit_center VARCHAR(30),
    order_id VARCHAR(30)
);