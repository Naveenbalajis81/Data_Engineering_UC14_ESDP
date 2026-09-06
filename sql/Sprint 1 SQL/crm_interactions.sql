CREATE TABLE staging.crm_interactions (
    interaction_id VARCHAR(30),
    customer_id VARCHAR(30),
    interaction_type VARCHAR(50),
    interaction_date DATE,
    channel VARCHAR(50),
    notes TEXT,
    related_order_id VARCHAR(30)
);