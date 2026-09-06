CREATE TABLE staging.hcm_payroll (
    payroll_id VARCHAR(30),
    employee_id VARCHAR(30),
    pay_period VARCHAR(20),
    gross_pay NUMERIC(14,2),
    deductions NUMERIC(14,2),
    net_pay NUMERIC(14,2),
    pay_date DATE
);