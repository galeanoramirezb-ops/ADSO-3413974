# 1. Caracterización de la solución y selección de metodología

**Proyecto:** EventFlow Manager (SIGEV): plataforma web para gestionar eventos, emitir tickets con QR dinámico, validar accesos y controlar el aforo en tiempo real.
**Producto:** G1-P1 · Guía 1 · Modelo conceptual
**Fuente base:** SRS del equipo (IEEE 830, versión de octubre de 2026), con 13 requisitos funcionales (RF1–RF13) y 10 no funcionales (RNF-01–RNF-10).

---

## 1.1 Caracterización de la solución

| Aspecto | Descripción en EventFlow Manager | Qué implica para la metodología |
|---|---|---|
| **Tipo de proyecto** | Aplicación web nueva (desarrollo desde cero), transaccional y en tiempo real (validación de QR en menos de 1,5 s, aforo en vivo). Maneja datos personales (Ley 1581 de 2012) y tiene seguridad crítica: anti-fraude, bitácora inmutable y blindaje contra ingeniería social. Es un proyecto formativo con un cliente institucional. | Necesita entregar valor por partes (módulo por módulo) y validar temprano lo más riesgoso: la validación de QR y el aforo. |
| **Tamaño del equipo** | **2 aprendices** (Brenda G.: análisis, UI/UX y frontend; Andrés C.: backend, QA y base de datos), más el instructor en el rol de Product Owner. | Un equipo muy pequeño no puede sostener muchos roles formales ni mucha documentación de proceso. Necesita roles livianos y comunicación directa. |
| **Estabilidad de los requisitos** | **Media.** El núcleo es estable (eventos, tickets, validación, reportes), pero los detalles han cambiado entre versiones: el QR pasó de estático a dinámico TOTP, se agregaron las alertas anti-phishing y el modo offline, y el equipo cambió de integrantes. | Hace falta un backlog priorizado que se pueda reordenar entre iteraciones sin rehacer todo el plan. |
| **Disponibilidad del cliente** | **Parcial.** El Product Owner (el instructor) está disponible en las sesiones semanales y por el canal de la ficha, no a diario. | Conviene una metodología con puntos de revisión fijos (al final de cada iteración), no una que exija al cliente presente todo el día. |

Otras características que pesan en la decisión:

- **Plazos fijos y cortos:** cada guía tiene fecha de entrega cerrada, lo que favorece trabajar en iteraciones con duración fija.
- **Documentación exigida:** el programa pide SRS, modelos UML y trazabilidad, así que la metodología debe dejar espacio para producir esos artefactos.
- **Base de trabajo ya existente:** hay historias de usuario estimadas en puntos (HU-01 a HU-12) con prioridad.

---

## 1.2 Comparación de metodologías

Los criterios salen de las características anteriores. Cada metodología se califica de 1 (no se ajusta) a 5 (se ajusta muy bien).

| Criterio (y de qué característica sale) | Peso | RUP | Scrum | XP | RAD |
|---|---|---|---|---|---|
| C1. Funciona con un equipo de 2 personas (tamaño del equipo) | 25 % | 2 | 4 | 4 | 3 |
| C2. Admite requisitos que cambian en los detalles (estabilidad media) | 25 % | 2 | 5 | 5 | 4 |
| C3. Se acomoda a un cliente disponible una vez por semana (disponibilidad parcial) | 20 % | 4 | 5 | 2 | 2 |
| C4. Entrega por partes y valida primero lo crítico: QR y aforo (tipo de proyecto) | 15 % | 3 | 5 | 4 | 4 |
| C5. Deja espacio para la documentación exigida: SRS, UML, trazabilidad (contexto formativo) | 15 % | 5 | 4 | 2 | 2 |
| **Puntaje ponderado (sobre 5)** | 100 % | **3,00** | **4,60** | **3,55** | **3,05** |

Cálculo: la suma de cada calificación por su peso. Por ejemplo, Scrum = 4·0,25 + 5·0,25 + 5·0,20 + 5·0,15 + 4·0,15 = 4,60.

### Análisis por metodología

- **RUP (Proceso Unificado Racional):** es fuerte en documentación y modelado UML (C5) y organiza el trabajo en fases (inicio, elaboración, construcción y transición). Pero define muchos roles y artefactos formales que 2 personas no pueden sostener, y cambiar un requisito obliga a actualizar mucha documentación de proceso. **Se descarta** por pesada para el tamaño del equipo.
- **Scrum:** trabaja en sprints de duración fija, con un Product Owner que prioriza el backlog y revisa al final de cada sprint. Eso coincide con la disponibilidad semanal del instructor. El backlog absorbe los cambios de detalle sin rehacer el plan. Ya existen historias de usuario con puntos, que son el insumo natural del backlog. **Se selecciona.**
- **XP (Programación Extrema):** se adapta muy bien al cambio y a equipos pequeños, porque 2 personas pueden programar en pareja. Pero exige un **cliente en sitio todo el tiempo** (C3) y se centra en prácticas de código (TDD, integración continua) más que en producir los artefactos de análisis que pide el programa. **Se descarta** para la gestión del proyecto, aunque algunas prácticas técnicas (pruebas unitarias, integración continua) se pueden usar en la fase de construcción.
- **RAD (Desarrollo Rápido de Aplicaciones):** acelera con prototipos y componentes reutilizables, pero depende de usuarios disponibles para validar prototipos de forma continua (C3). Además, es riesgoso en un sistema con seguridad crítica, donde no conviene sacrificar el análisis por la velocidad. **Se descarta.**

---

## 1.3 Metodología seleccionada: Scrum

**Justificación (ligada a las características):**

1. **Equipo de 2 personas:** Scrum tiene solo 3 roles. El instructor es el Product Owner. Brenda G. hace de Scrum Master y desarrolladora, y Andrés C. de desarrollador. No se necesitan más roles.
2. **Requisitos de estabilidad media:** el Product Backlog se reprioriza en cada Sprint Planning. Por ejemplo, si cambia el umbral de aforo, se ajusta una historia y no todo el plan.
3. **Cliente disponible una vez por semana:** la **Sprint Review** se hace en la sesión semanal con el instructor, y ese es el punto de validación formal.
4. **Validar primero lo crítico:** el backlog se ordena con prioridad MoSCoW. Lo "Must" (validar QR, emitir ticket, aforo y bitácora) va en los primeros sprints.
5. **Documentación exigida:** los artefactos de análisis (SRS, casos de uso, matriz y modelos) entran en la **Definición de Hecho (DoD)** de cada sprint. Así la documentación se produce dentro de Scrum y no hace falta una metodología híbrida.

**Cómo se aplica Scrum en la fase de análisis:**

| Elemento Scrum | Cómo se usa en EventFlow Manager |
|---|---|
| Sprint | 1 semana (de lunes a sábado), cerrando en la sesión con el instructor |
| Product Backlog | HU-01 a HU-12 del SRS, ligadas a RF1–RF13 y priorizadas con MoSCoW |
| Sprint Planning | Al inicio de cada sprint (lunes, 30 min) |
| Daily | 15 minutos, por mensaje o llamada (equipo de 2) |
| Sprint Review | Con el Product Owner (instructor) en la sesión del sábado |
| Retrospectiva | Al cierre del sprint (15 min) |
| Definición de Hecho (análisis) | El artefacto está en el repositorio, se verificó con la lista de chequeo y está trazado a los RF |
