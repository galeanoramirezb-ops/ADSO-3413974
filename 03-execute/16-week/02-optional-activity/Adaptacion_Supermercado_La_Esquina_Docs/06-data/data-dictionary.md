# data-dictionary

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

### Tabla `usuarios`

| Campo | Tipo | Regla |
|-------|------|-------|
| id_usuario | INTEGER PK | Autoincremental |
| nombre | TEXT | Obligatorio |
| usuario | TEXT | Único, obligatorio |
| contrasena_hash | TEXT | Obligatorio, nunca se guarda en texto plano |
| rol | TEXT | `administrador` o `cajero` |
| estado | TEXT | `activo` / `inactivo` |

### Tabla `productos`

| Campo | Tipo | Regla |
|-------|------|-------|
| id_producto | INTEGER PK | Autoincremental |
| nombre | TEXT | Obligatorio |
| categoria | TEXT | Opcional |
| precio_unitario | REAL | Mayor a 0 |
| stock_actual | INTEGER | >= 0 |
| stock_minimo | INTEGER | >= 0, por defecto 5 |
| estado | TEXT | `activo` / `inactivo` |

### Tabla `ventas`

| Campo | Tipo | Regla |
|-------|------|-------|
| id_venta | INTEGER PK | Autoincremental |
| fecha_hora | DATETIME | Obligatorio |
| id_cajero | INTEGER FK | Referencia a `usuarios` |
| total | REAL | = suma de subtotales de `detalle_ventas` |

### Tabla `detalle_ventas`

| Campo | Tipo | Regla |
|-------|------|-------|
| id_detalle | INTEGER PK | Autoincremental |
| id_venta | INTEGER FK | Referencia a `ventas` |
| id_producto | INTEGER FK | Referencia a `productos` |
| cantidad | INTEGER | > 0, <= stock disponible al momento de la venta |
| precio_unitario | REAL | Copia del precio del producto al momento de la venta |
| subtotal | REAL | = cantidad × precio_unitario |

### Tabla `movimientos_inventario`

| Campo | Tipo | Regla |
|-------|------|-------|
| id_movimiento | INTEGER PK | Autoincremental |
| id_producto | INTEGER FK | Referencia a `productos` |
| tipo | TEXT | `entrada` / `salida` |
| cantidad | INTEGER | > 0 |
| motivo | TEXT | Ej: "venta", "ajuste manual", "reabastecimiento" |
