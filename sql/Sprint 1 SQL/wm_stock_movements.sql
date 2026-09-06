CREATE TABLE staging.wm_stock_movements (
    movement_id VARCHAR(20),
    material_id VARCHAR(20),
    warehouse_id VARCHAR(20),
    movement_type VARCHAR(100),
    quantity INTEGER,
    movement_date DATE,
    reference_document VARCHAR(30)
);