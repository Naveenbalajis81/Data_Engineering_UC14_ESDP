SELECT
    p.cost_center,
    COUNT(*) AS orphan_count
FROM staging.co_postings p
LEFT JOIN staging.co_cost_centers c
    ON p.cost_center = c.cost_center
WHERE c.cost_center IS NULL
GROUP BY p.cost_center
ORDER BY p.cost_center;