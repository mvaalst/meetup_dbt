WITH stg_events AS (
    SELECT  
      group_id,
      name AS meetup_name,
      REGEXP_REPLACE(description, r'<[^>]+>', '') AS meetup_description,
      DATETIME(TIMESTAMP_MILLIS(created), 'Europe/Amsterdam') AS meetup_created,
      DATETIME(TIMESTAMP_MILLIS(CAST(time AS INT64)), 'Europe/Amsterdam') AS meetup_time,
      SAFE_DIVIDE(duration, 60000) AS duration,
      rsvp_limit,
      venue_id,
      CASE WHEN DATETIME(TIMESTAMP_MILLIS(CAST(time AS INT64)), 'Europe/Amsterdam') < CURRENT_DATETIME() THEN 'past' ELSE 'upcoming' END AS status,
      user_id,
      DATETIME(TIMESTAMP_MILLIS(CAST(raw_data.when AS INT64)), 'Europe/Amsterdam') AS time_rsvpd,
      response,
      guests
    FROM {{ source('raw_data', 'events') }} AS raw_data
),

unique_events AS (
  SELECT 
    group_id,
    meetup_created,
    meetup_time
  FROM stg_events
  WHERE
      status IN ('upcoming', 'past')
  GROUP BY ALL
)

SELECT *
FROM stg_events
INNER JOIN unique_events
  USING(group_id, meetup_created, meetup_time)
QUALIFY ROW_NUMBER() OVER(PARTITION BY group_id, meetup_created, meetup_time, user_id ORDER BY time_rsvpd DESC) = 1