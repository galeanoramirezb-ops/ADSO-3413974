# authentication

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Estrategia

- Autenticación basada en **sesión de Flask** (`flask.session`), con inicio de sesión mediante usuario y contraseña (RF-01).
- Las contraseñas se almacenan con hash (no en texto plano) en la tabla `usuarios`.
- Cada ruta protegida valida que exista una sesión activa; si no, redirige al login.

## Autorización por rol

| Rol | Acceso |
|-----|--------|
| Administrador | Todos los módulos: Productos, Inventario, Usuarios, Reportes, Ventas |
| Cajero | Módulo de Ventas y consulta de Productos (sin edición) |
| Cliente | No inicia sesión; solo consulta precios en el punto de venta y recibe comprobante |

Cumple con RNF-04 (acceso seguro mediante usuarios).
