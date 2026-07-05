# cross-cutting

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Seguridad

- Acceso mediante usuario y contraseña (RNF-04); contraseñas almacenadas con hash (nunca en texto plano).
- Control de acceso por rol: Administrador vs Cajero, verificado en cada ruta del backend.

## Logging y auditoría

- Registro de ventas con fecha/hora y cajero responsable (auditoría mínima de operaciones).
- Registro de cambios sobre productos (creación, edición, eliminación) con usuario responsable.

## Manejo de errores

- Validación de stock disponible antes de confirmar una venta.
- Mensajes de error en español, claros para el usuario final (RNF-01, RNF-03).

## Rendimiento

- Tiempo de respuesta objetivo menor a 2 segundos por operación (RNF-02), alcanzable dado el bajo volumen de datos con SQLite.

## Internacionalización

- Interfaz únicamente en español (RNF-03); no se contempla soporte multi-idioma.
