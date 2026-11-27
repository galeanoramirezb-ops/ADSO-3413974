# B3 · Evidencia de normalización (0FN → 3FN)

Se parte de dos planillas reales del proceso manual que EventFlow reemplaza (el problema descrito en el SRS: «listas físicas o Excel»). Las dos son tablas **de mi propio modelo**.

---

## Tabla 1 · Planilla de categorías por evento (llave compuesta → dependencia parcial)

**Estado 0FN:** así la lleva hoy el organizador en Excel.

`planilla_categorias(id_evento, num_categoria, titulo_evento, fecha_inicio, id_sede, nombre_sede, ciudad_sede, capacidad_sede, nombre_categoria, cupo, precio, codigos_tickets)`

- Llave candidata: (`id_evento`, `num_categoria`).
- `codigos_tickets` guarda varios códigos en una celda, por ejemplo `"EVF-01, EVF-02, EVF-07"`.

| Paso | Violación encontrada | Dependencias funcionales (DF) escritas | Estado después del paso |
|---|---|---|---|
| **1FN** | `codigos_tickets` no es atómico (grupo repetitivo) | `codigo → id_evento, num_categoria` (cada ticket pertenece a una categoría) | Sale la columna. Nueva tabla `ticket(codigo, id_evento, num_categoria)`. Queda `planilla_categorias(id_evento, num_categoria, titulo_evento, fecha_inicio, id_sede, nombre_sede, ciudad_sede, capacidad_sede, nombre_categoria, cupo, precio)`, ya con valores atómicos |
| **2FN** (dependencia **parcial** de la llave compuesta) | `titulo_evento`, `fecha_inicio`, `id_sede`, `nombre_sede`, `ciudad_sede` y `capacidad_sede` dependen **solo de `id_evento`**, no de la llave completa | `id_evento → titulo_evento, fecha_inicio, id_sede, nombre_sede, ciudad_sede, capacidad_sede` · `(id_evento, num_categoria) → nombre_categoria, cupo, precio` | Se separa en `evento(id_evento, titulo_evento, fecha_inicio, id_sede, nombre_sede, ciudad_sede, capacidad_sede)` y `categoria_entrada(id_evento, num_categoria, nombre_categoria, cupo, precio)`. Ningún atributo depende de una parte de la llave |
| **3FN** (dependencia **transitiva**) | En `evento`, los datos de la sede dependen de `id_sede`, que a su vez depende de `id_evento` | `id_evento → id_sede` · `id_sede → nombre_sede, ciudad_sede, capacidad_sede` | Nueva tabla `sede(id_sede, nombre, ciudad, capacidad_fisica)`. `evento` conserva solo `id_sede` como FK |

**Resultado (coincide con el modelo lógico):** `sede`, `evento`, `categoria_entrada` (PK compuesta) y `ticket`, sin dependencias parciales ni transitivas.

---

## Tabla 2 · Planilla del validador en puerta (dependencia transitiva)

**Estado 0FN:** la hoja que hoy se llena a mano en la entrada.

`planilla_puerta(id_validacion, fecha_hora, puerta, codigo_ticket, nombre_asistente, correo_asistente, categoria, id_validador, nombre_validador, telefonos_validador, resultado, motivo)`

- Llave: `id_validacion`.
- `telefonos_validador` trae varios números separados por «/».

| Paso | Violación encontrada | Dependencias funcionales (DF) escritas | Estado después del paso |
|---|---|---|---|
| **1FN** | `telefonos_validador` es multivaluado | `id_validador → {telefono}` | Nueva tabla `telefono_usuario(id_telefono, id_usuario, numero)`; sale la columna |
| **2FN** | La llave es simple (`id_validacion`), así que no puede haber dependencia parcial | `id_validacion → fecha_hora, puerta, codigo_ticket, id_validador, resultado, motivo` | La tabla ya está en 2FN (se verifica y se deja constancia) |
| **3FN** (dependencia **transitiva**) | Los datos del asistente dependen del ticket, y los del validador dependen del validador, no de la validación | `id_validacion → codigo_ticket → nombre_asistente, correo_asistente, categoria` · `id_validacion → id_validador → nombre_validador` | Los datos del asistente y la categoría salen a `ticket` y `usuario` (vía `id_asistente`); `nombre_validador` sale a `usuario`. Queda `validacion(id_validacion, id_ticket, id_validador, fecha_hora, puerta, resultado, motivo_rechazo)` |

**Resultado (coincide con el modelo lógico):** `validacion` con 2 FK (`id_ticket`, `id_validador`), sin atributos que dependan de otro atributo no llave.

---

## Desnormalización declarada (a propósito)

| Columna | Por qué rompe la 3FN | Justificación | Cómo se controla |
|---|---|---|---|
| `evento.ocupacion_actual` | Es un dato **derivado**: se puede calcular contando las validaciones concedidas del evento | **RNF-04** (validación < 1,5 s) y **RF7** (aforo en vivo): contar miles de filas en cada escaneo es lento | Se actualiza en la **misma transacción** que inserta la validación concedida; `CHECK (ocupacion_actual BETWEEN 0 AND aforo_maximo)` impide superar el aforo. Un reporte nocturno compara el valor con `COUNT(*)` |
