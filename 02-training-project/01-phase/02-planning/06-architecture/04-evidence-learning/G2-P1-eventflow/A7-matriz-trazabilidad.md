# A7 · Matriz de trazabilidad análisis → diseño

Las tablas corresponden al modelo lógico de `../G2-P2-eventflow/`.

## Hacia adelante: requisito → diseño

| Requisito | Clase(s) | Tabla(s) | Componente(s) | Decisión o patrón |
|---|---|---|---|---|
| RF1 Registro y consentimiento | `Usuario` | `usuario`, `telefono_usuario`, `consentimiento` | Autenticación y Roles | Consentimiento como tabla aparte (Ley 1581) |
| RF2 Inicio de sesión | `Usuario` | `usuario` | Autenticación y Roles | JWT sin estado (RNF-05) |
| RF3 Recuperar contraseña | `Usuario`, `Notificador` | `usuario` | Autenticación y Roles, Notificaciones | Estrategia (Notificador) |
| RF4 Roles y permisos | `Rol`, `Usuario` | `rol`, `permiso`, `usuario_rol`, `rol_permiso` | Autenticación y Roles | RBAC con N:M resuelta |
| RF5 Crear y parametrizar eventos | `Evento`, `Sede`, `CategoriaEntrada` | `evento`, `sede`, `categoria_entrada` | Gestión de Eventos | Composición Evento ◆ CategoriaEntrada |
| RF6 Ticket con QR dinámico | `Ticket`, `GeneradorCodigoQR`, `CategoriaEntrada`, `NotificadorCorreo` | `ticket` | Emisión de Tickets, Notificaciones | Estrategia (Notificador) |
| RF7 Aforo en tiempo real | `Evento`, `ReglaAforoDisponible`, `AlertaAforo` | `evento` (`ocupacion_actual`), `alerta` | Aforo y Tiempo Real, Validación de Acceso | WebSocket; Estrategia (regla de aforo) |
| RF8 Validación y anti-suplantación | `ServicioValidacionAcceso`, `ReglaValidacion`, `ReglaVigenciaCodigo`, `ReglaTicketNoUtilizado`, `Validacion`, `Ticket` | `validacion`, `ticket` | Validación de Acceso | **Fachada** + **Estrategia** |
| RF9 Dashboard | `Evento`, `Validacion` | `evento`, `validacion` | Reportes, Aforo y Tiempo Real | Consultas de solo lectura |
| RF10 Exportar reportes | `Ticket`, `Validacion` | `ticket`, `validacion` | Reportes | – |
| RF11 Importación masiva | `Usuario`, `Ticket` | `usuario`, `ticket` | Gestión de Eventos | Validación del CSV en el servidor |
| RF12 Bitácora inmutable | `ServicioBitacora`, `RegistroBitacora` | `bitacora` | Auditoría | Huella encadenada y disparador que bloquea UPDATE y DELETE |
| RF13 Anti-ingeniería social | `AlertaIntentoSospechoso`, `Notificador`, `NotificadorSMS` | `alerta` | Validación de Acceso, Notificaciones | Estrategia (Notificador) |
| RNF-03 Disponibilidad | n/a | n/a | (A6) balanceador, 2 instancias, réplica | Redundancia |
| RNF-04 Validación < 1,5 s | `ServicioValidacionAcceso` | `ticket` (índice único en `codigo`) | Validación de Acceso | Reglas en memoria |

**Cobertura:** 13 de 13 RF (100 %) llegan a clase, tabla y componente.

## Hacia atrás: clase → requisito (ninguna clase queda sin requisito)

| Clase | RF | Clase | RF | Clase | RF |
|---|---|---|---|---|---|
| Usuario | RF1, RF2, RF3, RF11 | Rol | RF4 | Sede | RF5 |
| Evento | RF5, RF7, RF9 | CategoriaEntrada | RF5, RF6 | Ticket | RF6, RF8, RF10 |
| Validacion | RF8, RF9, RF10 | GeneradorCodigoQR | RF6, RF8 | ServicioValidacionAcceso | RF8 |
| ReglaValidacion | RF8 | ReglaVigenciaCodigo | RF8 | ReglaTicketNoUtilizado | RF8 |
| ReglaAforoDisponible | RF7 | ServicioBitacora | RF12 | RegistroBitacora | RF12 |
| Alerta | RF7, RF13 | AlertaAforo | RF7 | AlertaIntentoSospechoso | RF13 |
| Notificador | RF3, RF6, RF13 | NotificadorCorreo | RF3, RF6 | NotificadorSMS | RF13 |

Las **21 de 21 clases** trazan al menos a un requisito.
