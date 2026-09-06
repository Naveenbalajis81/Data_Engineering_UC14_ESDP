CREATE TABLE staging.wm_inventory_balance (
    warehouse_id VARCHAR(20),
    material_id VARCHAR(20),
    quantity_on_hand INTEGER,
    as_of_date DATE
);