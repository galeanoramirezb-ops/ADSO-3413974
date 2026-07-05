# guidelines

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

Al ser una aplicación monolítica en Flask, las "rutas" cumplen el rol de API interna entre el frontend (Bootstrap + JS) y el backend.

## Convenciones

- Rutas en español, en minúsculas y con guiones: `/productos`, `/ventas/nueva`, `/reportes/ventas`.
- Respuestas JSON para las llamadas AJAX del frontend, con al menos `{"exito": bool, "mensaje": str, "datos": ...}`.
- Códigos HTTP estándar: `200` éxito, `400` datos inválidos, `401` no autenticado, `403` sin permiso por rol, `404` no encontrado.
- Toda ruta que modifique datos (crear venta, editar producto) debe validar el rol del usuario autenticado antes de ejecutar la acción.
