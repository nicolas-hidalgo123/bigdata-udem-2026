-- GRANO: <escribe aquí, en una frase, qué representa una fila de FACT_VIAJES_DIA. Sugerido: «una fila por fecha, zona y empresa»>
-- =====================================================================
-- TALLER 1 · 01_estrella.sql · DDL de la estrella (esqueleto)
-- Equipo: <nombres> · Anfitrión: <nombre> · Caso elegido: <A, B o C>
-- =====================================================================
-- CÓMO USAR ESTE ARCHIVO
--   1. Copia esta carpeta (plantilla/) a taller1/ en el fork del anfitrión: Add file > Create new
--      file, o Upload files.
--   2. Reemplaza cada línea «TODO» por tu sentencia. Todo se crea en CURSO.T1, con estos nombres:
--      FACT_VIAJES_DIA, DIM_FECHA, DIM_ZONA y DIM_EMPRESA.
--   3. La primera línea de este archivo es el grano. Si cambias el grano sugerido, justifícalo en el memo.
--   4. Cada integrante corre este archivo y 02_carga.sql en su propia cuenta de Snowflake.
--
-- RECORDATORIOS DEL ENUNCIADO (taller1/README.md, secciones 3, 4 y 6)
--   - El hecho guarda medidas aditivas: VIAJES, INGRESO_TOTAL y las sumas que permiten rehacer los
--     promedios (promedio x viajes). La lluvia no va en el hecho.
--   - Cada dimensión tiene una clave única. DIM_ZONA del Lab 4 repite 2 nombres de zona: decide
--     cómo dejar una fila por nombre.
--   - DIM_EMPRESA se construye con SELECT DISTINCT; no escribas los nombres de las empresas a mano.
-- =====================================================================

-- Grano: una fila por fecha, zona y empresa.

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
CREATE SCHEMA IF NOT EXISTS CURSO.T1;
USE SCHEMA CURSO.T1;

CREATE OR REPLACE TABLE DIM_ZONA (
  ZONA_KEY     NUMBER PRIMARY KEY,
  ZONA         VARCHAR,
  BOROUGH      VARCHAR,
  SERVICE_ZONE VARCHAR
);

CREATE OR REPLACE TABLE DIM_EMPRESA (
  EMPRESA_KEY NUMBER PRIMARY KEY,
  EMPRESA     VARCHAR
);

CREATE OR REPLACE TABLE DIM_FECHA (
  FECHA           DATE PRIMARY KEY,
  ANIO            NUMBER,
  MES             NUMBER,
  DIA_SEMANA_NUM  NUMBER,      -- 1 = lunes ... 7 = domingo
  DIA_SEMANA      VARCHAR,
  ES_FIN_SEMANA   BOOLEAN,
  ES_FESTIVO      BOOLEAN,
  NOMBRE_FESTIVO  VARCHAR,
  LLUVIA_MM       FLOAT        -- una vez por día
);

CREATE OR REPLACE TABLE FACT_VIAJES_DIA (
  FECHA              DATE,
  ZONA_KEY           NUMBER,
  EMPRESA_KEY        NUMBER,
  VIAJES             NUMBER,
  INGRESO_TOTAL      FLOAT,
  PROPINA_X_VIAJES   FLOAT,    -- PROPINA_PROMEDIO * VIAJES
  DISTANCIA_X_VIAJES FLOAT     -- DISTANCIA_PROMEDIO * VIAJES
);
