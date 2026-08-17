{% snapshot vendors_snapshot %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='vendor_id',
        strategy='check',
        check_cols=['vendor_name']
    )
}}

SELECT
    vendor_id,
    vendor_name
FROM {{ ref('dim_vendors') }}

{% endsnapshot %}