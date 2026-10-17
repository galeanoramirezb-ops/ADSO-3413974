# Preguntas de Análisis Técnico — Apartado DOCS
## Proyecto: Orderflow Engine (`orderflow-engine-docs`)

Este documento reúne **dos bloques de preguntas técnicas esenciales** formuladas a partir del análisis exhaustivo del repositorio de documentación (`spec/`, `governance/`, `handoff/` y `assignment/`), contrastando los requerimientos originales del cliente con la solución técnica implementada.

### Pregunta 1: Desviación de Alcance y Prevención de Defectos en el Frontend
> **Dado que el enunciado original solicitaba únicamente una pantalla de resumen en front-end (con un límite máximo de 1 hora), ¿cuál es la diferencia real entre lo solicitado y lo desarrollado en el cliente web, y cómo se implementó la prevención de los tres defectos visuales exigidos (textos cortados, controles tapados e imágenes desalineadas)?**

* **Referencia documental:** `assignment/ Plus Front`, `spec/SPEC.md §1 (Deviation), §10.2, §14.3`, `spec/TASKS.md T-17`.
* **Respuesta técnica documentada:**
  - Se extendió el alcance construyendo una SPA Angular completa (carrito, cotización, orden, historial y selector de tiendas en 13.5 horas de desarrollo medidas).
  - Prevención por componentes: `ui-text` con `overflow-wrap: anywhere` sin ellipsis para evitar textos cortados; `ui-action-bar` con soporte de `safe-area` y ajuste dinámico a `visualViewport` ante el teclado virtual; y `ui-product-image` con relación de aspecto fija (`aspect-ratio: 1/1`) y `object-fit: contain`.

---
---

## BLOQUE 2: Lógica Comercial, Concurrencia, Pureza Hexagonal y Calidad (5 Preguntas Nuevas)

### Pregunta 2: Orden de Aplicación de Palancas y Asignación de Descuentos en Combos
> **¿Cuál es la justificación técnica y de negocio del orden en que se aplican las palancas comerciales (`BR-01`), y mediante qué método matemático se distribuye el descuento de un combo entre los productos que lo conforman para calcular correctamente la base gravable de cada línea?**

* **Referencia documental:**
  - `spec/SPEC.md §3 (BR-01, BR-02, BR-03)`
  - `spec/SPEC.md §11` (Golden Tests GT-02 y GT-04)
  - `spec/architecture.md §3.1` (Pricing pipeline)
* **Respuesta técnica documentada:**
  - **Justificación del orden (`BR-01`):**
    1. *Obsequios:* se evalúan primero sobre cantidades pagadas y subtotal bruto; nunca alteran el valor que el cliente paga por los productos comprados.
    2. *Combos:* se aplican antes que los descuentos por escala para consumir unidades y evitar el doble descuento (*no double dipping*).
    3. *Descuentos por escala (tramos marginales):* aplican únicamente sobre las unidades **no consumidas** por combos.
    4. *Cálculo de impuestos:* se calcula la base gravable neta después de restar descuentos comerciales.
    5. *Evaluación de crédito:* se ejecuta al final porque requiere el total definitivo con impuestos.
  - **Distribución de combos (Método del Mayor Residuo):** El descuento global del combo se reparte proporcionalmente al valor bruto de lista de las unidades consumidas. Cada cuota se trunca a la escala de la moneda y los residuos decimales sobrantes se asignan a las líneas con mayores restos fraccionarios (desempate por orden alfabético de SKU), garantizando que la suma de las bases gravables coincida con precisión absoluta con el descuento del combo (`GoldenPricingTest#gt04`).

---

### Pregunta 3: Prevención de Deadlocks y Orden de Bloqueos en la Confirmación
> **¿Cómo gestiona la aplicación la concurrencia en ráfagas de pedidos simultáneos sobre un mismo cliente, y qué orden estricto de bloqueos adquiere la transacción para imposibilitar interbloqueos (*deadlocks*) en la base de datos?**

* **Referencia documental:**
  - `spec/SPEC.md §7.1` (Transaction lock order)
  - `spec/data-model.md §8` (Locks taken by the confirmation)
  - `spec/plan.md §4 (RISK-01)`
  - `ConfirmOrderConcurrencyIT`
* **Respuesta técnica documentada:**
  - **Orden de bloqueos determinista:** La transacción de confirmación toma bloqueos exclusivamente en este orden inmutable:
    1. `idempotency_keys`: inserción con `ON CONFLICT DO NOTHING`, bloqueando el registro de clave única.
    2. `quotes`: bloqueo pesimista de fila mediante `SELECT ... FOR UPDATE` para evitar que otra confirmación use la misma cotización.
    3. `credit_accounts`: actualización condicional de cupo (`UPDATE ... WHERE consumed + :total <= credit_limit`).
  - **Protección contra colgadas:** La transacción define un parámetro `lock_timeout`. Si dos peticiones compiten por el mismo recurso y vence el tiempo de espera, el sistema aborta de inmediato respondiendo HTTP `409 IDEMPOTENCY_KEY_IN_PROGRESS`, liberando conexiones y evitando que la API quede bloqueada.

---

### Pregunta 4: Política de Cupo de Crédito: Verificación Asesora vs. Consumo Atómico
> **¿Por qué en el momento de la cotización la verificación del cupo de crédito es únicamente asesora (*advisory*) y no reserva fondos, y cómo se evita que dos pedidos concurrentes excedan el límite de crédito disponible del tendero?**

* **Referencia documental:**
  - `spec/SPEC.md §3 (BR-06) y §13 (Supuesto A-08)`
  - `spec/data-model.md §3` (Tabla `credit_accounts` y `credit_ledger`)
  - `spec/api-contract.md §2 (E-01) y §4`
  - Golden Test GT-05 y prueba de integración `CreditLimitIT`
* **Respuesta técnica documentada:**
  - **Por qué no se reserva en la cotización:** Reservar crédito al cotizar permitiría ataques de denegación de servicio o congelamiento injustificado de fondos con carritos abandonados. Por tanto, en `POST /quotes`, el campo `credit{fits, available, shortfall}` es netamente informativo para la pantalla.
  - **Consumo atómico en confirmación:** La deducción se realiza en `POST /orders` mediante una única sentencia SQL atómica:
    ```sql
    UPDATE credit_accounts 
    SET consumed = consumed + :total 
    WHERE tenant_id = :tenant AND customer_id = :customer 
      AND (consumed + :total) <= credit_limit;
    ```
    Si dos cotizaciones abiertas intentan confirmarse concurrentemente y el saldo solo cubre una, la primera actualiza la fila (1 registro afectado) y la segunda afecta 0 filas, disparando un rollback inmediato con error HTTP `409 CREDIT_LIMIT_EXCEEDED` sin crear orden ni registrar movimientos en `credit_ledger`.

---

### Pregunta 5: Pureza Hexagonal y Aislamiento del Dominio de Precios
> **¿Por qué el núcleo del cálculo (`pricing.domain`) está diseñado sin dependencias de Spring Boot, JPA, JDBC ni acceso al reloj del sistema, y cómo se garantiza documental y técnicamente que esta arquitectura no se degrade con el tiempo?**

* **Referencia documental:**
  - `spec/constitution.md Art. P-05 y P-06` (The domain is pure)
  - `spec/architecture.md §2.1` (Dependency rule)
  - `spec/plan.md §1 (DEC-03 y DEC-05)`
  - Pruebas arquitectónicas `DomainPurityArchTest` y `TransactionBoundaryArchTest`
* **Respuesta técnica documentada:**
  - **Razón técnica de la pureza:** Al aislar el motor de frameworks, bases de datos y llamadas de red, el cálculo de precios se convierte en un sistema 100% determinista, fácil de auditar, ultra-rápido de probar y reproducible mediante fixtures JSON fijos (`request.json`, `snapshot.json`, `expected.json`). El tiempo se inyecta mediante un `java.time.Clock` para que las fechas de expiración no dependan del reloj del sistema operativo.
  - **Control técnico automatizado:** La pureza no se deja a la buena voluntad; se certifica con **ArchUnit** en el pipeline de integración continua. Si un desarrollador intenta importar anotaciones de Spring (`@Component`, `@Autowired`) o clases de base de datos dentro del paquete `pricing.domain`, la prueba `DomainPurityArchTest` falla de inmediato el build.

---

### Pregunta 10: Estrategia de Calidad: Golden Tests, Cobertura JaCoCo y Pruebas de Mutación PIT
> **¿Por qué en un sistema financiero y de facturación como este no es suficiente con alcanzar una alta cobertura de líneas con JaCoCo, y qué valor añaden las pruebas de mutación (PIT) y el principio constitucional "un test solo se aprueba si se ha visto fallar"?**

* **Referencia documental:**
  - `spec/constitution.md Art. P-08` (Every business rule has a test seen failing)
  - `spec/SPEC.md §11` (Testing strategy and quality gates)
  - `spec/plan.md §1 (DEC-14)`
  - `handoff/HANDOFF.md §3` (Métricas verificadas: JaCoCo 100% y PIT 185/185)
* **Respuesta técnica documentada:**
  - **Límite de la cobertura tradicional:** Una prueba puede ejecutar el 100% de las líneas de código sin aserciones rigurosas (falso positivo de calidad).
  - **Pruebas de Mutación con PIT:** La herramienta PIT modifica deliberadamente el bytecode en tiempo de compilación (invirtiendo condicionales booleanos, cambiando operadores aritméticos de `+` a `-` o alterando retornos). El conjunto de pruebas del proyecto logró detectar **185 de 185 mutaciones (100% mutation score)** en el dominio de precios, certificando que los tests realmente atrapan errores de lógica.
  - **Principio Constitucional `P-08`:** Exige que ningún test se integre a la rama principal sin haber sido ejecutado primero en rojo (fallando por la razón esperada al alterar la regla de negocio), evitando pruebas complacientes que nunca fallan.
