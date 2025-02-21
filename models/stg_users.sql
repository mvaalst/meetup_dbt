WITH stg_users AS (
    SELECT * FROM {{ source('raw_data', 'users') }}
)

SELECT DISTINCT
    user_id,
    city AS user_city,
    country AS user_country,
    hometown AS user_hometown,
    DATETIME(TIMESTAMP_MILLIS(joined), 'Europe/Amsterdam') AS joined_group,
    group_id
FROM stg_users