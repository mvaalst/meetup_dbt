WITH stg_groups AS (
    SELECT * FROM {{ source('raw_data', 'groups') }}
)

SELECT 
    group_id,
    topics,
    city AS group_city,
    lon,
    lat,
    DATETIME(TIMESTAMP_MILLIS(created), 'Europe/Amsterdam') AS group_created,
    description AS group_description,
    link,
    name AS group_name
FROM stg_groups