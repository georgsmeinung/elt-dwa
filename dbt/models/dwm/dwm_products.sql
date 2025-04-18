-- models/dwm/dwm_products.sql
SELECT
  *,
  CURRENT_DATE AS valid_from,
  NULL AS valid_to,
  TRUE AS is_current
FROM {{ ref('dwa_products') }};
