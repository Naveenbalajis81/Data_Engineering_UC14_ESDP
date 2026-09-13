INSERT INTO dw.dim_date (
    date_key,
    full_date,
    day_number,
    day_name,
    month_number,
    month_name,
    quarter_number,
    year_number,
    week_number,
    day_of_week
)
SELECT
    TO_CHAR(d, 'YYYYMMDD')::INTEGER AS date_key,
    d::DATE AS full_date,
    EXTRACT(DAY FROM d)::INTEGER AS day_number,
    TO_CHAR(d, 'FMDay') AS day_name,
    EXTRACT(MONTH FROM d)::INTEGER AS month_number,
    TO_CHAR(d, 'FMMonth') AS month_name,
    EXTRACT(QUARTER FROM d)::INTEGER AS quarter_number,
    EXTRACT(YEAR FROM d)::INTEGER AS year_number,
    EXTRACT(WEEK FROM d)::INTEGER AS week_number,
    EXTRACT(ISODOW FROM d)::INTEGER AS day_of_week
FROM generate_series(
    '2022-01-01'::DATE,
    '2025-12-31'::DATE,
    '1 day'::INTERVAL
) AS d;