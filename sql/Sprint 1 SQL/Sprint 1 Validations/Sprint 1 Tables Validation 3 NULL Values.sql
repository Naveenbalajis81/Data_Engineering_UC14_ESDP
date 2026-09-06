SELECT 'co_cost_centers' AS table_name, COUNT(*) AS null_count
FROM staging.co_cost_centers
WHERE cost_center IS NULL

UNION ALL
SELECT 'co_profit_centers', COUNT(*)
FROM staging.co_profit_centers
WHERE profit_center IS NULL

UNION ALL
SELECT 'co_postings', COUNT(*)
FROM staging.co_postings
WHERE posting_id IS NULL
   OR cost_center IS NULL
   OR gl_account IS NULL

UNION ALL
SELECT 'crm_leads', COUNT(*)
FROM staging.crm_leads
WHERE lead_id IS NULL

UNION ALL
SELECT 'crm_opportunities', COUNT(*)
FROM staging.crm_opportunities
WHERE opportunity_id IS NULL

UNION ALL
SELECT 'crm_interactions', COUNT(*)
FROM staging.crm_interactions
WHERE interaction_id IS NULL

UNION ALL
SELECT 'fi_gl_accounts', COUNT(*)
FROM staging.fi_gl_accounts
WHERE gl_account IS NULL

UNION ALL
SELECT 'fi_journal_entries', COUNT(*)
FROM staging.fi_journal_entries
WHERE document_number IS NULL

UNION ALL
SELECT 'fi_journal_entry_items', COUNT(*)
FROM staging.fi_journal_entry_items
WHERE document_number IS NULL
   OR line_item IS NULL
   OR gl_account IS NULL

UNION ALL
SELECT 'fi_ar_invoices', COUNT(*)
FROM staging.fi_ar_invoices
WHERE invoice_id IS NULL

UNION ALL
SELECT 'fi_ap_invoices', COUNT(*)
FROM staging.fi_ap_invoices
WHERE invoice_id IS NULL

UNION ALL
SELECT 'mm_vendors', COUNT(*)
FROM staging.mm_vendors
WHERE vendor_id IS NULL

UNION ALL
SELECT 'mm_material_master', COUNT(*)
FROM staging.mm_material_master
WHERE material_id IS NULL

UNION ALL
SELECT 'mm_purchase_orders', COUNT(*)
FROM staging.mm_purchase_orders
WHERE po_id IS NULL

UNION ALL
SELECT 'mm_purchase_order_items', COUNT(*)
FROM staging.mm_purchase_order_items
WHERE po_id IS NULL
   OR po_item IS NULL

UNION ALL
SELECT 'mm_goods_receipts', COUNT(*)
FROM staging.mm_goods_receipts
WHERE gr_id IS NULL

UNION ALL
SELECT 'pp_work_centers', COUNT(*)
FROM staging.pp_work_centers
WHERE work_center_id IS NULL

UNION ALL
SELECT 'pp_bom', COUNT(*)
FROM staging.pp_bom
WHERE bom_id IS NULL

UNION ALL
SELECT 'pp_production_orders', COUNT(*)
FROM staging.pp_production_orders
WHERE production_order_id IS NULL

UNION ALL
SELECT 'wm_warehouses', COUNT(*)
FROM staging.wm_warehouses
WHERE warehouse_id IS NULL

UNION ALL
SELECT 'wm_storage_bins', COUNT(*)
FROM staging.wm_storage_bins
WHERE bin_id IS NULL

UNION ALL
SELECT 'wm_inventory_balance', COUNT(*)
FROM staging.wm_inventory_balance
WHERE warehouse_id IS NULL
   OR material_id IS NULL

UNION ALL
SELECT 'wm_stock_movements', COUNT(*)
FROM staging.wm_stock_movements
WHERE movement_id IS NULL
   OR material_id IS NULL
   OR warehouse_id IS NULL;