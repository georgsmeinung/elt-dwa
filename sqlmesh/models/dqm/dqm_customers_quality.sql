-- models/dqm/dqm_customers_quality.sql
SELECT
  'customers' AS table_name,
  COUNT(*) AS total_records,
  COUNT(*) FILTER (WHERE customerid IS NULL) AS missing_customerid,
  COUNT(DISTINCT customerid) AS unique_customerid,
  CURRENT_TIMESTAMP AS evaluated_at
FROM {{ ref('tmp_customers') }};
