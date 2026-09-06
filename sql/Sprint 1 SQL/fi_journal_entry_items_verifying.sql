SELECT
    document_number,
    SUM(
        CASE
            WHEN debit_credit_indicator = 'D'
            THEN amount
            ELSE 0
        END
    ) AS total_debit,
    SUM(
        CASE
            WHEN debit_credit_indicator = 'C'
            THEN amount
            ELSE 0
        END
    ) AS total_credit
FROM staging.fi_journal_entry_items
GROUP BY document_number
ORDER BY document_number
LIMIT 20;