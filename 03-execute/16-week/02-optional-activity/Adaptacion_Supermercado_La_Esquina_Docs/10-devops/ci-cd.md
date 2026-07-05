# ci-cd

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

Dado el alcance académico del proyecto, no se implementa un pipeline de CI/CD complejo. Se recomienda como mínimo:

- Ejecutar pruebas (ver [11-quality/testing-strategy.md](../11-quality/testing-strategy.md)) antes de instalar una nueva versión en el equipo del negocio.
- Llevar control de versiones con Git siguiendo [00-governance/git-conventions.md](../00-governance/git-conventions.md).
- Instalación manual (no automatizada) en el equipo del supermercado: copiar el código actualizado y reiniciar el servidor Flask/WSGI.
