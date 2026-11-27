# A4 · Arquitectura del software

Diagrama: [`A4-arquitectura.png`](A4-arquitectura.png) · fuente editable: [`A4-arquitectura.drawio`](A4-arquitectura.drawio)

## Estilo definido

**Cliente-servidor con un monolito modular en capas** (presentación → API → servicios de negocio → persistencia → base de datos).

- **Comunicación entre cliente y servidor:** síncrona, por **REST/JSON sobre HTTPS** para las operaciones. Para el aforo en tiempo real, el servidor empuja los cambios por **WebSocket seguro (WSS)** (RF7, RF9).
- **Comunicación entre capas internas:** llamadas en proceso a través de interfaces (los componentes de A5).
- **Hacia la base de datos:** JDBC sobre TLS.
- **Hacia los externos:** SMTP 587 con STARTTLS y HTTPS para el envío de SMS.
- **Regla:** cada capa solo depende de la inmediatamente inferior. **No hay capas saltadas**: la presentación nunca consulta la base de datos.

## Tabla de decisiones frente a los RNF

| RNF | Decisión de diseño | Alternativa descartada | Razón del descarte |
|---|---|---|---|
| **RNF-04** Validación < 1,5 s | La fachada evalúa las reglas en memoria; `ticket.codigo` con índice `UNIQUE`; el QR se verifica con cálculo local, sin llamar a servicios externos | Verificar el QR contra un servicio externo de terceros | Agrega latencia de red y un punto de falla en la puerta |
| **RNF-05** 500 peticiones por segundo | API **sin estado** (sesión en el JWT), replicable detrás del balanceador, con pool de conexiones a la base de datos | Sesiones en memoria del servidor | Obliga a «sesión pegajosa» y no escala horizontalmente |
| **RNF-03** Disponibilidad ≥ 99,8 % | 2 instancias de la API y réplica de PostgreSQL en espera (ver A6) | Un solo servidor con todo | Cualquier caída o actualización deja el evento sin control de acceso |
| **RNF-02** TLS en tránsito | TLS 1.3 terminado en Nginx y TLS entre la API y la base de datos | HTTP en la red interna | La red del recinto puede ser compartida |
| **RNF-10** Contingencia offline | La PWA del validador guarda la lista de tickets vigentes y encola hasta 2.000 validaciones en IndexedDB; al volver la red, sincroniza por la fachada | Bloquear el acceso si no hay internet | Detiene el evento entero por una falla de red |
| **RNF-01** Contraseñas | Bcrypt con factor 12 en el componente de autenticación | Cifrado reversible (AES) de contraseñas | Una contraseña no debe poder descifrarse; se compara con hash y sal |

## Alternativa de estilo descartada

**Microservicios** (un servicio y una base de datos por módulo). Se descartó porque, para un equipo de 2 personas y una carga de 500 peticiones por segundo, multiplica los despliegues, la red, el monitoreo y la consistencia distribuida del aforo, sin un beneficio necesario. El **monolito modular** mantiene los módulos separados por interfaces (A5), así que un módulo, por ejemplo Notificaciones, se puede extraer después si crece.
