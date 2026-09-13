CREATE TABLE dw.fact_production (
    production_key BIGSERIAL PRIMARY KEY,
    production_order_id VARCHAR(20),
    date_key INTEGER,
    material_key INTEGER,
    work_center_key INTEGER,
    plant VARCHAR(20),
    order_quantity INTEGER,
    status VARCHAR(30)
);