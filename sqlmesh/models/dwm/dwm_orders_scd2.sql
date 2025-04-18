-- models/dwm/dwm_orders_scd2.sql

{{
  config(
    materialized='incremental',
    unique_key='orderid',
    incremental_strategy='insert_overwrite'
  )
}}

WITH new_data AS (
  SELECT
    orderid,
    customerid,
    employeeid,
    orderdate,
    freight,
    shipcountry,
    CURRENT_DATE AS valid_from,
    NULL AS valid_to,
    TRUE AS is_current
  FROM {{ ref('dwa_orders') }}
),

expired_existing AS (
  SELECT
    orderid,
    customerid,
    employeeid,
    orderdate,
    freight,
    shipcountry,
    valid_from,
    CURRENT_DATE AS valid_to,
    FALSE AS is_current
  FROM {{ this }}
  WHERE is_current = TRUE
    AND EXISTS (
      SELECT 1 FROM new_data n
      WHERE n.orderid = {{ this }}.orderid
        AND (
          n.customerid IS DISTINCT FROM {{ this }}.customerid OR
          n.employeeid IS DISTINCT FROM {{ this }}.employeeid OR
          n.freight IS DISTINCT FROM {{ this }}.freight OR
          n.shipcountry IS DISTINCT FROM {{ this }}.shipcountry
        )
    )
)

SELECT * FROM expired_existing
UNION ALL
SELECT * FROM new_data
