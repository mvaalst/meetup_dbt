WITH base_groups AS (
    SELECT * FROM {{ ref('stg_groups') }}
),

base_users AS (
    SELECT * FROM {{ ref('stg_users') }}
),

group_topics AS (
    SELECT
        group_id,
        group_city,
        group_created,
        group_description,
        group_name,
        COUNT(topic) AS cnt_topics
    FROM base_groups
    CROSS JOIN UNNEST(topics) AS topic
    GROUP BY ALL
),

group_users AS (
    SELECT
        group_id,
        COUNT(user_id) AS cnt_members,
        MIN(joined_group) AS first_joiner,
        MAX(joined_group) AS last_joiner,
        COUNT(DISTINCT user_country) AS cnt_countries
    FROM 
    GROUP BY 1
)

SELECT
    g.group_id,
    g.group_city,
    g.group_created,
    g.group_description,
    g.group_name,
    g.cnt_topics,
    u.cnt_members,
    u.first_joiner,
    u.last_joiner,
    u.cnt_countries
FROM group_topics AS g
INNER JOIN group_users AS u
    USING(group_id)
