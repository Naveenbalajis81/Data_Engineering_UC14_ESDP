SELECT
    po.vendor_id,
    COUNT(*) AS orphan_count
FROM staging.mm_purchase_orders po
LEFT JOIN staging.mm_vendors v
    ON po.vendor_id = v.vendor_id
WHERE po.vendor_id IS NOT NULL
  AND v.vendor_id IS NULL
GROUP BY po.vendor_id
ORDER BY po.vendor_id;