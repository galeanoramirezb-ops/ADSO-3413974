# 3. Registro de ajustes y segunda verificación (Anexo D)

Hallazgos de la **primera verificación** con la lista de chequeo (`02-lista-chequeo.md`), los cambios hechos y el resultado de la **segunda verificación**.

| # | Hallazgo (criterio que no cumplía) | Artefacto | Antes | Después | Enlace al commit | ¿Se verificó de nuevo? |
|---|---|---|---|---|---|---|
| H1 | Criterio 8: la especificación incluía detalles de implementación | Plantilla CU-09 (antes, especificación del CU de validación en el SRS) | Nombraba el endpoint `/api/v1/access/...`, el motor de base de datos y los algoritmos TOTP y HMAC-SHA256 dentro del flujo | Flujo redactado como intención: «el sistema verifica que el código esté vigente y sea auténtico»; la tecnología queda para la fase de diseño (G2) | (pegar enlace) | Sí · 26/11 · cumple |
| H2 | Criterio 9: excepciones clasificadas como flujos alternos | Plantilla CU-09 | «Código caducado» y «boleto ya utilizado» figuraban como flujos alternativos A1 y A2 | Reclasificados como **excepciones** 3a y 4a, porque impiden el objetivo (entrar). Se agregó la excepción 6a (foto no coincide) y el alterno 7a (alerta de aforo), que sí termina con éxito | (pegar enlace) | Sí · 26/11 · cumple |
| H3 | Criterios 6 y 7: pantallas sin rótulo y sin cubrir los casos críticos | Prototipo | Solo existía un boceto a mano del Dashboard (`03-execute/14-week`), sin caso de uso asociado | 3 pantallas de baja fidelidad rotuladas: P1 · CU-05, P2 · CU-07 y P3 · CU-09, con su estado principal y una variante alterna o de excepción | (pegar enlace) | Sí · 26/11 · cumple |
| H4 | Criterio 18: la relación N:M no estaba resuelta | MER | El rol era un atributo único del usuario, lo que no permitía que una persona fuera, por ejemplo, organizador y validador | Entidad asociativa **USUARIO_ROL** con atributos propios (`fecha_asignacion`, `asignado_por`) que resuelve la N:M USUARIO–ROL | (pegar enlace) | Sí · 26/11 · cumple |
| H5 | Criterio 10: el sistema figuraba como actor | Plantilla CU-09 | Actores primarios: «Validador de Acceso y Sistema Backend» | Actor primario: **Validador de acceso**; actor secundario: Asistente. El sistema es quien responde, no un actor | (pegar enlace) | Sí · 26/11 · cumple |
| H6 | Criterio 3: conceptos de las plantillas sin clase en el dominio | Modelo de dominio | «Sede» era solo un texto dentro del evento, y la regla «aforo ≤ capacidad de la sede» (PL-CU05) no tenía dónde apoyarse | Clase **Sede** con `capacidadFísica`; también se agregaron **CategoríaEntrada** y la jerarquía **Alerta** para soportar PL-CU07 y PL-CU09 | (pegar enlace) | Sí · 26/11 · cumple |

**Resultado de la segunda verificación:** los 8 criterios que fallaban (2, 3, 6, 7, 8, 9, 10 y 18) ahora se cumplen. Cumplimiento: de 60 % a **100 %** (20 de 20 criterios).
