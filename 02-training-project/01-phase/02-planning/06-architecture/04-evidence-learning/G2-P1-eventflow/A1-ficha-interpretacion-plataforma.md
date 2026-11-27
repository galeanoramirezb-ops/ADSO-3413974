# A1 · Ficha de interpretación del análisis y plataforma tecnológica

**Caso:** EventFlow Manager (SIGEV) · **Insumo:** SRS del equipo (IEEE 830) y G1 (`../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-eventflow/` y `G1-P2-eventflow/`)

**Subconjunto que diseño:** los 13 RF completos. El equipo actual es de 2 aprendices. Mis decisiones de diseño propias son los patrones Estrategia y Fachada, la arquitectura en capas y la política de bitácora encadenada; en la oral las explico.

## 1. Requisitos funcionales seleccionados (13)

| ID | Requisito (texto corto) | Prioridad | Caso de uso (G1) |
|---|---|---|---|
| RF1 | Registrar usuarios con consentimiento de datos personales | Alta | CU-01 |
| RF2 | Iniciar sesión con autenticación segura | Alta | CU-02 |
| RF3 | Recuperar la contraseña por correo con un enlace de 30 minutos | Media | CU-03 |
| RF4 | Administrar roles y matriz de permisos (Superadmin, Organizador, Validador, Asistente) | Alta | CU-04 |
| RF5 | Crear y parametrizar eventos (sede, fechas, aforo y categorías) | Alta | CU-05 |
| RF6 | Emitir tickets con QR dinámico y enviarlos por correo en PDF | Alta | CU-07, CU-08 |
| RF7 | Controlar el aforo en tiempo real (alerta al 80 % y bloqueo al 100 %) | Alta | CU-09, CU-11, CU-13 |
| RF8 | Validar el acceso con lectura del QR y verificación fotográfica | Alta | CU-09 |
| RF9 | Mostrar un dashboard de indicadores en vivo | Media | CU-14 |
| RF10 | Exportar reportes de asistencia en PDF y Excel | Media | CU-15 |
| RF11 | Importar asistentes por lote desde CSV | Baja | CU-06 |
| RF12 | Llevar una bitácora de auditoría inmutable | Alta | CU-10, CU-16 |
| RF13 | Detectar intentos sospechosos y alertar al titular | Alta | CU-12 |

## 2. Requisitos no funcionales (≥ 3, con métrica)

| ID | Requisito | Métrica | Decisión de diseño (ver A4) |
|---|---|---|---|
| RNF-02 | Seguridad en tránsito | 100 % del tráfico por TLS 1.3 | Terminación TLS en Nginx; TLS también hacia la base de datos |
| RNF-03 | Disponibilidad | ≥ 99,8 % mensual | 2 instancias de la API y réplica de base de datos en espera |
| RNF-04 | Rendimiento de la validación | < 1,5 s en el 95 % de los escaneos | Verificación del QR en memoria e índice único en `ticket.codigo` |
| RNF-05 | Concurrencia | 500 peticiones por segundo | API sin estado (JWT) escalable en horizontal |
| RNF-01 | Contraseñas | Bcrypt con factor 12 (hash con sal) | `hash_contrasena` de 60 caracteres; nunca en texto plano |
| RNF-10 | Contingencia offline | 2.000 validaciones en cola local | PWA con IndexedDB y sincronización posterior |

## 3. Actores

Asistente · Organizador · Validador de acceso · Superadministrador · Servicio de correo y SMS (sistema externo).

## 4. Restricciones

| Tipo | Restricción |
|---|---|
| Equipo | 2 aprendices en formación, que conocen Java y JavaScript |
| Plazo | El análisis y el diseño se entregan el 28/11/2026; la propuesta técnica, el 05/12/2026 |
| Infraestructura | Contenedores Docker, para un despliegue igual en el ambiente del SENA y en la nube (RNF-09) |
| Legal | Ley 1581 de 2012 (datos personales): consentimiento, finalidad y revocatoria |
| Presupuesto | Preferencia por software libre o de licencia permisiva |

## 5. Plataforma tecnológica

| Elemento | Decisión | Justificación con condiciones del caso |
|---|---|---|
| **Lenguaje orientado a objetos (backend)** | **Java 21 + Spring Boot 3** | (1) El equipo ya trabajó Java en la formación, así que no hay curva de aprendizaje; (2) Spring Security trae JWT y bcrypt listos para RF2 y RNF-01; (3) es tipado y orientado a objetos, lo que permite aplicar interfaces y patrones (Estrategia y Fachada) del diagrama de clases; (4) corre en un contenedor Docker de 512 MB (RNF-09); (5) tiene librerías maduras para QR y PDF (RF6) y para WebSocket (RF7). |
| Lenguaje del cliente | TypeScript + React | Interfaz reactiva para el dashboard en vivo (RF9); PWA con cámara e IndexedDB para el validador (RF8, RNF-10); componentes accesibles (RNF-06). |
| **Tipo de base de datos** | **Relacional: PostgreSQL 16** | (1) Las relaciones son fijas y fuertes (usuario → ticket → validación), y el aforo exige **transacciones ACID** para no vender ni dejar entrar de más (RF7); (2) la integridad referencial y las restricciones `CHECK` sostienen las reglas RN-01 a RN-08 de G1; (3) los disparadores permiten hacer la bitácora **inmutable** (RF12); (4) admite réplica en espera para la disponibilidad (RNF-03). Se descartó una base NoSQL de documentos, porque no garantiza la consistencia del aforo entre puertas sin lógica adicional. |

## 6. Entregables de diseño de esta guía

| Código | Entregable | Archivo |
|---|---|---|
| A1 | Ficha de interpretación y plataforma | este archivo |
| A2 | Diagrama de clases | `A2-diagrama-clases.drawio` / `.png` |
| A3 | Patrones de diseño | `A3-patrones-diseno.md` |
| A4 | Arquitectura y tabla de decisiones | `A4-arquitectura.drawio` / `.png` / `.md` |
| A5 | Vista de componentes | `A5-vista-componentes.drawio` / `.png` / `.md` |
| A6 | Vista de despliegue | `A6-vista-despliegue.drawio` / `.png` / `.md` |
| A7 | Matriz de trazabilidad | `A7-matriz-trazabilidad.md` |
| B1–B7 | Modelo de datos y verificación | carpeta `../G2-P2-eventflow/` |
