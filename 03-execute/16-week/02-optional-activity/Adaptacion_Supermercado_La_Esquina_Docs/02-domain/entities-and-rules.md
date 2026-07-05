# entities-and-rules

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Entidades principales

- **Producto**: nombre, descripción, categoría, precio unitario, stock actual, stock mínimo, estado (activo/inactivo).
- **Inventario**: movimiento de entrada o salida de stock asociado a un producto.
- **Venta**: fecha/hora, cajero que la registra, total, estado.
- **Detalle de venta**: producto, cantidad y subtotal dentro de una venta.
- **Usuario**: nombre, credenciales de acceso, rol (Administrador o Cajero), estado.
- **Cliente**: no se registra como entidad persistente; es quien recibe el comprobante de una venta.

## Reglas de negocio

- Un producto no puede venderse si su stock actual es 0.
- El total de una venta es la suma de los subtotales de su detalle (cantidad × precio unitario).
- Al confirmar una venta, el stock del producto se descuenta automáticamente en la misma cantidad vendida.
- Solo el rol **Administrador** puede crear, editar o eliminar productos y usuarios.
- El rol **Cajero** solo puede registrar ventas y consultar productos (no puede modificarlos).
- Un producto con stock actual menor o igual a su stock mínimo debe marcarse como "por reabastecer".
- Toda venta debe quedar asociada a un cajero autenticado (no existen ventas anónimas del lado del sistema).
- No se pueden eliminar productos con ventas asociadas; solo se pueden inactivar.

## Invariantes

- `stock_actual >= 0` siempre.
- `total_venta = Σ (cantidad_i × precio_unitario_i)` para cada línea i del detalle.
- Todo usuario tiene exactamente un rol vigente.
