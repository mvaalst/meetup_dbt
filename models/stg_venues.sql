WITH stg_venues AS (
    SELECT * FROM {{ source('raw_data', 'venues') }}
)
SELECT * 
FROM stg_venues
WHERE
    LOWER(country) IN ("nl", "be", "de")
    AND city IS NOT NULL
    AND venue_id IS NOT NULL
    AND country IS NOT NULL