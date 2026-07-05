# Alcance

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## En alcance

- Módulo de Ventas: registro de ventas y cálculo automático de totales.
- Módulo de Inventario: control de stock de productos en tiempo real.
- Módulo de Productos: gestión de productos y precios (alta, edición, baja).
- Módulo de Usuarios: administración de usuarios y roles (Administrador, Cajero).
- Módulo de Reportes: reportes básicos de ventas.
- Autenticación de usuarios (inicio de sesión).

## Fuera de alcance

- Comercio electrónico o venta en línea para clientes.
- Integración con pasarelas de pago o facturación electrónica ante la DIAN.
- Gestión de proveedores y compras (no descrita en el SRS actual).
- Aplicación móvil nativa.
- Múltiples sucursales o sedes.

## Supuestos

- El negocio opera en una sola sede física (Neiva, Huila).
- El cliente no requiere autenticarse en el sistema; solo consulta precios y recibe comprobante.
- El volumen de datos y usuarios concurrentes es bajo (negocio de barrio).

## Restricciones

- El sistema debe tener una interfaz en español.
- Tiempo de respuesta menor a 2 segundos (RNF-02).
- Debe usarse el stack definido: HTML/CSS/JavaScript, Bootstrap, Python (Flask) y SQLite.
