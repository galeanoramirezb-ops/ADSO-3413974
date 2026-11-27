# README de entrega · Guía 2 · Producto 1: artefactos de diseño

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P1 (artefactos de diseño) |
| Usuario de GitHub del autor | galeanoramirezb-ops |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | EventFlow Manager (SIGEV): gestión de eventos, tickets con QR dinámico, validación de acceso y aforo |
| Enlace al informe de análisis o SRS del caso (ruta en mi fork) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-eventflow/04-informe-analisis.md` (análisis) y `03-execute/14-week/01-session/01-activity/SIGEV.docx` (SRS base) |
| Cuenta de GitHub con la que hago los commits | galeanoramirezb-ops |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí. El SRS base lo elaboró el equipo con una conformación anterior; hoy el equipo del proyecto es de **2 aprendices**. El informe de análisis de G1 es individual. |
| ¿Qué parte del SRS es tuya? | Diseño los **13 RF** completos. Mi aporte al análisis está en G1 (casos de uso, plantillas, dominio y MER). |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| A1 Ficha y plataforma | `A1-ficha-interpretacion-plataforma.md` | Stack de `03-execute/14-week/01-session/01-activity/SIGEV_Presentacion.pptx` (React, Spring Boot, PostgreSQL, Docker) y RF/RNF del SRS | Justifiqué el lenguaje y la base de datos con 4 o 5 condiciones del caso cada uno, y ligué cada RNF a una decisión |
| A2 Diagrama de clases | `A2-diagrama-clases.drawio` / `.png` | Modelo de dominio de G1 (`.../G1-P2-eventflow/modelo-dominio.drawio`) | Agregué tipos, visibilidad, métodos con parámetros, composición, interfaces con implementaciones y clases de servicio; pasé de 13 a 21 clases |
| A3 Patrones | `A3-patrones-diseno.md` | nuevo | Estrategia (reglas de validación y notificadores) y Fachada (validación de acceso) |
| A4 Arquitectura | `A4-arquitectura.drawio` / `.png` / `.md` | Diapositiva «Arquitectura del sistema» de `SIGEV_Presentacion.pptx` (React → API → dominio → PostgreSQL) | La convertí en diagrama de capas con protocolos, tabla de 6 RNF → decisión y alternativa descartada (microservicios) |
| A5 Vista de componentes | `A5-vista-componentes.drawio` / `.png` / `.md` | Módulos del alcance del SRS (`SIGEV.docx`) | nuevo: 10 componentes con interfaces provistas y requeridas |
| A6 Vista de despliegue | `A6-vista-despliegue.drawio` / `.png` / `.md` | nuevo | 8 nodos con artefactos, protocolos y puertos, y decisiones por RNF |
| A7 Matriz de trazabilidad | `A7-matriz-trazabilidad.md` | Matriz RF → CU de G1-P1 | La extendí hasta clase, tabla y componente, e hice la revisión hacia atrás (clase → RF) |

**Qué reutilicé:** el SRS del equipo (13 RF y 10 RNF), el stack tecnológico y el esquema de arquitectura de la presentación SIGEV (semana 14), y mi modelo de dominio de la Guía 1, como punto de partida de las clases.

**Qué ajusté para llevarlo al estándar de la rúbrica:**
- El dominio de G1 no tenía tipos, métodos ni visibilidad; ahora cada clase los tiene.
- La generalización de alertas pasó a ser una clase abstracta con método abstracto.
- La arquitectura de la presentación era una sola línea de cajas; ahora es un diagrama de capas con protocolos, decisiones por RNF y la alternativa descartada.

**Qué hice completamente nuevo:**
- Las clases de servicio con los patrones Estrategia y Fachada.
- La vista de componentes con 9 interfaces.
- La vista de despliegue con 8 nodos, redundancia y respaldos.
- La matriz de trazabilidad en dos sentidos.

## 4. Autoverificación de mínimos

- [x] A1 Ficha de interpretación: ≥ 8 RF (13) y ≥ 3 RNF (6) con ID; plataforma justificada
- [x] A2 Diagrama de clases: ≥ 8 clases (21), tipos, métodos, multiplicidades, ≥ 1 composición/agregación (Evento ◆ CategoriaEntrada; ServicioValidacionAcceso ◇ ReglaValidacion) y ≥ 1 herencia o interfaz (Alerta ◁ 2 subclases; ReglaValidacion con 3 implementaciones; Notificador con 2)
- [x] A3 ≥ 2 patrones GoF distintos aplicados en el diagrama (Estrategia y Fachada; ninguno es Singleton)
- [x] A4 Arquitectura con diagrama y tabla de ≥ 3 RNF → decisión (6)
- [x] A5 Vista de componentes: ≥ 5 componentes con interfaces (10 componentes, 9 interfaces)
- [x] A6 Vista de despliegue: ≥ 3 nodos con artefactos y protocolos (8)
- [x] A7 Matriz de trazabilidad análisis → diseño (13/13 RF; 21/21 clases)
- [x] Fuente editable (`.drawio`) e imagen exportada (`.png` y `.svg`) de cada diagrama

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| Jueves 26/11/2026 | `G2-P1: artefactos de diseño EventFlow (clases, patrones, arquitectura, componentes, despliegue)` |
| Viernes 27/11/2026 | `G2-P2: modelo de datos, script SQL ejecutado y verificación` y `G2-P1: README con historial de los 2 días` |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Claude (Anthropic) | Para generar los `.drawio` y las imágenes de los diagramas a partir de mis clases y componentes, y para redactar borradores de las tablas de patrones, RNF y trazabilidad | Revisé que cada clase tuviera requisito, que las multiplicidades correspondieran a las reglas de G1, que las dependencias de componentes no formaran ciclos y que cada conexión de despliegue tuviera puerto |

## 7. Enlaces

- Informe de análisis / SRS del caso: `../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-eventflow/04-informe-analisis.md`
- Carpeta de esta entrega en GitHub: https://github.com/galeanoramirezb-ops/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-eventflow
- Producto 2 (modelo de datos): `../G2-P2-eventflow/`

**Índice y decisión principal de cada artefacto**

| Artefacto | Decisión principal |
|---|---|
| [A1](A1-ficha-interpretacion-plataforma.md) | Java 21 + Spring Boot y PostgreSQL, porque el aforo exige transacciones ACID |
| [A2](A2-diagrama-clases.png) | 21 clases; las reglas de acceso son clases intercambiables |
| [A3](A3-patrones-diseno.md) | Estrategia para reglas y notificadores; Fachada para validar acceso |
| [A4](A4-arquitectura.md) | Monolito modular en capas; microservicios descartados |
| [A5](A5-vista-componentes.md) | 10 componentes; la presentación nunca toca la base de datos |
| [A6](A6-vista-despliegue.md) | 2 instancias de la API y réplica de la base de datos para el 99,8 % |
| [A7](A7-matriz-trazabilidad.md) | 100 % de los RF trazados y ninguna clase huérfana |

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: galeanoramirezb-ops · Fecha: 26/11/2026
