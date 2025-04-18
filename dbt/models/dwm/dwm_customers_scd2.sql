-- models/dwm/dwm_customers_scd2.sql

{{
  config(
    materialized='incremental',
    unique_key='customerid',
    incremental_strategy='insert_overwrite'
  )
}}

WITH new_data AS (
  SELECT
    customerid,
    companyname,
    contactname,
    country,
    CURRENT_DATE AS valid_from,
    NULL AS valid_to,
    TRUE AS is_current
  FROM {{ ref('dwa_customers') }}
),

expired_existing AS (
  SELECT
    customerid,
    companyname,
    contactname,
    country,
    valid_from,
    CURRENT_DATE AS valid_to,
    FALSE AS is_current
  FROM {{ this }}
  WHERE is_current = TRUE
    AND EXISTS (
      SELECT 1 FROM new_data n
      WHERE n.customerid = {{ this }}.customerid
        AND (
          n.companyname IS DISTINCT FROM {{ this }}.companyname OR
          n.contactname IS DISTINCT FROM {{ this }}.contactname OR
          n.country IS DISTINCT FROM {{ this }}.country
        )
    )
)

SELECT * FROM expired_existing
UNION ALL
SELECT * FROM new_data
