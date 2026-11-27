# A5 · Vista de componentes

Diagrama: [`A5-vista-componentes.png`](A5-vista-componentes.png) · fuente editable: [`A5-vista-componentes.drawio`](A5-vista-componentes.drawio)

Hay 10 componentes. Las interfaces se nombran con el prefijo `I`. Todas las dependencias van **del consumidor a la interfaz del proveedor** y siempre hacia abajo, así que **no hay ciclos**.

| Componente | Interfaz que provee | Interfaces que requiere | Clases que agrupa (A2) | Requisitos que atiende |
|---|---|---|---|---|
| Aplicación web SPA | (interfaz de usuario) | IAutenticacion, IEventos, ITickets, IReportes, IAforoTiempoReal | (cliente React) | RF1–RF7, RF9–RF11 |
| PWA del validador | (interfaz de usuario) | IValidacion, IAforoTiempoReal | (cliente React + IndexedDB) | RF8, RNF-10 |
| Autenticación y Roles | **IAutenticacion** (`registrar`, `iniciarSesion`, `recuperarContrasena`, `asignarRol`) | IRepositorios | `Usuario`, `Rol` | RF1, RF2, RF3, RF4 |
| Gestión de Eventos | **IEventos** (`crearEvento`, `modificarEvento`, `cancelarEvento`, `importarAsistentes`) | IAuditoria, IRepositorios | `Evento`, `Sede`, `CategoriaEntrada` | RF5, RF11 |
| Emisión de Tickets | **ITickets** (`emitirTicket`, `descargarPdf`) | INotificacion, IRepositorios | `Ticket`, `GeneradorCodigoQR` | RF6 |
| Reportes | **IReportes** (`indicadores`, `exportarAsistencia`) | IRepositorios | (consultas de solo lectura) | RF9, RF10 |
| Validación de Acceso | **IValidacion** (`validar(codigo, puerta)`) | IAuditoria, INotificacion, IRepositorios, IAforoTiempoReal | `ServicioValidacionAcceso`, `ReglaValidacion` y sus 3 implementaciones, `Validacion` | RF8, RF13 |
| Aforo y Tiempo Real | **IAforoTiempoReal** (`ocupacion(evento)`, suscripción WebSocket) | INotificacion | `AlertaAforo` (y el cálculo de `Evento.porcentajeOcupacion`) | RF7, RF9 |
| Auditoría | **IAuditoria** (`registrar`, `verificarCadena`) | (escribe en la base por su propio repositorio) | `ServicioBitacora`, `RegistroBitacora` | RF12 |
| Notificaciones | **INotificacion** (`enviar(destino, alerta)`) | Servidor SMTP / SMS externo | `Notificador`, `NotificadorCorreo`, `NotificadorSMS`, `Alerta`, `AlertaIntentoSospechoso` | RF3, RF6, RF13 |
| Persistencia (repositorios) | **IRepositorios** (un repositorio por agregado) | JDBC → PostgreSQL | (repositorios Spring Data JPA) | Todos (almacenamiento) |
