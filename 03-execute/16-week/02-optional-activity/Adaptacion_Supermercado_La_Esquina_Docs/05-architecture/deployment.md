# deployment

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Topología

Al ser un proyecto académico de un solo negocio, el despliegue es simple: un único servidor/equipo que ejecuta la aplicación Flask junto con el archivo de base de datos SQLite.

| Ambiente | Descripción |
|----------|-------------|
| Local (desarrollo) | Servidor de desarrollo de Flask (`flask run`) en el equipo del desarrollador |
| Producción (punto de venta) | Equipo del supermercado ejecutando la app con un servidor WSGI (ej. Waitress o Gunicorn) |

## Consideraciones

- No se requiere balanceador de carga ni múltiples instancias.
- El archivo `.db` de SQLite debe respaldarse periódicamente (ver [13-operations/backup-and-recovery.md](../13-operations/backup-and-recovery.md)).
- No hay ambientes separados de QA/staging formales dado el tamaño del proyecto; las pruebas se hacen en local antes de instalar en el equipo del negocio.
