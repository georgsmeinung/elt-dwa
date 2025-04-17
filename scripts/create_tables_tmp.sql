-- Script SQL para crear todas las tablas TMP_ en PostgreSQL

CREATE TABLE tmp_orders (
  orderid INTEGER,
  customerid VARCHAR,
  employeeid INTEGER,
  orderdate VARCHAR,
  requireddate VARCHAR,
  shippeddate VARCHAR,
  shipvia INTEGER,
  freight NUMERIC,
  shipname VARCHAR,
  shipaddress VARCHAR,
  shipcity VARCHAR,
  shipregion VARCHAR,
  shippostalcode VARCHAR,
  shipcountry VARCHAR
);

CREATE TABLE tmp_customers (
  customerid VARCHAR,
  companyname VARCHAR,
  contactname VARCHAR,
  contacttitle VARCHAR,
  address VARCHAR,
  city VARCHAR,
  region NUMERIC,
  postalcode VARCHAR,
  country VARCHAR,
  phone VARCHAR,
  fax VARCHAR
);

CREATE TABLE tmp_employees (
  employeeid INTEGER,
  lastname VARCHAR,
  firstname VARCHAR,
  title VARCHAR,
  titleofcourtesy VARCHAR,
  birthdate VARCHAR,
  hiredate VARCHAR,
  address VARCHAR,
  city VARCHAR,
  region VARCHAR,
  postalcode VARCHAR,
  country VARCHAR,
  homephone VARCHAR,
  extension INTEGER,
  photo VARCHAR,
  notes VARCHAR,
  reportsto NUMERIC,
  photopath VARCHAR
);

CREATE TABLE tmp_order_details (
  orderid INTEGER,
  productid INTEGER,
  unitprice NUMERIC,
  quantity INTEGER,
  discount INTEGER
);

CREATE TABLE tmp_products (
  productid INTEGER,
  productname VARCHAR,
  supplierid INTEGER,
  categoryid INTEGER,
  quantityperunit VARCHAR,
  unitprice NUMERIC,
  unitsinstock INTEGER,
  unitsonorder INTEGER,
  reorderlevel INTEGER,
  discontinued INTEGER
);

CREATE TABLE tmp_suppliers (
  supplierid INTEGER,
  companyname VARCHAR,
  contactname VARCHAR,
  contacttitle VARCHAR,
  address VARCHAR,
  city VARCHAR,
  region VARCHAR,
  postalcode VARCHAR,
  country VARCHAR,
  phone VARCHAR,
  fax VARCHAR,
  homepage VARCHAR
);

CREATE TABLE tmp_categories (
  categoryid INTEGER,
  categoryname VARCHAR,
  description VARCHAR,
  picture VARCHAR
);

CREATE TABLE tmp_regions (
  regionid INTEGER,
  regiondescription VARCHAR
);

CREATE TABLE tmp_territories (
  territoryid INTEGER,
  territorydescription VARCHAR,
  regionid INTEGER
);

CREATE TABLE tmp_employee_territories (
  employeeid INTEGER,
  territoryid INTEGER
);

CREATE TABLE tmp_shippers (
  shipperid INTEGER,
  companyname VARCHAR,
  phone VARCHAR
);

CREATE TABLE tmp_world_data_2023 (
  country VARCHAR,
  density_pk2 INTEGER,
  abbreviation VARCHAR,
  agricultural_land_percent VARCHAR,
  land_area_km2 VARCHAR,
  armed_forces_size VARCHAR,
  birth_rate NUMERIC,
  calling_code INTEGER,
  capital_major_city VARCHAR,
  co2_emissions VARCHAR,
  cpi NUMERIC,
  cpi_change_percent VARCHAR,
  currency_code VARCHAR,
  fertility_rate NUMERIC,
  forested_area_percent VARCHAR,
  gasoline_price VARCHAR,
  gdp VARCHAR,
  gross_primary_education_enrollment_percent VARCHAR,
  gross_tertiary_education_enrollment_percent VARCHAR,
  infant_mortality NUMERIC,
  largest_city VARCHAR,
  life_expectancy NUMERIC,
  maternal_mortality_ratio NUMERIC,
  minimum_wage VARCHAR,
  official_language VARCHAR,
  out_of_pocket_health_expenditure VARCHAR,
  physicians_per_thousand NUMERIC,
  population VARCHAR,
  population_labor_force_participation_percent VARCHAR,
  tax_revenue_percent VARCHAR,
  total_tax_rate VARCHAR,
  unemployment_rate VARCHAR,
  urban_population VARCHAR,
  latitude NUMERIC,
  longitude NUMERIC
);