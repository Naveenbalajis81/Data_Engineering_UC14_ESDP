# UC14 Enterprise SAP Data Platform — Sprint 3

## Automation, Data Quality, Governance & Analytics

Sprint 3 makes the Sprint 2 warehouse load repeatable and documented. One Pentaho job empties and reloads the `dw` schema, runs automated quality checks and records every run in an audit table. Lineage, profiling and a data dictionary document the platform. A Power BI report on the `dw` schema completes the sprint.

## Objectives

- Automate the end-to-end warehouse load.
- Record every run and every quality check in audit tables.
- Profile the staging and warehouse data.
- Document source-to-target lineage and the warehouse data dictionary.
- Report on the warehouse in Power BI.

## Deliverables

| Item | Location |
|---|---|
| Audit, metadata tables and `audit.run_dw_checks()` | `sql/Sprint 3 SQL/01_audit_metadata_setup.sql` |
| Lineage seed (79 links) for `metadata.source_to_target` | `sql/Sprint 3 SQL/03_lineage_seed.sql` |
| Single transformation with all 16 dimension and fact loads | `pentaho/Jobs/UC14_Sprint2_Load_All_Dims_And_Facts.ktr` |
| Master load job | `pentaho/Jobs/UC14_Sprint3_Master_Load.kjb` |
| Profiling script | `python_file/02_profile_tables.py` |
| Export of `dw` tables to Excel for Power BI | `python_file/04_export_dw_to_excel.py` |
| Profiling report | `docs/profiling/` |
| Data dictionary for the `dw` schema | `docs/data_dictionary_dw.md` |
| Project presentation (Sprints 0 to 3) | `docs/UC14_ESDP_Detailed_Presentation_Sprint0-3.pptx` |

## How the master job works

`Start` → `Log start` → `Empty DW` → `Load all dims and facts` → `Run DQ checks` → `Log success`

A failure in any of the three working steps writes `FAILED` to `audit.etl_run_log` and aborts the job. The load transformation holds all 16 loads. Every fact waits until all dimension Table outputs have finished.

## How to run

1. Restore the Sprint 2 backup into a database named `uc14_esdp` (`sql/Backup_SQL/SPRINT_2_DIMENSIONAL_STAR_SCHEMA_MODEL_COMPLETE.sql`, a custom-format `pg_dump` archive; use `pg_restore` from PostgreSQL 18).
2. Run `sql/Sprint 3 SQL/01_audit_metadata_setup.sql`, then `03_lineage_seed.sql`.
3. In Spoon, open `pentaho/Jobs/UC14_Sprint3_Master_Load.kjb`. Set the job parameters `UC14_DB_PASSWORD` and `UC14_CUSTOMER_CSV` (full path of `esdp_data/olist/olist_customers_dataset.csv`).
4. Run the job.
5. Run `python python_file/02_profile_tables.py` from the repository root to regenerate the profiling report.

## Validation

| Check | Expected |
|---|---|
| `dw.fact_sales` | 4,735 rows |
| `dw.fact_finance_gl` | 4,526 rows |
| `dw.fact_procurement` | 1,209 rows |
| `dw.fact_production` | 500 rows |
| `dw.fact_inventory_movement` | 1,828 rows |
| `dw.fact_payroll` | 723 rows |
| Total fact rows | 13,521 |
| `metadata.source_to_target` | 79 rows (36 staging, 13 dimension, 30 fact) |
| `audit.run_dw_checks()` | 25 checks: 6 row-count reconciliations and 19 orphan-key checks |

## Notes

- The database has primary keys and unique constraints but no foreign key constraints. Relationships are logical and verified by `audit.run_dw_checks()`.
- The raw WM source files are not in the repository. The WM staging tables come from the database backup.
- The `UC14_DB_PASSWORD` parameter defaults to the local development password. Change it for any shared environment.
- Legacy transformations in `pentaho/transformations/csv` and `pentaho/transformations/json` load a different database (`sap_esdp_db`) and are not part of the master job.
