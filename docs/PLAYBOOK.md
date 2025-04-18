# 📘 PLAYBOOK: Automatización de Data Warehouse con SQLMesh

Este playbook guía paso a paso cómo implementar una arquitectura de **Data Warehouse Automation (DWA)** utilizando únicamente **SQLMesh**. Todo el flujo es 100% open source.

---

## 🔧 Requisitos Previos

- Docker y Docker Compose instalados
- Acceso a una terminal (Linux, macOS, Windows WSL)
- Clonar este repositorio:

```bash
git clone <url-del-repo>
cd elt-dwa-sqlmesh
```

---

## 🚀 Paso 1: Levantar el entorno

```bash
docker compose up -d
```

Esto levanta los siguientes servicios:
- PostgreSQL → base de datos del DWH
- SQLMesh UI → entorno visual de modelado y ejecución
- Apache NiFi → para ingestión visual de archivos CSV
- Lightdash → dashboards sobre los modelos `dp_`
- DBGate → para consultar y validar los datos manualmente

---

## 🗂 Paso 2: Cargar archivos de datos

1. Accedé a NiFi en `http://localhost:8080`
2. Diseñá un flujo para cargar los CSV desde `./data/ingesta1/` hacia PostgreSQL
3. Las tablas deben llamarse con prefijo `tmp_` (por ejemplo, `tmp_orders`, `tmp_customers`)

> Alternativamente, podés usar DBGate para cargar datos manualmente.

---

## 🧠 Paso 3: Comprender las capas del modelo

```plaintext
[CSV] → NiFi → TMP_ (staging) → SQLMesh → DWA_ / DWM_ / DQM_ / DP_ → Lightdash
```

- `tmp_`: staging directo desde los CSV
- `dwa_`: transformaciones limpias y normalizadas
- `dwm_`: modelos históricos (SCD Tipo 2)
- `dqm_`: control de calidad (nulos, duplicados, trazabilidad)
- `dp_`: vistas finales para dashboards y BI

---

## ✍️ Paso 4: Editar modelos SQL

Los modelos están en `./models/` organizados por capa. Cada archivo `.sql` contiene:

1. Un bloque `MODEL(...)` de configuración
2. Una query SQL estándar

Ejemplo:
```sql
MODEL (
  name d_wa_orders,
  kind FULL,
  cron '@daily'
);

SELECT * FROM model('tmp_orders') WHERE orderdate IS NOT NULL;
```

- `model('tmp_orders')` define la dependencia entre modelos
- Cada archivo es autocontenido y versionable

---

## ⚙️ Paso 5: Compilar y aplicar los modelos

Desde la terminal:

```bash
docker exec -it elt_sqlmesh bash
cd /app/sqlmesh
sqlmesh plan
sqlmesh apply
```

- `plan` verifica qué modelos cambiaron y simula el impacto
- `apply` ejecuta las transformaciones en orden correcto

> También podés hacerlo desde la UI: `http://localhost:8084`

---

## 🧪 Paso 6: Ver y validar los resultados

### DBGate
- URL: `http://localhost:8082`
- Usuario: `elt_user`, Contraseña: `elt_pass`
- Consultá las tablas `dwa_`, `dwm_`, `dqm_`, `dp_`

### Lightdash
- URL: `http://localhost:8081`
- Explora dashboards directamente desde las vistas `dp_*`

---

## 🧩 Estructura del proyecto

```bash
elt-dwa/
├── models/                      # Modelos SQL por capa
│   ├── tmp/                     # Staging
│   ├── dwa/                     # Transformaciones limpias
│   ├── dwm/                     # Históricos con SCD2
│   ├── dqm/                     # Calidad de datos
│   └── dp/                      # Producto de datos
├── docs/                      # Documentacion detallada
├── sqlmesh_project.toml        # Configuración del proyecto
├── docker-compose.yml          # Servicios y puertos
├── data/ingesta1/              # Archivos CSV
└── README.md                   # Documentación principal

```

---

## 🧠 Tips adicionales

- SQLMesh puede trabajar con múltiples entornos (`dev`, `prod`) y comparar resultados
- Las transformaciones son **SQL + YAML**, sin necesidad de Python
- Podés agregar tests custom con Python si lo necesitás
