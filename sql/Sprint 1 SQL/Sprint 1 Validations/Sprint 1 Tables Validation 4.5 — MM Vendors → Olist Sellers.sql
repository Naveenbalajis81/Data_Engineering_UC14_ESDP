SELECT
    v.seller_id,
    COUNT(*) AS orphan_count
FROM staging.mm_vendors v
LEFT JOIN staging.olist_sellers s
    ON v.seller_id = s.seller_id
WHERE v.seller_id IS NOT NULL
  AND s.seller_id IS NULL
GROUP BY v.seller_id
ORDER BY v.seller_id;