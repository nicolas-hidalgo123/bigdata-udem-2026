-- GRANO: una fila por fecha, nombre de zona y empresa.
-- Taller 1 · Caso C: Aeropuertos y distritos.
-- Equipo: Nicolas Hidalgo, Luis Armenta, Santiago Giraldo y Maiyan Yarce.
-- Anfitrión: Nicolas Hidalgo.
-- Destino: CURSO.T1.
-- Las claves y los totales se validan mediante 04_chequeos.sql.


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
