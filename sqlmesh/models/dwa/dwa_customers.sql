-- models/dwa/dwa_customers.sql
SELECT
  customerid,
  companyname,
  contactname,
  contacttitle,
  address,
  city,
  region,
  postalcode,
  country,
  phone,
  fax
FROM {{ ref('tmp_customers') }}
WHERE customerid IS NOT NULL;
