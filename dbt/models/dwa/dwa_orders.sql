-- models/dwa/dwa_orders.sql
SELECT
  orderid,
  customerid,
  employeeid,
  CAST(orderdate AS DATE) AS orderdate,
  CAST(requireddate AS DATE) AS requireddate,
  CAST(shippeddate AS DATE) AS shippeddate,
  shipvia,
  freight,
  shipname,
  shipaddress,
  shipcity,
  shipregion,
  shippostalcode,
  shipcountry
FROM {{ ref('tmp_orders') }}
WHERE orderdate IS NOT NULL;
