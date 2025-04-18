-- models/dp/dp_sales_summary.sql
SELECT
  o.orderid,
  o.orderdate,
  c.companyname AS customer_name,
  e.firstname || ' ' || e.lastname AS employee_name,
  SUM(od.quantity * od.unitprice) AS total_amount,
  o.shipcountry
FROM {{ ref('dwa_orders') }} o
JOIN {{ ref('dwa_customers') }} c ON o.customerid = c.customerid
JOIN {{ ref('dwa_order_details') }} od ON o.orderid = od.orderid
JOIN {{ ref('dwa_employees') }} e ON o.employeeid = e.employeeid
GROUP BY o.orderid, o.orderdate, c.companyname, employee_name, o.shipcountry;
