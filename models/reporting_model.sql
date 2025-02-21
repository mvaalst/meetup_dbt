WITH mrt_events AS (
    SELECT * FROM {{ ref('mrt_events') }}
),

mrt_groups AS (
    SELECT * FROM {{ ref('mrt_groups') }}
)

SELECT *
FROM mrt_events
LEFT JOIN mrt_groups
    USING(group_id)