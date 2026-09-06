CREATE TABLE staging.crm_leads (
    lead_id VARCHAR(30),
    customer_id VARCHAR(30),
    lead_source VARCHAR(100),
    lead_status VARCHAR(50),
    created_date DATE,
    owner_employee_id VARCHAR(30)
);