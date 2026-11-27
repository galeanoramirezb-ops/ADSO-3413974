# B6 · Políticas de seguridad de los datos

Todas las políticas se aplican sobre tablas y columnas concretas del modelo y están implementadas o declaradas en [`B5-script-creacion.sql`](B5-script-creacion.sql).

## 1. Políticas por principio

| # | Principio | Política (medida concreta sobre el caso) | Dónde se implementa |
|---|---|---|---|
| P1 | **Integridad** | **La bitácora es inmutable:** no se permite `UPDATE`, `DELETE` ni `TRUNCATE` sobre `bitacora`. Cada registro guarda la `huella_integridad` (SHA-256 del registro + `huella_anterior`), y alterar uno rompe la cadena | Disparadores `tg_bitacora_inmutable` y `tg_bitacora_no_truncate` (probados en `B5-evidencia-ejecucion.log`); `ServicioBitacora.verificarCadena()` |
| P2 | **Integridad** | **Reglas de negocio como restricciones:** fechas del evento (`ck_evento_fechas`), ocupación ≤ aforo (`ck_evento_ocupacion`), coherencia del resultado y el motivo de la validación (`ck_validacion_coherencia`), precio ≥ 0; FK con `ON DELETE RESTRICT` en ticket, validación y bitácora, para no borrar evidencia | 22 `CHECK` y 18 FK en el script |
| P3 | **Integridad** | **Aforo sin carreras:** la validación concedida y el aumento de `ocupacion_actual` van en una sola transacción con bloqueo de la fila del evento (`SELECT … FOR UPDATE`) | Servicio `ServicioValidacionAcceso` (A3) |
| P4 | **Confidencialidad** | **Contraseñas con hash y sal**, no cifradas: `usuario.hash_contrasena` guarda **bcrypt con factor 12**, que incluye una sal aleatoria por usuario (60 caracteres). La contraseña nunca se almacena ni se registra en logs | Componente Autenticación (RNF-01) |
| P5 | **Confidencialidad** | **Datos en tránsito por TLS 1.3** entre el cliente y Nginx; **TLS** entre la API y PostgreSQL (`sslmode=verify-full`); SMTP con **STARTTLS** | Vista de despliegue A6 (RNF-02) |
| P6 | **Confidencialidad** | **Cifrado de columnas sensibles en reposo:** `usuario.numero_documento` y `ticket.semilla_qr` se cifran en la aplicación con AES-256-GCM; la llave vive fuera de la base de datos, en una variable secreta del contenedor | Componentes Autenticación y Tickets (RNF-07) |
| P7 | **Confidencialidad** | **Mínimo privilegio en la base de datos:** la aplicación usa el rol `eventflow_app`, que **solo puede hacer INSERT y SELECT en `bitacora`, `validacion` y `consentimiento`**; los reportes usan `eventflow_reportes` (sin datos personales: no lee `usuario` y ve solo algunas columnas de `ticket`); la auditoría usa `eventflow_auditor` (solo lectura) | `GRANT` del script (ver la matriz) |
| P8 | **Disponibilidad** | **Respaldo:** copia completa diaria a las 02:00 (`pg_basebackup`) + archivado continuo de WAL a un almacenamiento separado. **RPO ≤ 15 min**; retención de 30 días | Nodo «Almacenamiento de respaldos» (A6) |
| P9 | **Disponibilidad** | **Prueba de restauración mensual:** el primer lunes de cada mes se restaura la última copia en un ambiente de prueba, se corre `ServicioBitacora.verificarCadena()` y se deja un acta con el tiempo logrado (**RTO objetivo ≤ 1 h**) | Procedimiento de operación |
| P10 | **Disponibilidad** | **Réplica en espera** de PostgreSQL con conmutación por error y **2 instancias de la API** detrás del balanceador (RNF-03, 99,8 %) | Vista de despliegue A6 |

## 2. Tratamiento de datos personales (Ley 1581 de 2012)

| Aspecto | Medida en EventFlow |
|---|---|
| Datos personales tratados | `usuario` (documento, nombre, correo), `telefono_usuario`, la foto de verificación (fuera de la base de datos, en almacenamiento de objetos cifrado) y `bitacora.ip_origen` |
| **Finalidad** | Se informa al registrarse y queda en `consentimiento.finalidad`: «Gestionar su inscripción, emitir su ticket, verificar su identidad en el ingreso y enviarle avisos de seguridad sobre su entrada» |
| **Autorización previa** | Sin consentimiento no hay cuenta: CU-01 exige aceptar la política; se guarda `version_politica` y `fecha_aceptacion` como prueba |
| Revocatoria y supresión | El titular puede revocar (`consentimiento.fecha_revocatoria`). Sus datos se anonimizan, pero se conservan los registros de `bitacora` y `validacion` por obligación de auditoría (por eso esas FK son `ON DELETE RESTRICT`) |
| Minimización | Reportes sin datos personales (`eventflow_reportes` no lee `usuario`); el validador ve solo el nombre y la foto, no el documento completo (`CC ****4821`) |

## 3. Matriz de roles contra tablas

**Roles de la aplicación** (lo que puede hacer cada rol de negocio a través de la API; la API usa el rol de base de datos `eventflow_app`):

| Tabla | Superadministrador | Organizador | Validador | Asistente |
|---|---|---|---|---|
| `usuario` | SELECT, INSERT, UPDATE (bloquear) | SELECT (asistentes de sus eventos) | SELECT (nombre y foto del titular) | SELECT, UPDATE (solo su fila) |
| `telefono_usuario` | SELECT | – | – | SELECT, INSERT, DELETE (los suyos) |
| `rol`, `permiso`, `rol_permiso` | SELECT, INSERT, UPDATE, DELETE | SELECT | SELECT | – |
| `usuario_rol` | SELECT, INSERT, DELETE | – | – | – |
| `consentimiento` | SELECT | – | – | SELECT, INSERT, UPDATE (revocar el suyo) |
| `sede` | SELECT, INSERT, UPDATE | SELECT | – | SELECT |
| `evento`, `categoria_entrada` | SELECT | SELECT, INSERT, UPDATE (los suyos) | SELECT (el asignado) | SELECT (publicados) |
| `ticket` | SELECT | SELECT (de sus eventos) | SELECT (por código) | SELECT, INSERT (los suyos) |
| `validacion` | SELECT | SELECT (de sus eventos) | SELECT, INSERT | SELECT (las de su ticket) |
| `alerta` | SELECT, UPDATE (atender) | SELECT, UPDATE (atender) | SELECT | – |
| `bitacora` | SELECT | – | INSERT (vía la fachada) | – |

**Roles de base de datos** (implementados con `GRANT` en el script):

| Rol de BD | Usado por | Permisos |
|---|---|---|
| `eventflow_app` | API (Spring Boot) | CRUD en tablas operativas; **solo SELECT e INSERT** en `bitacora`, `validacion` y `consentimiento` (más UPDATE solo de `fecha_revocatoria`); solo SELECT en `rol` y `permiso` |
| `eventflow_reportes` | Componente Reportes | Solo SELECT en `sede`, `evento`, `categoria_entrada`, `validacion` y `alerta`, y en las columnas no sensibles de `ticket`; **no accede a `usuario`** |
| `eventflow_auditor` | Auditoría externa | Solo SELECT en `bitacora`, `validacion`, `usuario_rol` y en 3 columnas de `usuario` |
