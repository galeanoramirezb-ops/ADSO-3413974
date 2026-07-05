# Preguntas abiertas

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Flujo de resolución

1. **Registrar:** cualquier integrante puede agregar una pregunta abierta con estado `ABIERTA`.
2. **Asignar:** se asigna un responsable y una fecha límite de respuesta.
3. **Resolver:** el responsable responde y cambia el estado a `RESUELTA`.
4. **Escalar si aplica:** si la resolución genera una decisión técnica relevante, crear un ADR en `05-architecture/decisions/records/`. Si afecta requisitos, actualizar `04-requirements/`.
5. **Cerrar:** preguntas resueltas se mantienen en el historial (no eliminar). Mover a sección `## Resueltas` cuando el registro sea largo.

## Formato de registro

| # | Pregunta | Área | Responsable | Fecha límite | Estado | Resolución / ADR |
|---|----------|------|-------------|--------------|--------|------------------|

## Estados válidos

| Estado | Significado |
|--------|-------------|
| `ABIERTA` | Sin respuesta aún |
| `EN REVISIÓN` | Responsable asignado, trabajando en ella |
| `RESUELTA` | Tiene respuesta, puede generar ADR o actualización |
| `CANCELADA` | Ya no aplica (indicar por qué) |

---

## Preguntas abiertas

| # | Pregunta | Área | Responsable | Fecha límite | Estado | Resolución / ADR |
|---|----------|------|-------------|--------------|--------|------------------|
| 1 | ¿Se debe soportar más de una caja registradora al mismo tiempo? | Arquitectura | Por definir | Por definir | ABIERTA | — |

---

## Resueltas

| # | Pregunta | Área | Resolución | ADR / Doc relacionado |
|---|----------|------|------------|-----------------------|
| 1 | ¿Se implementa el sistema como microservicios o como aplicación monolítica? | Arquitectura | Se decide monolito por el tamaño del negocio y del proyecto | [ADR-001](../05-architecture/decisions/records/ADR-001-arquitectura-monolitica.md) |
