-- Este script simula la inserción desde NiFi usando ExecuteSQL
-- Para cada carga de CSV, NiFi puede ejecutar algo como esto:

INSERT INTO dqm_ingesta_log (tabla, archivo, registros)
VALUES ('tmp_orders', 'orders_2023.csv', 1540);
