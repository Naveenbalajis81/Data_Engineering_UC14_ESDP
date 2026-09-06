# Data Engineering UC14 --- SAP / E-Commerce Data Integration

## 1. Project Overview

This project is a Data Engineering pipeline for ingesting, validating,
and integrating heterogeneous business datasets from multiple source
domains.

The project uses **Pentaho Data Integration (Spoon)** for ETL and
**PostgreSQL** for staging and downstream data modeling.

The source domains covered in the project are:

-   Olist / SD --- Sales and Distribution / e-commerce
-   FI --- Financial Accounting
-   CO --- Controlling
-   CRM --- Customer Relationship Management
-   HCM --- Human Capital Management
-   MM --- Materials Management
-   PP --- Production Planning
-   WM --- Warehouse Management

The project is organized into sprints. Sprint 0 establishes the project
structure and data understanding. Sprint 1 lands the source datasets
into PostgreSQL staging and validates the loaded data. Sprint 2 will
integrate the modules into a dimensional/star-schema layer.

------------------------------------------------------------------------

# 2. Technology Stack

  Component                 Technology
  ------------------------- ----------------------------------
  ETL                       Pentaho Data Integration (Spoon)
  Database                  PostgreSQL
  Database                  `uc14_esdp`
  Staging schema            `staging`
  Source formats            CSV, XML, Excel, Avro, JSON
  Development environment   VS Code + Pentaho Spoon
  Version control           Git / GitHub

------------------------------------------------------------------------

# 3. Sprint 0 --- Project Setup and Data Understanding

## Objectives

Sprint 0 focused on understanding the project requirements, source
systems, dataset structure, relationships, and target architecture
before implementing the ETL pipelines.

## Completed Work

### 3.1 Source-system identification

The dataset bundle was reviewed and mapped into the following business
modules:

  Source folder   Business module
  --------------- --------------------------
  `olist`         SD + CRM base
  `sap_fi`        Financial Accounting
  `sap_co`        Controlling
  `sap_mm`        Materials Management
  `sap_pp`        Production Planning
  `sap_wm`        Warehouse Management
  `sap_hcm`       Human Capital Management
  `sap_crm`       Extended CRM

### 3.2 Data dictionary review

The supplied data dictionary was used to understand:

-   source files
-   columns
-   business keys
-   relationships between datasets
-   data types
-   cross-module relationships
-   expected downstream facts and dimensions

### 3.3 Target architecture

The project follows a layered approach:

``` text
Source Files
    |
    v
Pentaho ETL
    |
    v
PostgreSQL staging
    |
    v
Data validation
    |
    v
Sprint 2 integration
    |
    v
Dimensional / Star Schema
    |
    v
Analytics / Reporting
```

### 3.4 Important design decision

Sprint 1 does **not** merge all source systems into one large table.

Each source entity is landed independently into the `staging` schema.
Cross-module integration is reserved for Sprint 2.

------------------------------------------------------------------------

# 4. Sprint 1 --- Raw/Staging Ingestion

## Objective

The objective of Sprint 1 was to ingest the source datasets into
PostgreSQL without prematurely integrating the systems.

Each source file was implemented as an independent Pentaho
transformation.

The general ETL pattern was:

``` text
Source Input
    |
    v
Select Values
    |
    v
Table Output
    |
    v
PostgreSQL staging
```

------------------------------------------------------------------------

# 5. PostgreSQL Staging Schema

All Sprint 1 tables were loaded into:

``` text
Database: uc14_esdp
Schema: staging
```

The staging layer contains the following tables.

## 5.1 Olist / SD

  Table                                       Rows
  ---------------------------------------- -------
  `staging.olist_customers`                  2,000
  `staging.olist_orders`                     3,000
  `staging.olist_order_items`                4,735
  `staging.olist_products`                     400
  `staging.olist_sellers`                      150
  `staging.olist_order_payments`             3,486
  `staging.olist_order_reviews`              2,867
  `staging.olist_geolocation`                1,000
  `staging.product_category_translation`        40

## 5.2 SAP FI

  Table                                 Rows
  ---------------------------------- -------
  `staging.fi_gl_accounts`                17
  `staging.fi_journal_entries`         2,263
  `staging.fi_journal_entry_items`     4,526
  `staging.fi_ar_invoices`             3,000
  `staging.fi_ap_invoices`               460

## 5.3 SAP CO

  Table                           Rows
  ----------------------------- ------
  `staging.co_cost_centers`         25
  `staging.co_profit_centers`       15
  `staging.co_postings`            750

## 5.4 SAP CRM

  Table                            Rows
  ----------------------------- -------
  `staging.crm_leads`               600
  `staging.crm_opportunities`       151
  `staging.crm_interactions`      1,500

## 5.5 SAP HCM

  Table                         Rows
  --------------------------- ------
  `staging.hcm_departments`       12
  `staging.hcm_employees`        250
  `staging.hcm_payroll`          723
  `staging.hcm_positions`         34

## 5.6 SAP MM

  Table                                  Rows
  ----------------------------------- -------
  `staging.mm_vendors`                    150
  `staging.mm_material_master`            400
  `staging.mm_purchase_orders`            600
  `staging.mm_purchase_order_items`     1,209
  `staging.mm_goods_receipts`             928

## 5.7 SAP PP

  Table                              Rows
  -------------------------------- ------
  `staging.pp_work_centers`            15
  `staging.pp_bom`                    571
  `staging.pp_production_orders`      500

## 5.8 SAP WM

  Table                               Rows
  -------------------------------- -------
  `staging.wm_warehouses`                8
  `staging.wm_storage_bins`            160
  `staging.wm_inventory_balance`     1,386
  `staging.wm_stock_movements`       1,828

------------------------------------------------------------------------

# 6. Pentaho Transformations

A separate `.ktr` transformation was created for each source entity.

Naming convention:

``` text
UC14_Sprint1_Ingest_<MODULE>_<ENTITY>.ktr
```

Examples:

``` text
UC14_Sprint1_Ingest_CRM_Leads.ktr
UC14_Sprint1_Ingest_CRM_Opportunities.ktr
UC14_Sprint1_Ingest_FI_Journal_Entries.ktr
UC14_Sprint1_Ingest_PP_Work_Centers.ktr
UC14_Sprint1_Ingest_WM_Warehouses.ktr
UC14_Sprint1_Ingest_WM_Stock_Movements.ktr
```

## Input steps used

  Source format   Pentaho step
  --------------- -----------------------
  CSV             CSV File Input
  XML             XML Input
  Excel           Microsoft Excel Input
  Avro            Avro Input
  JSON            JSON Input

The transformations generally used:

``` text
Input → Select Values → Table Output
```

------------------------------------------------------------------------

# 7. Data-Type and Transformation Decisions

Several important data-type decisions were made during Sprint 1.

## 7.1 Business identifiers remain strings

Fields such as:

-   `company_code`
-   `gl_account`
-   `seller_id`
-   `vendor_id`
-   `material_id`
-   `warehouse_id`
-   `document_number`

were treated as business identifiers rather than numeric measures.

For example:

``` text
1000.0
```

was cleaned to:

``` text
1000
```

when the field represented a business code.

Similarly:

``` text
400000.0
```

was treated as:

``` text
400000
```

for GL-account identifiers.

## 7.2 Financial amounts

Financial amounts were loaded as numeric values, using PostgreSQL types
such as:

``` sql
NUMERIC(14,2)
```

## 7.3 Dates

Source-specific date formats were handled during ingestion.

Examples:

``` text
yyyy-MM-dd
yyyy-MM-dd HH:mm:ss
yyyy/MM/dd HH:mm:ss.SSS
```

For WM stock movements, the source included date values with and without
a time component, so the date conversion was handled carefully rather
than blindly assuming one format.

## 7.4 NULL handling

Source NULL/blank values were preserved.

Fake values were not inserted to replace missing source values.

For example, PP production-order actual dates can legitimately be NULL
when production has not started or completed.

------------------------------------------------------------------------

# 8. Sprint 1 Validation

Validation was performed after ingestion.

## 8.1 Row-count validation

All staging tables were checked for successful loading.

The three counts that initially appeared different from earlier
expectations were investigated:

``` text
co_postings          = 750
crm_opportunities    = 151
fi_journal_entries   = 2,263
```

These were subsequently verified against their loaded identifier ranges
and distributions.

### CO postings

The table contains 750 records across fiscal years 2023 and 2024 and
periods 1--12.

### CRM opportunities

``` text
Total rows              = 151
Distinct opportunity_id = 151
First ID                = OPP00001
Last ID                 = OPP00151
```

### FI journal entries

``` text
Total rows               = 2,263
Distinct document_number = 2,263
First document           = JE0000001
Last document             = JE0002263
```

Fiscal-year distribution:

    Fiscal year        Rows
  ------------- -----------
           2023       1,084
           2024       1,167
           2025          12
      **Total**   **2,263**

The earlier assumptions of 1,000 CO postings, 302 CRM opportunities, and
1,000 FI journal headers were therefore not used as targets.

------------------------------------------------------------------------

# 9. Duplicate-Key Validation

Duplicate business-key validation returned:

``` text
0 rows
```

The following types of identifiers were checked:

-   cost center
-   profit center
-   posting ID
-   lead ID
-   opportunity ID
-   interaction ID
-   GL account
-   journal document number
-   journal document + line item
-   warehouse ID
-   storage-bin ID
-   stock-movement ID

Result:

**PASS --- no duplicate business keys were found in the checked staging
tables.**

------------------------------------------------------------------------

# 10. Required-NULL Validation

Required business keys and required fields were checked.

Result:

``` text
null_count = 0
```

Result:

**PASS --- no unexpected NULL values were found in the checked required
fields.**

Nullable source attributes were not incorrectly treated as errors.

------------------------------------------------------------------------

# 11. Cross-Module Referential Validation

A combined SQL validation query was used to check cross-module
relationships.

Result:

``` text
24 / 24 validations passed
0 orphan records
```

Validated relationships included:

``` text
CO Postings
    → CO Cost Centers

CO Postings
    → FI GL Accounts

CRM Opportunities
    → CRM Leads

CRM Leads
    → HCM Employees

MM Vendors
    → Olist Sellers

MM Materials
    → Olist Products

MM Purchase Orders
    → MM Vendors

MM PO Items
    → MM Purchase Orders

MM PO Items
    → MM Materials

MM Goods Receipts
    → MM PO Items

MM Goods Receipts
    → MM Materials

PP Production Orders
    → MM Materials

PP Production Orders
    → PP Work Centers

PP BOM
    → MM Materials

PP BOM Components
    → MM Materials

WM Storage Bins
    → WM Warehouses

WM Inventory
    → WM Warehouses

WM Inventory
    → MM Materials

WM Stock Movements
    → WM Warehouses

WM Stock Movements
    → MM Materials

FI Journal Items
    → FI Journal Entries

FI Journal Items
    → FI GL Accounts

FI AR Invoices
    → Olist Orders

FI AP Invoices
    → MM Purchase Orders
```

------------------------------------------------------------------------

# 12. Sprint 1 Final Status

## Sprint 1 is complete.

Completed:

-   [x] All source modules identified
-   [x] Source files analyzed
-   [x] PostgreSQL staging schema created
-   [x] Olist / SD datasets loaded
-   [x] FI datasets loaded
-   [x] CO datasets loaded
-   [x] CRM datasets loaded
-   [x] HCM datasets loaded
-   [x] MM datasets loaded
-   [x] PP datasets loaded
-   [x] WM datasets loaded
-   [x] Data types standardized
-   [x] Required NULL validation completed
-   [x] Duplicate-key validation completed
-   [x] Cross-module referential validation completed
-   [x] Suspicious row counts investigated
-   [x] 24/24 cross-module validations passed

------------------------------------------------------------------------

# 13. Sprint 2 --- Planned Work

Sprint 2 will move from independent staging tables toward an integrated
analytical model.

The next phase should include:

1.  Define shared dimensions.
2.  Define fact tables.
3.  Establish surrogate keys where required.
4.  Build dimension-loading transformations.
5.  Build fact-loading transformations.
6.  Integrate relationships across FI, CO, MM, PP, WM, HCM, CRM, and
    Olist.
7.  Validate fact-to-dimension relationships.
8.  Validate measures and business rules.
9.  Document the final star schema.

Potential analytical facts identified from the project design include:

``` text
fact_sales
fact_finance_gl
fact_procurement
fact_production
fact_inventory_movement
fact_payroll
```

Potential shared dimensions include:

``` text
dim_date
dim_customer
dim_product
dim_vendor
dim_employee
dim_department
dim_company
dim_cost_center
dim_warehouse
dim_material
```

These should be finalized during Sprint 2 based on the actual source
relationships rather than creating unnecessary duplicate dimensions.

------------------------------------------------------------------------

# 14. Repository Structure

Recommended GitHub repository structure:

``` text
data-engineering-uc14/
│
├── README.md
│
├── data/
│   └── README.md
│
├── pentaho/
│   ├── sprint_1/
│   │   ├── UC14_Sprint1_Ingest_Olist_Customers.ktr
│   │   ├── UC14_Sprint1_Ingest_Olist_Orders.ktr
│   │   ├── UC14_Sprint1_Ingest_FI_Journal_Entries.ktr
│   │   ├── UC14_Sprint1_Ingest_CRM_Leads.ktr
│   │   ├── UC14_Sprint1_Ingest_MM_Vendors.ktr
│   │   ├── UC14_Sprint1_Ingest_PP_Production_Orders.ktr
│   │   └── ...
│   │
│   └── sprint_2/
│       └── ...
│
├── sql/
│   ├── sprint_1_validation.sql
│   └── sprint_2/
│       └── ...
│
├── docs/
│   ├── sprint_0.md
│   └── sprint_1.md
│
└── screenshots/
    ├── sprint_1/
    └── sprint_2/
```

------------------------------------------------------------------------

# 15. How to Run the Project

## Step 1 --- Start PostgreSQL

Create/use the database:

``` sql
CREATE DATABASE uc14_esdp;
```

## Step 2 --- Create staging schema

``` sql
CREATE SCHEMA IF NOT EXISTS staging;
```

## Step 3 --- Open Pentaho Spoon

Configure the PostgreSQL connection:

``` text
Connection name: UC14_PostgreSQL
Database: uc14_esdp
Schema: staging
```

## Step 4 --- Run Sprint 1 transformations

Execute each source-specific `.ktr` transformation.

## Step 5 --- Run validation SQL

Run:

``` text
sql/sprint_1_validation.sql
```

All required checks should pass before starting Sprint 2.

------------------------------------------------------------------------

# 16. Data Engineering Principles Followed

The project follows these principles:

-   Keep source systems separate during raw/staging ingestion.
-   Do not merge heterogeneous sources prematurely.
-   Preserve source NULLs.
-   Do not invent missing values.
-   Keep business identifiers as strings.
-   Convert measures to appropriate numeric types.
-   Handle source-specific date formats explicitly.
-   Validate row counts.
-   Validate duplicate business keys.
-   Validate required fields.
-   Validate cross-module relationships.
-   Investigate unexpected counts instead of blindly forcing expected
    values.
-   Keep ETL transformations modular and traceable.

------------------------------------------------------------------------

# 17. Sprint Summary

  -------------------------------------------------------------------------
  Sprint                  Objective                 Status
  ----------------------- ------------------------- -----------------------
  Sprint 0                Project setup, source     ✅ Complete
                          analysis, architecture    
                          and planning              

  Sprint 1                Source ingestion into     ✅ Complete
                          PostgreSQL staging +      
                          validation                

  Sprint 2                Integrated                ⏳ Next
                          dimensional/star-schema   
                          model                     

  Sprint 3                Lineage, governance and   ⏳ Planned
                          final documentation       
  -------------------------------------------------------------------------

------------------------------------------------------------------------

## Current Status

**Sprint 0: COMPLETE**

**Sprint 1: COMPLETE**

**Next milestone: Sprint 2 --- Data Integration and Star Schema**
