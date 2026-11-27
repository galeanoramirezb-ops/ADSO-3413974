# 5. Matriz de trazabilidad requisito → artefactos (Anexo C)

**AD** = diagrama de actividades · **PL** = plantilla extendida · **P1–P3** = pantallas del prototipo. La pantalla se exige solo para los casos críticos (CU-05, CU-07 y CU-09).

| Requisito | Caso de uso | Diagrama de actividades | Plantilla | Clase de dominio | Entidad del MER | Pantalla |
|---|---|---|---|---|---|---|
| RF1 Registro y consentimiento | CU-01 | – | – (caso no crítico) | Usuario, Consentimiento | USUARIO, CONSENTIMIENTO | – |
| RF2 Inicio de sesión | CU-02 | – | – (caso no crítico) | Usuario, Rol | USUARIO, USUARIO_ROL | – |
| RF3 Recuperar contraseña | CU-03 | – | – (caso no crítico) | Usuario | USUARIO | – |
| RF4 Roles y permisos | CU-04 | – | – (caso no crítico) | Rol, Permiso, Usuario | ROL, USUARIO_ROL | – |
| RF5 Crear y parametrizar eventos | **CU-05** | – | **PL-CU05** (pasos 1–8, 1a, 1b, 6a, 6b) | Evento, Sede, CategoríaEntrada | EVENTO, SEDE, CATEGORIA_ENTRADA | **P1** |
| RF6 Ticket con QR dinámico | **CU-07**, CU-08 | **AD-CU07** | **PL-CU07** (pasos 1–8, 2a, 2b, 7a) | Ticket, CategoríaEntrada, Usuario | TICKET, CATEGORIA_ENTRADA | **P2** |
| RF7 Aforo en tiempo real | **CU-09**, CU-11, CU-13 | **AD-CU09** (rama 7a) | **PL-CU09** (paso 7 y alterno 7a) | Evento (aforoMáximo), AlertaAforo | EVENTO (ocupacion_actual), ALERTA | **P3** |
| RF8 Validación y anti-suplantación | **CU-09** | **AD-CU09** | **PL-CU09** (pasos 1–8, 3a, 4a, 6a) | Validación, Ticket | VALIDACION, TICKET | **P3** |
| RF9 Dashboard de indicadores | CU-14 | – | – (caso no crítico) | Evento, Validación | EVENTO, VALIDACION | – |
| RF10 Exportar reportes | CU-15 | – | – (caso no crítico) | Ticket, Validación, Evento | TICKET, VALIDACION | – |
| RF11 Importación masiva de asistentes | CU-06 | – | – (caso no crítico) | Usuario, Ticket | USUARIO, TICKET | – |
| RF12 Bitácora inmutable | CU-10, CU-16 | **AD-CU09** (registro final) | **PL-CU09** (paso 8) | RegistroBitácora | BITACORA | **P3** |
| RF13 Anti-ingeniería social | CU-12 | **AD-CU09** (ramas 3a, 4a, 6a) | **PL-CU09** (excepciones) | AlertaIntentoSospechoso | ALERTA (tipo SOSPECHOSO) | **P3** |

## Cobertura

| Nivel de trazabilidad | RF trazados | % |
|---|---|---|
| Caso de uso | 13 / 13 | 100 % |
| Clase de dominio | 13 / 13 | 100 % |
| Entidad del MER | 13 / 13 | 100 % |
| Plantilla o diagrama de actividades | 6 / 13 (todos los RF de los casos críticos) | 46 % (los 7 restantes son casos no críticos; su descripción está en el catálogo de G1-P1) |
| Pantalla de los casos críticos | 3 / 3 casos críticos | 100 % |

**Casos críticos elegidos:** CU-05, CU-07 y CU-09. Concentran el riesgo del sistema (aforo, fraude y suplantación) y atienden los 6 RF de prioridad alta del flujo central del evento: RF5, RF6, RF7, RF8, RF12 y RF13.
