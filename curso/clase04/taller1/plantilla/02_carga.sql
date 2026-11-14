-- =====================================================================
-- TALLER 1 · 02_carga.sql · Carga reproducible desde el Lab 4 (esqueleto)
-- =====================================================================
-- CÓMO USAR ESTE ARCHIVO
--   Reemplaza cada línea «TODO» por tu sentencia (INSERT INTO ... SELECT o CREATE TABLE ... AS
--   SELECT). El archivo se puede correr más de una vez y deja siempre el mismo resultado: carga
--   las dimensiones primero y el hecho después. Los datos de partida están en CURSO.LAB4:
--   DAILY_ZONE_METRICS (46715 filas), DIM_ZONA (265 filas) y FESTIVOS_2024 (11 filas).
--
-- ANTES DE CARGAR EL HECHO
--   Si unes el gold con DIM_ZONA por el nombre de la zona, cuenta las filas antes y después de
--   unir: 46715 antes (trampa 4 del enunciado).
-- =====================================================================

-- CARGA reproducible: se puede correr varias veces sin duplicar filas.
-- Orden: dimensiones primero, hecho al final.
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE SCHEMA CURSO.T1;
-- 1. DIM_ZONA: una fila por nombre de zona (trampa 4)
TRUNCATE TABLE DIM_ZONA;
INSERT INTO DIM_ZONA
SELECT ROW_NUMBER() OVER (ORDER BY ZONA), ZONA, BOROUGH, SERVICE_ZONE
FROM (SELECT DISTINCT ZONA, BOROUGH, SERVICE_ZONE FROM CURSO.LAB4.DIM_ZONA);
-- 2. DIM_EMPRESA: construida con DISTINCT, no a mano
TRUNCATE TABLE DIM_EMPRESA;
INSERT INTO DIM_EMPRESA
SELECT ROW_NUMBER() OVER (ORDER BY EMPRESA), EMPRESA
FROM (SELECT DISTINCT EMPRESA FROM CURSO.LAB4.DAILY_ZONE_METRICS);
-- 3. DIM_FECHA: lluvia una sola vez por día (trampa 1)
TRUNCATE TABLE DIM_FECHA;
INSERT INTO DIM_FECHA
WITH r AS (
SELECT MIN(FECHA) AS MINF, MAX(FECHA) AS MAXF
FROM CURSO.LAB4.DAILY_ZONE_METRICS
),
d AS (
SELECT DATEADD('day', ROW_NUMBER() OVER (ORDER BY SEQ4()) - 1, MINF) AS FECHA
FROM r, TABLE(GENERATOR(ROWCOUNT => 400))
QUALIFY FECHA <= MAXF
),
ll AS (
SELECT FECHA, MAX(LLUVIA_MM) AS LLUVIA_MM
FROM CURSO.LAB4.DAILY_ZONE_METRICS
GROUP BY FECHA
)
SELECT d.FECHA, YEAR(d.FECHA), MONTH(d.FECHA),
DAYOFWEEKISO(d.FECHA), DAYNAME(d.FECHA),
DAYOFWEEKISO(d.FECHA) >= 6,
f.FECHA IS NOT NULL, f.NOMBRE,
ll.LLUVIA_MM
FROM d
LEFT JOIN ll ON ll.FECHA = d.FECHA
LEFT JOIN CURSO.LAB4.FESTIVOS_2024 f ON f.FECHA = d.FECHA;
-- 4. FACT_VIAJES_DIA: se une por nombre contra la dimensión ya depurada
TRUNCATE TABLE FACT_VIAJES_DIA;
INSERT INTO FACT_VIAJES_DIA
SELECT g.FECHA, z.ZONA_KEY, e.EMPRESA_KEY,
g.VIAJES, g.INGRESO_TOTAL,
g.PROPINA_PROMEDIO * g.VIAJES,
g.DISTANCIA_PROMEDIO * g.VIAJES
FROM CURSO.LAB4.DAILY_ZONE_METRICS g
JOIN DIM_ZONA z ON g.ZONA = z.ZONA
JOIN DIM_EMPRESA e ON g.EMPRESA = e.EMPRESA;
-- 5. Conteo de control contra el paquete
SELECT 'origen' AS FUENTE, COUNT(*) AS FILAS, SUM(VIAJES) AS VIAJES
FROM CURSO.LAB4.DAILY_ZONE_METRICS
UNION ALL
SELECT 'hecho', COUNT(*), SUM(VIAJES) FROM FACT_VIAJES_DIA;

SELECT (SELECT COUNT(*) FROM DIM_ZONA) AS DIM_ZONA,
(SELECT COUNT(*) FROM DIM_EMPRESA) AS DIM_EMPRESA,
(SELECT COUNT(*) FROM DIM_FECHA) AS DIM_FECHA;