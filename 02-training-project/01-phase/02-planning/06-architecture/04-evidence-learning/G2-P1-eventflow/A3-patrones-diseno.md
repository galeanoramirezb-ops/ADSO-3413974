# A3 · Patrones de diseño aplicados

Los dos patrones están dibujados en [`A2-diagrama-clases.png`](A2-diagrama-clases.png). Ninguno es Singleton.

| Patrón (GoF) | Problema concreto del caso | Por qué ese patrón | Clases que lo implementan | Qué mejora en mantenibilidad |
|---|---|---|---|---|
| **Estrategia** (validación) | Para conceder un acceso (RF8) hay que comprobar varias reglas: que el código QR esté vigente, que el ticket no se haya usado y que haya aforo disponible (RF7). Las reglas cambian según el evento; por ejemplo, un evento gratuito sin control de aforo o, más adelante, una regla de «edad mínima». | Cada regla es un algoritmo intercambiable con la misma firma (`evaluar(t, ctx)`). El servicio recorre una lista de reglas sin saber cuáles son. Así se evita un método gigante con `if` anidados. | `«interface» ReglaValidacion` · `ReglaVigenciaCodigo` · `ReglaTicketNoUtilizado` · `ReglaAforoDisponible`. Las usa `ServicioValidacionAcceso` (agregación 1 → 1..*). | Una regla nueva es **una clase nueva**: no se modifica `ServicioValidacionAcceso` (principio abierto/cerrado). Cada regla se prueba por separado con pruebas unitarias. El **polimorfismo** está en que el servicio llama a `evaluar` sin conocer la implementación concreta. |
| **Estrategia** (notificación) | Las alertas (RF13 intento sospechoso, RF7 aforo) y el ticket (RF6) se envían por correo, y en el futuro por SMS, según la preferencia del titular. | El canal de envío es un algoritmo intercambiable detrás de una interfaz. | `«interface» Notificador` · `NotificadorCorreo` · `NotificadorSMS` | Cambiar de proveedor de correo o agregar WhatsApp no toca la lógica de validación ni la de tickets. |
| **Fachada** | Validar un acceso coordina 5 subsistemas: reglas, ticket, evento (ocupación), bitácora (RF12) y notificaciones (RF13). Si la PWA del validador llamara a cada uno, la interfaz quedaría acoplada a toda la lógica y se podría saltar la bitácora. | Una sola puerta de entrada simple (`validar(codigo, puerta, idValidador)`) oculta la orquestación y garantiza el orden: evaluar reglas → actualizar ocupación → registrar en bitácora → notificar. | `«fachada» ServicioValidacionAcceso`, que usa `ReglaValidacion`, `ServicioBitacora` y `Notificador` y crea `Validacion` | El controlador REST y la PWA dependen de **un solo método**. Si cambia el orden interno o se agrega un paso (por ejemplo, la sincronización offline), solo cambia la fachada. También asegura que **ninguna validación quede sin bitácora** (RN-08). |

## Cómo se lee en el diagrama

- `ServicioValidacionAcceso ◇── 1..* ReglaValidacion`: la fachada **agrega** una lista de reglas (Estrategia).
- `ReglaValidacion ◁┄ ReglaVigenciaCodigo / ReglaTicketNoUtilizado / ReglaAforoDisponible`: **realización** de la interfaz, con 3 implementaciones.
- `Notificador ◁┄ NotificadorCorreo / NotificadorSMS`: **realización**, con 2 implementaciones.
- `ServicioValidacionAcceso ┄> Validacion «crea»`: la fachada produce el resultado.

## Patrón considerado y descartado

**Singleton para `GeneradorCodigoQR`.** Se descartó porque el contenedor de Spring ya gestiona una única instancia por inyección de dependencias. Un Singleton manual dificultaría las pruebas, porque no se podría sustituir por un generador falso.
