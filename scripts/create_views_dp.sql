-- Script SQL para crear vistas DP_ (producto de datos para dashboards)

CREATE VIEW dp_sales_summary AS
SELECT
  o.orderid,
  o.orderdate,
  c.companyname AS customer_name,
  e.firstname || ' ' || e.lastname AS employee_name,
  SUM(od.quantity * od.unitprice) AS total_amount,
  o.shipcountry
FROM dwa_orders o
JOIN dwa_customers c ON o.customerid = c.customerid
JOIN dwa_order_details od ON o.orderid = od.orderid
JOIN dwa_employees e ON o.employeeid = e.employeeid
GROUP BY o.orderid, o.orderdate, c.companyname, employee_name, o.shipcountry;


CREATE VIEW dp_top_countries AS
SELECT
  o.shipcountry,
  COUNT(DISTINCT o.orderid) AS total_orders,
  SUM(od.quantity * od.unitprice) AS total_revenue
FROM dwa_orders o
JOIN dwa_order_details od ON o.orderid = od.orderid
GROUP BY o.shipcountry
ORDER BY total_revenue DESC
LIMIT 10;
