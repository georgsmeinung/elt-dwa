-- Script para crear tablas MET_ de metadatos de modelos y columnas

CREATE TABLE met_model_registry (
  model_name VARCHAR PRIMARY KEY,
  model_type VARCHAR,
  layer VARCHAR,
  owner VARCHAR,
  description TEXT,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

CREATE TABLE met_model_dependencies (
  model_name VARCHAR,
  depends_on VARCHAR,
  FOREIGN KEY (model_name) REFERENCES met_model_registry(model_name),
  FOREIGN KEY (depends_on) REFERENCES met_model_registry(model_name)
);

CREATE TABLE met_model_columns (
  model_name VARCHAR,
  column_name VARCHAR,
  data_type VARCHAR,
  is_nullable BOOLEAN,
  is_primary_key BOOLEAN DEFAULT false,
  description TEXT,
  FOREIGN KEY (model_name) REFERENCES met_model_registry(model_name)
);

-- Insertar metadatos de modelos
INSERT INTO met_model_registry (model_name, model_type, layer, owner, description) VALUES
  ('tmp_orders', 'view', 'tmp', 'etl@datateam', 'Carga cruda de pedidos desde CSV'),
  ('tmp_customers', 'view', 'tmp', 'etl@datateam', 'Carga cruda de clientes'),
  ('tmp_employees', 'view', 'tmp', 'etl@datateam', 'Carga cruda de empleados'),
  ('tmp_order_details', 'view', 'tmp', 'etl@datateam', 'Carga cruda de detalles de pedidos'),
  ('tmp_products', 'view', 'tmp', 'etl@datateam', 'Carga cruda de productos'),
  ('tmp_suppliers', 'view', 'tmp', 'etl@datateam', 'Carga cruda de proveedores'),
  ('tmp_categories', 'view', 'tmp', 'etl@datateam', 'Carga cruda de categorías'),
  ('tmp_regions', 'view', 'tmp', 'etl@datateam', 'Carga cruda de regiones'),
  ('tmp_territories', 'view', 'tmp', 'etl@datateam', 'Carga cruda de territorios'),
  ('tmp_employee_territories', 'view', 'tmp', 'etl@datateam', 'Carga cruda de relaciones empleados-territorios'),
  ('tmp_shippers', 'view', 'tmp', 'etl@datateam', 'Carga cruda de transportistas'),
  ('tmp_world_data_2023', 'view', 'tmp', 'etl@datateam', 'Carga de datos complementarios por país'),
  ('dwa_orders', 'table', 'dwa', 'etl@datateam', 'Transformación de pedidos limpia'),
  ('dwa_customers', 'table', 'dwa', 'etl@datateam', 'Transformación de clientes'),
  ('dwm_orders', 'incremental', 'dwm', 'etl@datateam', 'Histórico de pedidos con SCD2'),
  ('dqm_orders_quality', 'table', 'dqm', 'qa@datateam', 'Métricas de calidad para pedidos'),
  ('dqm_ingesta_tracking', 'table', 'dqm', 'qa@datateam', 'Trazabilidad de archivos cargados'),
  ('dp_sales_summary', 'view', 'dp', 'bi@datateam', 'Vista agregada de ventas');

-- Insertar dependencias (simplificado)
INSERT INTO met_model_dependencies (model_name, depends_on) VALUES
  ('dwa_orders', 'tmp_orders'),
  ('dwa_customers', 'tmp_customers'),
  ('dwm_orders', 'dwa_orders'),
  ('dqm_orders_quality', 'tmp_orders'),
  ('dqm_ingesta_tracking', 'tmp_orders'),
  ('dp_sales_summary', 'dwa_orders');

-- Insertar metadatos de columnas (ejemplares)
INSERT INTO met_model_columns (model_name, column_name, data_type, is_nullable, is_primary_key, description) VALUES
  ('tmp_orders', 'orderid', 'INTEGER', false, true, 'ID del pedido'),
  ('tmp_orders', 'customerid', 'VARCHAR', true, false, 'ID del cliente'),
  ('tmp_customers', 'customerid', 'VARCHAR', false, true, 'ID del cliente'),
  ('tmp_customers', 'companyname', 'VARCHAR', true, false, 'Nombre de la compañía'),
  ('dwa_orders', 'orderid', 'INTEGER', false, true, 'ID del pedido limpio'),
  ('dwa_orders', 'orderdate', 'DATE', true, false, 'Fecha del pedido'),
  ('dwa_customers', 'customerid', 'VARCHAR', false, true, 'ID del cliente limpio'),
  ('dwm_orders', 'orderid', 'INTEGER', false, false, 'ID del pedido histórico'),
  ('dwm_orders', 'valid_from', 'TIMESTAMP', false, false, 'Inicio de validez del registro'),
  ('dwm_orders', 'valid_to', 'TIMESTAMP', true, false, 'Fin de validez del registro'),
  ('dwm_orders', 'is_current', 'BOOLEAN', false, false, 'Indica si es la versión vigente'),
  ('dqm_orders_quality', 'orderid', 'INTEGER', true, false, 'ID evaluado'),
  ('dqm_orders_quality', 'missing_fields', 'INTEGER', true, false, 'Campos faltantes detectados'),
  ('dqm_ingesta_tracking', 'tabla', 'VARCHAR', false, false, 'Nombre de la tabla de destino'),
  ('dqm_ingesta_tracking', 'archivo', 'VARCHAR', false, false, 'Archivo CSV cargado'),
  ('dqm_ingesta_tracking', 'registros', 'INTEGER', false, false, 'Cantidad de registros insertados'),
  ('dqm_ingesta_tracking', 'fecha_ingesta', 'TIMESTAMP', false, false, 'Momento de la carga'),
  ('dp_sales_summary', 'orderid', 'INTEGER', false, false, 'ID de pedido en resumen de ventas'),
  ('dp_sales_summary', 'total_amount', 'NUMERIC', true, false, 'Monto total de la venta');
