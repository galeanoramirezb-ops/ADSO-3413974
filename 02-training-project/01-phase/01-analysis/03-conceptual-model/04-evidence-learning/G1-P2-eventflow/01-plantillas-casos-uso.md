# 1. Plantillas extendidas de casos de uso (Anexo A)

**Proyecto:** EventFlow Manager (SIGEV) · **Casos críticos:** CU-05, CU-07 y CU-09
Las plantillas describen la **intención** de cada acción, sin tecnología: no mencionan tablas, lenguajes, frameworks ni direcciones de servicios. Cada rama de los diagramas de actividades aparece aquí con la misma numeración.

---

## PL-CU05 · Gestionar evento

| Campo | Contenido |
|---|---|
| Identificador y nombre | **CU-05 · Gestionar evento** |
| Requisitos que atiende | RF5 (creación y parametrización de eventos) |
| Actor primario / secundarios | Organizador / — |
| Objetivo del actor | Dejar un evento creado o actualizado, con su sede, fechas, aforo y categorías de entrada, listo para que los asistentes obtengan tickets |
| Precondiciones | 1. El organizador inició sesión con el rol Organizador. 2. Existe al menos una sede registrada. |
| Disparador | El organizador elige «Crear evento» en el módulo de eventos |
| Flujo principal | 1. El organizador elige crear un evento.<br>2. El sistema muestra el formulario del evento.<br>3. El organizador ingresa el título, la descripción, la sede, la fecha y hora de inicio y de fin, y el aforo máximo.<br>4. El organizador define las categorías de entrada (por ejemplo General, VIP y Prensa) con su cupo y su precio.<br>5. El organizador solicita guardar.<br>6. El sistema comprueba que los datos obligatorios estén completos, que el aforo no supere la capacidad de la sede y que la suma de cupos no supere el aforo.<br>7. El sistema registra el evento como publicado y confirma la operación.<br>8. El sistema deja constancia del cambio para la auditoría. |
| Flujos alternos | **1a. Modificar un evento existente:** el organizador selecciona un evento de su lista; el sistema muestra los datos actuales y el caso continúa en el paso 3. Si la categoría ya tiene tickets emitidos, su cupo no puede quedar por debajo de los emitidos.<br>**1b. Cancelar un evento:** el organizador elige «Cancelar evento» y confirma; el sistema cambia el estado del evento a cancelado, avisa a los asistentes con ticket y el caso continúa en el paso 8. |
| Excepciones | **6a. El aforo supera la capacidad de la sede:** el sistema señala el campo, explica la regla y no guarda; el organizador puede corregir y volver al paso 5.<br>**6b. La suma de cupos supera el aforo:** el sistema indica la diferencia y no guarda.<br>**1b-1. El evento ya empezó:** el sistema no permite cancelarlo y lo informa. |
| Postcondiciones | El evento queda publicado (o actualizado, o cancelado) con su sede, aforo y categorías, y el cambio queda registrado para la auditoría. |
| Reglas de negocio | RN-01: aforo máximo ≤ capacidad física de la sede. RN-02: suma de cupos de las categorías ≤ aforo máximo. RN-03: un evento iniciado no se cancela. |
| Pantalla del prototipo | [P1 · Gestionar evento](mockup-P1-CU05-gestionar-evento.png) |

---

## PL-CU07 · Obtener ticket con QR dinámico

| Campo | Contenido |
|---|---|
| Identificador y nombre | **CU-07 · Obtener ticket con QR dinámico** (incluye CU-08 Enviar ticket por correo) |
| Requisitos que atiende | RF6 (emisión de tickets con QR dinámico) |
| Actor primario / secundarios | Asistente / Servicio de correo (sistema externo) |
| Objetivo del actor | Tener un ticket válido para el evento elegido, en su cuenta y en su correo |
| Precondiciones | 1. El asistente inició sesión y aceptó el tratamiento de datos al registrarse (CU-01). 2. El evento está publicado. |
| Disparador | El asistente elige «Obtener ticket» en un evento publicado |
| Flujo principal | 1. El asistente selecciona el evento y la categoría de entrada.<br>2. El sistema verifica que la categoría tenga cupo.<br>3. El sistema muestra el resumen (evento, categoría y precio) y las condiciones del evento.<br>4. El asistente confirma sus datos y acepta las condiciones.<br>5. El sistema registra el ticket y genera su código QR dinámico, que cambia cada pocos segundos.<br>6. Al mismo tiempo, el sistema muestra el QR dinámico en la cuenta del asistente y envía el ticket en PDF por correo (**incluye CU-08**).<br>7. El servicio de correo entrega el ticket al asistente.<br>8. El asistente ve y descarga su ticket. |
| Flujos alternos | **2a. La categoría elegida está agotada:** el sistema ofrece las categorías del evento que tienen cupo; si el asistente elige otra, el caso vuelve al paso 2.<br>**7a. El correo es rechazado:** el sistema programa un reintento de envío y avisa en pantalla que el ticket ya está disponible en la cuenta; el caso continúa en el paso 8. |
| Excepciones | **2b. No hay otra categoría con cupo, o el asistente no acepta otra:** el sistema informa que no es posible emitir el ticket y el caso termina sin ticket. |
| Postcondiciones | Existe un ticket a nombre del asistente, asociado a la categoría y al evento; el cupo disponible de la categoría disminuye en uno; el ticket está visible en la cuenta y fue enviado (o quedó programado su envío) al correo. |
| Reglas de negocio | RN-04: un ticket pertenece a un solo asistente y a una sola categoría. RN-05: una captura de pantalla del QR no es válida para ingresar, porque el código cambia. |
| Pantalla del prototipo | [P2 · Obtener ticket](mockup-P2-CU07-obtener-ticket.png) |
| Diagrama de actividades | [AD-CU07](actividades-CU07-obtener-ticket.png): ramas 2a, 2b y 7a; bifurcación y unión en el paso 6 |

---

## PL-CU09 · Validar acceso con QR

| Campo | Contenido |
|---|---|
| Identificador y nombre | **CU-09 · Validar acceso con QR** (incluye CU-10; lo extienden CU-11 y CU-12) |
| Requisitos que atiende | RF8 (validación y blindaje contra suplantación), RF7 (aforo), RF12 (bitácora), RF13 (intento sospechoso) |
| Actor primario / secundarios | Validador de acceso / Asistente (presenta el código) |
| Objetivo del actor | Decidir en pocos segundos, y sin que lo puedan presionar, si la persona que presenta el ticket puede entrar |
| Precondiciones | 1. El validador inició sesión con el rol Validador y tiene asignada una puerta. 2. El evento está en curso. |
| Disparador | El asistente presenta su código QR en la puerta |
| Flujo principal | 1. El asistente presenta su QR dinámico.<br>2. El validador escanea el código.<br>3. El sistema verifica que el código esté vigente y sea auténtico.<br>4. El sistema verifica que el ticket no haya sido utilizado.<br>5. El sistema muestra la foto y el nombre del titular.<br>6. El validador compara la foto con la persona y confirma que coincide.<br>7. El sistema concede el acceso con una señal inequívoca (pantalla verde, tono y vibración) y suma una persona a la ocupación del evento.<br>8. El sistema registra la validación en la bitácora (**incluye CU-10**). |
| Flujos alternos | **7a. La ocupación llega al 80 % o más:** el sistema emite una alerta de aforo al organizador (**extiende CU-11**) y el caso continúa en el paso 8. |
| Excepciones | **3a. Código caducado o inválido** (por ejemplo, una captura de pantalla): el sistema deniega el acceso con el mensaje «código no vigente», alerta el intento sospechoso al titular (**extiende CU-12**) y el caso continúa en el paso 8.<br>**4a. Ticket ya utilizado:** el sistema deniega el acceso mostrando la hora y la puerta del uso anterior, alerta el intento sospechoso (CU-12) y el caso continúa en el paso 8.<br>**6a. La foto no coincide:** el sistema deniega el acceso por posible suplantación, alerta el intento sospechoso (CU-12) y el caso continúa en el paso 8. |
| Postcondiciones | **Éxito:** el ticket queda marcado como utilizado, la ocupación aumentó en uno y la validación quedó en la bitácora. **Denegado:** el ticket no cambia, el titular fue alertado y la validación denegada quedó en la bitácora. |
| Reglas de negocio | RN-06: un ticket permite un solo ingreso. RN-07: la pantalla de denegación se mantiene unos segundos y el validador no la puede cambiar (protección contra la presión verbal). RN-08: toda validación, concedida o denegada, queda registrada y no se puede borrar. |
| Pantalla del prototipo | [P3 · Validar acceso](mockup-P3-CU09-validar-acceso.png) |
| Diagrama de actividades | [AD-CU09](actividades-CU09-validar-acceso.png): ramas 3a, 4a, 6a y 7a |
