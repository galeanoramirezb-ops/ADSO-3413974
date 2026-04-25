# Instrumentos de Recolección de Información
## SRS — Supermercado "La Esquina" | Sistema de Gestión Integral
**SENA 2025 | Tecnología en Análisis y Desarrollo de Software**

---

## ¿Qué es el SRS?

**SRS** = **S**oftware **R**equirements **S**pecification *(Especificación de Requerimientos de Software)*

Es un documento formal que describe **qué debe hacer un sistema de software** antes de construirlo. Funciona como un "contrato" entre el equipo de desarrollo y el cliente del negocio.

En nuestro caso, describe todo lo que necesita el Sistema del Supermercado "La Esquina" de Don Carlos.

---

## Los 5 Instrumentos de Recolección

Cada instrumento captura un tipo diferente de información.

| # | Instrumento | Tipo de información |
|---|---|---|
| 01 | 🎙️ Entrevista Semiestructurada | Cualitativa — profundidad |
| 02 | 📊 Encuesta Estructurada | Cuantitativa — frecuencias |
| 03 | 👁️ Observación Directa | Mixta |
| 04 | 📁 Revisión Documental | Secundaria |
| 05 | 🤝 Grupo Focal | Consenso grupal |

---

## 01 🎙️ Entrevista Semiestructurada

**Tipo:** Cualitativa — profundidad

**¿Qué es?**
Una conversación guiada con preguntas flexibles que permite profundizar según las respuestas del entrevistado.

**¿A quién se aplicó?**
- **Don Carlos** — Dueño, gestión del negocio
- **Martha R.** — Cajera, proceso de ventas
- **Julián P.** — Empleado, atención al cliente

**💬 Citas textuales reales:**

> *"No sé cuándo se va a acabar un producto hasta que ya no hay"*
> — Don Carlos, Dueño
> → **Requerimiento derivado:** Alerta de stock mínimo

> *"Yo registro todo a mano y después cuadro la caja, eso tarda mucho"*
> — Martha R., Cajera
> → **Requerimiento derivado:** Cierre de caja automático

> *"El cliente pregunta el precio y toca buscarlo uno a uno en el cuaderno"*
> — Julián P., Empleado
> → **Requerimiento derivado:** Búsqueda de precios en menos de 3 segundos

---

## 02 📊 Encuesta Estructurada

**Tipo:** Cuantitativa — frecuencias

**¿Qué es?**
Formulario con preguntas cerradas que produce datos numéricos (porcentajes, frecuencias). Aplicada a los 5 participantes del estudio.

**Pregunta aplicada:** *¿Cuál es la funcionalidad más importante para usted en el nuevo sistema?*

| Funcionalidad | Participante | Freq (n) | Porcentaje |
|---|---|---|---|
| ⭐ Registro de ventas | Martha R., Julián P. | 2 | **40%** |
| Control de inventario | Carlos R. (Dueño) | 1 | 20% |
| Ver precios en pantalla | Cliente 1 | 1 | 20% |
| Pago con tarjeta | Cliente 2 | 1 | 20% |
| **TOTAL** | **5 participantes** | **5** | **100%** |

**📌 Hallazgos clave:**
- El **40%** de participantes priorizó el Registro de Ventas
- El **60%** requiere factura electrónica (obligación DIAN)

---

## 03 👁️ Ficha de Observación Directa

**Tipo:** Cuantitativa / Mixta

**¿Qué es?**
El analista se sienta en el negocio y mide lo que realmente ocurre: tiempos, pasos, errores. Revela cuellos de botella que los empleados no mencionan porque ya están acostumbrados.

**Datos medidos en campo:**

| Métrica | Valor |
|---|---|
| Ventas registradas en 2 horas | 18 ventas |
| Tiempo de venta usado en calcular | 44% |
| Duración de una venta manual | 4.5 minutos |
| Respaldo digital existente | 0 |

**Hallazgos que NO surgieron en entrevistas:**
- El proceso de venta es idéntico para cajera y empleado: manual, en cuaderno, sin validación ni respaldo.
- Los clientes esperan en promedio más de 4 minutos por venta, causando filas y abandono.
- Ningún empleado mencionó el tiempo perdido porque lo consideran parte de la rutina normal.

---

## 04 📁 Revisión Documental

**Tipo:** Secundaria — datos existentes

**¿Qué es?**
Se analizan los documentos físicos que ya existen en el negocio para entender el estado actual real del sistema manual.

**Documentos revisados:**

| Documento | Descripción |
|---|---|
| 📒 Cuaderno de Ventas | Registro manual de todas las transacciones diarias |
| 🏷️ Lista de Precios | Lista física con los precios de los 90 productos |
| 📋 Registro de Proveedores | Datos de contacto y pedidos escritos en papel |

**Lo que se encontró:**
- 90 productos registrados en cuaderno físico, sin sistema de búsqueda
- Descuadres de caja frecuentes por suma manual sin validación
- Cero respaldo digital — toda la información puede perderse
- Los clientes deben preguntar el precio de cada artículo uno por uno

---

## 05 🤝 Taller / Grupo Focal

**Tipo:** Cualitativa — consenso grupal

**¿Qué es?**
Reunión donde todos los stakeholders discuten y priorizan juntos. Permite resolver contradicciones entre usuarios y llegar a acuerdos sobre el sistema.

**Participantes:** Don Carlos (Dueño) → Martha R. (Cajera) → Julián P. (Empleado)

**⚡ Contradicción encontrada y resuelta:**

❌ **Problema:** Don Carlos quería exclusividad total en reportes. Julián pedía ver su propio rendimiento de ventas.

✅ **Solución acordada:** Sistema de roles diferenciados:
- **Rol Administrador** — acceso total (Don Carlos)
- **Rol Cajero** — acceso restringido (Martha y Julián)

📌 **RF-005 — Gestión de Usuarios y Roles** — Requerimiento derivado del taller grupal.

**También se priorizaron en el taller:**
- RF-009 — Gestión de proveedores
- RF-005 — Sistema de permisos
- Funcionalidades versión 2 (DIAN)

---

## ¿Por qué usar 5 instrumentos y no solo uno?

Cada instrumento aporta un ángulo diferente de la realidad del negocio.

| Instrumento | Lo que captura | Hallazgo principal |
|---|---|---|
| 🎙️ Entrevista | Lo que la gente **SIENTE** y piensa | Reveló las frustraciones ocultas de Don Carlos, Martha y Julián |
| 📊 Encuesta | Lo que dicen en **NÚMEROS** | El 40% prioriza ventas y el 60% requiere factura electrónica |
| 👁️ Observación | Lo que **REALMENTE** pasa | El 44% del tiempo de venta se va en calcular con calculadora |
| 📁 Documental | Lo que ya **EXISTE** físicamente | 90 productos en cuaderno sin respaldo ni sistema de búsqueda |
| 🤝 Grupo Focal | Lo que **TODOS** acuerdan | Resolvió la contradicción dueño vs. empleado: sistema de roles |

---

## Conclusión

> *"El análisis con los 5 instrumentos permitió transformar las necesidades reales del Supermercado 'La Esquina' en un catálogo estructurado de requerimientos. Los requerimientos del sistema no son suposiciones — son necesidades reales y comprobadas."*

**Módulos resultantes del análisis (ordenados por prioridad):**

| Módulo | Sprint |
|---|---|
| 🛒 Módulo de Ventas | Sprint 1 |
| 📦 Módulo de Inventario | Sprint 1 |
| 👥 Módulo de Usuarios | Sprint 2 |
| 📈 Módulo de Reportes | Sprint 2 |
| 🏭 Módulo de Proveedores | Sprint 3 |
| 🧾 Facturación Electrónica DIAN | Versión 2 |

---

*Elaborado por el equipo de aprendices — Análisis y Desarrollo de Software | SENA 2025*
