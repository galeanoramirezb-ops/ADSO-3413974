# 2. Lista de chequeo de validación del análisis (Anexo B)

**Aplicada a:** los artefactos de G1-P1 y G1-P2 de EventFlow Manager (SIGEV).

- **Primera verificación:** 25/11/2026, sobre la versión base (SRS del equipo y los primeros borradores).
- **Segunda verificación:** 26/11/2026, después de los ajustes registrados en `03-registro-ajustes.md`.

Cada criterio se responde **sí o no**, con evidencia. Los criterios 1 a 5 son de **cobertura o trazabilidad**.

| # | Criterio verificable (sí / no) | Artefacto | 1.ª verif. | 2.ª verif. | Evidencia | Hallazgo |
|---|---|---|---|---|---|---|
| 1 | Cada requisito funcional (RF1–RF13) aparece en al menos un caso de uso | Matriz RF→CU | Sí | Sí | `../G1-P1-eventflow/04-matriz-requisitos-casos-uso.md`: 13 de 13 (100 %) | – |
| 2 | Cada caso de uso crítico (CU-05, CU-07 y CU-09) tiene plantilla extendida con flujo alterno y excepción | Plantillas | No | Sí | `01-plantillas-casos-uso.md`: PL-CU05, PL-CU07 y PL-CU09 | H1, H2 |
| 3 | Todo concepto usado en las plantillas existe en el modelo de dominio | Plantillas y dominio | No | Sí | «sede», «categoría», «ticket», «validación» y «alerta» son clases de `modelo-dominio.png` | H6 |
| 4 | Cada rama de los diagramas de actividades aparece en la plantilla del mismo caso, con la misma numeración | Actividades y plantillas | Sí | Sí | AD-CU07: 2a, 2b y 7a; AD-CU09: 3a, 4a, 6a y 7a, presentes en PL-CU07 y PL-CU09 | – |
| 5 | El 90 % o más de los RF están trazados hasta la clase de dominio y la entidad del MER | Matriz de trazabilidad | Sí | Sí | `05-matriz-trazabilidad.md`: 13 de 13 RF con clase y entidad | – |
| 6 | Toda pantalla del prototipo está rotulada con su caso de uso y no hay pantallas huérfanas | Mockups | No | Sí | Encabezados «P1 · CU-05», «P2 · CU-07» y «P3 · CU-09» | H3 |
| 7 | Hay una pantalla por cada caso de uso crítico | Mockups | No | Sí | 3 pantallas: P1, P2 y P3 | H3 |
| 8 | Las plantillas no contienen detalles de implementación (tablas, endpoints, frameworks ni algoritmos) | Plantillas | No | Sí | PL-CU09 dice «verifica que el código esté vigente y sea auténtico» y no nombra algoritmos ni servicios | H1 |
| 9 | En las plantillas, las excepciones son fallas que impiden el objetivo y los flujos alternos son variantes exitosas | Plantillas | No | Sí | PL-CU09: 3a, 4a y 6a son excepciones; 7a es alterno | H2 |
| 10 | El actor primario de cada plantilla es externo al sistema (el sistema no figura como actor) | Plantillas | No | Sí | PL-CU09: actor primario es el Validador de acceso | H5 |
| 11 | Cada plantilla tiene un flujo principal de 6 pasos o más | Plantillas | Sí | Sí | PL-CU05: 8 pasos; PL-CU07: 8; PL-CU09: 8 | – |
| 12 | Cada decisión de los diagramas de actividades tiene guardas entre corchetes que cubren todas sus salidas | Actividades | Sí | Sí | AD-CU09: [coincide] / [no coincide]; [ocupación ≥ 80 %] / [ocupación < 80 %] | – |
| 13 | Los diagramas de actividades tienen inicio, fin y una calle por actor; la concurrencia se modela con bifurcación y unión, o se declara su ausencia | Actividades | Sí | Sí | AD-CU07: bifurcación y unión; AD-CU09: nota «sin concurrencia» | – |
| 14 | El modelo de dominio tiene 8 clases o más, sin métodos ni claves foráneas | Dominio | Sí | Sí | 13 clases, solo con atributos de negocio | – |
| 15 | Todas las asociaciones del dominio tienen multiplicidad en ambos extremos | Dominio | Sí | Sí | 12 asociaciones con multiplicidad en los dos extremos | – |
| 16 | El dominio tiene al menos una generalización o una clase de asociación | Dominio | Sí | Sí | Alerta ← AlertaAforo / AlertaIntentoSospechoso | – |
| 17 | El MER declara su notación y tiene 6 entidades o más con identificador | MER | Sí | Sí | Pata de gallo declarada; 11 entidades con PK | – |
| 18 | Toda relación N:M del MER está resuelta con una entidad asociativa con atributos propios | MER | No | Sí | USUARIO_ROL (fecha_asignacion, asignado_por) | H4 |
| 19 | El MER tiene al menos una entidad débil o una relación recursiva | MER | Sí | Sí | CATEGORIA_ENTRADA, entidad débil de EVENTO (doble borde) | – |
| 20 | Cada relación del MER muestra cardinalidad y participación (obligatoria u opcional) | MER | Sí | Sí | Símbolos «\|», «o» y pata de gallo en ambos extremos | – |

## Resumen

| Verificación | Cumplen | No cumplen | % de cumplimiento |
|---|---|---|---|
| 1.ª (25/11/2026) | 12 | 8 (criterios 2, 3, 6, 7, 8, 9, 10 y 18) | 60 % |
| 2.ª (26/11/2026) | **20** | **0** | **100 %** |
