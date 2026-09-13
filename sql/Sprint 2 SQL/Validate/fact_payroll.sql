SELECT
    'Payroll → Employee' AS check_name,
    COUNT(*) AS invalid_rows
FROM dw.fact_payroll f
LEFT JOIN dw.dim_employee e
    ON f.employee_key = e.employee_key
WHERE e.employee_key IS NULL

UNION ALL

SELECT
    'Payroll → Date',
    COUNT(*)
FROM dw.fact_payroll f
LEFT JOIN dw.dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL;