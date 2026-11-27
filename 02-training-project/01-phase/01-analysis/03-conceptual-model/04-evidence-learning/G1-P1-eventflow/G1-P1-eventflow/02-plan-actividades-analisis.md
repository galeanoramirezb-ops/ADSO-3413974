# 2. Plan de actividades de análisis (Scrum)

**Proyecto:** EventFlow Manager (SIGEV) · **Metodología:** Scrum (ver `01-caracterizacion-y-metodologia.md`)
**Equipo:** Brenda G. (Scrum Master, analista y UI/UX) · Andrés C. (desarrollador, QA y base de datos) · Product Owner: instructor de la ficha

La fase de análisis se organiza en **2 sprints de una semana**. Cada sprint cierra con la Sprint Review frente al Product Owner. Las actividades están priorizadas con MoSCoW (M = imprescindible, S = importante, C = deseable) y en orden de dependencia.

## Sprint A1 · Requisitos y casos de uso (23 al 28 de noviembre de 2026)

**Objetivo del sprint:** dejar los requisitos depurados y el modelo de casos de uso trazado al 100 % de los RF.

| # | Actividad | Prioridad | Responsable | Fecha | Entregable | Depende de |
|---|---|---|---|---|---|---|
| A1 | Sprint Planning del análisis: definir el objetivo, seleccionar las actividades y acordar la Definición de Hecho | M | Brenda G. y Andrés C. | Lun 23/11/2026 | Sprint backlog del sprint A1 | – |
| A2 | Depurar el SRS: unificar el nombre del sistema, separar RF de RNF, actualizar el equipo y revisar que cada RF sea verificable | M | Andrés C. | Lun 23/11/2026 | SRS depurado (lista RF1–RF13 y RNF-01–RNF-10) | A1 |
| A3 | Caracterizar la solución, comparar metodologías y seleccionar una | M | Brenda G. | Mar 24/11/2026 | `01-caracterizacion-y-metodologia.md` | A2 |
| A4 | Refinar el Product Backlog: ligar cada historia de usuario (HU-01 a HU-12) a sus RF y priorizar con MoSCoW | M | Andrés C. | Mar 24/11/2026 | Backlog priorizado | A2 |
| A5 | Modelar el diagrama de casos de uso con actores, frontera, «include», «extend» y generalización | M | Brenda G. | Mié 25/11/2026 | `diagrama-casos-uso.drawio` y `.png` | A2, A4 |
| A6 | Justificar las relaciones del diagrama y revisarlo contra las reglas UML (ciclos, duplicados, nombres en forma de verbo + objeto) | M | Brenda G. | Mié 25/11/2026 | `03-casos-de-uso-y-relaciones.md` | A5 |
| A7 | Construir la matriz requisito → caso de uso y medir la cobertura | M | Brenda G. | Jue 26/11/2026 | `04-matriz-requisitos-casos-uso.md` | A5 |
| A8 | Revisión cruzada: Andrés C. verifica el diagrama y la matriz, y Brenda G. corrige | S | Andrés C. | Vie 27/11/2026 | Observaciones registradas y corregidas | A6, A7 |
| A9 | Sprint Review con el Product Owner: presentar los casos de uso y la matriz, y recoger observaciones | M | Brenda G. y Andrés C. | Sáb 28/11/2026 | Observaciones del Product Owner | A8 |
| A10 | Retrospectiva del sprint A1 | S | Brenda G. y Andrés C. | Sáb 28/11/2026 | 3 acciones de mejora | A9 |

## Sprint A2 · Modelo de análisis y verificación (30 de noviembre al 5 de diciembre de 2026)

**Objetivo del sprint:** detallar los casos críticos (CU-05, CU-07 y CU-09), modelar el negocio y los datos, y verificar el análisis.

| # | Actividad | Prioridad | Responsable | Fecha | Entregable | Depende de |
|---|---|---|---|---|---|---|
| A11 | Especificar las plantillas extendidas de los casos críticos (CU-05, CU-07 y CU-09) | M | Brenda G. | Lun 30/11/2026 | 3 plantillas extendidas | A9 |
| A12 | Elaborar los diagramas de actividades de CU-07 y CU-09 | M | Brenda G. | Mar 01/12/2026 | 2 diagramas de actividades | A11 |
| A13 | Construir el modelo de dominio y el modelo entidad-relación | M | Andrés C. | Mar 01/12/2026 | Modelo de dominio y MER | A11 |
| A14 | Ajustar los mockups de las 3 pantallas críticas y rotularlas con su caso de uso | S | Brenda G. | Mié 02/12/2026 | Prototipo de 3 pantallas | A11 |
| A15 | Verificar el análisis con la lista de chequeo, corregir y volver a verificar | M | Andrés C. | Jue 03/12/2026 | Lista de chequeo y registro de ajustes | A12, A13, A14 |
| A16 | Redactar el informe de análisis y la matriz de trazabilidad completa | M | Brenda G. | Vie 04/12/2026 | Informe y matriz de trazabilidad | A15 |
| A17 | Sprint Review y retrospectiva del sprint A2 | M | Brenda G. y Andrés C. | Sáb 05/12/2026 | Aprobación del análisis por el Product Owner | A16 |

> Nota: las fechas del sprint A2 son las del plan del proyecto. Los productos de la Guía 1 se entregan en las fechas que fija la guía.

## Cronograma resumido

```
Semana 23–28 nov (Sprint A1)  L  M  M  J  V  S
A1 Planning                   ■
A2 Depurar SRS                ■
A3 Metodología                   ■
A4 Backlog                       ■
A5–A6 Casos de uso                  ■
A7 Matriz RF→CU                        ■
A8 Revisión cruzada                       ■
A9–A10 Review y retro                        ■

Semana 30 nov–5 dic (Sprint A2) L  M  M  J  V  S
A11 Plantillas extendidas     ■
A12 Diagramas de actividades     ■
A13 Dominio y MER                ■
A14 Mockups                         ■
A15 Verificación                       ■
A16 Informe y trazabilidad                ■
A17 Review y retro                           ■
```

**Ceremonias fijas:** daily de 15 minutos (por mensaje o llamada) todos los días hábiles. Sprint Review y retrospectiva cada sábado con el Product Owner.
