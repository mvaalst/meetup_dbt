WITH stg_venues AS (
    SELECT * FROM {{ source('raw_data', 'venues') }}
)
SELECT
    city AS venue_city,
    country AS venue_country,
    name AS venue_name,
    lon,
    lat,
    venue_id
FROM stg_venues
WHERE
    LOWER(country) IN ("nl", "be", "de")
    AND city IS NOT NULL
    AND venue_id IS NOT NULL
    AND country IS NOT NULL