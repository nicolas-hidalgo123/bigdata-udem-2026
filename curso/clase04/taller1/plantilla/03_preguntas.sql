-- =====================================================================
-- TALLER 1 · 03_preguntas.sql · Las cinco preguntas del caso (esqueleto)
-- =====================================================================
-- Caso elegido: <A · Competencia entre plataformas | B · Clima y festivos | C · Aeropuertos y distritos>
-- Entre las cinco preguntas usa al menos: RANK con QUALIFY, LAG y una agregación de ventana
-- (SUM o AVG con OVER). Cada pregunta lleva su enunciado arriba, su consulta y, debajo, un
-- comentario que interprete el resultado (qué dice el número y qué no dice).
-- =====================================================================

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE SCHEMA CURSO.T1;

-- ---------------------------------------------------------------------
-- Pregunta 1: <copia el enunciado de la pregunta 1 de tu caso>
-- ---------------------------------------------------------------------
-- TODO · consulta
-- Interpretación: <qué dice el resultado, en una o dos frases>

-- ---------------------------------------------------------------------
-- Pregunta 2: Ranking de zonas dentro de cada distrito 
WITH zb AS (
  SELECT z.BOROUGH, z.ZONA, SUM(f.VIAJES) AS VIAJES
  FROM FACT_VIAJES_DIA f
  JOIN DIM_ZONA z ON f.ZONA_KEY = z.ZONA_KEY
  WHERE z.BOROUGH NOT IN ('Unknown', 'N/A')
  GROUP BY z.BOROUGH, z.ZONA
)
SELECT BOROUGH, ZONA, VIAJES,
       RANK() OVER (PARTITION BY BOROUGH ORDER BY VIAJES DESC) AS RK
FROM zb
QUALIFY RK <= 3
ORDER BY BOROUGH, RK;
--Interpretación: En Queens el ranking lo encabezan los dos aeropuertos,
-- LaGuardia (1 069 364 viajes) y JFK (1 057 240), casi empatados; juntos
-- duplican a la tercera zona, Astoria (588 138). Es la mayor concentración
-- entre los distritos (la zona 1 tiene 1,8 veces los viajes de la zona 3).
-- Manhattan, en cambio, reparte la demanda: East Village (842 537), Times
-- Sq/Theatre District (738 384) y Midtown Center (716 124) están a menos de
-- 18 % de distancia. Brooklyn y el Bronx los lideran zonas residenciales
-- (Crown Heights North, 807 434; Mott Haven/Port Morris, 361 546), y Staten
-- Island tiene el menor volumen (líder: Saint George/New Brighton, 122 492).
-- Newark Airport (EWR) aparece con solo 2 viajes, por lo que su peso es
-- insignificante y por eso es la única zona de su distrito.
-- Unknown y N/A se excluyeron del ranking porque no son lugares reales.

-- ---------------------------------------------------------------------
-- Pregunta 3: <copia el enunciado>
-- ---------------------------------------------------------------------
-- TODO · consulta
-- Interpretación: <...>

-- ---------------------------------------------------------------------
-- Pregunta 4: Media móvil de 7 días de viajes: aeropuertos frente al resto
-- ---------------------------------------------------------------------
WITH grupos AS (
  SELECT 'Aeropuertos' AS GRUPO UNION ALL SELECT 'Resto'
),
diario AS (
  SELECT f.FECHA,
         IFF(z.SERVICE_ZONE IN ('Airports', 'EWR'), 'Aeropuertos', 'Resto') AS GRUPO,
         SUM(f.VIAJES) AS VIAJES
  FROM FACT_VIAJES_DIA f
  JOIN DIM_ZONA z ON f.ZONA_KEY = z.ZONA_KEY
  GROUP BY 1, 2
),
serie AS (
  SELECT d.FECHA, g.GRUPO, COALESCE(x.VIAJES, 0) AS VIAJES
  FROM DIM_FECHA d
  CROSS JOIN grupos g
  LEFT JOIN diario x ON x.FECHA = d.FECHA AND x.GRUPO = g.GRUPO
)
SELECT FECHA, GRUPO, VIAJES,
       ROUND(AVG(VIAJES) OVER (PARTITION BY GRUPO ORDER BY FECHA
             ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS MEDIA_MOVIL_7D,
       COUNT(*) OVER (PARTITION BY GRUPO ORDER BY FECHA
             ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS DIAS_VENTANA,
       ROUND(VIAJES * 100 / SUM(VIAJES) OVER (PARTITION BY FECHA), 2) AS PCT_DEL_DIA
FROM serie
ORDER BY GRUPO, FECHA;
-- Interpretación: (¿qué porcentaje del total son los aeropuertos? ¿su media móvil es más estable o más volátil que la del resto?)
-- Inter-- Interpretación: Los aeropuertos son una parte pequeña del servicio: entre
-- 2 % y 6 % de los viajes de cada día. Se comportan al revés que el resto de
-- la ciudad: caen los sábados (mínimo de 13 955 viajes el 3 de febrero) y
-- suben domingos y lunes, mientras el resto tiene sus picos los sábados
-- (868 038 el 9 de marzo). Su media móvil de 7 días se mantiene estable,
-- entre unos 21 000 y 25 000 viajes.pretación: <...>

-- ---------------------------------------------------------------------
-- Pregunta 5: Participación de cada zona en su distrito y su cambio frente al mes anterior
-- ---------------------------------------------------------------------
WITH zm AS (
  SELECT z.BOROUGH, z.ZONA, d.MES, SUM(f.VIAJES) AS VIAJES
  FROM FACT_VIAJES_DIA f
  JOIN DIM_ZONA  z ON f.ZONA_KEY = z.ZONA_KEY
  JOIN DIM_FECHA d ON f.FECHA = d.FECHA
  WHERE z.BOROUGH NOT IN ('Unknown', 'N/A')
  GROUP BY z.BOROUGH, z.ZONA, d.MES
),
part AS (
  SELECT BOROUGH, ZONA, MES, VIAJES,
         VIAJES / SUM(VIAJES) OVER (PARTITION BY BOROUGH, MES) AS PART
  FROM zm
),
res AS (
  SELECT BOROUGH, ZONA, MES, VIAJES,
         ROUND(PART * 100, 2) AS PART_PCT,
         IFF(MES - LAG(MES) OVER (PARTITION BY BOROUGH, ZONA ORDER BY MES) = 1,
             ROUND((PART - LAG(PART) OVER (PARTITION BY BOROUGH, ZONA ORDER BY MES)) * 100, 2),
             NULL) AS CAMBIO_PP
  FROM part
)
-- Las 10 zonas cuya participación más cambió de febrero a marzo
SELECT * FROM res
WHERE MES = 3 AND CAMBIO_PP IS NOT NULL
ORDER BY ABS(CAMBIO_PP) DESC
LIMIT 10;
-- Interpretación: La participación de las zonas dentro de su distrito casi no
-- cambió de febrero a marzo: el mayor movimiento es de 0,51 puntos
-- porcentuales (West Brighton, Staten Island). Seis de las diez zonas con
-- más cambio son de Staten Island, el distrito con menos viajes, donde una
-- variación pequeña pesa más. Los aeropuertos de Queens ganaron un poco de
-- peso: JFK +0,38 y LaGuardia +0,19 puntos. En general, el reparto de la
-- demanda dentro de cada distrito es estable.
