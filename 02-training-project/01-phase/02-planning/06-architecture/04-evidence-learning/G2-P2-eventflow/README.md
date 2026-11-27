# README de entrega · Guía 2 · Producto 2: modelo de datos y verificación

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P2 (modelo de datos y verificación) |
| Usuario de GitHub del autor | galeanoramirezb-ops |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | EventFlow Manager (SIGEV), el mismo caso de P1 |
| Enlace al informe de análisis o SRS del caso (ruta en mi fork) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-eventflow/04-informe-analisis.md` |
| Cuenta de GitHub con la que hago los commits | galeanoramirezb-ops |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | El SRS base, sí: lo hizo el equipo con una conformación anterior; hoy el equipo es de 2 aprendices. El MER de partida es mío (G1-P2). |
| ¿Qué parte del SRS es tuya? | Diseño los datos de los 13 RF |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| B1 Modelo conceptual | `B1-modelo-conceptual.drawio` / `.png`, `B1-B2-modelo-conceptual-y-logico.md` | `.../G1-P2-eventflow/modelo-entidad-relacion.drawio` | Dejé la N:M USUARIO–ROL sin resolver (nivel conceptual), agregué PERMISO y la N:M ROL–PERMISO, el teléfono multivaluado, verbos y (mín, máx); quité las FK |
| B2 Modelo lógico | `B2-modelo-logico.drawio` / `.png`, `B1-B2-…md` | nuevo (a partir de B1) | 14 tablas con tipos, PK y FK; cuadro de 12 reglas de transformación |
| B3 Normalización | `B3-normalizacion.md` | nuevo | 2 planillas reales del proceso manual llevadas de 0FN a 3FN con DF escritas; desnormalización justificada |
| B4 Diccionario | `B4-diccionario-datos.md` | nuevo | 84 columnas en 14 tablas, con estándar de nombrado declarado |
| B5 Script SQL | `B5-script-creacion.sql`, `B5-pruebas-restricciones.sql`, `B5-evidencia-ejecucion.log` | nuevo | Ejecutado en PostgreSQL 16.15 sin errores; 22 CHECK; 18 FK con acción referencial; disparador de inmutabilidad; roles con `GRANT`; 9 pruebas negativas |
| B6 Políticas de seguridad | `B6-politicas-seguridad.md` | Requisitos RNF-01, RNF-02 y RNF-07 del SRS | 10 políticas ligadas a tablas y columnas, tratamiento de datos personales y matriz de 4 roles de aplicación + 3 roles de BD |
| B7 Lista de chequeo | `B7-lista-chequeo.md` | Formato de lista de chequeo de mi G1-P2 | 30 criterios con severidad aplicados a P1 y P2, y 5 hallazgos con su corrección |

**Qué reutilicé:** mi MER de la Guía 1 (11 entidades en notación pata de gallo) y las reglas de negocio RN-01 a RN-08 de mis plantillas de casos de uso, que se convirtieron en restricciones `CHECK` y `FOREIGN KEY`.

**Qué ajusté para llevarlo al estándar de la rúbrica:**
- Separé el nivel conceptual (N:M sin resolver, sin FK) del lógico (tablas intermedias, PK y FK).
- Agregué la entidad PERMISO, que faltaba para RF4.
- Agregué verbos y cardinalidades (mín, máx) en todas las relaciones.

**Qué hice completamente nuevo:**
- La normalización paso a paso.
- El diccionario completo.
- El script ejecutado en un motor real, con pruebas negativas.
- Los roles de base de datos con mínimo privilegio.
- La bitácora inmutable por disparador.
- Las políticas de respaldo y restauración.
- La lista de chequeo con severidad.

## 4. Autoverificación de mínimos

- [x] B1 Modelo conceptual: ≥ 6 entidades (11), cardinalidades, ≥ 1 N:M (2) y ≥ 1 1:N (9)
- [x] B2 Modelo lógico: ≥ 8 tablas (14) con PK/FK y cuadro de reglas de transformación
- [x] B3 Normalización: 2 tablas de 0FN a 3FN con dependencias funcionales (una con llave compuesta y una con dependencia transitiva)
- [x] B4 Diccionario de datos completo (84/84 columnas)
- [x] B5 Script SQL ejecutado sin errores (evidencia en `B5-evidencia-ejecucion.log`) y `ON DELETE` en ≥ 3 FK (18)
- [x] B6 ≥ 6 políticas de seguridad (10), con hash y sal en contraseñas y TLS, y matriz de ≥ 3 roles
- [x] B7 Lista de chequeo de ≥ 20 criterios (30), diligenciada sobre P1 y P2, con evidencia

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| Jueves 26/11/2026 | `G2-P1: artefactos de diseño EventFlow` (el diseño del que sale este modelo) |
| Viernes 27/11/2026 | `G2-P2: modelo de datos, script SQL ejecutado y verificación` |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Claude (Anthropic) | Para generar el script SQL, el diccionario y los diagramas a partir de una sola especificación del modelo, ejecutar el script en PostgreSQL y redactar borradores de la normalización, las políticas y la lista de chequeo | Revisé el log de ejecución (código de salida 0 y las 9 pruebas negativas), comprobé que el diccionario y el script coinciden columna por columna, y que cada política de B6 apunta a una tabla o columna real del script |

## 7. Enlaces

- Informe de análisis / SRS del caso: `../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-eventflow/04-informe-analisis.md`
- Carpeta de esta entrega en GitHub: https://github.com/galeanoramirezb-ops/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-eventflow
- Producto 1 (artefactos de diseño): `../G2-P1-eventflow/`

**Cómo reproducir la ejecución del script:**
```bash
createdb eventflow_db
psql -v ON_ERROR_STOP=1 -d eventflow_db -f B5-script-creacion.sql
psql -d eventflow_db -f B5-pruebas-restricciones.sql   # los ERROR son esperados
```

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: galeanoramirezb-ops · Fecha: 27/11/2026
