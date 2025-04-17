# Explicación detallada de la estructura del repositorio `elt-dwa/`

Este documento explica línea por línea la estructura del repositorio generado para un flujo de Data Warehouse Automation (DWA) con herramientas open source.

```bash
elt-dwa/
```
Carpeta raíz del proyecto.

---

## `data/`

```bash
├── data/
│   └── ingesta1/
```
Contiene los archivos CSV de entrada utilizados en las cargas iniciales. Simula el origen de datos crudos que NiFi va a procesar.

---

## `dbt/`

```bash
├── dbt/
```
Directorio principal del proyecto `dbt`, que contiene:
- Modelos SQL organizados por capa (TMP, DWA, etc.)
- Archivos de configuración y documentación

### `models/`

```bash
│   ├── models/
```
Contiene los modelos de transformación de datos estructurados por capas:

#### `tmp/`
```bash
│   │   ├── tmp/
```
Modelos de staging: `SELECT * FROM tmp_<tabla>` que reproducen los datos sin transformación para facilitar validaciones.

#### `dwa/`
```bash
│   │   ├── dwa/
```
Modelos de limpieza y normalización. Aquí se ajustan tipos de datos, se filtran registros inválidos y se realizan joins simples.

#### `dwm/`
```bash
│   │   ├── dwm/
```
Modelos de memoria histórica. Implementan SCD Tipo 2 para conservar versiones históricas de registros.

#### `dqm/`
```bash
│   │   ├── dqm/
```
Modelos que calculan indicadores de calidad y trazabilidad de ingesta. Incluye métricas como nulos, duplicados, etc.

#### `dp/`
```bash
│   │   └── dp/
```
Vistas finales para dashboards. Muestran datos ya agregados y curados para ser consumidos por Lightdash.

### `schema.yml`
```bash
│   ├── schema.yml
```
Define documentación y tests automáticos (not_null, unique, etc.) para cada modelo y columna de dbt.

### `dbt_project.yml`
```bash
│   └── dbt_project.yml
```
Archivo de configuración principal del proyecto dbt: rutas, capas, materializaciones y nombre del proyecto.

---

## `docs/`

```bash
├── docs/
│   └── flujo-dwa.png
```
Documentación visual. Incluye el diagrama del flujo de datos a través del pipeline ELT.

---

## `docker-compose.yml`
```bash
├── docker-compose.yml
```
Archivo para levantar el entorno completo con Docker: NiFi, PostgreSQL, dbt Core, Lightdash, DBGate, etc.

---

## `README.md`
```bash
├── README.md
```
Explica qué hace el proyecto, cómo usarlo, cómo ejecutar transformaciones y acceder a dashboards.

---

## `scripts/`

```bash
└── scripts/
    ├── create_tables_tmp.sql
    ├── create_tables_dwa.sql
    ├── create_tables_dwm.sql
    ├── create_tables_dqm.sql
    ├── create_tables_dp.sql
    ├── nifi_log_ingesta.sql
    └── lightdash_models.yml
```
Utilidades:
- `create_tables_tmp.sql`: define las tablas de staging (TMP_)
- `create_tables_dwa.sql`: define las tablas del data warehouse (DWA_)
- `create_tables_dwm.sql`: define las tablas del SCD tipo 2 (DWM_)
- `create_tables_dqm.sql`: define las tablas del data quality mart (DQM_)
- `create_tables_dp.sql`: define las tablas de data products (DP_)
- `nifi_log_ingesta.sql`: ejemplo de inserción de log desde NiFi
- `lightdash_models.yml`: mapea métricas y dimensiones para usar los modelos dbt en Lightdash

---

Esta estructura permite aislar responsabilidades por capa, mantener un linaje trazable y facilitar el trabajo colaborativo, tanto para el desarrollo como para la entrega académica o profesional.
