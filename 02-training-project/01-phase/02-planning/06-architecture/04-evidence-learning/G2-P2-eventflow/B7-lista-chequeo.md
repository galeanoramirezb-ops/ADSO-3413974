# B7 · Lista de chequeo de verificación del diseño (P1 y P2)

Aplicada el **26/11/2026** sobre `../G2-P1-eventflow/` (P1) y esta carpeta (P2).

**Severidad:**
- **Crítico:** rompe un requisito o la integridad.
- **Mayor:** afecta la calidad o la trazabilidad.
- **Menor:** afecta la presentación.

| ID | Artefacto | Criterio de aceptación (medible) | Severidad | Cumple | Evidencia |
|---|---|---|---|---|---|
| LC-01 | Clases (A2) | Hay ≥ 8 clases con atributos tipados y visibilidad | Mayor | Sí | 21 clases; todos los atributos con `- / + / #` y tipo |
| LC-02 | Clases (A2) | Todas las asociaciones tienen multiplicidad en los dos extremos | Menor | Sí | 11 asociaciones con multiplicidad (ej. Usuario 1 — 0..* Ticket) |
| LC-03 | Clases (A2) | Hay ≥ 1 composición o agregación usada con criterio «es parte de» | Mayor | Sí | Evento ◆ CategoriaEntrada (la categoría no existe sin evento); ServicioValidacionAcceso ◇ ReglaValidacion |
| LC-04 | Clases (A2) | Hay ≥ 1 interfaz con ≥ 2 implementaciones (polimorfismo) | Mayor | Sí | ReglaValidacion (3), Notificador (2) |
| LC-05 | Clases (A2) | Ninguna clase mezcla interfaz, lógica, persistencia y notificación | Mayor | Sí | Las notificaciones están en `Notificador`, la bitácora en `ServicioBitacora` y la orquestación en la fachada; las entidades solo tienen reglas propias |
| LC-06 | Clases / matriz (A7) | Cada clase traza a ≥ 1 requisito | Mayor | Sí | A7, tabla «clase → requisito»: 21/21 |
| LC-07 | Patrones (A3) | Hay ≥ 2 patrones GoF distintos, uno no Singleton, visibles en el diagrama | Mayor | Sí | Estrategia y Fachada, con estereotipos `«interface»` y `«fachada»` en A2 |
| LC-08 | Patrones (A3) | Cada patrón declara el problema del caso, las clases y la mejora en mantenibilidad | Menor | Sí | Tabla de A3, columnas 2 a 5 |
| LC-09 | Arquitectura (A4) | La tabla de decisiones cubre ≥ 3 RNF con su alternativa descartada | Mayor | Sí | 6 RNF en `A4-arquitectura.md` |
| LC-10 | Arquitectura (A4) | La presentación no accede directamente a la base de datos (sin capas saltadas) | Crítico | Sí | A4: la flecha de la capa 1 solo llega a la capa 2; A5: la SPA y la PWA solo requieren interfaces de servicio |
| LC-11 | Componentes (A5) | Hay ≥ 5 componentes con interfaz provista y requerida nombradas | Mayor | Sí | 10 componentes y 9 interfaces `I…` |
| LC-12 | Componentes (A5) | Las dependencias no forman ciclos | Mayor | Sí | Todas las flechas van de arriba hacia abajo en A5 |
| LC-13 | Despliegue (A6) | Hay ≥ 3 nodos y cada conexión indica protocolo y puerto | Menor | Sí | 8 nodos; 8 conexiones con puerto (443, 8080, 5432, 587) |
| LC-14 | Despliegue (A6) | Hay ≥ 1 decisión de despliegue que responde a un RNF | Mayor | Sí | 2 instancias y réplica → RNF-03 |
| LC-15 | Modelo conceptual (B1) | Cada relación tiene verbo y (mín, máx) en ambos extremos | Mayor | Sí | 12 relaciones en B1 |
| LC-16 | Modelo conceptual (B1) | Hay ≥ 1 N:M y ≥ 1 1:N | Crítico | Sí | USUARIO–ROL y ROL–PERMISO (N:M); 9 relaciones 1:N |
| LC-17 | Modelo lógico (B2) | Toda tabla tiene PK y toda relación 1:N tiene su FK | Crítico | Sí | 14 PK y 18 FK (consulta a `pg_constraint` en el log) |
| LC-18 | Modelo lógico (B2) | Cada N:M tiene tabla intermedia | Crítico | Sí | `usuario_rol`, `rol_permiso` |
| LC-19 | Normalización (B3) | Ninguna columna guarda varios valores en una celda (1FN) | Crítico | Sí | Teléfonos en `telefono_usuario`; códigos de tickets en `ticket` |
| LC-20 | Normalización (B3) | No quedan dependencias parciales ni transitivas sin justificar | Mayor | Sí | B3: las 2 tablas llegan a 3FN; la única desnormalización (`ocupacion_actual`) está justificada |
| LC-21 | Diccionario (B4) | El 100 % de las columnas tiene tipo, tamaño, restricciones y dominio | Mayor | Sí | 84 de 84 filas en B4 |
| LC-22 | Diccionario / script | Los nombres y tipos del diccionario coinciden con el script | Mayor | Sí | Ambos se generan de la misma especificación; 84 columnas en `information_schema` = 84 en B4 |
| LC-23 | Script (B5) | El script ejecuta sin errores en un motor real | Crítico | Sí | `B5-evidencia-ejecucion.log`: PostgreSQL 16.15, «Código de salida: 0» |
| LC-24 | Script (B5) | Hay ≥ 3 CHECK y ≥ 3 FK con `ON DELETE` declarado | Mayor | Sí | 22 CHECK; 18 FK con CASCADE, RESTRICT o SET NULL |
| LC-25 | Script (B5) | Las restricciones rechazan datos inválidos (prueba negativa) | Mayor | Sí | 9 pruebas negativas fallan como se espera (log, sección «Pruebas») |
| LC-26 | Seguridad (B6) | Hay ≥ 2 políticas por principio, vinculadas a tablas del caso | Mayor | Sí | 3 de integridad, 4 de confidencialidad y 3 de disponibilidad |
| LC-27 | Seguridad (B6) | Las contraseñas se guardan con hash y sal, no cifradas | Crítico | Sí | `usuario.hash_contrasena CHAR(60)` bcrypt factor 12 (P4) |
| LC-28 | Seguridad (B6) | Hay matriz de ≥ 3 roles contra tablas | Mayor | Sí | 4 roles de aplicación y 3 roles de BD con `GRANT` |
| LC-29 | Seguridad (B6) | El respaldo tiene frecuencia y prueba de restauración | Mayor | Sí | Copia diaria + WAL; restauración mensual con acta (P8, P9) |
| LC-30 | Calidad documental | Cada diagrama tiene título, fuente editable e imagen | Menor | Sí | 6 diagramas con `.drawio` + `.png` + `.svg` |

**Resultado:** 30 de 30 criterios cumplen en la verificación final (después de corregir los hallazgos de abajo).

## Registro de hallazgos encontrados durante la verificación

| ID | Artefacto | Descripción del hallazgo | Requisito afectado | Severidad | Corrección aplicada |
|---|---|---|---|---|---|
| H-01 | Modelo conceptual (B1) | El MER de G1 mostraba la N:M USUARIO–ROL **ya resuelta** con USUARIO_ROL; en el nivel conceptual debe verse como N:M, y su resolución pertenece al modelo lógico | RF4 | Mayor | En B1 queda como N:M con sus atributos de relación; la tabla `usuario_rol` aparece solo en B2 |
| H-02 | Modelo conceptual (B1) | RF4 pide una «matriz de permisos», pero el MER de G1 no tenía la entidad PERMISO | RF4 | Mayor | Se agregaron PERMISO y la N:M ROL–PERMISO; en el lógico, `permiso` y `rol_permiso` |
| H-03 | Script (B5) | La primera prueba de `ON DELETE CASCADE` falló: suponía que el evento nuevo tendría `id_evento = 2`, pero la identidad ya había consumido ese número en un INSERT fallido | Integridad (evidencia) | Menor | La prueba ahora toma el evento con `max(id_evento)` y compara las categorías antes y después del borrado: 1 → 0 |
| H-04 | Componentes (A5) | En la primera versión del diagrama, las dependencias hacia Auditoría, Notificaciones y Persistencia se superponían y no se podía saber quién requería qué | Calidad documental | Menor | Se reorganizó en 3 filas (clientes, servicios, soporte) con dependencias directas a cada interfaz |
| H-05 | Clases (A2) | En la primera versión, la nota de notación tapaba la interfaz `Notificador` y varios métodos se salían de su caja | Calidad documental | Menor | Se ensancharon las clases, se partieron las firmas largas y la nota se movió a un espacio libre |
