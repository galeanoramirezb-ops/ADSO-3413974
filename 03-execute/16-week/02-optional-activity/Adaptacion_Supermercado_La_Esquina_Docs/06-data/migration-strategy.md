# migration-strategy

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

Dado que la base de datos es SQLite y el proyecto es de alcance académico/pequeño negocio, la estrategia de migración es simple:

- El esquema inicial se crea mediante un script SQL (`schema.sql`) ejecutado una sola vez al desplegar.
- Cambios posteriores al esquema se documentan como scripts numerados (`001_add_stock_minimo.sql`, `002_...sql`) para poder aplicarse en orden.
- Antes de aplicar una migración en el equipo del negocio, se debe hacer una copia del archivo `.db` (ver [13-operations/backup-and-recovery.md](../13-operations/backup-and-recovery.md)).
- No se contempla migración de datos entre motores de base de datos distintos en el alcance actual.
