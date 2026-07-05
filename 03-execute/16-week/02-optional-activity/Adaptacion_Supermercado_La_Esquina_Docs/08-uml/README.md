# UML

> Estado: 🟡 En progreso | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

Repositorio de diagramas UML del Sistema de Gestión Supermercado "La Esquina". Todo diagrama debe tener fuente editable y exportación revisable.

## Convenciones

- Fuentes en `diagrams/source/` con extensión `.wsd` o `.puml`
- Exportaciones en `diagrams/exports/` con formato `.svg` preferido
- Nombre de archivo: `<dominio>-<tipo>.<ext>` (ej: `supermercado-sequence.wsd`)
- Todo diagrama debe registrarse en [diagram-index.md](./diagram-index.md)

## Tipos de diagrama

| Tipo | Archivo fuente |
|------|---------------|
| Casos de uso | `*-use-case.wsd` |
| Clases | `*-class.wsd` |
| Secuencia | `*-sequence.wsd` |
| Actividad | `*-activity.wsd` |
| Estado | `*-state.wsd` |
| Componentes | `*-component.wsd` |
| Despliegue | `*-deployment.wsd` |

## Archivos

| Archivo | Descripción | Estado |
|---------|-------------|--------|
| [diagram-index.md](./diagram-index.md) | Índice de fuentes y exportaciones de diagramas | 🟡 |
| [diagrams/source/](./diagrams/source/) | Fuentes editables: casos de uso, clases y secuencia | 🟡 |
| [diagrams/exports/](./diagrams/exports/) | Exportaciones SVG o PNG (pendiente de generar) | 🔴 |

## Diagramas disponibles

- **Casos de uso**: Cajero, Administrador y Cliente frente a CU-01, CU-02, CU-03 del SRS.
- **Clases**: Usuario, Producto, Venta, DetalleVenta, MovimientoInventario.
- **Secuencia**: flujo completo de CU-01 Registrar Venta (login → búsqueda de producto → confirmación → descuento de stock → comprobante).
