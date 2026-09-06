CREATE TABLE staging.pp_bom (
    bom_id VARCHAR(20),
    material_id VARCHAR(20),
    component_material_id VARCHAR(20),
    quantity NUMERIC(14,2),
    unit VARCHAR(10)
);