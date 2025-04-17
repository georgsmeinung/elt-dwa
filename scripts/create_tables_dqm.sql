-- Script SQL para crear las tablas DQM_ en PostgreSQL

CREATE TABLE dqm_orders_quality (
  table_name TEXT,
  total_records INTEGER,
  missing_orderdate INTEGER,
  pct_missing_orderdate NUMERIC,
  negative_freight INTEGER,
  evaluated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dqm_customers_quality (
  table_name TEXT,
  total_records INTEGER,
  missing_customerid INTEGER,
  unique_customerid INTEGER,
  evaluated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dqm_ingesta_log (
  tabla TEXT,
  archivo TEXT,
  registros INTEGER,
  fecha_ingesta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);