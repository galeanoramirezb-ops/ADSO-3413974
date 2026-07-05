# Patrones de comunicación

> Estado: 🟡 En progreso | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

> No aplica en la versión actual del sistema: al ser una aplicación monolítica (Flask + SQLite), los módulos (Ventas, Inventario, Productos, Usuarios, Reportes) se comunican mediante llamadas a funciones dentro del mismo proceso y transacciones directas a la base de datos, no mediante red.

## Síncrona (REST / gRPC)

No aplica entre módulos internos. El único punto de comunicación por HTTP es entre el frontend (Bootstrap/JS) y el backend Flask, documentado en [07-api/guidelines.md](../07-api/guidelines.md).

## Asíncrona (eventos)

No aplica; los "eventos de dominio" descritos en [02-domain/domain-events.md](../02-domain/domain-events.md) ocurren dentro de la misma transacción, no como mensajería real.

## Resiliencia

No aplica circuit breaker/retry entre servicios. La resiliencia se limita a validaciones dentro de la aplicación (ej. no permitir venta si el stock es insuficiente).
