-- Script SQL para crear las tablas DWM_ con estructura SCD Tipo 2

CREATE TABLE dwm_orders (
  orderid INTEGER,
  customerid VARCHAR,
  employeeid INTEGER,
  orderdate DATE,
  freight NUMERIC,
  shipcountry VARCHAR,
  valid_from DATE,
  valid_to DATE,
  is_current BOOLEAN,
  PRIMARY KEY (orderid, valid_from)
);

CREATE TABLE dwm_customers (
  customerid VARCHAR,
  companyname VARCHAR,
  contactname VARCHAR,
  country VARCHAR,
  valid_from DATE,
  valid_to DATE,
  is_current BOOLEAN,
  PRIMARY KEY (customerid, valid_from)
);

CREATE TABLE dwm_products (
  productid INTEGER,
  productname VARCHAR,
  supplierid INTEGER,
  unitprice NUMERIC,
  valid_from DATE,
  valid_to DATE,
  is_current BOOLEAN,
  PRIMARY KEY (productid, valid_from)
);

CREATE TABLE dwm_employees (
  employeeid INTEGER,
  firstname VARCHAR,
  lastname VARCHAR,
  title VARCHAR,
  region VARCHAR,
  valid_from DATE,
  valid_to DATE,
  is_current BOOLEAN,
  PRIMARY KEY (employeeid, valid_from)
);
