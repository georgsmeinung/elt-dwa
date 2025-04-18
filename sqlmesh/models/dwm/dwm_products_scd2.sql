-- models/dwm/dwm_products_scd2.sql

{{
  config(
    materialized='incremental',
    unique_key='productid',
    incremental_strategy='insert_overwrite'
  )
}}

WITH new_data AS (
  SELECT
    productid,
    productname,
    supplierid,
    unitprice,
    CURRENT_DATE AS valid_from,
    NULL AS valid_to,
    TRUE AS is_current
  FROM {{ ref('dwa_products') }}
),

expired_existing AS (
  SELECT
    productid,
    productname,
    supplierid,
    unitprice,
    valid_from,
    CURRENT_DATE AS valid_to,
    FALSE AS is_current
  FROM {{ this }}
  WHERE is_current = TRUE
    AND EXISTS (
      SELECT 1 FROM new_data n
      WHERE n.productid = {{ this }}.productid
        AND (
          n.productname IS DISTINCT FROM {{ this }}.productname OR
          n.supplierid IS DISTINCT FROM {{ this }}.supplierid OR
          n.unitprice IS DISTINCT FROM {{ this }}.unitprice
        )
    )
)

SELECT * FROM expired_existing
UNION ALL
SELECT * FROM new_data
