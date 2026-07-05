# testing-strategy

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Niveles de prueba

| Nivel | Qué cubre | Herramienta sugerida |
|-------|-----------|-----------------------|
| Unitaria | Cálculo de totales (RF-03), reglas de stock, validaciones de formulario | `pytest` |
| Integración | Rutas Flask: login, registrar venta, gestionar productos | `pytest` + cliente de pruebas de Flask |
| Manual/aceptación | Flujos completos de CU-01, CU-02, CU-03 desde el navegador | Pruebas exploratorias guiadas por el SRS |

## Casos clave a probar

- Registrar una venta descuenta correctamente el stock (RF-04).
- No se permite vender más unidades que el stock disponible.
- El total calculado coincide con la suma de subtotales (RF-03).
- Un cajero no puede acceder a las rutas de gestión de productos o usuarios (RNF-04).
- Tiempo de respuesta de las operaciones principales menor a 2 segundos (RNF-02).
