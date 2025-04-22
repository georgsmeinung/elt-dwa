-- Script para crear tabla de memoria histórica de metadatos de modelos (SCD Tipo 2)

CREATE TABLE met_model_registry_hist (
  model_name VARCHAR,
  model_type VARCHAR,
  layer VARCHAR,
  owner VARCHAR,
  description TEXT,
  valid_from TIMESTAMP NOT NULL,
  valid_to TIMESTAMP,
  is_current BOOLEAN DEFAULT TRUE,
  PRIMARY KEY (model_name, valid_from)
);

-- Inserción de nuevos registros como versión histórica
-- Este script simula una actualización con SCD tipo 2 basada en diferencias

WITH changed_models AS (
  SELECT r.*
  FROM met_model_registry r
  LEFT JOIN met_model_registry_hist h
    ON r.model_name = h.model_name AND h.is_current = TRUE
  WHERE h.model_name IS NULL
     OR r.model_type IS DISTINCT FROM h.model_type
     OR r.layer IS DISTINCT FROM h.layer
     OR r.owner IS DISTINCT FROM h.owner
     OR r.description IS DISTINCT FROM h.description
)
-- Cerrar versiones anteriores
UPDATE met_model_registry_hist h
SET valid_to = now(), is_current = FALSE
FROM changed_models c
WHERE h.model_name = c.model_name AND h.is_current = TRUE;

-- Insertar nueva versión como vigente
INSERT INTO met_model_registry_hist (
  model_name, model_type, layer, owner, description, valid_from, is_current
)
SELECT
  model_name, model_type, layer, owner, description, now(), TRUE
FROM changed_models;
