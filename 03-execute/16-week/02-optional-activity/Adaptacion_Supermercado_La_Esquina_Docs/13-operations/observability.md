# observability

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

Dado el tamaño del proyecto, la observabilidad es básica:

- **Logs**: registro de errores del servidor Flask en archivo local (`app.log`).
- **Métricas mínimas**: número de ventas del día, productos con stock bajo (visibles desde el módulo de Reportes/Inventario, no mediante un tablero externo).
- **Alertas**: alerta visual en la interfaz cuando un producto llega a su stock mínimo (no hay alertas por correo/SMS en el alcance actual).
