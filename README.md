# Proyecto DWA - Data Warehouse Automation con NiFi, dbt, PostgreSQL y Lightdash

## 📌 Descripción General
Este proyecto implementa un flujo completo de Data Warehouse Automation (DWA) solicitado por la materia "Introducción a Data Warehousing". Utiliza herramientas 100% open source orquestadas con Docker Compose:

- **Apache NiFi**: Ingesta y carga de archivos CSV
- **PostgreSQL**: Base de datos para staging y DWA
- **dbt Core**: Transformación, documentación y control de calidad
- **Lightdash**: Visualización y dashboards
- **DBGate**: Administración visual de la base de datos

## 🔄 Flujo de Datos

```
[CSV] → NiFi → TMP_ (PostgreSQL) → dbt → DWA_ / DQM_ / DWM_ / DP_ → Lightdash
```

## 🧱 Estructura de Capas
- `TMP_`: staging crudo desde NiFi
- `DWA_`: modelo limpio y validado
- `DWM_`: memoria histórica con SCD tipo 2
- `DQM_`: data quality mart (indicadores de calidad)
- `DP_`: producto de datos para dashboards

## 🧭 Trazabilidad de Datos (End-to-End Lineage)

- **Desde Lightdash hasta dbt**: el lineage es automático
- **Desde dbt a TMP_**: visible en `dbt docs`
- **Desde TMP_ al CSV original**: trazabilidad registrada en la tabla `dqm_ingesta_log`

```sql
-- Tracking automático por NiFi:
INSERT INTO dqm_ingesta_log (tabla, archivo, registros)
VALUES ('tmp_orders', 'orders_2023.csv', 1540);
```

- **Modelo dbt**: `dqm_ingesta_tracking.sql` permite visualizar estas cargas en dashboards Lightdash

## 📊 Dashboards Lightdash

### 1. `Ventas por País y Cliente`
- Fuente: `dp_sales_summary`
- Visualizaciones: barras por país, tabla por cliente/empleado, serie temporal

### 2. `Top 10 Países por Ingresos`
- Fuente: `dp_top_countries`
- Visualizaciones: columnas y tabla de resumen

### 3. `Historial de Ingesta de Datos`
- Fuente: `dqm_ingesta_tracking`
- Muestra qué archivos se cargaron, cuándo y con cuántos registros

## 🚀 Cómo ejecutar
1. Clonar este repositorio
2. Colocar los CSV en `./data/ingesta1/`
3. Ejecutar:
```bash
docker compose up -d
```
4. Acceder a:
   - NiFi: http://localhost:8080
   - DBGate: http://localhost:8082
   - Lightdash: http://localhost:8081
5. Ejecutar transformaciones:
```bash
docker exec -it elt_dbt dbt run
```

## 📂 Estructura del Proyecto
```
├── dbt/
│   ├── models/
│   │   ├── tmp/
│   │   ├── dwa/
│   │   ├── dwm/
│   │   ├── dqm/
│   │   ├── dp/
├── data/ingesta1/
├── docker-compose.yml
└── README.md
```

---

**Autores**: Cancelas, Nicolau, Verdejo - Introducción a Data Warehouse - 2025

