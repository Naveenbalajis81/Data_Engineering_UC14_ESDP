CREATE TABLE staging.crm_opportunities (
    opportunity_id VARCHAR(30),
    lead_id VARCHAR(30),
    customer_id VARCHAR(30),
    opportunity_stage VARCHAR(50),
    expected_value NUMERIC(14,2),
    close_date DATE
);
