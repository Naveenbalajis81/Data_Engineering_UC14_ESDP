WITH checks AS (

    /* 1. CO Postings → Cost Centers */
    SELECT
        'CO Postings → CO Cost Centers' AS validation,
        COUNT(*) AS errors
    FROM staging.co_postings p
    LEFT JOIN staging.co_cost_centers c
        ON p.cost_center = c.cost_center
    WHERE c.cost_center IS NULL

    UNION ALL

    /* 2. CO Postings → FI GL Accounts */
    SELECT
        'CO Postings → FI GL Accounts',
        COUNT(*)
    FROM staging.co_postings p
    LEFT JOIN staging.fi_gl_accounts g
        ON p.gl_account = g.gl_account
    WHERE g.gl_account IS NULL

    UNION ALL

    /* 3. CRM Opportunities → Leads */
    SELECT
        'CRM Opportunities → Leads',
        COUNT(*)
    FROM staging.crm_opportunities o
    LEFT JOIN staging.crm_leads l
        ON o.lead_id = l.lead_id
    WHERE l.lead_id IS NULL

    UNION ALL

    /* 4. CRM Leads → HCM Employees */
    SELECT
        'CRM Leads → HCM Employees',
        COUNT(*)
    FROM staging.crm_leads l
    LEFT JOIN staging.hcm_employees e
        ON l.owner_employee_id = e.employee_id
    WHERE l.owner_employee_id IS NOT NULL
      AND e.employee_id IS NULL

    UNION ALL

    /* 5. MM Vendors → Olist Sellers */
    SELECT
        'MM Vendors → Olist Sellers',
        COUNT(*)
    FROM staging.mm_vendors v
    LEFT JOIN staging.olist_sellers s
        ON v.seller_id = s.seller_id
    WHERE v.seller_id IS NOT NULL
      AND s.seller_id IS NULL

    UNION ALL

    /* 6. MM Materials → Olist Products */
    SELECT
        'MM Materials → Olist Products',
        COUNT(*)
    FROM staging.mm_material_master m
    LEFT JOIN staging.olist_products p
        ON m.product_id = p.product_id
    WHERE m.product_id IS NOT NULL
      AND p.product_id IS NULL

    UNION ALL

    /* 7. Purchase Orders → Vendors */
    SELECT
        'MM Purchase Orders → Vendors',
        COUNT(*)
    FROM staging.mm_purchase_orders po
    LEFT JOIN staging.mm_vendors v
        ON po.vendor_id = v.vendor_id
    WHERE v.vendor_id IS NULL

    UNION ALL

    /* 8. PO Items → Purchase Orders */
    SELECT
        'MM PO Items → Purchase Orders',
        COUNT(*)
    FROM staging.mm_purchase_order_items i
    LEFT JOIN staging.mm_purchase_orders po
        ON i.po_id = po.po_id
    WHERE po.po_id IS NULL

    UNION ALL

    /* 9. PO Items → Materials */
    SELECT
        'MM PO Items → Materials',
        COUNT(*)
    FROM staging.mm_purchase_order_items i
    LEFT JOIN staging.mm_material_master m
        ON i.material_id = m.material_id
    WHERE m.material_id IS NULL

    UNION ALL

    /* 10. Goods Receipts → PO Items */
    SELECT
        'MM Goods Receipts → PO Items',
        COUNT(*)
    FROM staging.mm_goods_receipts gr
    LEFT JOIN staging.mm_purchase_order_items i
        ON gr.po_id = i.po_id
       AND gr.po_item = i.po_item
    WHERE i.po_id IS NULL

    UNION ALL

    /* 11. Goods Receipts → Materials */
    SELECT
        'MM Goods Receipts → Materials',
        COUNT(*)
    FROM staging.mm_goods_receipts gr
    LEFT JOIN staging.mm_material_master m
        ON gr.material_id = m.material_id
    WHERE m.material_id IS NULL

    UNION ALL

    /* 12. PP Production Orders → Materials */
    SELECT
        'PP Production Orders → Materials',
        COUNT(*)
    FROM staging.pp_production_orders p
    LEFT JOIN staging.mm_material_master m
        ON p.material_id = m.material_id
    WHERE m.material_id IS NULL

    UNION ALL

    /* 13. PP Production Orders → Work Centers */
    SELECT
        'PP Production Orders → Work Centers',
        COUNT(*)
    FROM staging.pp_production_orders p
    LEFT JOIN staging.pp_work_centers w
        ON p.work_center_id = w.work_center_id
    WHERE w.work_center_id IS NULL

    UNION ALL

    /* 14. PP BOM → Materials */
    SELECT
        'PP BOM → Materials',
        COUNT(*)
    FROM staging.pp_bom b
    LEFT JOIN staging.mm_material_master m
        ON b.material_id = m.material_id
    WHERE m.material_id IS NULL

    UNION ALL

    /* 15. PP BOM Components → Materials */
    SELECT
        'PP BOM Components → Materials',
        COUNT(*)
    FROM staging.pp_bom b
    LEFT JOIN staging.mm_material_master m
        ON b.component_material_id = m.material_id
    WHERE m.material_id IS NULL

    UNION ALL

    /* 16. WM Storage Bins → Warehouses */
    SELECT
        'WM Storage Bins → Warehouses',
        COUNT(*)
    FROM staging.wm_storage_bins b
    LEFT JOIN staging.wm_warehouses w
        ON b.warehouse_id = w.warehouse_id
    WHERE w.warehouse_id IS NULL

    UNION ALL

    /* 17. WM Inventory → Warehouses */
    SELECT
        'WM Inventory → Warehouses',
        COUNT(*)
    FROM staging.wm_inventory_balance i
    LEFT JOIN staging.wm_warehouses w
        ON i.warehouse_id = w.warehouse_id
    WHERE w.warehouse_id IS NULL

    UNION ALL

    /* 18. WM Inventory → Materials */
    SELECT
        'WM Inventory → Materials',
        COUNT(*)
    FROM staging.wm_inventory_balance i
    LEFT JOIN staging.mm_material_master m
        ON i.material_id = m.material_id
    WHERE m.material_id IS NULL

    UNION ALL

    /* 19. WM Stock Movements → Warehouses */
    SELECT
        'WM Stock Movements → Warehouses',
        COUNT(*)
    FROM staging.wm_stock_movements sm
    LEFT JOIN staging.wm_warehouses w
        ON sm.warehouse_id = w.warehouse_id
    WHERE w.warehouse_id IS NULL

    UNION ALL

    /* 20. WM Stock Movements → Materials */
    SELECT
        'WM Stock Movements → Materials',
        COUNT(*)
    FROM staging.wm_stock_movements sm
    LEFT JOIN staging.mm_material_master m
        ON sm.material_id = m.material_id
    WHERE m.material_id IS NULL

    UNION ALL

    /* 21. FI Journal Items → Journal Headers */
    SELECT
        'FI Journal Items → Journal Headers',
        COUNT(*)
    FROM staging.fi_journal_entry_items i
    LEFT JOIN staging.fi_journal_entries j
        ON i.document_number = j.document_number
    WHERE j.document_number IS NULL

    UNION ALL

    /* 22. FI Journal Items → GL Accounts */
    SELECT
        'FI Journal Items → GL Accounts',
        COUNT(*)
    FROM staging.fi_journal_entry_items i
    LEFT JOIN staging.fi_gl_accounts g
        ON i.gl_account = g.gl_account
    WHERE g.gl_account IS NULL

    UNION ALL

    /* 23. FI AR Invoices → Olist Orders */
    SELECT
        'FI AR Invoices → Olist Orders',
        COUNT(*)
    FROM staging.fi_ar_invoices a
    LEFT JOIN staging.olist_orders o
        ON a.order_id = o.order_id
    WHERE a.order_id IS NOT NULL
      AND o.order_id IS NULL

    UNION ALL

    /* 24. FI AP Invoices → Purchase Orders */
    SELECT
        'FI AP Invoices → Purchase Orders',
        COUNT(*)
    FROM staging.fi_ap_invoices a
    LEFT JOIN staging.mm_purchase_orders po
        ON a.po_id = po.po_id
    WHERE a.po_id IS NOT NULL
      AND po.po_id IS NULL
)

SELECT
    validation,
    errors,
    CASE
        WHEN errors = 0 THEN 'PASS'
        ELSE 'FAIL'
    END AS status
FROM checks
ORDER BY
    CASE WHEN errors = 0 THEN 1 ELSE 0 END,
    validation;