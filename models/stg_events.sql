WITH stg_events AS (
    SELECT * FROM {{ source('raw_data', 'events') }}
)

SELECT 
    group_id,
    name AS meetup_name,
    description AS meetup_description,
    DATETIME(TIMESTAMP_MILLIS(created), 'Europe/Amsterdam') AS meetup_created,
    DATETIME(TIMESTAMP_MILLIS(CAST(time AS INT64)), 'Europe/Amsterdam') AS meetup_time,
    SAFE_DIVIDE(duration, 60000) AS duration,
    rsvp_limit,
    venue_id,
    CASE WHEN DATETIME(TIMESTAMP_MILLIS(CAST(time AS INT64)), 'Europe/Amsterdam') < CURRENT_DATETIME() THEN 'past' ELSE 'upcoming' END AS status,
    user_id,
    stg_events.when AS time_rsvpd,
    response,
    guests,
    ROW_NUMBER() OVER (PARTITION BY group_id, name, CAST(time AS INT64), user_id ORDER BY created DESC) AS row_num
FROM stg_events
WHERE
    status IN ('upcoming', 'past')
QUALIFY row_num = 1
