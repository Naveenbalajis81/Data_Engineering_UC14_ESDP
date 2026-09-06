SELECT
    o.lead_id,
    COUNT(*) AS orphan_count
FROM staging.crm_opportunities o
LEFT JOIN staging.crm_leads l
    ON o.lead_id = l.lead_id
WHERE l.lead_id IS NULL
GROUP BY o.lead_id
ORDER BY o.lead_id;