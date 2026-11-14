# Taller 1 · Big Data e Ingeniería de Datos

## Equipo

- Nicolas Hidalgo — Anfitrión.
- Luis Armenta - Calidad y Costos
- Santiago Giraldo - Ingeniero de datos
- Maiyan Yarce - Analista

## Caso elegido

Caso C: Aeropuertos y distritos.

## Modelo

Esquema: CURSO.T1.

Grano del hecho: una fila por fecha, nombre de zona y empresa.

Tablas:
- FACT_VIAJES_DIA.
- DIM_FECHA.
- DIM_ZONA.
- DIM_EMPRESA.

## Orden de ejecución

1. 01_estrella.sql: crea las tablas.
2. 02_carga.sql: carga dimensiones y hecho.
3. 04_chequeos.sql: comprueba calidad e integridad.
4. 03_preguntas.sql: responde las cinco preguntas del caso.
5. verificar_t1.sql del curso: produce la autoverificación.

- 01_estrella.sql reemplaza las tablas existentes.
- 02_carga.sql vacía y recarga las tablas del modelo.

## Documentación

- diagrama.md: estructura y relaciones.
- memo.md: hallazgos, supuestos y límites.
- costos.md: consumo reportado y perfil de ejecución.
- RETOS.md: retos implementados.
- autoverificacion.txt: salida de la autoverificación.



