# API

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Contenido

Define lineamientos de las rutas/API internas de Flask, la estrategia de autenticación y la ubicación de contratos OpenAPI del Sistema de Gestión Supermercado "La Esquina".

## Archivos

| Archivo | Descripción | Estado |
|---------|-------------|--------|
| [guidelines.md](./guidelines.md) | Convenciones de diseño de rutas/API | 🟢 |
| [authentication.md](./authentication.md) | Estrategia de autenticación y autorización por rol | 🟢 |
| [contracts/openapi/](./contracts/openapi/) | Contrato OpenAPI de la aplicación | 🟢 |

## Nota sobre el contrato

Al ser una aplicación monolítica (ver [ADR-001](../05-architecture/decisions/records/ADR-001-arquitectura-monolitica.md)), existe un único contrato OpenAPI para toda la aplicación en [`contracts/openapi/supermercado-la-esquina.yaml`](./contracts/openapi/supermercado-la-esquina.yaml), en lugar de un contrato por servicio.
