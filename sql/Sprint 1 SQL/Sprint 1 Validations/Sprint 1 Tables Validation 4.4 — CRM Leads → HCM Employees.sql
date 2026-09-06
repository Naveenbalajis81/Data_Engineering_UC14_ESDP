SELECT
    l.owner_employee_id,
    COUNT(*) AS orphan_count
FROM staging.crm_leads l
LEFT JOIN staging.hcm_employees e
    ON l.owner_employee_id = e.employee_id
WHERE l.owner_employee_id IS NOT NULL
  AND e.employee_id IS NULL
GROUP BY l.owner_employee_id
ORDER BY l.owner_employee_id;