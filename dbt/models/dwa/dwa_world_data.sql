-- models/dwa/dwa_world_data.sql
SELECT
  country,
  life_expectancy,
  gdp,
  population,
  latitude,
  longitude
FROM {{ ref('tmp_world_data_2023') }}
WHERE country IS NOT NULL;
