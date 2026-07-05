# domain-events

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

Aunque el sistema es monolítico y no usa mensajería entre servicios, se documentan los eventos de dominio como referencia funcional (equivalen a acciones registradas dentro de la misma base de datos/transacción):

| Evento | Disparado por | Efecto |
|--------|----------------|--------|
| `VentaRegistrada` | Módulo de Ventas (RF-02) | Se calcula el total (RF-03) y se descuenta stock en Inventario (RF-04) |
| `ProductoCreado` | Módulo de Productos (RF-05) | Aparece disponible para venta e inventario |
| `ProductoActualizado` | Módulo de Productos (RF-05) | Cambia precio, descripción o estado del producto |
| `StockActualizado` | Módulo de Inventario (RF-04) | Se recalcula disponibilidad y se evalúa alerta de stock mínimo |
| `StockMinimoAlcanzado` | Módulo de Inventario | Genera alerta visible para el Administrador |
| `UsuarioAutenticado` | Módulo de Usuarios (RF-01) | Habilita acciones según el rol del usuario |
| `ReporteGenerado` | Módulo de Reportes | Consolida ventas por rango de fecha para el Administrador |
