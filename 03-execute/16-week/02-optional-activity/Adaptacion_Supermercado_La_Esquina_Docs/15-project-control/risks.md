# risks

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|---------------|---------|------------|
| Pérdida del archivo SQLite (fallo de equipo) | Media | Alto | Respaldos diarios (ver [13-operations/backup-and-recovery.md](../13-operations/backup-and-recovery.md)) |
| Resistencia del personal del negocio a dejar el registro manual | Media | Medio | Capacitación con el [manual de usuario](../14-training/user-manual.md) y acompañamiento en los primeros días |
| Errores de cálculo por mala configuración de precios | Baja | Alto | Validaciones en el módulo de Productos y pruebas (RF-05, [11-quality/testing-strategy.md](../11-quality/testing-strategy.md)) |
| Crecimiento del negocio a varias sedes no soportado por el diseño monolítico | Baja | Medio | Documentado en [ADR-001](../05-architecture/decisions/records/ADR-001-arquitectura-monolitica.md) como decisión revisable |
