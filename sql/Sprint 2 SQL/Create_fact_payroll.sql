CREATE TABLE dw.fact_payroll (
    payroll_key BIGSERIAL PRIMARY KEY,
    payroll_id VARCHAR(30),
    employee_key INTEGER,
    date_key INTEGER,
    pay_period VARCHAR(20),
    gross_pay NUMERIC(14,2),
    deductions NUMERIC(14,2),
    net_pay NUMERIC(14,2)
);