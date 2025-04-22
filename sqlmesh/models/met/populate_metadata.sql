-- Script SQL para poblar met_model_columns usando metadata de PostgreSQL

INSERT INTO met_model_columns (model_name, column_name, data_type, is_nullable, is_primary_key, description)
SELECT
    table_name AS model_name,
    column_name,
    data_type,
    is_nullable = 'YES' AS is_nullable,
    FALSE AS is_primary_key,  -- Puede ajustarse con otra consulta
    NULL AS description       -- Puede actualizarse manualmente luego
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN (
    SELECT model_name FROM met_model_registry
  );

-- Para actualizar los campos de clave primaria (is_primary_key),
-- Ejecutar un UPDATE basado en pg_constraint + pg_attribute si se desea mayor precisión.

-- Ejemplo 
-- UPDATE met_model_columns SET is_primary_key = TRUE
-- WHERE (model_name, column_name) IN (
--   SELECT c.relname, a.attname
--   FROM pg_index i
--   JOIN pg_class c ON c.oid = i.indrelid
--   JOIN pg_attribute a ON a.attrelid = c.oid AND a.attnum = ANY(i.indkey)
--   WHERE i.indisprimary
-- );
