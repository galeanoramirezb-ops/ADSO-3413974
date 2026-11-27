# B1 · Modelo conceptual y B2 · Modelo lógico relacional

## B1 · Modelo conceptual

Diagrama: [`B1-modelo-conceptual.png`](B1-modelo-conceptual.png) · fuente: [`B1-modelo-conceptual.drawio`](B1-modelo-conceptual.drawio)

**Tipo de base de datos:** relacional (PostgreSQL 16).
- Los datos tienen relaciones fijas y fuertes (usuario → ticket → validación).
- El aforo exige **transacciones ACID**, para que dos puertas no dejen entrar a la misma persona ni se supere el cupo.
- Las reglas de negocio de G1 (RN-01 a RN-08) se expresan como restricciones de integridad.

**Notación:** pata de gallo, con (mín, máx) escrito en cada extremo y un verbo en cada relación.

### Entidades y su trazabilidad a requisitos

| Entidad | Identificador | Requisito que la origina |
|---|---|---|
| USUARIO (con teléfono multivaluado) | id_usuario | RF1, RF2, RF3 |
| CONSENTIMIENTO | id_consentimiento | RF1 (Ley 1581) |
| ROL | id_rol | RF4 |
| PERMISO | id_permiso | RF4 |
| SEDE | id_sede | RF5 |
| EVENTO | id_evento | RF5, RF7 |
| CATEGORIA_ENTRADA (débil) | id_evento + num_categoria | RF5, RF6 |
| TICKET | id_ticket | RF6 |
| VALIDACION | id_validacion | RF8 |
| ALERTA (generalización AFORO / SOSPECHOSO) | id_alerta | RF7, RF13 |
| BITACORA | id_registro | RF12 |

### Relaciones (verbo y cardinalidad mínima y máxima)

| Relación | Tipo | Lado A (mín, máx) | Lado B (mín, máx) |
|---|---|---|---|
| USUARIO **tiene** ROL | **N:M** (con atributos fecha_asignacion y asignado_por) | Un usuario tiene (1,N) roles | Un rol lo tienen (0,N) usuarios |
| ROL **concede** PERMISO | **N:M** | Un rol concede (1,N) permisos | Un permiso lo conceden (0,N) roles |
| USUARIO **otorga** CONSENTIMIENTO | 1:N | Un usuario otorga (1,N) | Un consentimiento es de (1,1) usuario |
| USUARIO **organiza** EVENTO | 1:N | Un organizador organiza (0,N) | Un evento lo organiza (1,1) |
| SEDE **aloja** EVENTO | 1:N | Una sede aloja (0,N) | Un evento está en (1,1) sede |
| EVENTO **ofrece** CATEGORIA_ENTRADA | 1:N identificadora | Un evento ofrece (1,N) | Una categoría es de (1,1) evento |
| CATEGORIA_ENTRADA **clasifica** TICKET | 1:N | Una categoría clasifica (0,N) | Un ticket es de (1,1) categoría |
| USUARIO **posee** TICKET | 1:N | Un asistente posee (0,N) | Un ticket es de (1,1) asistente |
| TICKET **se verifica en** VALIDACION | 1:N | Un ticket se verifica en (0,N) | Una validación es de (1,1) ticket |
| USUARIO **realiza** VALIDACION | 1:N | Un validador realiza (0,N) | Una validación la hace (1,1) validador |
| EVENTO **genera** ALERTA | 1:N | Un evento genera (0,N) | Una alerta es de (1,1) evento |
| VALIDACION **queda en** BITACORA | 1:1 | Una validación queda en (1,1) registro | Un registro es de (0,1) validación |

**Qué ajusté respecto al MER de G1:**
1. Agregué la entidad **PERMISO** y la N:M **ROL–PERMISO** (RF4 habla de la matriz de permisos).
2. Agregué **teléfono** como atributo multivaluado.
3. Dejé **USUARIO–ROL como N:M** en el nivel conceptual. En G1 ya aparecía resuelta, lo que corresponde al nivel lógico.
4. Escribí el **verbo y (mín, máx)** en cada relación.
5. Quité las llaves foráneas del modelo conceptual, porque pertenecen al modelo lógico.

## B2 · Modelo lógico relacional

Diagrama: [`B2-modelo-logico.png`](B2-modelo-logico.png) · fuente: [`B2-modelo-logico.drawio`](B2-modelo-logico.drawio) · 14 tablas, todas con PK; 18 FK.

### Cuadro de reglas de transformación aplicadas

| Regla | Caso en EventFlow | Resultado en el modelo lógico |
|---|---|---|
| Entidad fuerte → tabla con PK | USUARIO, ROL, PERMISO, SEDE, EVENTO, TICKET, VALIDACION, CONSENTIMIENTO, ALERTA, BITACORA | Una tabla por entidad con `id_<tabla>` como PK de identidad |
| **N:M → tabla intermedia** con PK compuesta | USUARIO tiene ROL | `usuario_rol(id_usuario FK, id_rol FK)` con PK compuesta y sus atributos propios `fecha_asignacion` y `asignado_por` |
| **N:M → tabla intermedia** | ROL concede PERMISO | `rol_permiso(id_rol FK, id_permiso FK)` con PK compuesta |
| **1:N → FK en el lado «muchos»** | USUARIO organiza EVENTO; SEDE aloja EVENTO | `evento.id_organizador FK`, `evento.id_sede FK` |
| 1:N → FK | USUARIO posee TICKET; CATEGORIA clasifica TICKET | `ticket.id_asistente FK`; `ticket(id_evento, num_categoria) FK` compuesta |
| 1:N → FK | TICKET se verifica en VALIDACION; USUARIO realiza VALIDACION | `validacion.id_ticket FK`, `validacion.id_validador FK` |
| 1:N → FK | USUARIO otorga CONSENTIMIENTO; EVENTO genera ALERTA | `consentimiento.id_usuario FK`; `alerta.id_evento FK` |
| **1:1 → FK única** | VALIDACION queda en BITACORA | `bitacora.id_validacion FK UNIQUE` (admite nulos, porque hay registros que no son validaciones) |
| **Entidad débil → PK compuesta con la PK del dueño** | CATEGORIA_ENTRADA de EVENTO | `categoria_entrada` con PK (`id_evento`, `num_categoria`); FK con `ON DELETE CASCADE` |
| **Atributo multivaluado → tabla aparte** | Teléfonos del usuario | `telefono_usuario(id_telefono PK, id_usuario FK, numero, tipo)` |
| **Generalización → una sola tabla con discriminador** | ALERTA → AFORO / SOSPECHOSO | `alerta.tipo` con `CHECK (tipo IN ('AFORO','SOSPECHOSO'))`; las columnas de cada subtipo son opcionales y un `CHECK` exige la que corresponde. Se eligió una sola tabla porque los subtipos comparten 5 de 7 atributos y siempre se consultan juntos en el dashboard. |
| Relación recursiva (indirecta) | Un usuario (superadministrador) asigna roles a otros usuarios | `usuario_rol.asignado_por` es FK hacia `usuario`, la misma tabla de la que sale `usuario_rol.id_usuario`; `ON DELETE SET NULL` para no perder la asignación si se retira quien la hizo |
