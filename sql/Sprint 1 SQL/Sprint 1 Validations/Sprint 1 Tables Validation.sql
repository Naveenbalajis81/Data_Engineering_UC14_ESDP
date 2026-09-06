SELECT
    table_name,
    (
        xpath(
            '/row/count/text()',
            query_to_xml(
                format('SELECT COUNT(*) AS count FROM staging.%I', table_name),
                false,
                true,
                ''
            )
        )
    )[1]::text::integer AS row_count
FROM information_schema.tables
WHERE table_schema = 'staging'
ORDER BY table_name;