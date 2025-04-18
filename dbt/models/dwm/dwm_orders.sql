-- models/dwm/dwm_orders.sql
SELECT
  *,
  CURRENT_DATE AS valid_from,
  NULL AS valid_to,
  TRUE AS is_current
FROM {{ ref('dwa_orders') }};
