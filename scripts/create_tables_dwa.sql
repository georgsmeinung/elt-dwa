-- Script SQL para crear todas las tablas DWA_ en PostgreSQL

CREATE TABLE dwa_orders (
  orderid INTEGER PRIMARY KEY,
  customerid VARCHAR,
  employeeid INTEGER,
  orderdate DATE,
  requireddate DATE,
  shippeddate DATE,
  shipvia INTEGER,
  freight NUMERIC,
  shipname VARCHAR,
  shipaddress VARCHAR,
  shipcity VARCHAR,
  shipregion VARCHAR,
  shippostalcode VARCHAR,
  shipcountry VARCHAR
);

CREATE TABLE dwa_customers (
  customerid VARCHAR PRIMARY KEY,
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

CREATE TABLE dwa_employees (
  employeeid INTEGER PRIMARY KEY,
  lastname VARCHAR,
  firstname VARCHAR,
  title VARCHAR,
  titleofcourtesy VARCHAR,
  birthdate DATE,
  hiredate DATE,
  address VARCHAR,
  city VARCHAR,
  region VARCHAR,
  postalcode VARCHAR,
  country VARCHAR,
  homephone VARCHAR,
  extension INTEGER,
  photopath VARCHAR
);

CREATE TABLE dwa_products (
  productid INTEGER PRIMARY KEY,
  productname VARCHAR,
  supplierid INTEGER,
  categoryid INTEGER,
  quantityperunit VARCHAR,
  unitprice NUMERIC,
  unitsinstock INTEGER,
  unitsonorder INTEGER,
  reorderlevel INTEGER
);

CREATE TABLE dwa_order_details (
  orderid INTEGER,
  productid INTEGER,
  unitprice NUMERIC,
  quantity INTEGER,
  discount INTEGER
);

CREATE TABLE dwa_world_data (
  country VARCHAR PRIMARY KEY,
  life_expectancy NUMERIC,
  gdp VARCHAR,
  population VARCHAR,
  latitude NUMERIC,
  longitude NUMERIC
);
