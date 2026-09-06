CREATE TABLE staging.mm_goods_receipts (
    gr_id VARCHAR(30),
    po_id VARCHAR(30),
    po_item INTEGER,
    material_id VARCHAR(30),
    quantity INTEGER,
    gr_date DATE,
    plant VARCHAR(30),
    warehouse VARCHAR(30)
);