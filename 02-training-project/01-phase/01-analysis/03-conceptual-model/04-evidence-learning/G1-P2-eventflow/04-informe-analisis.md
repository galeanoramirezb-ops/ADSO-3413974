# 4. Informe de análisis · EventFlow Manager (SIGEV)

**Guía 1 · Producto 2** · Fecha: 26/11/2026 · Metodología: Scrum (sprint de análisis, ver G1-P1)

## 4.1 Requisitos interpretados

El SRS del equipo (IEEE 830) define **13 requisitos funcionales** y **10 no funcionales**.

**Funcionales (qué hace el sistema).** Se agrupan en cuatro frentes:

| Frente | RF | Interpretación |
|---|---|---|
| Cuentas y acceso | RF1–RF4 | Registro con consentimiento de datos (Ley 1581 de 2012), inicio de sesión, recuperación de contraseña y asignación de roles (Superadministrador, Organizador, Validador y Asistente) |
| Eventos y tickets | RF5, RF6, RF11 | El organizador crea eventos con sede, aforo y categorías; el asistente obtiene un ticket con QR que cambia cada pocos segundos para impedir la reventa por captura de pantalla |
| Control en puerta | RF7, RF8, RF13 | El validador escanea el QR, el sistema muestra la foto del titular y controla el aforo (alerta al 80 % y bloqueo al 100 %). Los intentos de reutilizar un ticket se alertan al titular |
| Seguimiento | RF9, RF10, RF12 | Indicadores en vivo, reportes exportables y una bitácora que no se puede modificar |

**No funcionales (cómo de bien).** Se tratan como restricciones sobre los casos de uso, no como funciones:
- **Rendimiento:** validación en menos de 1,5 s (RNF-04) con 500 peticiones por segundo (RNF-05).
- **Seguridad:** contraseñas protegidas y tráfico cifrado (RNF-01 y RNF-02).
- **Disponibilidad:** 99,8 % (RNF-03).
- **Accesibilidad:** WCAG 2.1 AA (RNF-06).
- **Datos personales:** Ley 1581 (RNF-07).
- **Anti-clonación:** RNF-08.
- **Despliegue en contenedores:** RNF-09.
- **Validación sin conexión:** RNF-10.

En `../G1-P1-eventflow/04-matriz-requisitos-casos-uso.md` cada RNF está ligado a los casos que restringe.

## 4.2 Modelos producidos

| Modelo | Archivo (fuente editable e imagen) | Qué muestra |
|---|---|---|
| Diagrama de casos de uso (G1-P1) | `../G1-P1-eventflow/diagrama-casos-uso.drawio` / `.png` | 16 casos, 6 actores, 2 «include», 3 «extend» y generalización de actores |
| Plantillas extendidas | [`01-plantillas-casos-uso.md`](01-plantillas-casos-uso.md) | CU-05, CU-07 y CU-09, con flujos alternos, excepciones y reglas de negocio |
| Diagrama de actividades CU-07 | [`actividades-CU07-obtener-ticket.drawio`](actividades-CU07-obtener-ticket.drawio) / [`.png`](actividades-CU07-obtener-ticket.png) | 3 calles, 3 decisiones con guardas, bifurcación y unión |
| Diagrama de actividades CU-09 | [`actividades-CU09-validar-acceso.drawio`](actividades-CU09-validar-acceso.drawio) / [`.png`](actividades-CU09-validar-acceso.png) | 3 calles, 4 decisiones con guardas y 2 nodos de fusión; sin concurrencia (declarado) |
| Modelo de dominio | [`modelo-dominio.drawio`](modelo-dominio.drawio) / [`.png`](modelo-dominio.png) | 13 clases conceptuales, multiplicidades y generalización de Alerta |
| Modelo entidad-relación | [`modelo-entidad-relacion.drawio`](modelo-entidad-relacion.drawio) / [`.png`](modelo-entidad-relacion.png) | Pata de gallo; 11 entidades; N:M resuelta (USUARIO_ROL); entidad débil CATEGORIA_ENTRADA |
| Prototipo inicial | [`P1`](mockup-P1-CU05-gestionar-evento.png) · [`P2`](mockup-P2-CU07-obtener-ticket.png) · [`P3`](mockup-P3-CU09-validar-acceso.png) | Una pantalla por caso crítico, rotulada con su caso de uso |

## 4.3 Resultado de la verificación

Se aplicó una lista de **20 criterios verificables**, 5 de ellos de cobertura o trazabilidad ([`02-lista-chequeo.md`](02-lista-chequeo.md)).

- **Primera verificación (25/11):** cumplen 12 de 20 (60 %). No cumplían:
  - los criterios **2 y 3**, porque faltaban plantillas y conceptos en el dominio;
  - los criterios **6 y 7**, porque las pantallas no estaban rotuladas ni cubrían los casos críticos;
  - los criterios **8, 9 y 10**, porque la especificación de validación tenía detalles técnicos, confundía alterno con excepción y ponía al sistema como actor;
  - el criterio **18**, porque la relación N:M entre usuario y rol no estaba resuelta.
- **Segunda verificación (26/11):** cumplen **20 de 20 (100 %)**.

## 4.4 Ajustes realizados

Se registraron **6 hallazgos** con su antes y después ([`03-registro-ajustes.md`](03-registro-ajustes.md)):

1. Quité los detalles de implementación de la especificación de validación.
2. Reclasifiqué las excepciones que figuraban como flujos alternos.
3. Construí 3 pantallas rotuladas.
4. Resolví la N:M USUARIO–ROL con USUARIO_ROL.
5. Saqué al sistema del papel de actor.
6. Agregué las clases Sede, CategoríaEntrada y Alerta al dominio.

## 4.5 Trazabilidad

En [`05-matriz-trazabilidad.md`](05-matriz-trazabilidad.md), el **100 %** de los RF (13 de 13) está trazado hasta el caso de uso, la clase de dominio y la entidad del MER. Los 6 RF de los casos críticos llegan además hasta la plantilla, el diagrama de actividades y la pantalla.

**Pendiente para la fase de diseño (G2):**
- pasar el MER al modelo lógico relacional y normalizarlo;
- definir la arquitectura que cumpla RNF-03, RNF-04 y RNF-10;
- convertir las reglas RN-01 a RN-08 en restricciones de la base de datos.
