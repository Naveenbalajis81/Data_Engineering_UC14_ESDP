# UC14 Enterprise SAP Data Platform — Sprint 2

## Data Warehouse & Dimensional Modeling

Sprint 2 implements the PostgreSQL data warehouse layer for the UC14 Enterprise SAP Data Platform. Validated data from the Sprint 1 `staging` layer was transformed with Pentaho Data Integration (Spoon) into a dimensional/star-schema model in the `dw` schema.

## Objectives

- Build the dimensional data warehouse.
- Create and populate conformed dimensions.
- Create and populate business-process fact tables.
- Map facts to dimension surrogate keys.
- Validate source-to-fact row counts.
- Validate dimension-key integrity.
- Validate finance GL balancing and duplicates.
- Complete final warehouse checks.

## Technology

| Component | Technology |
|---|---|
| ETL | Pentaho Data Integration / Spoon |
| Pentaho Version | 9.4.0.0-343 |
| Database | PostgreSQL |
| Staging Schema | `staging` |
| Warehouse Schema | `dw` |
| SQL Tool | pgAdmin 4 |
| ETL Files | `.ktr` |

## Architecture

```text
Source Systems
      |
      v
Sprint 1 PostgreSQL staging
      |
      | Pentaho ETL
      v
11 Dimension Tables
      |
      | Surrogate-key lookups
      v
6 Fact Tables
      |
      v
PostgreSQL Data Warehouse
```

## Dimension Tables

The completed warehouse contains 11 dimensions:

```text
dw.dim_company
dw.dim_cost_center
dw.dim_customer
dw.dim_date
dw.dim_department
dw.dim_employee
dw.dim_material
dw.dim_product
dw.dim_vendor
dw.dim_warehouse
dw.dim_work_center
```

## Fact Tables

The completed warehouse contains 6 facts:

```text
dw.fact_sales
dw.fact_finance_gl
dw.fact_procurement
dw.fact_production
dw.fact_inventory_movement
dw.fact_payroll
```

## Fact Load Results

| Fact Table | Rows |
|---|---:|
| `fact_sales` | 4,735 |
| `fact_finance_gl` | 4,526 |
| `fact_procurement` | 1,209 |
| `fact_production` | 500 |
| `fact_inventory_movement` | 1,828 |
| `fact_payroll` | 723 |
| **Total** | **13,521** |

## Fact Design

### Sales

`dw.fact_sales`

Business grain: one sales order item.

Main dimensions:

```text
date → customer → product → vendor
```

### Finance GL

`dw.fact_finance_gl`

Business grain: one financial journal-entry line item.

Main dimensions:

```text
date → company → cost center
```

The fact also retains source business attributes such as document number, line item, GL account, debit/credit indicator, amount, profit center, order ID, currency, and document type.

### Procurement

`dw.fact_procurement`

Business grain: one purchase-order item.

Main dimensions:

```text
date → vendor → product → company
```

### Production

`dw.fact_production`

Business grain: one production order.

Main dimensions:

```text
date → material → work center
```

### Inventory Movement

`dw.fact_inventory_movement`

Business grain: one warehouse stock movement.

Main dimensions:

```text
date → warehouse → product
```

### Payroll

`dw.fact_payroll`

Business grain: one employee payroll record for a pay period.

Main dimensions:

```text
date → employee
```

## Pentaho ETL Pattern

The fact transformations use:

```text
Table Input
     |
     v
Select Values
     |
     v
Table Output
```

`Table Input` reads from the `staging` layer and joins the required dimensions.

`Select Values` standardizes field metadata such as string lengths, integers, numeric precision, and warehouse keys.

`Table Output` writes the result to the appropriate `dw.fact_*` table.

Typical Table Output configuration:

```text
Connection: UC_14
Target schema: dw
Commit size: 1000
Batch update: Enabled
```

## Dimension Key Mapping

Examples:

```text
fact_sales.customer_key
    -> dim_customer.customer_key

fact_sales.product_key
    -> dim_product.product_key

fact_procurement.vendor_key
    -> dim_vendor.vendor_key

fact_production.material_key
    -> dim_material.material_key

fact_production.work_center_key
    -> dim_work_center.work_center_key

fact_inventory_movement.warehouse_key
    -> dim_warehouse.warehouse_key

fact_payroll.employee_key
    -> dim_employee.employee_key
```

## Data Quality Validation

All completed dimension-key validation checks returned zero invalid/orphan records.

### Sales

```text
Sales → Customer = 0
Sales → Product  = 0
Sales → Vendor   = 0
Sales → Date     = 0
```

### Inventory Movement

```text
Inventory → Warehouse = 0
Inventory → Product   = 0
Inventory → Date      = 0
```

### Procurement

```text
Procurement → Vendor  = 0
Procurement → Product = 0
Procurement → Company = 0
Procurement → Date    = 0
```

### Production

```text
Production → Material    = 0
Production → Work Center = 0
Production → Date        = 0
```

### Payroll

```text
Payroll → Employee = 0
Payroll → Date     = 0
```

### Finance GL

```text
Finance GL → Date        = 0
Finance GL → Company     = 0
Finance GL → Cost Center = 0
Duplicate records        = 0
Unbalanced documents     = 0
Source rows              = 4,526
Fact rows                = 4,526
```

## Final Warehouse Validation

```text
Dimensions      = 11
Facts           = 6
Total fact rows = 13,521
```

All six fact tables were successfully loaded and validated.

## Recommended Repository Structure

```text
Data_Engineering_UC14_ESDP/
│
├── README.md
├── data/
├── sql/
│   ├── dimensions/
│   ├── facts/
│   └── validation/
├── pentaho/
│   ├── ingestion/
│   └── dimensional-star-schema/
│       ├── UC14_Sprint2_Load_Dim_Company.ktr
│       ├── UC14_Sprint2_Load_Dim_Cost_Center.ktr
│       ├── UC14_Sprint2_Load_Dim_Customer.ktr
│       ├── UC14_Sprint2_Load_Dim_Department.ktr
│       ├── UC14_Sprint2_Load_Dim_Employee.ktr
│       ├── UC14_Sprint2_Load_Dim_Material.ktr
│       ├── UC14_Sprint2_Load_Dim_Product.ktr
│       ├── UC14_Sprint2_Load_Dim_Vendor.ktr
│       ├── UC14_Sprint2_Load_Dim_Warehouse.ktr
│       ├── UC14_Sprint2_Load_Dim_Work_Center.ktr
│       ├── UC14_Sprint2_Load_Fact_Sales.ktr
│       ├── UC14_Sprint2_Load_Fact_Finance_GL.ktr
│       ├── UC14_Sprint2_Load_Fact_Procurement.ktr
│       ├── UC14_Sprint2_Load_Fact_Production.ktr
│       ├── UC14_Sprint2_Load_Fact_Inventory_Movement.ktr
│       └── UC14_Sprint2_Load_Fact_Payroll.ktr
├── screenshots/
│   └── sprint2/
└── docs/
```

## Sprint 2 Deliverables

- [x] Dimensional warehouse schema
- [x] 11 dimension tables
- [x] 6 fact tables
- [x] Dimension ETL transformations
- [x] Fact ETL transformations
- [x] Surrogate-key lookups
- [x] Fact row-count validation
- [x] Dimension-key integrity validation
- [x] Duplicate validation
- [x] Finance GL balancing validation
- [x] Source-to-fact reconciliation
- [x] Final warehouse validation

## Sprint 2 Status

**COMPLETE**

The Sprint 2 warehouse layer is ready for the next phase.

## Next Sprint — Sprint 3

Sprint 3 will focus on:

```text
Data Quality Framework
        ↓
Audit / Control Tables
        ↓
ETL Logging
        ↓
Error Handling
        ↓
Data Lineage
        ↓
Data Dictionary
        ↓
Governance
        ↓
End-to-End Pipeline Execution
        ↓
Final Documentation
```

Sprint 3 will build on the existing `staging` and `dw` layers without redesigning the completed warehouse.
