# overview

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Estilo arquitectónico

El sistema se implementa como una **aplicación web monolítica** (no microservicios), acorde al alcance y tamaño del proyecto descrito en el SRS: un solo negocio, una sola sede, bajo volumen de usuarios concurrentes.

## Componentes

- **Frontend**: HTML, CSS y JavaScript, con Bootstrap para el diseño de interfaz.
- **Backend**: aplicación Python con Flask, que expone las vistas/rutas para Ventas, Inventario, Productos, Usuarios y Reportes.
- **Base de datos**: SQLite, con un único archivo de base de datos para todo el sistema.

## Diagrama de componentes (alto nivel)

```
[Navegador] --HTTP--> [Flask app]
                          |-- Módulo Usuarios (auth y roles)
                          |-- Módulo Productos
                          |-- Módulo Ventas
                          |-- Módulo Inventario
                          |-- Módulo Reportes
                          |
                       [SQLite]
```

## Módulos internos

| Módulo | Responsabilidad |
|--------|------------------|
| Usuarios | Autenticación e inicio de sesión (RF-01), roles Administrador/Cajero |
| Productos | Gestión de productos y precios (RF-05) |
| Ventas | Registro de ventas y cálculo de totales (RF-02, RF-03) |
| Inventario | Actualización de stock (RF-04) |
| Reportes | Reportes básicos de ventas |
