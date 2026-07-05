# models

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Modelo relacional (SQLite)

```
usuarios (id_usuario PK, nombre, correo, usuario, contrasena_hash, rol, estado, fecha_creacion)

productos (id_producto PK, nombre, descripcion, categoria, precio_unitario,
           stock_actual, stock_minimo, estado)

ventas (id_venta PK, fecha_hora, id_cajero FK -> usuarios.id_usuario, total, estado)

detalle_ventas (id_detalle PK, id_venta FK -> ventas.id_venta,
                id_producto FK -> productos.id_producto,
                cantidad, precio_unitario, subtotal)

movimientos_inventario (id_movimiento PK, id_producto FK -> productos.id_producto,
                         tipo, cantidad, fecha, motivo, id_usuario FK -> usuarios.id_usuario)
```

## Relaciones

- `usuarios (1) --- (N) ventas`: un cajero registra muchas ventas.
- `ventas (1) --- (N) detalle_ventas`: una venta tiene una o más líneas de detalle.
- `productos (1) --- (N) detalle_ventas`: un producto aparece en muchas líneas de venta.
- `productos (1) --- (N) movimientos_inventario`: un producto tiene muchos movimientos de stock.
