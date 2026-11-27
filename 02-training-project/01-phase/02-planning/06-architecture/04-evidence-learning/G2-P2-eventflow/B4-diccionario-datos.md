# B4 · Diccionario de datos

**Motor:** PostgreSQL 16 · **Esquema:** `eventflow` · **Fuente única:** este diccionario, el script [`B5-script-creacion.sql`](B5-script-creacion.sql) y el diagrama [`B2-modelo-logico.png`](B2-modelo-logico.png) se generaron de la **misma especificación**, así que los nombres, tipos y tamaños coinciden al 100 %.

**Estándar de nombrado declarado:**
- Tablas en singular y `snake_case`.
- Columnas en `snake_case`.
- Llave primaria `id_<tabla>`; la llave foránea conserva el nombre de la PK referida, o un nombre de rol cuando hay dos hacia la misma tabla (`id_organizador`, `id_asistente`, `id_validador`, `asignado_por`).
- Restricciones con prefijo `pk_`, `fk_`, `uq_`, `ck_` + tabla + campo.

**Convenciones:** «n/a» en tamaño indica un tipo de longitud fija (enteros, fechas, booleanos). `TIMESTAMPTZ` guarda la fecha y hora con zona horaria (UTC internamente).

**Totales:** 14 tablas · 84 columnas (100 % documentadas).

### `usuario`

Personas con cuenta (asistentes, organizadores, validadores y superadministradores).

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_usuario` | BIGINT | n/a | PK, identidad autoincremental | Entero positivo |
| `tipo_documento` | VARCHAR | 3 | NOT NULL, CHECK | CC, CE, TI o PAS |
| `numero_documento` | VARCHAR | 20 | NOT NULL, UNIQUE con tipo_documento | Solo dígitos o letras; dato personal (se cifra en la aplicación) |
| `nombre_completo` | VARCHAR | 120 | NOT NULL | Nombres y apellidos |
| `correo` | VARCHAR | 120 | NOT NULL, UNIQUE, CHECK formato | Correo válido (contiene @) |
| `hash_contrasena` | CHAR | 60 | NOT NULL | Hash bcrypt con sal (factor 12); nunca la contraseña |
| `estado` | VARCHAR | 10 | NOT NULL, DEFAULT 'ACTIVO', CHECK | ACTIVO, BLOQUEADO o INACTIVO |
| `fecha_registro` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Fecha y hora del registro |

### `telefono_usuario`

Teléfonos de un usuario (atributo multivaluado en tabla aparte).

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_telefono` | BIGINT | n/a | PK, identidad | Entero positivo |
| `id_usuario` | BIGINT | n/a | FK → usuario.id_usuario, NOT NULL, ON DELETE CASCADE | Usuario existente |
| `numero` | VARCHAR | 15 | NOT NULL, CHECK formato | 7 a 15 dígitos, puede iniciar con + |
| `tipo` | VARCHAR | 5 | NOT NULL, CHECK | MOVIL o FIJO |

### `rol`

Roles del sistema (RBAC).

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_rol` | SMALLINT | n/a | PK, identidad | Entero positivo |
| `nombre` | VARCHAR | 20 | NOT NULL, UNIQUE, CHECK | SUPERADMIN, ORGANIZADOR, VALIDADOR o ASISTENTE |
| `descripcion` | VARCHAR | 200 | NULL | Texto libre |

### `permiso`

Acciones que se pueden autorizar por rol.

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_permiso` | SMALLINT | n/a | PK, identidad | Entero positivo |
| `codigo` | VARCHAR | 50 | NOT NULL, UNIQUE | Formato modulo:accion (ej. evento:crear) |
| `modulo` | VARCHAR | 30 | NOT NULL | Módulo del sistema (A5) |
| `descripcion` | VARCHAR | 200 | NULL | Texto libre |

### `usuario_rol`

Asignación de roles a usuarios (resuelve N:M usuario–rol).

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_usuario` | BIGINT | n/a | PK, FK → usuario.id_usuario, ON DELETE CASCADE | Usuario existente |
| `id_rol` | SMALLINT | n/a | PK, FK → rol.id_rol, ON DELETE RESTRICT | Rol existente |
| `fecha_asignacion` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Fecha y hora de la asignación |
| `asignado_por` | BIGINT | n/a | FK → usuario.id_usuario, NULL, ON DELETE SET NULL | Superadministrador que asignó |

### `rol_permiso`

Permisos de cada rol (resuelve N:M rol–permiso).

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_rol` | SMALLINT | n/a | PK, FK → rol.id_rol, ON DELETE CASCADE | Rol existente |
| `id_permiso` | SMALLINT | n/a | PK, FK → permiso.id_permiso, ON DELETE CASCADE | Permiso existente |

### `consentimiento`

Autorización del titular para el tratamiento de datos (Ley 1581 de 2012).

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_consentimiento` | BIGINT | n/a | PK, identidad | Entero positivo |
| `id_usuario` | BIGINT | n/a | FK → usuario.id_usuario, NOT NULL, ON DELETE RESTRICT | Titular existente (la prueba de la autorización se conserva) |
| `version_politica` | VARCHAR | 10 | NOT NULL | Versión de la política aceptada (ej. 1.0) |
| `finalidad` | VARCHAR | 300 | NOT NULL | Finalidad informada al titular |
| `fecha_aceptacion` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Fecha y hora de la aceptación |
| `fecha_revocatoria` | TIMESTAMPTZ | n/a | NULL, CHECK ≥ fecha_aceptacion | Vacío mientras esté vigente |

### `sede`

Lugares físicos donde se realizan los eventos.

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_sede` | INTEGER | n/a | PK, identidad | Entero positivo |
| `nombre` | VARCHAR | 80 | NOT NULL, UNIQUE | Nombre del lugar |
| `direccion` | VARCHAR | 150 | NOT NULL | Dirección |
| `ciudad` | VARCHAR | 60 | NOT NULL | Ciudad |
| `capacidad_fisica` | INTEGER | n/a | NOT NULL, CHECK > 0 | Personas que admite el lugar |

### `evento`

Eventos organizados.

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_evento` | BIGINT | n/a | PK, identidad | Entero positivo |
| `id_organizador` | BIGINT | n/a | FK → usuario.id_usuario, NOT NULL, ON DELETE RESTRICT | Usuario con rol ORGANIZADOR |
| `id_sede` | INTEGER | n/a | FK → sede.id_sede, NOT NULL, ON DELETE RESTRICT | Sede existente |
| `titulo` | VARCHAR | 150 | NOT NULL | Título del evento |
| `descripcion` | TEXT | n/a | NULL | Texto libre |
| `fecha_inicio` | TIMESTAMPTZ | n/a | NOT NULL | Fecha y hora de inicio |
| `fecha_fin` | TIMESTAMPTZ | n/a | NOT NULL, CHECK > fecha_inicio | Fecha y hora de fin |
| `aforo_maximo` | INTEGER | n/a | NOT NULL, CHECK > 0 | ≤ capacidad física de la sede (RN-01, validado en el servicio) |
| `ocupacion_actual` | INTEGER | n/a | NOT NULL, DEFAULT 0, CHECK entre 0 y aforo_maximo | Personas dentro (desnormalizado a propósito, ver B3) |
| `estado` | VARCHAR | 10 | NOT NULL, DEFAULT 'BORRADOR', CHECK | BORRADOR, PUBLICADO, EN_CURSO, FINALIZADO o CANCELADO |

### `categoria_entrada`

Categorías de entrada de un evento (entidad débil de evento).

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_evento` | BIGINT | n/a | PK, FK → evento.id_evento, ON DELETE CASCADE | Evento existente |
| `num_categoria` | SMALLINT | n/a | PK (discriminante), CHECK > 0 | 1, 2, 3… dentro del evento |
| `nombre` | VARCHAR | 40 | NOT NULL, UNIQUE con id_evento | General, VIP, Prensa… |
| `cupo` | INTEGER | n/a | NOT NULL, CHECK > 0 | Tickets disponibles en la categoría |
| `precio` | NUMERIC | 12,2 | NOT NULL, DEFAULT 0, CHECK ≥ 0 | Pesos colombianos |

### `ticket`

Entradas emitidas a los asistentes.

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_ticket` | BIGINT | n/a | PK, identidad | Entero positivo |
| `codigo` | VARCHAR | 40 | NOT NULL, UNIQUE (índice para RNF-04) | Código público del ticket (ej. EVF-2026-000613) |
| `id_asistente` | BIGINT | n/a | FK → usuario.id_usuario, NOT NULL, ON DELETE RESTRICT | Usuario con rol ASISTENTE |
| `id_evento` | BIGINT | n/a | FK (con num_categoria) → categoria_entrada, NOT NULL, ON DELETE RESTRICT | Evento existente |
| `num_categoria` | SMALLINT | n/a | FK (con id_evento) → categoria_entrada, NOT NULL | Categoría existente del evento |
| `semilla_qr` | BYTEA | 32 bytes | NOT NULL | Secreto para el QR dinámico; cifrado en la aplicación |
| `fecha_emision` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Fecha y hora de emisión |
| `estado` | VARCHAR | 10 | NOT NULL, DEFAULT 'EMITIDO', CHECK | EMITIDO, UTILIZADO o ANULADO |

### `validacion`

Cada intento de ingreso en una puerta.

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_validacion` | BIGINT | n/a | PK, identidad | Entero positivo |
| `id_ticket` | BIGINT | n/a | FK → ticket.id_ticket, NULL, ON DELETE RESTRICT | Vacío solo si el código leído no corresponde a ningún ticket |
| `id_validador` | BIGINT | n/a | FK → usuario.id_usuario, NOT NULL, ON DELETE RESTRICT | Usuario con rol VALIDADOR |
| `fecha_hora` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Momento del escaneo |
| `puerta` | VARCHAR | 20 | NOT NULL | Identificador de la puerta (ej. Puerta 2) |
| `resultado` | VARCHAR | 9 | NOT NULL, CHECK | CONCEDIDO o DENEGADO |
| `motivo_rechazo` | VARCHAR | 16 | NULL, CHECK coherente con resultado | NO_VIGENTE, YA_UTILIZADO, FOTO_NO_COINCIDE o AFORO_LLENO |

### `alerta`

Alertas de aforo y de intento sospechoso (generalización en una sola tabla).

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_alerta` | BIGINT | n/a | PK, identidad | Entero positivo |
| `id_evento` | BIGINT | n/a | FK → evento.id_evento, NOT NULL, ON DELETE CASCADE | Evento existente |
| `id_validacion` | BIGINT | n/a | FK → validacion.id_validacion, NULL, ON DELETE SET NULL | Validación que originó la alerta sospechosa |
| `tipo` | VARCHAR | 10 | NOT NULL, CHECK | AFORO o SOSPECHOSO (discriminador del subtipo) |
| `fecha_hora` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Momento de la alerta |
| `mensaje` | VARCHAR | 300 | NOT NULL | Texto enviado |
| `porcentaje_ocupacion` | NUMERIC | 5,2 | NULL, CHECK 0–100; obligatorio si tipo = AFORO | Porcentaje de ocupación del evento |
| `motivo` | VARCHAR | 100 | NULL; obligatorio si tipo = SOSPECHOSO | Motivo del intento sospechoso |
| `atendida` | BOOLEAN | n/a | NOT NULL, DEFAULT false | Verdadero cuando alguien la atendió |

### `bitacora`

Registro inmutable de auditoría (RF12).

| Columna | Tipo | Tamaño | Restricciones | Dominio / regla |
|---|---|---|---|---|
| `id_registro` | BIGINT | n/a | PK, identidad | Entero positivo |
| `id_usuario` | BIGINT | n/a | FK → usuario.id_usuario, NOT NULL, ON DELETE RESTRICT | Usuario que hizo la acción |
| `id_validacion` | BIGINT | n/a | FK → validacion.id_validacion, NULL, UNIQUE (1:1), ON DELETE RESTRICT | Validación registrada, si la acción es una validación |
| `fecha_hora` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Momento de la acción (UTC) |
| `accion` | VARCHAR | 40 | NOT NULL | Ej. VALIDAR_ACCESO, CAMBIAR_ROL, MODIFICAR_EVENTO |
| `resultado` | VARCHAR | 20 | NOT NULL | Ej. CONCEDIDO, DENEGADO, OK |
| `ip_origen` | INET | n/a | NULL | Dirección IP del dispositivo |
| `huella_anterior` | CHAR | 64 | NULL | SHA-256 del registro anterior (cadena) |
| `huella_integridad` | CHAR | 64 | NOT NULL, UNIQUE | SHA-256 de este registro + huella_anterior |
