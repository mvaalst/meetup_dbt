WITH base_events AS (
    SELECT * FROM {{ ref('stg_events') }}
)

SELECT
    group_id,
    meetup_name,
    meetup_description,
    meetup_created,
    venue_id,
    duration,
    rsvp_limit,
    status,
    meetup_time,
    COUNT(user_id) AS total_invited_guests,
    SUM(CASE WHEN response = 'yes' THEN 1 ELSE 0 END) AS cnt_rsvp_yes,
    SUM(CASE WHEN response != 'yes' THEN 1 ELSE 0 END) AS cnt_rsvp_no,
    SUM(guests) AS guests_per_meetup
FROM base_events
GROUP BY ALL