# 4. Matriz requisito → caso de uso

**Fuente:** SRS EventFlow Manager (SIGEV), tabla de requisitos funcionales RF1–RF13 y tabla de no funcionales RNF-01–RNF-10.

## 4.1 Requisitos funcionales → casos de uso

| RF | Requisito funcional | Prioridad | Caso(s) de uso | Actor que lo inicia |
|---|---|---|---|---|
| RF1 | Registro de usuarios y consentimiento de datos | Alta | CU-01 | Asistente |
| RF2 | Inicio de sesión y autenticación segura | Alta | CU-02 | Usuario registrado |
| RF3 | Recuperación de contraseña por correo | Media | CU-03 (extiende CU-02) | Usuario registrado |
| RF4 | Administración de roles y matriz de permisos | Alta | CU-04 | Superadministrador |
| RF5 | Creación y parametrización de eventos | Alta | CU-05 | Organizador |
| RF6 | Emisión de tickets con QR dinámico | Alta | CU-07, CU-08 | Asistente |
| RF7 | Control y monitoreo de aforo en tiempo real | Alta | CU-09 (actualiza la ocupación), CU-11, CU-13 | Validador de acceso / Organizador |
| RF8 | Validación óptica y blindaje contra suplantación | Alta | CU-09 | Validador de acceso |
| RF9 | Dashboard de indicadores en vivo | Media | CU-14 | Organizador |
| RF10 | Exportación de reportes en PDF y Excel | Media | CU-15 | Organizador |
| RF11 | Importación masiva de asistentes | Baja | CU-06 | Organizador |
| RF12 | Bitácora de auditoría inmutable | Alta | CU-10, CU-16 | Validador de acceso (vía CU-09) / Superadministrador |
| RF13 | Prevención de ingeniería social y alertas anti-phishing | Alta | CU-12 (extiende CU-09) | Validador de acceso (vía CU-09) |

### Cobertura

| Indicador | Valor |
|---|---|
| Requisitos funcionales en el SRS | 13 |
| RF cubiertos por al menos un caso de uso | **13** |
| **Cobertura** | **100 %** (13 / 13) |
| RF no cubiertos | Ninguno |
| Casos de uso sin requisito (huérfanos) | Ninguno: los 16 casos atienden al menos un RF |

### Matriz de verificación cruzada (RF × CU)

| | CU01 | CU02 | CU03 | CU04 | CU05 | CU06 | CU07 | CU08 | CU09 | CU10 | CU11 | CU12 | CU13 | CU14 | CU15 | CU16 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| RF1 | X | | | | | | | | | | | | | | | |
| RF2 | | X | | | | | | | | | | | | | | |
| RF3 | | | X | | | | | | | | | | | | | |
| RF4 | | | | X | | | | | | | | | | | | |
| RF5 | | | | | X | | | | | | | | | | | |
| RF6 | | | | | | | X | X | | | | | | | | |
| RF7 | | | | | | | | | X | | X | | X | | | |
| RF8 | | | | | | | | | X | | | | | | | |
| RF9 | | | | | | | | | | | | | | X | | |
| RF10 | | | | | | | | | | | | | | | X | |
| RF11 | | | | | | X | | | | | | | | | | |
| RF12 | | | | | | | | | | X | | | | | | X |
| RF13 | | | | | | | | | | | | X | | | | |

## 4.2 Requisitos no funcionales (no se modelan como casos de uso)

Los requisitos no funcionales **no son funciones** que un actor pida al sistema. Son restricciones de calidad que se cumplen *dentro* de los casos de uso. Por eso no aparecen como óvalos en el diagrama, sino como condiciones sobre los casos que afectan.

| RNF | Atributo de calidad | Métrica | Casos de uso que restringe |
|---|---|---|---|
| RNF-01 | Seguridad de contraseñas | Bcrypt con factor 12; cero contraseñas en texto plano | CU-01, CU-02, CU-03 |
| RNF-02 | Seguridad en tránsito | Todo el tráfico por HTTPS / TLS 1.3 | Todos |
| RNF-03 | Disponibilidad | 99,8 % o más al mes | Todos, en especial CU-09 |
| RNF-04 | Rendimiento | Escaneo en menos de 1,5 s en el 95 % de los casos | CU-09 |
| RNF-05 | Concurrencia | 500 peticiones por segundo | CU-09, CU-13 |
| RNF-06 | Accesibilidad | WCAG 2.1 nivel AA | CU-01, CU-07, CU-09 |
| RNF-07 | Protección de datos | Ley 1581 de 2012: consentimiento expreso y cifrado en reposo | CU-01, CU-06 |
| RNF-08 | Blindaje contra ingeniería social | QR rotativo cada 30 s y alertas anti-clonación | CU-07, CU-09, CU-12 |
| RNF-09 | Portabilidad | Despliegue en contenedores Docker | No afecta un caso de uso concreto (restricción de infraestructura) |
| RNF-10 | Contingencia offline | Validación local de hasta 2.000 entradas sin internet | CU-09 |

**Distinción aplicada:**
- Un requisito es **funcional** si describe *qué hace* el sistema ante la petición de un actor (por ejemplo, "emitir ticket").
- Es **no funcional** si describe *cómo de bien* debe hacerlo, o bajo qué restricción (por ejemplo, "en menos de 1,5 s" o "con TLS 1.3").
