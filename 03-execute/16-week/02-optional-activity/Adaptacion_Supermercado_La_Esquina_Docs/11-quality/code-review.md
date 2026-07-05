# code-review

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Criterios de revisión

- El código sigue las convenciones de Git del repositorio ([00-governance/git-conventions.md](../00-governance/git-conventions.md)).
- Toda ruta que modifique datos valida el rol del usuario (Administrador/Cajero).
- No se introduce lógica de cálculo de totales o stock duplicada; se reutiliza la existente.
- Los mensajes de la interfaz están en español (RNF-03).
- No se sube al repositorio ninguna credencial ni el archivo de base de datos con datos reales.

## Flujo

1. Crear rama a partir de `dev`.
2. Abrir Pull Request describiendo el cambio y el requerimiento relacionado (RF-XX / RNF-XX).
3. Revisión por al menos un compañero o el instructor antes de fusionar.
