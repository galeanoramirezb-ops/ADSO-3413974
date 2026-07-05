# Microservicios

> Estado: 🟡 En progreso | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Contenido

> **Nota de alcance:** según [ADR-001](../05-architecture/decisions/records/ADR-001-arquitectura-monolitica.md), el Sistema de Gestión Supermercado "La Esquina" se implementa como **una sola aplicación monolítica**, no como microservicios. Esta sección se conserva por consistencia con la plantilla del repositorio y para documentar la aplicación como un único "servicio" desplegable. Si en el futuro el negocio crece a varias sedes, esta carpeta sería el punto de partida para dividir el sistema en servicios reales.

## Archivos

| Archivo | Descripción | Estado |
|---------|-------------|--------|
| [service-catalog.md](./service-catalog.md) | Inventario: la aplicación como único "servicio" | 🟢 |
| [communication-patterns.md](./communication-patterns.md) | No aplica actualmente (monolito); documentado para referencia futura | 🟡 |
| [_template/](./_template/) | Plantilla para documentar un servicio nuevo, si el sistema llegara a dividirse | 🟡 |
| [services/](./services/) | Documentación específica por servicio (vacío mientras el sistema sea monolítico) | 🔴 |
