# Memo · ¿La lluvia cambia los viajes en NYC? (Taller 1)

Equipo: <Nicolas Hidalgo, Luis Armenta, Maiyan Yarce, Santiago Giraldo> · Anfitrión: <Nicolas Hidalgo> · Caso: <C> · Fecha: <2026-11-13>



## Pregunta y decisión

### Pregunta 1: Viajes por distrito (BOROUGH) y mes

 Manhattan lidera la concentración del servicio con 8.251.302 viajes en marzo, seguido de Brooklyn con 5.695.991 y Queens con 4.329.102. 


### Pregunta 2: Ranking de zonas dentro de cada distrito 

Queens concentra sus mayores viajes en LaGuardia (1.069.364) y JFK (1.057.240), mientras Manhattan es liderado por East Village (842.537) y Brooklyn por Crown Heights North (807.434). Esto evidencia que la concentración del servicio varía entre distritos y que las zonas aeroportuarias tienen un peso importante en Queens.

### Pregunta 3: Propina promedio ponderada por distrito y empresa

Lyft presenta una propina promedio ponderada superior a Uber en Bronx (0,38 frente a 0,31), Brooklyn (0,99 frente a 0,73), Manhattan (1,50 frente a 1,43) y Queens (1,30 frente a 1,23). En EWR, Uber registra 11,91, pero corresponde únicamente a 2 viajes, por lo que no es una comparación representativa.

### Pregunta 4: Media móvil de 7 días de viajes: aeropuertos frente al resto

Los aeropuertos son una parte pequeña del servicio: entre 2 % y 6 % de los viajes de cada día. Se comportan al revés que el resto de la ciudad: caen los sábados (mínimo de 13 955 viajes el 3 de febrero) y suben domingos y lunes, mientras el resto tiene sus picos los sábados (868 038 el 9 de marzo). Su media móvil de 7 días se mantiene estable, entre unos 21 000 y 25 000 viajes.

### Pregunta 5: Participación de cada zona en su distrito y su cambio frente al mes anterior

La participación de las zonas dentro de su distrito casi no cambió de febrero a marzo: el mayor movimiento es de 0,51 puntos porcentuales (West Brighton, Staten Island). Seis de las diez zonas con más cambio son de Staten Island, el distrito con menos viajes, donde una variación pequeña pesa más. Los aeropuertos de Queens ganaron un poco de peso: JFK +0,38 y LaGuardia +0,19 puntos. En general, el reparto de la demanda dentro de cada distrito es estable.

## Hallazgos

>## Hallazgos

1. **Los aeropuertos dominan Queens.** LaGuardia (1 069 364 viajes) y JFK (1 057 240) casi empatan y suman más del doble que la tercera zona, Astoria (588 138). *Significa* que en Queens el servicio depende mucho de dos puntos. *No significa* que los aeropuertos sean importantes para toda la ciudad: sumados son cerca del 3,5 % de los 60 268 466 viajes.

2. **Manhattan reparte la demanda entre varias zonas.** East Village (842 537), Times Sq/Theatre District (738 384) y Midtown Center (716 124) quedan a menos del 18 % de distancia entre sí. *Significa* que ninguna zona concentra el distrito. *No significa* que East Village sea la zona con más movimiento de personas: los datos solo cuentan viajes de Uber y Lyft, y no incluyen los taxis amarillos.

3. **Los aeropuertos se mueven al revés que el resto de la ciudad.** Pesan entre 2 % y 6 % de los viajes de cada día y caen los sábados (mínimo de 13 955 viajes el 3 de febrero), cuando el resto de la ciudad tiene sus picos (868 038 el 9 de marzo). *Significa* que el servicio no se puede planear igual para ambos. *No significa* que sepamos la causa: los datos muestran el patrón, no lo explican.

4. **El reparto dentro de cada distrito casi no cambió de febrero a marzo.** Ninguna zona se movió más de 0,6 puntos porcentuales. *Significa* que la demanda se mantiene estable en el trimestre. *No significa* que sea igual en otras épocas del año: solo hay tres meses.

## Supuestos y definiciones


- **Nombres de zona repetidos.** Dos nombres tenían más de un código y unirlos habría inflado los viajes en 0,3 %. Dejamos una fila por nombre (262 zonas) y el total sigue en 60 268 466 viajes.
- **Aeropuertos.** Contamos JFK, LaGuardia y también Newark. Newark solo tiene 2 viajes, así que no cambia ningún resultado.
- **`Unknown` y `N/A`.** Se mantienen en los totales y se excluyen de los rankings.
- **Propina.** Se promedió ponderando por viajes, para que los grupos grandes pesen más.
- **Días completos.** Las medias móviles usan los 91 días del trimestre, con 0 viajes cuando no hubo servicio.
- **Alcance.** Solo viajes de Uber y Lyft, por zona de recogida, de enero a marzo de 2024.

## Trampa evitada

**Nombres de zona repetidos.** Los viajes identifican la zona por nombre, pero la tabla de zonas repite dos nombres con varios códigos (Corona y Governor's Island/Ellis Island/Liberty Island). Al unir por nombre sin cuidado, cada viaje de esas zonas se copia una vez por código. Habría agregado **196 filas y 184 265 viajes de más** (cerca del 0,3 %), y el total habría sido 60 452 731 en vez de **60 268 466**. La cifra parece válida, pero está inflada.

**Qué hicimos:** dejamos una fila por nombre en la tabla de zonas (262 zonas) y comprobamos, antes y después de unir, que el hecho conserva 46 715 filas y 60 268 466 viajes.

## Límites

- **Solo tres meses de un año.** Los datos van de enero a marzo de 2024 (invierno), así que no sirven para hablar de verano ni de otros años. El patrón de febrero a marzo puede ser distinto en otras épocas.
- **Solo Uber y Lyft.** No incluyen taxis amarillos, ni transporte público ni otros servicios, por lo que no miden todo el movimiento de personas en la ciudad.
- **Solo la zona de recogida.** No sabemos a dónde fueron los viajes, así que no podemos decir qué zonas reciben más gente, solo de cuáles salen más viajes.

## Coevaluación

# COEVALUACIÓN DEL EQUIPO
**Asignatura:** Big Data e Ingeniería de Datos  
**Actividad:** Taller 1 – Caso C: Aeropuertos y distritos  
**Número de integrantes:** 4

## Criterios de evaluación

Calificar cada criterio de 1 a 5, donde:

- **5:** Excelente
- **4:** Bueno
- **3:** Aceptable
- **2:** Bajo
- **1:** Deficiente

Criterios:
1. **Responsabilidad:** cumplió con las tareas asignadas y los tiempos establecidos.
2. **Participación:** aportó ideas y contribuyó al desarrollo del taller.
3. **Trabajo en equipo:** mantuvo una comunicación respetuosa y colaboró con sus compañeros.
4. **Compromiso:** mostró interés y disposición para resolver dificultades.
5. **Calidad del aporte:** entregó trabajo útil y pertinente para alcanzar los objetivos del proyecto.

---

## COEVALUACIÓN 1

**Integrante que evalúa:** Nicolas hidalgo

| Compañero evaluado | Responsabilidad | Participación | Trabajo en equipo | Compromiso | Calidad del aporte |
|---|---:|---:|---:|---:|---:|
| Luis Armenta  | 5 | 5 | 5 | 5 | 5 |
| Santiago Giraldo | 5 | 5 | 5 | 5 | 5 |
| Maiyan Yarce| 5 | 5 | 5 | 5 | 5 |

**Observaciones generales:**

________________________________________________

## COEVALUACIÓN 2

**Integrante que evalúa:** Luis Jose Armenta

| Compañero evaluado | Responsabilidad | Participación | Trabajo en equipo | Compromiso | Calidad del aporte |
|---|---:|---:|---:|---:|---:|
| Nicolas Hidalgo | 5 | 5 | 5 | 5 | 5 |
| Santiago Giraldo | 5 | 5 | 5 | 5 | 5 |
| Maiyan Yarce | 5 | 5 | 5 | 5 | 5 |

**Observaciones generales:**

________________________________________________

## COEVALUACIÓN 3

**Integrante que evalúa:** ______________________

| Compañero evaluado | Responsabilidad | Participación | Trabajo en equipo | Compromiso | Calidad del aporte |
|---|---:|---:|---:|---:|---:|
| Integrante 1 | ___ | ___ | ___ | ___ | ___ |
| Integrante 2 | ___ | ___ | ___ | ___ | ___ |
| Integrante 4 | ___ | ___ | ___ | ___ | ___ |

**Observaciones generales:**

________________________________________________

## COEVALUACIÓN 4

**Integrante que evalúa:** Maiyan Yarce

| Compañero evaluado | Responsabilidad | Participación | Trabajo en equipo | Compromiso | Calidad del aporte |
|---|---:|---:|---:|---:|---:|
| Nicolás Hidalgo | 5 | 5 | 5 | 5 | 5 |
| Santiago Giraldo | 5 | 5 | 5 | 5 | 5 |
| Luis Armenta | 5 | 5 | 5 | 5 | 5 |

**Observaciones generales:**

________________________________________________

---

## Comentario general del equipo

Durante el desarrollo del Taller 1, todos los 4 integrantes trabajarmos en conjunto para cumplir con los objetivos propuestos. Nos  distribuímos responsabilidades relacionadas con el análisis de los datos, el diseño del modelo dimensional, las consultas SQL y la interpretación de los resultados. La colaboración y la comunicación fueron importantes para avanzar en las actividades y resolver las dificultades que se presentaron.


