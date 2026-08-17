SELECT *
FROM {{ ref('fct_taxi_trips') }}
WHERE dropoff_datetime < pickup_datetime