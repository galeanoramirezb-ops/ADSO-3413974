# G1-P1 · Plan de análisis y casos de uso · EventFlow Manager (SIGEV)

Ruta: `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-eventflow/`

## 1. Datos de la entrega

- **Producto:** P1 · plan de análisis y casos de uso
- **Usuario de GitHub del autor:** galeanoramirezb-ops
- **Caso de estudio:** EventFlow Manager (SIGEV): plataforma web de gestión de eventos, tickets con QR dinámico, validación de acceso y control de aforo
- **Trabajo en equipo del año:** sí. Equipo EventFlow / SIGEV, conformado actualmente por 2 aprendices. El SRS base se elaboró cuando el equipo tenía más integrantes, que ya no hacen parte del proyecto.

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| SRS EventFlow Manager (IEEE 830): RF1–RF13, RNF-01–RNF-10, HU-01–HU-12 y tabla de actores y casos de uso | Documento de equipo de la evidencia GA1-37371-AA2-EV01 (octubre de 2026) | En equipo (con la conformación anterior) |
| Planteamiento, objetivos y alcance de SIGEV | `03-execute/14-week/01-session/01-activity/SIGEV.docx` | En equipo |
| Diagrama general de casos de uso (versión anterior, solo imagen) | Incluido en el SRS (figura 2) | En equipo |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | Diagrama de casos de uso | Agregué 2 «include» (CU-07→CU-08, CU-09→CU-10) y 3 «extend» (CU-03→CU-02, CU-11→CU-09, CU-12→CU-09), cada uno justificado. La versión anterior no tenía ninguno (criterio C4). | (pegar enlace) |
| 2 | Diagrama de casos de uso | Eliminé el actor "Sistema / Motor de aforo": el sistema no puede ser actor de sí mismo. Lo reemplacé por el actor secundario externo "Servicio de correo" (C4, regla 6). | (pegar enlace) |
| 3 | Diagrama de casos de uso | Separé "Autenticación y Gestión de Roles" en CU-02 Iniciar sesión y CU-04 Gestionar roles y permisos, porque eran dos funciones con actores distintos. También agregué la generalización de actores hacia "Usuario registrado" (C4). | (pegar enlace) |
| 4 | Diagrama de casos de uso | Unifiqué los dos catálogos que no coincidían (9 casos en la figura y 20 en la tabla) en 16 casos con nombre verbo + objeto. Agrupé el CRUD de eventos en CU-05 Gestionar evento (C4, regla 1). | (pegar enlace) |
| 5 | Diagrama de casos de uso | Lo pasé de imagen pegada en Word a fuente editable `.drawio` más `.png` y `.svg` (artefacto f). | (pegar enlace) |
| 6 | SRS / matriz | Unifiqué el nombre del sistema, "EventFlow Manager (SIGEV)", y actualicé el equipo a 2 integrantes (C3). | (pegar enlace) |

## 4. Qué construí nuevo

- Caracterización de la solución en sus 4 aspectos y comparación ponderada de RUP, Scrum, XP y RAD, con la selección justificada de Scrum.
- Plan de actividades de análisis en 2 sprints: 17 actividades, cada una con prioridad, responsable, fecha, entregable y dependencia, más el cronograma.
- Matriz requisito → caso de uso con 100 % de cobertura (13 de 13 RF) y la distinción entre RF y RNF.
- Justificación de cada relación del diagrama y verificación de las reglas UML.

## 5. Artefactos entregados

**Producto 1**

- [x] Caracterización de la solución: [01-caracterizacion-y-metodologia.md](01-caracterizacion-y-metodologia.md) (sección 1.1)
- [x] Comparación de metodologías y selección justificada: [01-caracterizacion-y-metodologia.md](01-caracterizacion-y-metodologia.md) (secciones 1.2 y 1.3)
- [x] Plan de actividades, cronograma y entregables: [02-plan-actividades-analisis.md](02-plan-actividades-analisis.md)
- [x] Diagrama de casos de uso (fuente editable): [diagrama-casos-uso.drawio](diagrama-casos-uso.drawio)
- [x] Diagrama de casos de uso (imagen): [diagrama-casos-uso.png](diagrama-casos-uso.png) · [svg](diagrama-casos-uso.svg)
- [x] Catálogo y justificación de relaciones: [03-casos-de-uso-y-relaciones.md](03-casos-de-uso-y-relaciones.md)
- [x] Matriz requisito → caso de uso: [04-matriz-requisitos-casos-uso.md](04-matriz-requisitos-casos-uso.md)

**Decisión principal:** Scrum con sprints de 1 semana. Hay 16 casos de uso que cubren el 100 % de los RF. La validación de acceso (CU-09) es el caso central: siempre registra en la bitácora y, solo cuando corresponde, dispara las alertas de aforo o de intento sospechoso.

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma: galeanoramirezb-ops · 26/11/2026

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Claude (Anthropic) | Para revisar el SRS frente a la rúbrica, proponer la estructura de los documentos, generar el `.drawio` y redactar borradores de la comparación de metodologías, el plan y la matriz | Revisé que cada RF tuviera su caso de uso, recalculé el puntaje de la comparación, ajusté responsables y fechas a mi equipo real y comprobé el sentido de cada flecha «include» y «extend» |

## 8. Autocontrol antes del push

- [ ] Hice commits propios en al menos 2 días distintos entre el 21 de noviembre de 2026 y la entrega.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [ ] Hice `push` y comprobé en GitHub que la carpeta está publicada.
