-- =====================================================================
-- TALLER 1 · 04_chequeos.sql · Los cuatro controles de integridad (esqueleto)
-- =====================================================================
-- Los cuatro controles del enunciado (sección 15): filas, grano único, sin huérfanos y viajes
-- totales contra el origen. Debajo está la consulta del enunciado como punto de partida:
-- descoméntala y ajusta los nombres de tus llaves (ZONA_KEY, EMPRESA_KEY) a los de tu estrella.
-- Salida esperada: cuatro filas con HECHO igual a ESPERADO.
-- Si `filas` o `viajes` no coinciden, revisa la trampa 4; si `grano` es menor que `filas`, hay duplicados.
-- =====================================================================

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE SCHEMA CURSO.T1;


SELECT 'filas' AS CONTROL, COUNT(*) AS HECHO, 46715 AS ESPERADO
FROM FACT_VIAJES_DIA
UNION ALL
SELECT 'grano', COUNT(DISTINCT FECHA || '|' || ZONA_KEY || '|' || EMPRESA_KEY), 46715
FROM FACT_VIAJES_DIA
UNION ALL
SELECT 'sin zona', COUNT(*), 0
FROM FACT_VIAJES_DIA F LEFT JOIN DIM_ZONA Z ON F.ZONA_KEY = Z.ZONA_KEY
WHERE Z.ZONA_KEY IS NULL
UNION ALL
SELECT 'sin empresa', COUNT(*), 0
FROM FACT_VIAJES_DIA F LEFT JOIN DIM_EMPRESA E ON F.EMPRESA_KEY = E.EMPRESA_KEY
WHERE E.EMPRESA_KEY IS NULL
UNION ALL
SELECT 'sin fecha', COUNT(*), 0
FROM FACT_VIAJES_DIA F LEFT JOIN DIM_FECHA D ON F.FECHA = D.FECHA
WHERE D.FECHA IS NULL
UNION ALL
SELECT 'viajes', SUM(VIAJES), 60268466
FROM FACT_VIAJES_DIA;


