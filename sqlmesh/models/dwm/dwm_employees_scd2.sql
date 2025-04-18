-- models/dwm/dwm_employees_scd2.sql

{{
  config(
    materialized='incremental',
    unique_key='employeeid',
    incremental_strategy='insert_overwrite'
  )
}}

WITH new_data AS (
  SELECT
    employeeid,
    firstname,
    lastname,
    title,
    region,
    CURRENT_DATE AS valid_from,
    NULL AS valid_to,
    TRUE AS is_current
  FROM {{ ref('dwa_employees') }}
),

expired_existing AS (
  SELECT
    employeeid,
    firstname,
    lastname,
    title,
    region,
    valid_from,
    CURRENT_DATE AS valid_to,
    FALSE AS is_current
  FROM {{ this }}
  WHERE is_current = TRUE
    AND EXISTS (
      SELECT 1 FROM new_data n
      WHERE n.employeeid = {{ this }}.employeeid
        AND (
          n.firstname IS DISTINCT FROM {{ this }}.firstname OR
          n.lastname IS DISTINCT FROM {{ this }}.lastname OR
          n.title IS DISTINCT FROM {{ this }}.title OR
          n.region IS DISTINCT FROM {{ this }}.region
        )
    )
)

SELECT * FROM expired_existing
UNION ALL
SELECT * FROM new_data
