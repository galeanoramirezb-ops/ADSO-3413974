# A6 · Vista de despliegue

Diagrama: [`A6-vista-despliegue.png`](A6-vista-despliegue.png) · fuente editable: [`A6-vista-despliegue.drawio`](A6-vista-despliegue.drawio)

| Nodo | Artefactos que aloja | Conexión (protocolo y puerto) | Decisión que responde a un RNF |
|---|---|---|---|
| Dispositivo cliente (navegador o móvil) | SPA React; PWA del validador con IndexedDB | → Balanceador: **HTTPS 443** y **WSS 443** | RNF-10: la PWA valida sin conexión y sincroniza después |
| Proxy inverso y balanceador (Nginx) | `nginx.conf` con TLS 1.3 | → Servidores de aplicación: **HTTP 8080** por red interna privada | RNF-02: TLS 1.3 terminado aquí; RNF-03: reparte la carga y saca de servicio la instancia que falle |
| Servidor de aplicación 1 (Docker) | `eventflow-api.jar` | → BD primaria: **JDBC/TLS 5432**; → Correo: **SMTP 587 STARTTLS** y **HTTPS 443** (SMS) | RNF-05: API sin estado y replicable |
| Servidor de aplicación 2 (Docker) | `eventflow-api.jar` (misma imagen) | → BD primaria: **JDBC/TLS 5432** | RNF-03: la segunda instancia mantiene el servicio si cae la primera |
| Servidor de BD primario | PostgreSQL 16, esquema `eventflow` | → Réplica: **replicación streaming 5432**; → Respaldos: **SSH/TLS** | RNF-03 y la política de disponibilidad de B6 |
| Servidor de BD réplica (en espera) | Réplica de PostgreSQL 16 | (recibe la replicación) | RNF-03: conmutación por error si falla el primario |
| Almacenamiento de respaldos | Copias completas diarias y archivos WAL | (recibe las copias) | Política B6 de disponibilidad: copia diaria con retención de 30 días y prueba de restauración mensual |
| Proveedor de correo y SMS (externo) | Servicio SMTP | (recibe los envíos) | RF6 y RF13: el envío del ticket y de las alertas no depende de un servidor propio |

**Nodos mínimos para operar:** cliente, balanceador, una instancia de aplicación y la BD primaria. La segunda instancia y la réplica son las que permiten llegar al **99,8 %** de disponibilidad.
