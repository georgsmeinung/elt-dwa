# Estructura del Repositorio `elt-dwa`

Este archivo describe la organización del repositorio del proyecto de Data Warehouse Automation (DWA) utilizando **SQLMesh**, **PostgreSQL**, **Apache NiFi**, **Lightdash** y otras herramientas open source.

---

## 📁 `models/`
Contiene todos los modelos SQL que definen las transformaciones por capas.

### 📂 `models/tmp/`
- Modelos de staging (`tmp_`) que replican las tablas cargadas por NiFi en PostgreSQL.
- No aplican transformaciones, solo exponen los datos crudos.

### 📂 `models/dwa/`
- Modelos transformados y validados (`dwa_`).
- Aplican cast de tipos, filtros, limpieza de datos, joins.
- Esta es la capa del Data Warehouse "limpio".

### 📂 `models/dwm/`
- Modelos con memoria histórica (`dwm_`) usando SCD tipo 2.
- Conservan versiones anteriores de los registros con columnas `valid_from`, `valid_to`, `is_current`.

### 📂 `models/dqm/`
- Modelos de calidad de datos (`dqm_`).
- Calculan métricas como valores nulos, duplicados, inconsistencias y log de ingesta (`dqm_ingesta_tracking`).

### 📂 `models/dp/`
- Producto de datos (`dp_`): vistas finales para análisis y dashboards.
- Contienen agregaciones, métricas y dimensiones utilizadas por Lightdash.

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
