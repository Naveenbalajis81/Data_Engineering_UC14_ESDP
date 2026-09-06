SELECT
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'staging'
  AND table_name = 'olist_customers'
ORDER BY ordinal_position;