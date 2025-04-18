-- models/dwa/dwa_order_details.sql
SELECT
  orderid,
  productid,
  unitprice,
  quantity,
  discount
FROM {{ ref('tmp_order_details') }}
WHERE quantity IS NOT NULL;
