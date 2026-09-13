SELECT
    -- 1. Total fact rows
    (SELECT COUNT(*)
     FROM dw.fact_finance_gl) AS fact_rows,

    -- 2. Duplicate records
    (SELECT COUNT(*)
     FROM (
         SELECT document_number, line_item
         FROM dw.fact_finance_gl
         GROUP BY document_number, line_item
         HAVING COUNT(*) > 1
     ) d) AS duplicate_records,

    -- 3. Missing date keys
    (SELECT COUNT(*)
     FROM dw.fact_finance_gl
     WHERE date_key IS NULL) AS missing_date_keys,

    -- 4. Missing company keys
    (SELECT COUNT(*)
     FROM dw.fact_finance_gl
     WHERE company_key IS NULL) AS missing_company_keys,

    -- 5. Unbalanced journal entries
    (SELECT COUNT(*)
     FROM (
         SELECT document_number
         FROM dw.fact_finance_gl
         GROUP BY document_number
         HAVING ROUND(
             SUM(
                 CASE
                     WHEN debit_credit_indicator = 'D' THEN amount
                     WHEN debit_credit_indicator = 'C' THEN -amount
                     ELSE 0
                 END
             ), 2
         ) <> 0
     ) b) AS unbalanced_documents,

    -- 6. Source vs Fact
    (SELECT COUNT(*)
     FROM staging.fi_journal_entry_items) AS source_rows,

    (SELECT COUNT(*)
     FROM dw.fact_finance_gl) AS fact_rows_check;