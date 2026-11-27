# G1-P2 · Modelo de análisis y verificación · EventFlow Manager (SIGEV)

Ruta: `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-eventflow/`

## 1. Datos de la entrega

- **Producto:** P2 · modelo de análisis y verificación
- **Usuario de GitHub del autor:** galeanoramirezb-ops
- **Caso de estudio:** EventFlow Manager (SIGEV): gestión de eventos, tickets con QR dinámico, validación de acceso y control de aforo
- **Trabajo en equipo del año:** sí. Equipo EventFlow / SIGEV, conformado actualmente por 2 aprendices. El SRS base se elaboró cuando el equipo tenía otra conformación.

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Especificaciones de casos de uso (validación de acceso y emisión de ticket), requisitos RF1–RF13 y RNF | SRS EventFlow Manager (evidencia GA1-37371-AA2-EV01, octubre de 2026) | En equipo |
| Boceto a mano del Dashboard SIGEV (menú lateral, métricas, eventos en curso) | `03-execute/14-week/01-session/01-activity/CamScanner 05-06-2026 21.59.pdf` | En equipo |
| Módulos del sistema y roles | `03-execute/14-week/01-session/01-activity/SIGEV.docx` | En equipo |
| Catálogo de casos de uso y matriz RF→CU | `../G1-P1-eventflow/` | Individual |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | Plantilla CU-09 | Quité el endpoint, el motor de base de datos y los algoritmos del flujo, y lo redacté como intención (criterio C2, regla 10 de arbitraje) | [a1c745f](https://github.com/galeanoramirezb-ops/ADSO-3413974/commit/a1c745f) |
| 2 | Plantilla CU-09 | Reclasifiqué «código caducado» y «ya utilizado» de flujo alterno a **excepción**; agregué la excepción 6a y el alterno 7a (C2, regla 4) | [a1c745f](https://github.com/galeanoramirezb-ops/ADSO-3413974/commit/a1c745f) |
| 3 | Plantilla CU-09 | Saqué al «Sistema Backend» del papel de actor primario (C2) | [a1c745f](https://github.com/galeanoramirezb-ops/ADSO-3413974/commit/a1c745f) |
| 4 | MER | Resolví la N:M USUARIO–ROL con la entidad asociativa USUARIO_ROL con atributos propios (C4) | [a1c745f](https://github.com/galeanoramirezb-ops/ADSO-3413974/commit/a1c745f) |
| 5 | Prototipo | Del boceto del Dashboard pasé a 3 pantallas rotuladas con los casos críticos CU-05, CU-07 y CU-09 (C5) | [a1c745f](https://github.com/galeanoramirezb-ops/ADSO-3413974/commit/a1c745f) |

## 4. Qué construí nuevo

- Diagramas de actividades de CU-07 (con bifurcación y unión) y CU-09, con calles por actor y guardas en todas las decisiones.
- Plantilla extendida de CU-05 Gestionar evento, con reglas de negocio RN-01 a RN-03.
- Modelo de dominio de 13 clases con la generalización Alerta.
- MER completo en notación pata de gallo, con la entidad débil CATEGORIA_ENTRADA.
- Lista de chequeo de 20 criterios, registro de 6 ajustes con segunda verificación, informe de análisis y matriz de trazabilidad.

## 5. Artefactos entregados

**Producto 2**

- [x] Diagramas de actividades (2): [CU-07 .drawio](actividades-CU07-obtener-ticket.drawio) · [.png](actividades-CU07-obtener-ticket.png) · [CU-09 .drawio](actividades-CU09-validar-acceso.drawio) · [.png](actividades-CU09-validar-acceso.png)
- [x] Plantillas extendidas de casos de uso (3): [01-plantillas-casos-uso.md](01-plantillas-casos-uso.md)
- [x] Modelo de dominio: [.drawio](modelo-dominio.drawio) · [.png](modelo-dominio.png)
- [x] Modelo entidad-relación: [.drawio](modelo-entidad-relacion.drawio) · [.png](modelo-entidad-relacion.png)
- [x] Prototipo inicial (3 pantallas): [P1 CU-05](mockup-P1-CU05-gestionar-evento.png) · [P2 CU-07](mockup-P2-CU07-obtener-ticket.png) · [P3 CU-09](mockup-P3-CU09-validar-acceso.png)
- [x] Lista de chequeo diligenciada (20 criterios): [02-lista-chequeo.md](02-lista-chequeo.md)
- [x] Registro de ajustes y segunda verificación: [03-registro-ajustes.md](03-registro-ajustes.md)
- [x] Informe de análisis: [04-informe-analisis.md](04-informe-analisis.md)
- [x] Matriz de trazabilidad (Anexo C): [05-matriz-trazabilidad.md](05-matriz-trazabilidad.md)

**Decisión principal:** CU-05, CU-07 y CU-09 son los casos críticos porque concentran el riesgo (aforo, fraude y suplantación). El MER separa los roles en USUARIO_ROL para que una persona pueda tener varios roles.

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma: galeanoramirezb-ops · 26/11/2026

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Claude (Anthropic) | Para generar los `.drawio` de los diagramas y los bocetos de pantallas, y para redactar borradores de las plantillas, la lista de chequeo, el informe y la matriz | Comprobé que cada rama de los diagramas de actividades estuviera en su plantilla, revisé las multiplicidades del dominio y la cardinalidad del MER contra las reglas de negocio, y que los ajustes registrados correspondieran a cambios reales frente al SRS |

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 días distintos (26/11 y 27/11/2026).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.
