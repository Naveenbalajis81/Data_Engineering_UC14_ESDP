CREATE TABLE dw.dim_material (
    material_key SERIAL PRIMARY KEY,
    material_id VARCHAR(30) NOT NULL,
    product_id VARCHAR(50),
    material_type VARCHAR(50),
    base_unit VARCHAR(20),
    material_group VARCHAR(50),
    standard_price NUMERIC(14,2),
    CONSTRAINT uq_dim_material_material_id UNIQUE (material_id)
);