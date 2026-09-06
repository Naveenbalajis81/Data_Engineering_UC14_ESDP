SELECT
    p.gl_account,
    COUNT(*) AS orphan_count
FROM staging.co_postings p
LEFT JOIN staging.fi_gl_accounts g
    ON p.gl_account = g.gl_account
WHERE g.gl_account IS NULL
GROUP BY p.gl_account
ORDER BY p.gl_account;