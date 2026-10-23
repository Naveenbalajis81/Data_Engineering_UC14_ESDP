# Data Profiling Report

Database `uc14_esdp`, schemas: staging, dw.

## Table summary

| Schema | Table | Rows | Columns | Duplicate rows |
|---|---|---:|---:|---:|
| dw | dim_company | 1 | 2 | 0 |
| dw | dim_cost_center | 25 | 6 | 0 |
| dw | dim_customer | 2,000 | 6 | 0 |
| dw | dim_date | 1,461 | 10 | 0 |
| dw | dim_department | 12 | 5 | 0 |
| dw | dim_employee | 250 | 8 | 0 |
| dw | dim_material | 400 | 7 | 0 |
| dw | dim_product | 400 | 10 | 0 |
| dw | dim_vendor | 150 | 7 | 0 |
| dw | dim_warehouse | 8 | 6 | 0 |
| dw | dim_work_center | 15 | 5 | 0 |
| dw | fact_finance_gl | 4,526 | 13 | 0 |
| dw | fact_inventory_movement | 1,828 | 9 | 0 |
| dw | fact_payroll | 0 | 8 | 0 |
| dw | fact_procurement | 1,209 | 12 | 0 |
| dw | fact_production | 500 | 8 | 0 |
| dw | fact_sales | 4,735 | 9 | 0 |
| staging | co_cost_centers | 25 | 5 | 0 |
| staging | co_postings | 750 | 7 | 0 |
| staging | co_profit_centers | 15 | 3 | 0 |
| staging | crm_interactions | 1,500 | 7 | 0 |
| staging | crm_leads | 600 | 6 | 0 |
| staging | crm_opportunities | 151 | 6 | 0 |
| staging | fi_ap_invoices | 460 | 8 | 0 |
| staging | fi_ar_invoices | 3,000 | 8 | 0 |
| staging | fi_gl_accounts | 17 | 4 | 0 |
| staging | fi_journal_entries | 2,263 | 9 | 0 |
| staging | fi_journal_entry_items | 4,526 | 8 | 0 |
| staging | hcm_departments | 12 | 4 | 0 |
| staging | hcm_employees | 250 | 7 | 0 |
| staging | hcm_payroll | 723 | 7 | 0 |
| staging | hcm_positions | 34 | 3 | 0 |
| staging | mm_goods_receipts | 928 | 8 | 0 |
| staging | mm_material_master | 400 | 6 | 0 |
| staging | mm_purchase_order_items | 1,209 | 7 | 0 |
| staging | mm_purchase_orders | 600 | 6 | 0 |
| staging | mm_vendors | 150 | 6 | 0 |
| staging | olist_customers | 2,000 | 5 | 0 |
| staging | olist_geolocation | 1,000 | 5 | 0 |
| staging | olist_order_items | 4,735 | 7 | 0 |
| staging | olist_order_payments | 3,486 | 5 | 0 |
| staging | olist_order_reviews | 2,867 | 7 | 0 |
| staging | olist_orders | 3,000 | 8 | 0 |
| staging | olist_products | 400 | 9 | 0 |
| staging | olist_sellers | 150 | 4 | 0 |
| staging | pp_bom | 571 | 5 | 0 |
| staging | pp_production_orders | 500 | 10 | 0 |
| staging | pp_work_centers | 15 | 4 | 0 |
| staging | product_category_translation | 40 | 2 | 0 |
| staging | wm_inventory_balance | 1,386 | 4 | 0 |
| staging | wm_stock_movements | 1,828 | 7 | 0 |
| staging | wm_storage_bins | 160 | 4 | 0 |
| staging | wm_warehouses | 8 | 5 | 0 |

## dw.dim_company

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| company_key | int64 | 0 | 0.0 | 1 | 1 | 1 |
| company_code | str | 0 | 0.0 | 1 | 1000 | 1000 |

## dw.dim_cost_center

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| cost_center_key | int64 | 0 | 0.0 | 25 | 1 | 25 |
| cost_center | str | 0 | 0.0 | 25 | CC0001 | CC0025 |
| cost_center_name | str | 0 | 0.0 | 25 | Finance Cost Center 13 | Warehouse Cost Center 5 |
| department | str | 0 | 0.0 | 10 | Finance | Warehouse |
| company_code | str | 0 | 0.0 | 1 | 1000 | 1000 |
| responsible_person | str | 0 | 0.0 | 25 | Angelica Tucker | Tricia Valencia |

## dw.dim_customer

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| customer_key | int64 | 0 | 0.0 | 2000 | 1 | 2000 |
| customer_id | str | 0 | 0.0 | 2000 | CUST000001 | CUST002000 |
| customer_unique_id | str | 0 | 0.0 | 2000 | CUNQ000001 | CUNQ002000 |
| customer_zip_code_prefix | str | 0 | 0.0 | 1972 | 10012 | 99959 |
| customer_city | str | 0 | 0.0 | 61 | ananindeua | vitoria da conquista |
| customer_state | str | 0 | 0.0 | 27 | AC | TO |

## dw.dim_date

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| date_key | int64 | 0 | 0.0 | 1461 | 20220101 | 20251231 |
| full_date | object | 0 | 0.0 | 1461 | 2022-01-01 | 2025-12-31 |
| day_number | int64 | 0 | 0.0 | 31 | 1 | 31 |
| day_name | str | 0 | 0.0 | 7 | Friday | Wednesday |
| month_number | int64 | 0 | 0.0 | 12 | 1 | 12 |
| month_name | str | 0 | 0.0 | 12 | April | September |
| quarter_number | int64 | 0 | 0.0 | 4 | 1 | 4 |
| year_number | int64 | 0 | 0.0 | 4 | 2022 | 2025 |
| week_number | int64 | 0 | 0.0 | 52 | 1 | 52 |
| day_of_week | int64 | 0 | 0.0 | 7 | 1 | 7 |

## dw.dim_department

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| department_key | int64 | 0 | 0.0 | 12 | 1 | 12 |
| department_id | str | 0 | 0.0 | 12 | DEPT001 | DEPT012 |
| department_name | str | 0 | 0.0 | 12 | Customer Service | Warehouse |
| company_code | str | 0 | 0.0 | 1 | 1000 | 1000 |
| cost_center | str | 0 | 0.0 | 11 | CC0001 | CC0023 |

## dw.dim_employee

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| employee_key | int64 | 0 | 0.0 | 250 | 1 | 250 |
| employee_id | str | 0 | 0.0 | 250 | EMP00001 | EMP00250 |
| employee_name | str | 0 | 0.0 | 250 | Aaron Bell | William Wilson |
| department_id | str | 0 | 0.0 | 12 | DEPT001 | DEPT012 |
| position_id | str | 0 | 0.0 | 33 | POS0001 | POS0034 |
| hire_date | object | 0 | 0.0 | 244 | 2018-01-02 | 2024-12-19 |
| employment_status | str | 0 | 0.0 | 3 | Active | Terminated |
| location | str | 0 | 0.0 | 250 | Alyssaview | Zacharyside |

## dw.dim_material

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| material_key | int64 | 0 | 0.0 | 400 | 1 | 400 |
| material_id | str | 0 | 0.0 | 400 | MAT00001 | MAT00400 |
| product_id | str | 0 | 0.0 | 400 | PROD00001 | PROD00400 |
| material_type | str | 0 | 0.0 | 2 | FERT | HALB |
| base_unit | str | 0 | 0.0 | 1 | EA | EA |
| material_group | str | 0 | 0.0 | 40 | air_conditioning | watches_gifts |
| standard_price | float64 | 0 | 0.0 | 400 | 10.06 | 697.91 |

## dw.dim_product

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| product_key | int64 | 0 | 0.0 | 400 | 1 | 400 |
| product_id | str | 0 | 0.0 | 400 | PROD00001 | PROD00400 |
| product_category_name | str | 0 | 0.0 | 40 | air_conditioning | watches_gifts |
| product_name_length | int64 | 0 | 0.0 | 46 | 15 | 60 |
| product_description_length | int64 | 0 | 0.0 | 378 | 137 | 2978 |
| product_photos_qty | int64 | 0 | 0.0 | 8 | 1 | 8 |
| product_weight_g | int64 | 0 | 0.0 | 393 | 66 | 19958 |
| product_length_cm | int64 | 0 | 0.0 | 95 | 5 | 100 |
| product_height_cm | int64 | 0 | 0.0 | 79 | 2 | 80 |
| product_width_cm | int64 | 0 | 0.0 | 86 | 5 | 90 |

## dw.dim_vendor

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| vendor_key | int64 | 0 | 0.0 | 150 | 1 | 150 |
| vendor_id | str | 0 | 0.0 | 150 | VEND00001 | VEND00150 |
| vendor_name | str | 0 | 0.0 | 149 | Adams, Christian and Rivas | Yu Inc |
| seller_id | str | 0 | 0.0 | 150 | SELL00001 | SELL00150 |
| country | str | 0 | 0.0 | 1 | BR | BR |
| payment_terms | str | 0 | 0.0 | 4 | NET15 | NET60 |
| currency | str | 0 | 0.0 | 1 | BRL | BRL |

## dw.dim_warehouse

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| warehouse_key | int64 | 0 | 0.0 | 8 | 1 | 8 |
| warehouse_id | str | 0 | 0.0 | 8 | WH01 | WH08 |
| warehouse_name | str | 0 | 0.0 | 8 | Distribution Center 1 | Distribution Center 8 |
| plant | str | 0 | 0.0 | 3 | PL01 | PL03 |
| city | str | 0 | 0.0 | 8 | belo horizonte | sao paulo |
| state | str | 0 | 0.0 | 8 | BA | SP |

## dw.dim_work_center

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| work_center_key | int64 | 0 | 0.0 | 15 | 1 | 15 |
| work_center_id | str | 0 | 0.0 | 15 | WC001 | WC015 |
| work_center_name | str | 0 | 0.0 | 15 | Assembly Line 1 | Welding Line 6 |
| plant | str | 0 | 0.0 | 2 | PL01 | PL03 |
| capacity_hours | float64 | 0 | 0.0 | 10 | 8.0 | 24.0 |

## dw.fact_finance_gl

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| finance_gl_key | int64 | 0 | 0.0 | 4526 | 1 | 4526 |
| document_number | str | 0 | 0.0 | 2263 | JE0000001 | JE0002263 |
| line_item | int64 | 0 | 0.0 | 2 | 1 | 2 |
| date_key | int64 | 0 | 0.0 | 710 | 20230101 | 20250114 |
| company_key | int64 | 0 | 0.0 | 1 | 1 | 1 |
| cost_center_key | float64 | 3600 | 79.54 | 25 | 1.0 | 25.0 |
| gl_account | str | 0 | 0.0 | 6 | 100000 | 600000 |
| debit_credit_indicator | str | 0 | 0.0 | 2 | C | D |
| amount | float64 | 0 | 0.0 | 2249 | 27.75 | 2417125.24 |
| profit_center | str | 926 | 20.46 | 15 | PC001 | PC015 |
| order_id | str | 926 | 20.46 | 1800 | ORD000001 | ORD003000 |
| currency | str | 0 | 0.0 | 1 | BRL | BRL |
| document_type | str | 0 | 0.0 | 3 | KR | RV |

## dw.fact_inventory_movement

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| movement_key | int64 | 0 | 0.0 | 1828 | 1 | 1828 |
| movement_id | str | 0 | 0.0 | 1828 | MOV000001 | MOV001828 |
| material_id | str | 0 | 0.0 | 394 | MAT00001 | MAT00400 |
| warehouse_key | int64 | 0 | 0.0 | 8 | 1 | 8 |
| product_key | int64 | 0 | 0.0 | 394 | 1 | 400 |
| date_key | int64 | 0 | 0.0 | 685 | 20230101 | 20250201 |
| movement_type | str | 0 | 0.0 | 3 | GI_261_Goods_Issue_Production | GR_101_Goods_Receipt |
| quantity | int64 | 0 | 0.0 | 597 | -200 | 500 |
| reference_document | str | 0 | 0.0 | 1809 | DELV000002 | PRO000499 |

## dw.fact_payroll

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| payroll_key | object | 0 | 0.0 | 0 |  |  |
| payroll_id | object | 0 | 0.0 | 0 |  |  |
| employee_key | object | 0 | 0.0 | 0 |  |  |
| date_key | object | 0 | 0.0 | 0 |  |  |
| pay_period | object | 0 | 0.0 | 0 |  |  |
| gross_pay | object | 0 | 0.0 | 0 |  |  |
| deductions | object | 0 | 0.0 | 0 |  |  |
| net_pay | object | 0 | 0.0 | 0 |  |  |

## dw.fact_procurement

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| procurement_key | int64 | 0 | 0.0 | 1209 | 1 | 1209 |
| po_id | str | 0 | 0.0 | 600 | PO000001 | PO000600 |
| po_item | int64 | 0 | 0.0 | 3 | 1 | 3 |
| date_key | int64 | 0 | 0.0 | 420 | 20230102 | 20241231 |
| vendor_key | int64 | 0 | 0.0 | 146 | 2 | 150 |
| product_key | int64 | 0 | 0.0 | 374 | 1 | 400 |
| company_key | int64 | 0 | 0.0 | 1 | 1 | 1 |
| plant | str | 0 | 0.0 | 3 | PL01 | PL03 |
| quantity | int64 | 0 | 0.0 | 448 | 10 | 500 |
| unit_price | float64 | 0 | 0.0 | 1199 | 8.34 | 649.33 |
| total_amount | float64 | 0 | 0.0 | 1209 | 164.32 | 311299.52 |
| currency | str | 0 | 0.0 | 1 | BRL | BRL |

## dw.fact_production

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| production_key | int64 | 0 | 0.0 | 500 | 1 | 500 |
| production_order_id | str | 0 | 0.0 | 500 | PRO000001 | PRO000500 |
| date_key | int64 | 0 | 0.0 | 362 | 20230102 | 20241230 |
| material_key | int64 | 0 | 0.0 | 239 | 1 | 399 |
| work_center_key | int64 | 0 | 0.0 | 15 | 1 | 15 |
| plant | str | 0 | 0.0 | 3 | PL01 | PL03 |
| order_quantity | int64 | 0 | 0.0 | 441 | 63 | 1997 |
| status | str | 0 | 0.0 | 4 | Completed | Planned |

## dw.fact_sales

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| sales_key | int64 | 0 | 0.0 | 4735 | 1 | 4735 |
| order_id | str | 0 | 0.0 | 3000 | ORD000001 | ORD003000 |
| order_item_id | int64 | 0 | 0.0 | 4 | 1 | 4 |
| date_key | int64 | 0 | 0.0 | 721 | 20230101 | 20241231 |
| customer_key | int64 | 0 | 0.0 | 1537 | 1 | 2000 |
| product_key | int64 | 0 | 0.0 | 400 | 1 | 400 |
| vendor_key | int64 | 0 | 0.0 | 150 | 1 | 150 |
| price | float64 | 0 | 0.0 | 4607 | 15.11 | 899.99 |
| freight_value | float64 | 0 | 0.0 | 3520 | 5.01 | 79.98 |

## staging.co_cost_centers

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| cost_center | str | 0 | 0.0 | 25 | CC0001 | CC0025 |
| cost_center_name | str | 0 | 0.0 | 25 | Finance Cost Center 13 | Warehouse Cost Center 5 |
| department | str | 0 | 0.0 | 10 | Finance | Warehouse |
| company_code | str | 0 | 0.0 | 1 | 1000.0 | 1000.0 |
| responsible_person | str | 0 | 0.0 | 25 | Angelica Tucker | Tricia Valencia |

## staging.co_postings

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| posting_id | str | 0 | 0.0 | 750 | COP000001 | COP001499 |
| cost_center | str | 0 | 0.0 | 25 | CC0001 | CC0025 |
| gl_account | str | 0 | 0.0 | 5 | 400000 | 440000 |
| fiscal_year | int64 | 0 | 0.0 | 2 | 2023 | 2024 |
| period | int64 | 0 | 0.0 | 12 | 1 | 12 |
| amount | float64 | 0 | 0.0 | 750 | 553.77 | 49968.99 |
| posting_date | datetime64[us] | 0 | 0.0 | 464 | 2023-01-02 00:00:00 | 2024-12-31 00:00:00 |

## staging.co_profit_centers

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| profit_center | str | 0 | 0.0 | 15 | PC001 | PC015 |
| profit_center_name | str | 0 | 0.0 | 15 | Corporate Profit Center | Wholesale Profit Center |
| business_area | str | 0 | 0.0 | 15 | Corporate | Wholesale |

## staging.crm_interactions

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| interaction_id | str | 0 | 0.0 | 1500 | INT000001 | INT001500 |
| customer_id | str | 0 | 0.0 | 1045 | CUNQ000001 | CUNQ001997 |
| interaction_type | str | 0 | 0.0 | 5 | Chat | Support Ticket |
| interaction_date | object | 0 | 0.0 | 641 | 2023-01-01 | 2024-12-31 |
| channel | str | 0 | 0.0 | 5 | Email | Web Chat |
| notes | str | 0 | 0.0 | 1500 | A at teach enter lot at life w | Your long heavy what least mou |
| related_order_id | str | 578 | 38.53 | 777 | ORD000013 | ORD002999 |

## staging.crm_leads

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| lead_id | str | 0 | 0.0 | 600 | LEAD00001 | LEAD00600 |
| customer_id | str | 0 | 0.0 | 527 | CUNQ000002 | CUNQ001995 |
| lead_source | str | 0 | 0.0 | 6 | Cold Call | Website |
| lead_status | str | 0 | 0.0 | 5 | Contacted | Qualified |
| created_date | object | 0 | 0.0 | 417 | 2023-01-02 | 2024-12-31 |
| owner_employee_id | str | 0 | 0.0 | 19 | EMP00016 | EMP00249 |

## staging.crm_opportunities

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| opportunity_id | str | 0 | 0.0 | 151 | OPP00001 | OPP00151 |
| lead_id | str | 0 | 0.0 | 151 | LEAD00003 | LEAD00600 |
| customer_id | str | 0 | 0.0 | 146 | CUNQ000002 | CUNQ001994 |
| opportunity_stage | str | 0 | 0.0 | 4 | Closed Lost | Proposal Sent |
| expected_value | float64 | 0 | 0.0 | 151 | 276.69 | 14959.48 |
| close_date | object | 0 | 0.0 | 133 | 2023-01-27 | 2025-01-22 |

## staging.fi_ap_invoices

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| invoice_id | str | 0 | 0.0 | 460 | APINV000001 | APINV000460 |
| po_id | str | 0 | 0.0 | 460 | PO000002 | PO000599 |
| vendor_id | str | 0 | 0.0 | 142 | VEND00002 | VEND00150 |
| invoice_date | datetime64[us] | 0 | 0.0 | 346 | 2023-01-13 00:00:00 | 2025-01-14 00:00:00 |
| due_date | datetime64[us] | 0 | 0.0 | 346 | 2023-02-27 00:00:00 | 2025-02-28 00:00:00 |
| amount | float64 | 0 | 0.0 | 460 | 1129.62 | 59838.88 |
| currency | str | 0 | 0.0 | 1 | BRL | BRL |
| payment_status | str | 0 | 0.0 | 3 | Open | Paid |

## staging.fi_ar_invoices

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| invoice_id | str | 0 | 0.0 | 3000 | ARINV000001 | ARINV003000 |
| order_id | str | 0 | 0.0 | 3000 | ORD000001 | ORD003000 |
| customer_id | str | 0 | 0.0 | 1537 | CUST000001 | CUST002000 |
| invoice_date | datetime64[us] | 0 | 0.0 | 3000 | 2023-01-01 10:48:29 | 2024-12-31 20:12:24 |
| due_date | datetime64[us] | 0 | 0.0 | 3000 | 2023-01-31 10:48:29 | 2025-01-30 20:12:24 |
| amount | float64 | 0 | 0.0 | 2965 | 27.75 | 2914.37 |
| currency | str | 0 | 0.0 | 1 | BRL | BRL |
| payment_status | str | 0 | 0.0 | 3 | Cancelled | Paid |

## staging.fi_gl_accounts

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| gl_account | str | 0 | 0.0 | 17 | 100000 | 610000 |
| account_name | str | 0 | 0.0 | 17 | Accounts Payable | Warehouse & Logistics Costs |
| account_type | str | 0 | 0.0 | 5 | Asset | Revenue |
| account_group | str | 0 | 0.0 | 2 | Balance Sheet | P&L |

## staging.fi_journal_entries

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| document_number | str | 0 | 0.0 | 2263 | JE0000001 | JE0002263 |
| company_code | str | 0 | 0.0 | 1 | 1000 | 1000 |
| fiscal_year | int64 | 0 | 0.0 | 3 | 2023 | 2025 |
| posting_date | datetime64[us] | 0 | 0.0 | 2148 | 2023-01-01 12:26:31 | 2025-01-14 00:00:00 |
| document_date | datetime64[us] | 0 | 0.0 | 2148 | 2023-01-01 12:26:31 | 2025-01-14 00:00:00 |
| document_type | str | 0 | 0.0 | 3 | KR | RV |
| currency | str | 0 | 0.0 | 1 | BRL | BRL |
| reference | str | 0 | 0.0 | 2263 | APINV000001 | PAYROLL-2024-03 |
| created_by | str | 0 | 0.0 | 2226 | aaronkelly | zwelch |

## staging.fi_journal_entry_items

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| document_number | str | 0 | 0.0 | 2263 | JE0000001 | JE0002263 |
| line_item | int64 | 0 | 0.0 | 2 | 1 | 2 |
| gl_account | str | 0 | 0.0 | 6 | 100000 | 600000 |
| debit_credit_indicator | str | 0 | 0.0 | 2 | C | D |
| amount | float64 | 0 | 0.0 | 2249 | 27.75 | 2417125.24 |
| cost_center | str | 3600 | 79.54 | 25 | CC0001 | CC0025 |
| profit_center | str | 926 | 20.46 | 15 | PC001 | PC015 |
| order_id | str | 926 | 20.46 | 1800 | ORD000001 | ORD003000 |

## staging.hcm_departments

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| department_id | str | 0 | 0.0 | 12 | DEPT001 | DEPT012 |
| department_name | str | 0 | 0.0 | 12 | Customer Service | Warehouse |
| company_code | str | 0 | 0.0 | 1 | 1000 | 1000 |
| cost_center | str | 0 | 0.0 | 11 | CC0001 | CC0023 |

## staging.hcm_employees

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| employee_id | str | 0 | 0.0 | 250 | EMP00001 | EMP00250 |
| employee_name | str | 0 | 0.0 | 250 | Aaron Bell | William Wilson |
| department_id | str | 0 | 0.0 | 12 | DEPT001 | DEPT012 |
| position_id | str | 0 | 0.0 | 33 | POS0001 | POS0034 |
| hire_date | object | 0 | 0.0 | 244 | 2018-01-02 | 2024-12-19 |
| employment_status | str | 0 | 0.0 | 3 | Active | Terminated |
| location | str | 0 | 0.0 | 250 | Alyssaview | Zacharyside |

## staging.hcm_payroll

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| payroll_id | str | 0 | 0.0 | 723 | PAY000001 | PAY000723 |
| employee_id | str | 0 | 0.0 | 241 | EMP00002 | EMP00250 |
| pay_period | str | 0 | 0.0 | 3 | 2024-01 | 2024-03 |
| gross_pay | float64 | 0 | 0.0 | 241 | 2711.95 | 17952.65 |
| deductions | float64 | 0 | 0.0 | 722 | 286.77 | 3882.92 |
| net_pay | float64 | 0 | 0.0 | 723 | 2145.42 | 15713.11 |
| pay_date | object | 0 | 0.0 | 3 | 2024-01-28 | 2024-03-28 |

## staging.hcm_positions

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| position_id | str | 0 | 0.0 | 34 | POS0001 | POS0034 |
| position_title | str | 0 | 0.0 | 34 | Analyst - Procurement | Team Lead - Sales |
| department_id | str | 0 | 0.0 | 12 | DEPT001 | DEPT012 |

## staging.mm_goods_receipts

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| gr_id | str | 0 | 0.0 | 928 | GR000001 | GR000928 |
| po_id | str | 0 | 0.0 | 460 | PO000002 | PO000599 |
| po_item | int64 | 0 | 0.0 | 3 | 1 | 3 |
| material_id | str | 0 | 0.0 | 353 | MAT00001 | MAT00400 |
| quantity | int64 | 0 | 0.0 | 424 | 8 | 500 |
| gr_date | object | 0 | 0.0 | 524 | 2023-01-15 | 2025-02-01 |
| plant | str | 0 | 0.0 | 3 | PL01 | PL03 |
| warehouse | str | 0 | 0.0 | 8 | WH01 | WH08 |

## staging.mm_material_master

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| material_id | str | 0 | 0.0 | 400 | MAT00001 | MAT00400 |
| product_id | str | 0 | 0.0 | 400 | PROD00001 | PROD00400 |
| material_type | str | 0 | 0.0 | 2 | FERT | HALB |
| base_unit | str | 0 | 0.0 | 1 | EA | EA |
| material_group | str | 0 | 0.0 | 40 | air_conditioning | watches_gifts |
| standard_price | float64 | 0 | 0.0 | 400 | 10.06 | 697.91 |

## staging.mm_purchase_order_items

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| po_id | str | 0 | 0.0 | 600 | PO000001 | PO000600 |
| po_item | int64 | 0 | 0.0 | 3 | 1 | 3 |
| material_id | str | 0 | 0.0 | 374 | MAT00001 | MAT00400 |
| quantity | int64 | 0 | 0.0 | 448 | 10 | 500 |
| unit_price | float64 | 0 | 0.0 | 1199 | 8.34 | 649.33 |
| delivery_date | object | 0 | 0.0 | 582 | 2023-01-11 | 2025-01-30 |
| plant | str | 0 | 0.0 | 3 | PL01 | PL03 |

## staging.mm_purchase_orders

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| po_id | str | 0 | 0.0 | 600 | PO000001 | PO000600 |
| vendor_id | str | 0 | 0.0 | 146 | VEND00002 | VEND00150 |
| po_date | object | 0 | 0.0 | 420 | 2023-01-02 | 2024-12-31 |
| company_code | str | 0 | 0.0 | 1 | 1000.0 | 1000.0 |
| currency | str | 0 | 0.0 | 1 | BRL | BRL |
| status | str | 0 | 0.0 | 4 | Cancelled | Partially Received |

## staging.mm_vendors

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| vendor_id | str | 0 | 0.0 | 150 | VEND00001 | VEND00150 |
| vendor_name | str | 0 | 0.0 | 149 | Adams, Christian and Rivas | Yu Inc |
| seller_id | str | 0 | 0.0 | 150 | SELL00001 | SELL00150 |
| country | str | 0 | 0.0 | 1 | BR | BR |
| payment_terms | str | 0 | 0.0 | 4 | NET15 | NET60 |
| currency | str | 0 | 0.0 | 1 | BRL | BRL |

## staging.olist_customers

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| customer_id | str | 0 | 0.0 | 2000 | CUST000001 | CUST002000 |
| customer_unique_id | str | 0 | 0.0 | 2000 | CUNQ000001 | CUNQ002000 |
| customer_zip_code_prefix | str | 0 | 0.0 | 1972 | 10012 | 99959 |
| customer_city | str | 0 | 0.0 | 61 | ananindeua | vitoria da conquista |
| customer_state | str | 0 | 0.0 | 27 | AC | TO |

## staging.olist_geolocation

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| geolocation_zip_code_prefix | str | 0 | 0.0 | 990 | 10110 | 99850 |
| geolocation_lat | float64 | 0 | 0.0 | 1000 | -32.996749 | 4.924173 |
| geolocation_lng | float64 | 0 | 0.0 | 1000 | -72.979369 | -35.038494 |
| geolocation_city | str | 0 | 0.0 | 61 | ananindeua | vitoria da conquista |
| geolocation_state | str | 0 | 0.0 | 27 | AC | TO |

## staging.olist_order_items

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| order_id | str | 0 | 0.0 | 3000 | ORD000001 | ORD003000 |
| order_item_id | int64 | 0 | 0.0 | 4 | 1 | 4 |
| product_id | str | 0 | 0.0 | 400 | PROD00001 | PROD00400 |
| seller_id | str | 0 | 0.0 | 150 | SELL00001 | SELL00150 |
| shipping_limit_date | datetime64[us] | 0 | 0.0 | 4735 | 2023-01-01 15:56:25 | 2024-12-31 23:59:31 |
| price | float64 | 0 | 0.0 | 4607 | 15.11 | 899.99 |
| freight_value | float64 | 0 | 0.0 | 3520 | 5.01 | 79.98 |

## staging.olist_order_payments

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| order_id | str | 0 | 0.0 | 3000 | ORD000001 | ORD003000 |
| payment_sequential | int64 | 0 | 0.0 | 2 | 1 | 2 |
| payment_type | str | 0 | 0.0 | 4 | boleto | voucher |
| payment_installments | int64 | 0 | 0.0 | 5 | 1 | 10 |
| payment_value | float64 | 0 | 0.0 | 3443 | 15.25 | 2893.22 |

## staging.olist_order_reviews

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| review_id | str | 0 | 0.0 | 2867 | REV000001 | REV003000 |
| order_id | str | 0 | 0.0 | 2867 | ORD000001 | ORD003000 |
| review_score | int64 | 0 | 0.0 | 5 | 1 | 5 |
| review_comment_title | str | 2017 | 70.35 | 850 | Ability election parent. | Your above short Congress turn |
| review_comment_message | str | 1416 | 49.39 | 1451 | A avoid choice media church to | Yourself whether discuss altho |
| review_creation_date | datetime64[us] | 0 | 0.0 | 2867 | 2023-01-01 02:15:39 | 2024-12-31 03:33:48 |
| review_answer_timestamp | datetime64[us] | 0 | 0.0 | 2867 | 2023-01-02 06:55:11 | 2025-01-05 03:33:48 |

## staging.olist_orders

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| order_id | str | 0 | 0.0 | 3000 | ORD000001 | ORD003000 |
| customer_id | str | 0 | 0.0 | 1537 | CUST000001 | CUST002000 |
| order_status | str | 0 | 0.0 | 6 | approved | shipped |
| order_purchase_timestamp | datetime64[us] | 0 | 0.0 | 3000 | 2023-01-01 10:48:29 | 2024-12-31 20:12:24 |
| order_approved_at | datetime64[us] | 127 | 4.23 | 2873 | 2023-01-01 18:48:29 | 2025-01-02 06:12:24 |
| order_delivered_carrier_date | datetime64[us] | 478 | 15.93 | 2522 | 2023-01-03 04:26:31 | 2025-01-05 04:23:17 |
| order_delivered_customer_date | datetime64[us] | 679 | 22.63 | 2321 | 2023-01-05 08:34:40 | 2025-01-14 23:20:33 |
| order_estimated_delivery_date | datetime64[us] | 0 | 0.0 | 3000 | 2023-01-09 07:34:40 | 2025-01-25 20:12:24 |

## staging.olist_products

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| product_id | str | 0 | 0.0 | 400 | PROD00001 | PROD00400 |
| product_category_name | str | 0 | 0.0 | 40 | air_conditioning | watches_gifts |
| product_name_lenght | int64 | 0 | 0.0 | 46 | 15 | 60 |
| product_description_lenght | int64 | 0 | 0.0 | 378 | 137 | 2978 |
| product_photos_qty | int64 | 0 | 0.0 | 8 | 1 | 8 |
| product_weight_g | float64 | 0 | 0.0 | 393 | 66.0 | 19958.0 |
| product_length_cm | float64 | 0 | 0.0 | 95 | 5.0 | 100.0 |
| product_height_cm | float64 | 0 | 0.0 | 79 | 2.0 | 80.0 |
| product_width_cm | float64 | 0 | 0.0 | 86 | 5.0 | 90.0 |

## staging.olist_sellers

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| seller_id | str | 0 | 0.0 | 150 | SELL00001 | SELL00150 |
| seller_zip_code_prefix | str | 0 | 0.0 | 149 | 10860 | 99694 |
| seller_city | str | 0 | 0.0 | 51 | ananindeua | vitoria da conquista |
| seller_state | str | 0 | 0.0 | 27 | AC | TO |

## staging.pp_bom

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| bom_id | str | 0 | 0.0 | 571 | BOM000001 | BOM000571 |
| material_id | str | 0 | 0.0 | 291 | MAT00001 | MAT00399 |
| component_material_id | str | 0 | 0.0 | 109 | MAT00005 | MAT00400 |
| quantity | float64 | 0 | 0.0 | 419 | 1.02 | 10.0 |
| unit | str | 0 | 0.0 | 1 | EA | EA |

## staging.pp_production_orders

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| production_order_id | str | 0 | 0.0 | 500 | PRO000001 | PRO000500 |
| material_id | str | 0 | 0.0 | 239 | MAT00001 | MAT00399 |
| plant | str | 0 | 0.0 | 3 | PL01 | PL03 |
| work_center_id | str | 0 | 0.0 | 15 | WC001 | WC015 |
| order_quantity | int64 | 0 | 0.0 | 441 | 63 | 1997 |
| planned_start_date | object | 0 | 0.0 | 362 | 2023-01-02 | 2024-12-30 |
| planned_end_date | object | 0 | 0.0 | 362 | 2023-01-04 | 2025-01-09 |
| actual_start_date | object | 66 | 13.2 | 321 | 2023-01-03 | 2024-12-31 |
| actual_end_date | object | 165 | 33.0 | 269 | 2023-01-07 | 2025-01-12 |
| status | str | 0 | 0.0 | 4 | Completed | Planned |

## staging.pp_work_centers

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| work_center_id | str | 0 | 0.0 | 15 | WC001 | WC015 |
| work_center_name | str | 0 | 0.0 | 15 | Assembly Line 1 | Welding Line 6 |
| plant | str | 0 | 0.0 | 2 | PL01 | PL03 |
| capacity_hours | float64 | 0 | 0.0 | 10 | 8.0 | 24.0 |

## staging.product_category_translation

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| product_category_name | str | 0 | 0.0 | 40 | air_conditioning | watches_gifts |
| product_category_name_english | str | 0 | 0.0 | 40 | air_conditioning | watches_gifts |

## staging.wm_inventory_balance

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| warehouse_id | str | 0 | 0.0 | 8 | WH01 | WH08 |
| material_id | str | 0 | 0.0 | 394 | MAT00001 | MAT00400 |
| quantity_on_hand | int64 | 0 | 0.0 | 424 | 0 | 1009 |
| as_of_date | object | 0 | 0.0 | 1 | 2024-12-31 | 2024-12-31 |

## staging.wm_stock_movements

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| movement_id | str | 0 | 0.0 | 1828 | MOV000001 | MOV001828 |
| material_id | str | 0 | 0.0 | 394 | MAT00001 | MAT00400 |
| warehouse_id | str | 0 | 0.0 | 8 | WH01 | WH08 |
| movement_type | str | 0 | 0.0 | 3 | GI_261_Goods_Issue_Production | GR_101_Goods_Receipt |
| quantity | int64 | 0 | 0.0 | 597 | -200 | 500 |
| movement_date | object | 0 | 0.0 | 685 | 2023-01-01 | 2025-02-01 |
| reference_document | str | 0 | 0.0 | 1809 | DELV000002 | PRO000499 |

## staging.wm_storage_bins

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| bin_id | str | 0 | 0.0 | 160 | BIN00001 | BIN00160 |
| warehouse_id | str | 0 | 0.0 | 8 | WH01 | WH08 |
| storage_type | str | 0 | 0.0 | 4 | Bin | Rack |
| capacity | int64 | 0 | 0.0 | 156 | 122 | 4965 |

## staging.wm_warehouses

| Column | Type | Nulls | Null % | Distinct | Min | Max |
|---|---|---:|---:|---:|---|---|
| warehouse_id | str | 0 | 0.0 | 8 | WH01 | WH08 |
| warehouse_name | str | 0 | 0.0 | 8 | Distribution Center 1 | Distribution Center 8 |
| plant | str | 0 | 0.0 | 3 | PL01 | PL03 |
| city | str | 0 | 0.0 | 8 | belo horizonte | sao paulo |
| state | str | 0 | 0.0 | 8 | BA | SP |