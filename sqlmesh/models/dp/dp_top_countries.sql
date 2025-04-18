-- models/dp/dp_top_countries.sql
SELECT
  shipcountry,
  COUNT(DISTINCT orderid) AS total_orders,
  SUM(od.quantity * od.unitprice) AS total_revenue
FROM {{ ref('dwa_orders') }} o
JOIN {{ ref('dwa_order_details') }} od ON o.orderid = od.orderid
GROUP BY shipcountry
ORDER BY total_revenue DESC
LIMIT 10;
