CREATE TABLE staging.olist_geolocation (
    geolocation_zip_code_prefix VARCHAR(20),
    geolocation_lat NUMERIC(12,8),
    geolocation_lng NUMERIC(12,8),
    geolocation_city VARCHAR(150),
    geolocation_state VARCHAR(20)
);