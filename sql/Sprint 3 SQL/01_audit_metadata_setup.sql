-- Sprint 3, step 1: audit + metadata tables and a data-quality check function.
-- Run in database uc14_esdp. Safe to re-run (uses IF NOT EXISTS / CREATE OR REPLACE).

CREATE SCHEMA IF NOT EXISTS audit;
CREATE SCHEMA IF NOT EXISTS metadata;

-- One row per ETL step execution. Pentaho jobs will insert into this later.
CREATE TABLE IF NOT EXISTS audit.etl_run_log (
    run_id        BIGSERIAL PRIMARY KEY,
    job_name      VARCHAR(100) NOT NULL,
    step_name     VARCHAR(150),
    start_time    TIMESTAMP NOT NULL DEFAULT now(),
    end_time      TIMESTAMP,
    rows_read     BIGINT,
    rows_written  BIGINT,
    rows_rejected BIGINT,
    status        VARCHAR(20) NOT NULL DEFAULT 'RUNNING',  -- RUNNING / SUCCESS / FAILED
    error_message TEXT
);

-- One row per data-quality check result.
CREATE TABLE IF NOT EXISTS audit.dq_results (
    dq_id        BIGSERIAL PRIMARY KEY,
    run_label    VARCHAR(100),
    checked_at   TIMESTAMP NOT NULL DEFAULT now(),
    object_name  VARCHAR(150) NOT NULL,
    check_name   VARCHAR(150) NOT NULL,
    expected     BIGINT,
    actual       BIGINT,
    status       VARCHAR(10) NOT NULL            -- PASS / FAIL
);

-- Table-level source-to-target lineage (fill from the .ktr files).
CREATE TABLE IF NOT EXISTS metadata.source_to_target (
    map_id        SERIAL PRIMARY KEY,
    source_system VARCHAR(30),                   -- e.g. SAP FI, Olist
    source_object VARCHAR(200),                  -- file or staging table
    etl_file      VARCHAR(200),                  -- .ktr that moves it
    target_object VARCHAR(100),                  -- staging.* or dw.*
    layer         VARCHAR(20),                   -- STAGING / DIMENSION / FACT
    load_type     VARCHAR(30),                   -- FULL / APPEND
    notes         TEXT
);

-- Runs every check and writes the results to audit.dq_results.
--   1. fact rows = row count of the staging table it was built from
--   2. every foreign key in each fact points at an existing dimension row
CREATE OR REPLACE FUNCTION audit.run_dw_checks(p_run_label TEXT DEFAULT 'manual')
RETURNS TABLE (object_name TEXT, check_name TEXT, expected BIGINT, actual BIGINT, status TEXT)
LANGUAGE plpgsql AS $$
DECLARE
    r RECORD;
    v_expected BIGINT;
    v_actual   BIGINT;
    v_start    BIGINT := COALESCE((SELECT MAX(dq_id) FROM audit.dq_results), 0);
BEGIN
    -- 1. staging -> fact reconciliation
    FOR r IN
        SELECT * FROM (VALUES
            ('dw.fact_sales',              'staging.olist_order_items'),
            ('dw.fact_finance_gl',         'staging.fi_journal_entry_items'),
            ('dw.fact_procurement',        'staging.mm_purchase_order_items'),
            ('dw.fact_production',         'staging.pp_production_orders'),
            ('dw.fact_inventory_movement', 'staging.wm_stock_movements'),
            ('dw.fact_payroll',            'staging.hcm_payroll')
        ) AS t(fact_tbl, src_tbl)
    LOOP
        EXECUTE format('SELECT COUNT(*) FROM %s', r.src_tbl)  INTO v_expected;
        EXECUTE format('SELECT COUNT(*) FROM %s', r.fact_tbl) INTO v_actual;
        INSERT INTO audit.dq_results(run_label, object_name, check_name, expected, actual, status)
        VALUES (p_run_label, r.fact_tbl, 'row count = ' || r.src_tbl, v_expected, v_actual,
                CASE WHEN v_expected = v_actual THEN 'PASS' ELSE 'FAIL' END);
    END LOOP;

    -- 2. orphan foreign keys
    FOR r IN
        SELECT * FROM (VALUES
            ('dw.fact_sales','date_key','dw.dim_date'),
            ('dw.fact_sales','customer_key','dw.dim_customer'),
            ('dw.fact_sales','product_key','dw.dim_product'),
            ('dw.fact_sales','vendor_key','dw.dim_vendor'),
            ('dw.fact_finance_gl','date_key','dw.dim_date'),
            ('dw.fact_finance_gl','company_key','dw.dim_company'),
            ('dw.fact_finance_gl','cost_center_key','dw.dim_cost_center'),
            ('dw.fact_procurement','date_key','dw.dim_date'),
            ('dw.fact_procurement','vendor_key','dw.dim_vendor'),
            ('dw.fact_procurement','product_key','dw.dim_product'),
            ('dw.fact_procurement','company_key','dw.dim_company'),
            ('dw.fact_production','date_key','dw.dim_date'),
            ('dw.fact_production','material_key','dw.dim_material'),
            ('dw.fact_production','work_center_key','dw.dim_work_center'),
            ('dw.fact_inventory_movement','date_key','dw.dim_date'),
            ('dw.fact_inventory_movement','warehouse_key','dw.dim_warehouse'),
            ('dw.fact_inventory_movement','product_key','dw.dim_product'),
            ('dw.fact_payroll','date_key','dw.dim_date'),
            ('dw.fact_payroll','employee_key','dw.dim_employee')
        ) AS t(fact_tbl, fk_col, dim_tbl)
    LOOP
        EXECUTE format(
            'SELECT COUNT(*) FROM %s f LEFT JOIN %s d ON f.%I = d.%I WHERE f.%I IS NOT NULL AND d.%I IS NULL',
            r.fact_tbl, r.dim_tbl, r.fk_col, r.fk_col, r.fk_col, r.fk_col) INTO v_actual;
        INSERT INTO audit.dq_results(run_label, object_name, check_name, expected, actual, status)
        VALUES (p_run_label, r.fact_tbl, 'orphan ' || r.fk_col, 0, v_actual,
                CASE WHEN v_actual = 0 THEN 'PASS' ELSE 'FAIL' END);
    END LOOP;

    RETURN QUERY
        SELECT d.object_name::TEXT, d.check_name::TEXT, d.expected, d.actual, d.status::TEXT
        FROM audit.dq_results d WHERE d.dq_id > v_start ORDER BY d.dq_id;
END;
$$;

-- Usage:  SELECT * FROM audit.run_dw_checks('after_sprint2_rebuild');
