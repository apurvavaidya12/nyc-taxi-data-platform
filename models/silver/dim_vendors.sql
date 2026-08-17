WITH vendors AS (

    SELECT DISTINCT vendor_id
    FROM {{ ref('stg_taxi_trips') }}

)

SELECT
    vendor_id,

    {{ clean_string(
        "CASE
            WHEN vendor_id = 1 THEN 'Creative Mobile Technologies'
            WHEN vendor_id = 2 THEN 'VeriFone Inc.'
            WHEN vendor_id = 6 THEN 'Myle Technologies'
            WHEN vendor_id = 7 THEN 'Standard Taxi'
            ELSE 'Unknown Vendor'
        END"
    ) }} AS vendor_name

FROM vendors