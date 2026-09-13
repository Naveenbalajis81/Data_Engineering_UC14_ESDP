CREATE TABLE dw.fact_inventory_movement (
    movement_key BIGSERIAL PRIMARY KEY,
    movement_id VARCHAR(20),
    material_id VARCHAR(20),
    warehouse_key INTEGER,
    product_key INTEGER,
    date_key INTEGER,
    movement_type VARCHAR(100),
    quantity INTEGER,
    reference_document VARCHAR(30)
);