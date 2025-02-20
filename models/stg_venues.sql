WITH stg_venues AS (
    SELECT * FROM {{ source('raw_data', 'venues') }}
)
SELECT * FROM stg_venues