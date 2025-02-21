WITH base_events AS (
    SELECT
        * EXCEPT(row_num),
        ROW_NUMBER() OVER (PARTITION BY group_id, meetup_name, meetup_time ORDER BY meetup_created DESC) AS row_num
    FROM {{ ref('stg_events') }}
    QUALIFY row_num = 1
),

base_venues AS (
    SELECT * FROM {{ ref('stg_venues') }}
)

SELECT
    group_id,
    meetup_name,
    meetup_description,
    meetup_created,
    venue_id,
    venue_city,
    venue_country,
    venue_name,
    duration,
    rsvp_limit,
    status,
    meetup_time,
    COUNT(user_id) AS total_invited_guests,
    SUM(CASE WHEN response = 'yes' THEN 1 ELSE 0 END) AS cnt_rsvp_yes,
    SUM(CASE WHEN response != 'yes' THEN 1 ELSE 0 END) AS cnt_rsvp_no,
    SUM(guests) AS guests_per_meetup
FROM base_events
LEFT JOIN base_venues
    USING(venue_id)
GROUP BY ALL