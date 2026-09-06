SELECT 'co_cost_centers' AS table_name, cost_center AS key_value, COUNT(*) AS duplicate_count
FROM staging.co_cost_centers
GROUP BY cost_center
HAVING COUNT(*) > 1

UNION ALL

SELECT 'co_profit_centers', profit_center, COUNT(*)
FROM staging.co_profit_centers
GROUP BY profit_center
HAVING COUNT(*) > 1

UNION ALL

SELECT 'co_postings', posting_id, COUNT(*)
FROM staging.co_postings
GROUP BY posting_id
HAVING COUNT(*) > 1

UNION ALL

SELECT 'crm_leads', lead_id, COUNT(*)
FROM staging.crm_leads
GROUP BY lead_id
HAVING COUNT(*) > 1

UNION ALL

SELECT 'crm_opportunities', opportunity_id, COUNT(*)
FROM staging.crm_opportunities
GROUP BY opportunity_id
HAVING COUNT(*) > 1

UNION ALL

SELECT 'crm_interactions', interaction_id, COUNT(*)
FROM staging.crm_interactions
GROUP BY interaction_id
HAVING COUNT(*) > 1

UNION ALL

SELECT 'fi_gl_accounts', gl_account, COUNT(*)
FROM staging.fi_gl_accounts
GROUP BY gl_account
HAVING COUNT(*) > 1

UNION ALL

SELECT 'fi_journal_entries', document_number, COUNT(*)
FROM staging.fi_journal_entries
GROUP BY document_number
HAVING COUNT(*) > 1

UNION ALL

SELECT 'fi_journal_entry_items',
       document_number || '-' || line_item,
       COUNT(*)
FROM staging.fi_journal_entry_items
GROUP BY document_number, line_item
HAVING COUNT(*) > 1

UNION ALL

SELECT 'wm_warehouses', warehouse_id, COUNT(*)
FROM staging.wm_warehouses
GROUP BY warehouse_id
HAVING COUNT(*) > 1

UNION ALL

SELECT 'wm_storage_bins', bin_id, COUNT(*)
FROM staging.wm_storage_bins
GROUP BY bin_id
HAVING COUNT(*) > 1

UNION ALL

SELECT 'wm_stock_movements', movement_id, COUNT(*)
FROM staging.wm_stock_movements
GROUP BY movement_id
HAVING COUNT(*) > 1;