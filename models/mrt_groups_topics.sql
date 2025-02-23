WITH base_groups AS (
    SELECT * FROM {{ ref('stg_groups') }}
),

SELECT
    group_id,
    topic
FROM base_groups
CROSS JOIN UNNEST(topics) AS topic
