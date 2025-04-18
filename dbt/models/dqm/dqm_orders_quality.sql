-- models/dqm/dqm_orders_quality.sql
SELECT
  'orders' AS table_name,
  COUNT(*) AS total_records,
  COUNT(*) FILTER (WHERE orderdate IS NULL) AS missing_orderdate,
  100.0 * COUNT(*) FILTER (WHERE orderdate IS NULL) / NULLIF(COUNT(*), 0) AS pct_missing_orderdate,
  COUNT(*) FILTER (WHERE freight < 0) AS negative_freight,
  CURRENT_TIMESTAMP AS evaluated_at
FROM {{ ref('tmp_orders') }};
