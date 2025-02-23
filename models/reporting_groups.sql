WITH mrt_groups AS (
    SELECT * FROM {{ ref('mrt_groups') }}
),

mrt_groups_topics AS (
    SELECT * FROM {{ ref('mrt_groups_topics') }}
)

SELECT 
    *,
    DATE_DIFF("2015-09-01", DATE(last_joiner), DAY) AS days_since_last_joiner
FROM mrt_groups
INNER JOIN mrt_groups_topics
    USING(group_id)
