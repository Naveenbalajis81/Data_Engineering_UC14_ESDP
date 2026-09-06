CREATE TABLE staging.pp_production_orders (
    production_order_id VARCHAR(20),
    material_id VARCHAR(20),
    plant VARCHAR(20),
    work_center_id VARCHAR(20),
    order_quantity INTEGER,
    planned_start_date DATE,
    planned_end_date DATE,
    actual_start_date DATE,
    actual_end_date DATE,
    status VARCHAR(30)
);