# ADR-001: Usar arquitectura monolítica en lugar de microservicios

**Estado:** ACCEPTED
**Fecha:** 2026-07-05
**Autores:** Brenda Carolina Galeano Ramírez
**Equipos involucrados:** Desarrollo Supermercado "La Esquina"

---

## Contexto

El repositorio de documentación fue heredado de una plantilla pensada para arquitecturas de microservicios (carpeta `09-microservices`, catálogo de servicios, contratos entre servicios). Sin embargo, el SRS del Sistema de Gestión Supermercado "La Esquina" describe un negocio de una sola sede, con bajo volumen de datos y usuarios concurrentes, y un stack tecnológico simple (Flask + SQLite + Bootstrap).

## Decisión

Se decide implementar el sistema como una **aplicación monolítica** con Flask y SQLite. Los cinco módulos identificados en el SRS (Ventas, Inventario, Productos, Usuarios, Reportes) se implementan como módulos internos de una sola aplicación, no como servicios independientes.

## Consecuencias

### Positivas

- Menor complejidad de desarrollo, despliegue y mantenimiento para el tamaño real del proyecto.
- Una sola base de datos evita problemas de consistencia entre servicios.
- Coherente con el stack definido en el SRS (Flask + SQLite).

### Negativas / Trade-offs

- Menor escalabilidad horizontal si el negocio creciera a múltiples sedes.
- Acoplamiento entre módulos al compartir el mismo proceso y base de datos.

### Riesgos

- Si el negocio crece a varias sucursales, se requerirá revisar esta decisión.

## Alternativas consideradas

| Alternativa | Por qué se descartó |
|-------------|---------------------|
| Arquitectura de microservicios (plantilla original) | Sobre-ingeniería para un negocio de una sola sede y bajo volumen; no está soportada por el SRS |

## Referencias

- `../../../01-context/overview.md`
- SRS - Sistema de Gestión para Supermercado "La Esquina", v1.0
