WITH stg_events AS (
    SELECT * FROM {{ source('raw_data', 'events') }}
)

SELECT 
    group_id,
    name AS meetup_name,
    description AS meetup_description,
    TIMESTAMP_MILLIS(created) AS meetup_created,
    TIMESTAMP_MILLIS(CAST(time AS INT64)) AS meetup_time,
    SAFE_DIVIDE(duration, 60000) AS duration,
    rsvp_limit,
    venue_id,
    status,
    user_id,
    stg_events.when AS time_rsvpd,
    response,
    guests
FROM stg_events
