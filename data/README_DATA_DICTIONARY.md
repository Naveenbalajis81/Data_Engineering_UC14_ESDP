# ESDP (UC14) — Full Dataset Bundle: Olist + Synthetic SAP Modules

## What this is
A complete, referentially-consistent dataset for the UC14 Enterprise SAP Data
Platform capstone. It has two parts:

1. **`/olist`** — a schema-accurate **replica** of the real Kaggle "Brazilian
   E-Commerce Public Dataset by Olist" (same file names, same columns, same
   data patterns). This stands in for **SAP SD (Sales & Distribution)** and
   part of **SAP CRM**.
2. **`/sap_fi`, `/sap_co`, `/sap_mm`, `/sap_pp`, `/sap_wm`, `/sap_hcm`, `/sap_crm`**
   — synthetic tables generated to complete the remaining SAP modules named
   in the brief, all **foreign-keyed into the Olist tables** so the whole
   bundle behaves like one integrated ERP landscape.

> ⚠️ Note on Olist: the sandbox this was built in cannot reach kaggle.com
> (network is restricted to package registries), so the `/olist` folder is
> **synthetic data matching the real schema exactly**, not a live download.
> Swap in the real CSVs from Kaggle at any time — the column names/types
> match, so no pipeline changes are needed. Real dataset:
> https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

All keys were validated for referential integrity (20/20 checks passed —
every foreign key resolves to a real parent row, no orphans).

---

## Folder → SAP Module mapping

| Folder | SAP Module | Row counts |
|---|---|---|
| `olist/` | SD (Sales & Distribution) + CRM base | 9 files, ~17,700 rows |
| `sap_fi/` | FI (Finance) | 5 files, ~10,266 rows |
| `sap_co/` | CO (Controlling) | 3 files, 1,540 rows |
| `sap_mm/` | MM (Materials Management) | 5 files, 3,287 rows |
| `sap_pp/` | PP (Production Planning) | 3 files, 1,086 rows |
| `sap_wm/` | WM (Warehouse Management) | 4 files, 3,382 rows |
| `sap_hcm/` | HCM (Human Capital Management) | 4 files, 1,019 rows |
| `sap_crm/` | CRM (extended) | 3 files, 2,251 rows |

**34 CSV files, ~40,500 rows total.**

---

## Table-by-table dictionary

### `olist/` (SD + CRM base)
| File | Key columns | Notes |
|---|---|---|
| `olist_customers_dataset.csv` | `customer_id` (PK), `customer_unique_id` | 2,000 customers |
| `olist_sellers_dataset.csv` | `seller_id` (PK) | 150 sellers → becomes MM Vendor |
| `olist_geolocation_dataset.csv` | `geolocation_zip_code_prefix` | Zip/lat/lng reference |
| `olist_products_dataset.csv` | `product_id` (PK) | 400 products → becomes MM Material |
| `product_category_name_translation.csv` | `product_category_name` (PK) | Category lookup |
| `olist_orders_dataset.csv` | `order_id` (PK), `customer_id` (FK) | 3,000 orders (SD sales document) |
| `olist_order_items_dataset.csv` | `order_id`+`order_item_id` (PK), `product_id`/`seller_id` (FK) | Line items |
| `olist_order_payments_dataset.csv` | `order_id` (FK) | Payment installments |
| `olist_order_reviews_dataset.csv` | `order_id` (FK) | CSAT / reviews |

### `sap_fi/` (Finance)
| File | Key columns | Notes |
|---|---|---|
| `fi_gl_accounts.csv` | `gl_account` (PK) | Chart of accounts (17 accounts) |
| `fi_ar_invoices.csv` | `invoice_id` (PK), `order_id` (FK→orders) | Billing document from SD |
| `fi_ap_invoices.csv` | `invoice_id` (PK), `po_id` (FK→MM PO) | Vendor invoice |
| `fi_journal_entries.csv` | `document_number` (PK) | BKPF-style header |
| `fi_journal_entry_items.csv` | `document_number`+`line_item` (PK), `gl_account`/`cost_center` (FK) | BSEG-style lines, always balance D=C |

### `sap_co/` (Controlling)
| File | Key columns | Notes |
|---|---|---|
| `co_cost_centers.csv` | `cost_center` (PK) | 25 cost centers across 10 departments |
| `co_profit_centers.csv` | `profit_center` (PK) | 15 profit centers |
| `co_cost_center_postings.csv` | `posting_id` (PK), `cost_center` (FK) | Cost allocations |

### `sap_mm/` (Materials Management)
| File | Key columns | Notes |
|---|---|---|
| `mm_vendors.csv` | `vendor_id` (PK), `seller_id` (FK→olist sellers) | 1:1 with Olist sellers |
| `mm_material_master.csv` | `material_id` (PK), `product_id` (FK→olist products) | 1:1 with Olist products |
| `mm_purchase_orders.csv` | `po_id` (PK), `vendor_id` (FK) | 600 POs |
| `mm_purchase_order_items.csv` | `po_id`+`po_item` (PK), `material_id` (FK) | Line items |
| `mm_goods_receipts.csv` | `gr_id` (PK), `po_id`/`material_id` (FK) | Inbound receipts |

### `sap_pp/` (Production Planning)
| File | Key columns | Notes |
|---|---|---|
| `pp_work_centers.csv` | `work_center_id` (PK) | 15 work centers |
| `pp_bom.csv` | `bom_id` (PK), `material_id`/`component_material_id` (FK) | Bill of materials |
| `pp_production_orders.csv` | `production_order_id` (PK), `material_id`/`work_center_id` (FK) | 500 orders |

### `sap_wm/` (Warehouse Management)
| File | Key columns | Notes |
|---|---|---|
| `wm_warehouses.csv` | `warehouse_id` (PK) | 8 distribution centers |
| `wm_storage_bins.csv` | `bin_id` (PK), `warehouse_id` (FK) | 160 bins |
| `wm_stock_movements.csv` | `movement_id` (PK), `material_id`/`warehouse_id` (FK) | GR/GI movements incl. links to `gr_id` and `production_order_id` |
| `wm_inventory_balance.csv` | `warehouse_id`+`material_id` (PK) | Derived net on-hand qty |

### `sap_hcm/` (Human Capital Management)
| File | Key columns | Notes |
|---|---|---|
| `hcm_departments.csv` | `department_id` (PK), `cost_center` (FK→CO) | 12 departments |
| `hcm_positions.csv` | `position_id` (PK), `department_id` (FK) | 34 positions |
| `hcm_employees.csv` | `employee_id` (PK), `department_id`/`position_id` (FK) | 250 employees |
| `hcm_payroll.csv` | `payroll_id` (PK), `employee_id` (FK) | 3 monthly pay runs |

### `sap_crm/` (extended CRM)
| File | Key columns | Notes |
|---|---|---|
| `crm_leads.csv` | `lead_id` (PK), `customer_id` (FK→olist `customer_unique_id`), `owner_employee_id` (FK→HCM) | 600 leads |
| `crm_opportunities.csv` | `opportunity_id` (PK), `lead_id`/`customer_id` (FK) | Converted leads only |
| `crm_interactions.csv` | `interaction_id` (PK), `customer_id`/`related_order_id` (FK) | 1,500 touchpoints |

---

## Cross-module integration map (for your Sprint 0 architecture doc)

```
Olist Customer ──┬─→ Olist Order ──┬─→ FI AR Invoice ──→ FI Journal Entry (Revenue)
                  │                 └─→ Order Items ──→ Olist Product
                  └─→ CRM Lead/Interaction

Olist Seller ────→ MM Vendor ──→ MM Purchase Order ──┬─→ FI AP Invoice ──→ FI Journal Entry (COGS)
                                                       └─→ MM Goods Receipt ──→ WM Stock Movement
Olist Product ───→ MM Material ──┬─→ PP BOM / Production Order ──→ WM Stock Movement
                                   └─→ WM Inventory Balance

CO Cost Center ──→ FI Journal Entry lines / HCM Department / Payroll
HCM Employee ────→ CRM Lead Owner / Payroll
```

This mirrors exactly the "cross-functional information for enterprise
reporting, financial reconciliation, and executive decision-making" goal
stated in the UC14 brief — Finance ties back to Sales (AR) and Procurement
(AP), Warehouse ties back to Production and Procurement, and HR/CRM tie back
to organizational structure and customers.

## Suggested use in your Pentaho / PostgreSQL pipeline
- **Sprint 1 (ingestion):** land each folder's CSVs into raw PostgreSQL
  staging tables — one schema per module (`stg_sd`, `stg_fi`, `stg_co`,
  `stg_mm`, `stg_pp`, `stg_wm`, `stg_hcm`, `stg_crm`).
- **Sprint 2 (warehouse):** build a star schema with `fact_sales`,
  `fact_finance_gl`, `fact_procurement`, `fact_production`,
  `fact_inventory_movement`, `fact_payroll`, and shared dimensions
  `dim_customer`, `dim_product_material`, `dim_vendor`, `dim_employee`,
  `dim_cost_center`, `dim_date`.
- **Sprint 3 (lineage/governance):** the FK map above is your source-to-target
  mapping backbone.
