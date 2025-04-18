-- models/dwa/dwa_employees.sql
SELECT
  employeeid,
  lastname,
  firstname,
  title,
  titleofcourtesy,
  CAST(birthdate AS DATE) AS birthdate,
  CAST(hiredate AS DATE) AS hiredate,
  address,
  city,
  region,
  postalcode,
  country,
  homephone,
  extension,
  photopath
FROM {{ ref('tmp_employees') }}
WHERE employeeid IS NOT NULL;
