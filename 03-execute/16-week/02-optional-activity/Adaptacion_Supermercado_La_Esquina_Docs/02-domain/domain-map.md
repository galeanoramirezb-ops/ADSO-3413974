# domain-map

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

Al ser un sistema de un solo negocio y una sola sede, se maneja un único contexto de negocio ("Gestión del supermercado"), dividido en subdominios funcionales que corresponden a los módulos del SRS:

| Subdominio | Responsabilidad | Tipo |
|------------|------------------|------|
| Ventas | Registrar ventas, calcular totales, emitir comprobante | Núcleo (core) |
| Inventario | Controlar el stock disponible de cada producto | Núcleo (core) |
| Productos | Gestionar catálogo de productos y precios | Núcleo (core) |
| Usuarios | Administrar usuarios, roles y autenticación | Soporte |
| Reportes | Consolidar y presentar reportes básicos de ventas | Soporte |

## Relación entre subdominios

- **Ventas** consulta **Productos** para obtener precio y disponibilidad, y descuenta stock en **Inventario** al confirmar una venta.
- **Inventario** depende de **Productos** (cada registro de inventario referencia un producto).
- **Reportes** consume datos generados por **Ventas** (no los modifica).
- **Usuarios** es transversal: todos los módulos verifican el rol del usuario autenticado antes de permitir una acción.

Dado que el sistema se implementa como una aplicación monolítica (Flask + SQLite), estos subdominios se representan como módulos internos de la misma aplicación y no como servicios independientes.
