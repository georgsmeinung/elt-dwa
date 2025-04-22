# Estructura del Repositorio `elt-dwa`

Este archivo describe la organización del repositorio del proyecto de Data Warehouse Automation (DWA) utilizando **SQLMesh**, **PostgreSQL**, **Apache NiFi**, **Lightdash** y otras herramientas open source.

---

## 📁 `models/`
Contiene todos los modelos SQL que definen las transformaciones por capas.

### 📂 `models/tmp/`
Modelos de staging que reflejan la carga cruda desde CSV.
- `tmp_orders`: pedidos originales
- `tmp_customers`: información de clientes
- `tmp_employees`: empleados de ventas
- `tmp_order_details`: detalle línea por línea de cada pedido
- `tmp_products`: productos ofrecidos
- `tmp_suppliers`: proveedores
- `tmp_categories`: categorías de productos
- `tmp_regions`: regiones geográficas
- `tmp_territories`: territorios asignados
- `tmp_employee_territories`: asignación empleados-territorios
- `tmp_shippers`: transportistas
- `tmp_world_data_2023`: datos complementarios por país

### 📂 `models/dwa/`
Modelos transformados y validados.
- `dwa_orders`: normalización y limpieza de pedidos, con fechas, empleados, cliente y dirección de envío.
- `dwa_customers`: unificación de clientes con sus datos de contacto y ubicación.
- `dwa_employees`: empleados normalizados con cargo, fechas de ingreso y contacto.
- `dwa_products`: catálogo de productos enriquecido con precios y stock.
- `dwa_order_details`: detalles línea por línea de cada pedido, incluyendo precio, cantidad y descuento.
- `dwa_world_data`: datos por país con indicadores complementarios como esperanza de vida, población y coordenadas geográficas.

### 📂 `models/dwm/`
Modelos con memoria histórica.
- `dwm_orders`: pedidos con control de versiones tipo SCD2, incluyendo fechas de vigencia y estado actual.
- `dwm_customers`: clientes versionados históricamente por país, contacto y nombre de empresa.
- `dwm_products`: productos con control de precio y proveedor a lo largo del tiempo.
- `dwm_employees`: empleados con evolución de cargo, región y cambios de datos relevantes.

### 📂 `models/dqm/`
Modelos para control de calidad de datos.
- `dqm_orders_quality`: detecta anomalías y faltantes en pedidos como `orderdate` y `freight` negativos.
- `dqm_customers_quality`: valida integridad de clientes, presencia de claves y unicidad.
- `dqm_ingesta_tracking`: tabla histórica de trazabilidad con cantidad de registros cargados por archivo.
- `dqm_ingesta_log`: log operativo de ingesta con nombre de tabla, archivo y timestamp exacto de carga.

### 📂 `models/dp/`
Producto final para análisis.
- `dp_sales_summary`: resumen de ventas consolidado, por orden, empleado, cliente, monto total y país de destino.
- `dp_top_countries`: ranking de los 10 países con mayor cantidad de pedidos y facturación total.

## 📁 `models/met/`
Contiene los modelos de gestión de metadatos internos del pipeline DWA.

- `met_model_registry`: Registro principal de modelos en uso: nombre, tipo, capa, descripción.
- `met_model_dependencies`: Relaciones entre modelos (DAG lógico).
- `met_model_columns`: Metadatos de columnas por modelo: nombre, tipo, nulabilidad, clave primaria.
- `met_model_registry_hist`: Tabla con memoria histórica (SCD Tipo 2) de cambios en `met_model_registry`.

---

## 📄 `sqlmesh_project.toml`
Archivo de configuración del proyecto SQLMesh.

- Define el nombre del proyecto, dialecto (PostgreSQL) y conexión a la base de datos.

---

## 📁 `data/ingesta1/`
- Carpeta que contiene los archivos CSV fuente.
- Estos archivos son cargados por NiFi hacia las tablas `TMP_` en PostgreSQL.

---

## 📄 `docker-compose.yml`
Archivo para levantar todo el entorno de desarrollo local.

Contiene los siguientes servicios:
- `postgres`: almacén de datos
- `sqlmesh`: motor de transformación y UI
- `nifi`: motor de ingesta visual
- `lightdash`: herramienta BI sobre DP_
- `dbgate`: cliente web para inspección manual de la base

---

## 📄 `README.md`
- Guía general del proyecto: qué hace, cómo usarlo, puertos, estructura.

---

## 📄 `docs/STRUCT.md`
- Este archivo. Explica en detalle la estructura de carpetas y archivos del repositorio.

---

Esta estructura modular permite mantener separado cada paso del flujo de datos, mejorar la trazabilidad, facilitar el testing y exponer los resultados en forma visual y reutilizable.
