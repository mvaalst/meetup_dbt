WITH stg_events AS (
    SELECT * FROM {{ source('raw_data', 'events') }}
)

SELECT 
    group_id,
    name AS meetup_name,
    description AS meetup_description,
    TIMESTAMP_MILLIS(created, 'Europe/Amsterdam') AS meetup_created,
    TIMESTAMP_MILLIS(CAST(time AS INT64), 'Europe/Amsterdam') AS meetup_time,
    SAFE_DIVIDE(duration, 60000) AS duration,
    rsvp_limit,
    venue_id,
    status,
    CASE WHEN TIMESTAMP_MILLIS(CAST(time AS INT64), 'Europe/Amsterdam') < CURRENT_TIMESTAMP() THEN 'past' ELSE 'upcoming' END AS status_new,
    user_id,
    stg_events.when AS time_rsvpd,
    response,
    guests,
    ROW_NUMBER() OVER (PARTITION BY group_id, name, created, time ORDER BY created DESC) AS row_num
FROM stg_events
WHERE
    status IN ('upcoming', 'past')
QUALIFY row_num = 1
