WITH base_users AS (
    SELECT * FROM {{ ref('stg_users') }}
)

SELECT
    user_id,
    user_city,
    user_country,
    MIN(joined_group) AS first_joined_group,
    MAX(joined_group) AS last_joined_group,
    COUNT(DISTINCT group_id) AS cnt_groups_joined
FROM base_users
GROUP BY ALL