CREATE TABLE staging.mm_purchase_order_items (
    po_id VARCHAR(30),
    po_item INTEGER,
    material_id VARCHAR(30),
    quantity INTEGER,
    unit_price NUMERIC(14,2),
    delivery_date DATE,
    plant VARCHAR(30)
);