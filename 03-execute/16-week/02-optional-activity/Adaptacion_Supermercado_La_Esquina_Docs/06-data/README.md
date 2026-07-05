# Datos

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Contenido

Documenta el modelo de datos en SQLite, el diccionario de datos y la estrategia de migración del Sistema de Gestión Supermercado "La Esquina".

> **Diferencia con `02-domain`:** esta sección describe la implementación de persistencia (tablas, columnas, tipos, relaciones). Las entidades de negocio y sus reglas se documentan en [`02-domain/`](../02-domain/). Un mismo concepto (ej: "Producto") tendrá una definición de dominio allá y un esquema de tabla aquí.

> Al tratarse de una aplicación monolítica (ver [ADR-001](../05-architecture/decisions/records/ADR-001-arquitectura-monolitica.md)), no existe un modelo de datos separado por servicio; todo el esquema vive en una sola base SQLite documentada en esta sección.

## Archivos

| Archivo | Descripción | Estado |
|---------|-------------|--------|
| [models.md](./models.md) | Modelo relacional de la base de datos SQLite | 🟢 |
| [data-dictionary.md](./data-dictionary.md) | Diccionario de tablas, campos y reglas | 🟢 |
| [migration-strategy.md](./migration-strategy.md) | Estrategia para cambios y migraciones del esquema | 🟢 |
