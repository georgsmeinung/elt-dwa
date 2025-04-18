-- models/dwa/dwa_products.sql
SELECT
  productid,
  productname,
  supplierid,
  categoryid,
  quantityperunit,
  unitprice,
  unitsinstock,
  unitsonorder,
  reorderlevel
FROM {{ ref('tmp_products') }}
WHERE discontinued = 0;
