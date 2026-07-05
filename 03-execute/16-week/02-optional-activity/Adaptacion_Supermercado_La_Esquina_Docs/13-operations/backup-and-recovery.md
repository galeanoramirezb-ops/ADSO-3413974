# backup-and-recovery

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Backups

- El archivo de base de datos SQLite (`.db`) debe copiarse diariamente al cierre del negocio (después del cierre de caja).
- Las copias se guardan con fecha en el nombre (ej. `supermercado_2026-07-05.db`) en un medio distinto al equipo principal (USB o carpeta en la nube).

## Recuperación

- Ante pérdida o corrupción del archivo de base de datos, se restaura la copia más reciente y se reinicia la aplicación.
- RPO (pérdida máxima aceptable de datos): 1 día (una jornada de ventas).
- RTO (tiempo máximo de restauración): el tiempo de copiar el archivo `.db` de respaldo al equipo y reiniciar el servidor.
