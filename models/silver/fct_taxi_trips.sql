{{
    config(
        materialized='incremental',
        unique_key='trip_id',
        incremental_strategy='merge'
    )
}}

SELECT
    trip_id,
    vendor_id,
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    rate_code_id,
    pickup_location_id,
    dropoff_location_id,
    payment_type,
    fare_amount,
    tip_amount,
    tolls_amount,
    total_amount

FROM {{ ref('stg_taxi_trips') }}

{% if is_incremental() %}

WHERE pickup_datetime >= (
    SELECT DATEADD(
        day,
        -1,
        MAX(pickup_datetime)
    )
    FROM {{ this }}
)

{% endif %}