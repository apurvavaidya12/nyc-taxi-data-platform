SELECT
    "trip_id" AS trip_id,
    "VendorID" AS vendor_id,

    TO_TIMESTAMP_NTZ(
        "tpep_pickup_datetime"::NUMBER,
        6
    ) AS pickup_datetime,

    TO_TIMESTAMP_NTZ(
        "tpep_dropoff_datetime"::NUMBER,
        6
    ) AS dropoff_datetime,

    "passenger_count" AS passenger_count,
    "trip_distance" AS trip_distance,
    "RatecodeID" AS rate_code_id,
    "PULocationID" AS pickup_location_id,
    "DOLocationID" AS dropoff_location_id,
    "payment_type" AS payment_type,
    "fare_amount" AS fare_amount,
    "tip_amount" AS tip_amount,
    "tolls_amount" AS tolls_amount,
    "total_amount" AS total_amount

FROM {{ source('raw', 'TAXI_TRIPS_RAW') }}