CREATE TABLE dw.dim_employee (
    employee_key SERIAL PRIMARY KEY,
    employee_id VARCHAR(30) NOT NULL,
    employee_name VARCHAR(100),
    department_id VARCHAR(30),
    position_id VARCHAR(30),
    hire_date DATE,
    employment_status VARCHAR(50),
    location VARCHAR(100),
    CONSTRAINT uq_dim_employee_employee_id UNIQUE (employee_id)
);