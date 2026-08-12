# Análisis por ingeniería inversa del sistema de Gestión de Horarios del SENA

## 1. Introducción

Para este trabajo tomé como punto de partida el **Sistema de Gestión de
Horarios** publicado como mockup por el repositorio
`code-sena/design-software-mockup`.

Mi intención no es decir que el mockup sea el sistema real del SENA. De
hecho, el propio proyecto aclara que se trata de un prototipo estático
de revisión UX/UI, que no consume backend, utiliza datos ficticios y que
la documentación técnica completa permanece en un repositorio privado.
Por eso, para hacer el análisis, separo lo que realmente aparece en el
mockup de lo que se puede deducir como requisito y de lo que tendría que
validarse con documentación oficial del SENA.

La página principal indica que el prototipo contiene **53 pantallas y
modales**, organizados por roles y áreas, y que utiliza una arquitectura
de micro-frontends, navegación mediante rutas hash y controles de acceso
por rol (RBAC).

> **Idea principal del análisis:** no quiero empezar creando tablas o
> código. Primero debo entender qué hace el sistema, qué problema
> intenta resolver, qué información necesita y qué reglas se pueden
> deducir. Después de eso se puede pasar al modelo de datos.

------------------------------------------------------------------------

# 2. ¿Qué es lo que estoy analizando?

El sistema se presenta como un **Sistema de Gestión de Horarios**.

Al recorrer la estructura del proyecto se encuentran cinco roles
principales:

-   Coordinador Académico
-   Instructor
-   Aprendiz
-   Director de Centro
-   Administrador de Soporte

Además, existen funcionalidades transversales de autenticación,
parametrización y componentes comunes.

El inventario oficial del mockup registra las 53 pantallas y modales y
especifica para cada una el grupo, el rol, el micro-front-end y la ruta
de revisión.

## 2.1. Mi primera conclusión

Aunque el nombre habla de "gestión de horarios", al revisar todas las
pantallas veo que el sistema realmente intenta cubrir un dominio más
amplio:

**planificación de horarios → asignación de instructores y ambientes →
ejecución → seguimiento → notificaciones → indicadores → administración
→ parametrización.**

Esto es importante porque el horario no funciona aislado. Para construir
un horario se necesitan como mínimo una ficha, un período, sesiones,
competencias, instructores, ambientes y franjas horarias.

------------------------------------------------------------------------

# 3. Ingeniería inversa: ¿cómo la voy a aplicar?

La ingeniería inversa consiste, en este caso, en partir de lo que ya
existe en el mockup y tratar de descubrir cómo funciona el sistema por
detrás.

Mi camino de análisis es:

``` text
Pantalla
   ↓
Funcionalidad
   ↓
Comportamiento esperado
   ↓
Requisito
   ↓
Regla de negocio
   ↓
Datos necesarios
   ↓
Entidad
   ↓
Relaciones
```

No voy a crear una entidad solamente porque su nombre parezca
importante. Primero debe existir una razón funcional para almacenarla.

También voy a separar cuatro cosas:

  -----------------------------------------------------------------------
  Categoría                           Qué significa
  ----------------------------------- -----------------------------------
  Existente                           Se observa directamente en el
                                      mockup

  Deducción técnica                   Se puede inferir porque una
                                      funcionalidad necesita esos datos

  Sustento SENA                       Existe respaldo en documentación
                                      oficial

  Propuesta                           Es una mejora que considero
                                      conveniente, pero no la presento
                                      como regla oficial
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# 4. Inventario general del sistema

El mockup organiza las pantallas en siete grupos.

## 4.1. Autenticación y shell

Incluye:

1.  Login
2.  Recuperar contraseña
3.  Nueva contraseña
4.  App Shell por rol
5.  Panel de notificaciones
6.  Estados globales

### Lo que entiendo

El sistema necesita identificar al usuario antes de permitirle entrar a
determinadas funcionalidades.

También existe una separación por roles. El proyecto indica que una ruta
no autorizada debe producir un estado 403.

### Requisito deducido

**RF-01.** El sistema debe permitir el ingreso de usuarios y mostrar las
funcionalidades de acuerdo con el rol autorizado.

### Regla deducida

Un usuario no debería poder acceder directamente a una funcionalidad que
no corresponde a su rol.

### Mi opinión

Esta parte sí me parece necesaria. No sería buena idea que todos los
usuarios vieran las mismas opciones, porque un aprendiz no debería
administrar horarios, asignar roles o modificar parámetros
institucionales.

------------------------------------------------------------------------

# 5. Coordinador Académico

El coordinador tiene el bloque funcional más relacionado con la creación
y administración de horarios.

## 5.1. Dashboard / Inicio

Muestra:

-   conflictos pendientes;
-   fichas activas;
-   horarios en borrador;
-   horarios recientes.

### Ingeniería inversa

La pantalla no solamente sirve para mostrar información. También
funciona como punto de entrada para detectar problemas que impiden
publicar horarios.

### Requisitos

**RF-02.** Mostrar al coordinador un resumen del estado de los horarios.

**RF-03.** Mostrar conflictos pendientes que requieren atención.

**RF-04.** Permitir acceder desde el inicio al horario o al conflicto
correspondiente.

### Mi opinión

Me parece una buena decisión porque evita que el coordinador tenga que
revisar todo manualmente para encontrar un problema.

------------------------------------------------------------------------

## 5.2. Lista de horarios

La lista permite consultar horarios y utilizar filtros por:

-   ficha;
-   instructor;
-   ambiente;
-   estado;
-   rango de fechas.

Los horarios manejan estados como:

-   borrador;
-   en revisión;
-   publicado.

### Requisitos

**RF-05.** Consultar horarios.

**RF-06.** Filtrar horarios.

**RF-07.** Diferenciar el estado de cada horario.

### Regla deducida

Un horario publicado no debería comportarse igual que uno en borrador.

------------------------------------------------------------------------

## 5.3. Crear y editar horario

El mockup permite trabajar con:

-   ficha;
-   período;
-   nombre;
-   sesiones;
-   competencia;
-   instructor;
-   ambiente;
-   franja horaria;
-   fecha;
-   notas.

También aparecen acciones para:

-   guardar;
-   validar;
-   publicar.

### Mi análisis

Aquí se encuentra el núcleo del sistema.

La sesión es una unidad importante porque conecta varios datos:

``` text
Horario
   ↓
Sesión
   ├── Competencia
   ├── Instructor
   ├── Ambiente
   ├── Franja horaria
   └── Fecha
```

Por eso, en un futuro modelo de datos no tendría sentido guardar todo
directamente en la tabla `HORARIO`.

------------------------------------------------------------------------

# 6. Conflictos

El sistema identifica problemas como:

-   instructor doble-asignado;
-   ambiente doble-asignado;
-   sesiones solapadas.

También permite marcar un conflicto como resuelto.

## Requisito

**RF-08.** El sistema debe detectar conflictos de programación.

**RF-09.** El sistema debe mostrar el motivo del conflicto.

**RF-10.** El usuario autorizado debe poder registrar la resolución del
conflicto.

## Regla de negocio deducida

No se debería publicar un horario cuando existen conflictos pendientes
que bloquean su publicación.

Esto aparece directamente en el comportamiento del mockup: cuando hay
conflictos sin resolver, la acción de publicar aparece bloqueada.

### Mi opinión

Esta es una de las partes más fuertes del diseño porque no se limita a
guardar horarios; intenta prevenir errores antes de que el horario
llegue al instructor o al aprendiz.

------------------------------------------------------------------------

# 7. Disponibilidad y ambientes

El coordinador puede consultar disponibilidad y el detalle de los
ambientes.

El mockup maneja información como:

-   nombre del ambiente;
-   tipo;
-   capacidad;
-   ubicación;
-   disponibilidad.

### Entidades que puedo deducir

-   AMBIENTE
-   TIPO_AMBIENTE
-   DISPONIBILIDAD

Pero no necesariamente significa que las tres deban ser tablas
independientes.

### Mi criterio contra la sobreingeniería

Si `TIPO_AMBIENTE` solamente contiene valores pequeños como "Aula",
"Laboratorio" y "Taller", inicialmente podría manejarse como un
catálogo.

No necesito crear una arquitectura completa solamente para guardar tres
valores.

------------------------------------------------------------------------

# 8. Fichas

El coordinador también consulta:

-   listado de fichas;
-   detalle de ficha;
-   horarios relacionados.

Aquí aparece una relación importante:

``` text
FICHA
   ↓
HORARIOS
   ↓
SESIONES
```

La ficha funciona como contexto de formación sobre el cual se programa
el horario.

## Mi análisis

La ficha no debería confundirse con el horario.

Una ficha puede tener diferentes horarios o períodos de programación.

Por eso la relación debe ser:

**FICHA 1:N HORARIO**

------------------------------------------------------------------------

# 9. Instructor

El instructor tiene tres grupos principales:

1.  Mi horario
2.  Mi disponibilidad
3.  Seguimiento

## 9.1. Mi horario

Puede consultar sus sesiones publicadas.

El detalle muestra:

-   ficha;
-   programa;
-   competencia;
-   ambiente;
-   instructor;
-   estado;
-   notas.

### Requisito

**RF-11.** El instructor debe poder consultar las sesiones que tiene
asignadas.

------------------------------------------------------------------------

## 9.2. Mi disponibilidad

El instructor puede gestionar excepciones de disponibilidad.

### Entidad posible

**DISPONIBILIDAD_INSTRUCTOR**

Pero no considero necesario crear muchas tablas para esto sin conocer
las reglas completas de disponibilidad.

------------------------------------------------------------------------

# 10. Seguimiento del instructor

Esta parte me parece especialmente importante porque conecta la gestión
de horarios con el seguimiento del proceso formativo.

El mockup presenta:

-   fecha;
-   tipo de seguimiento;
-   asistencia;
-   avance curricular;
-   necesidad de seguimiento;
-   observaciones.

Los tipos mostrados son:

-   Académico
-   Bienestar
-   Proyecto
-   Etapa productiva

El formulario también registra:

-   asistentes;
-   total de aprendices;
-   avance curricular;
-   observaciones;
-   si requiere seguimiento adicional.

## Mi análisis

Aquí aparece una diferencia importante:

**gestionar un horario** no es lo mismo que **hacer seguimiento al
proceso formativo**.

El mockup ya muestra que ambos procesos están relacionados.

### Posibles entidades

-   SEGUIMIENTO
-   FICHA
-   TIPO_SEGUIMIENTO
-   INDICADOR

Sin embargo, no todas tienen que convertirse inmediatamente en tablas.

------------------------------------------------------------------------

# 11. Aprendiz

El apartado del aprendiz es pequeño comparado con el resto del sistema.

El inventario registra cuatro pantallas:

1.  Mi horario --- semana
2.  Notificaciones
3.  Detalle de clase
4.  Detalle de notificación

## 11.1. Mi horario

El aprendiz consulta:

-   ficha;
-   semana;
-   día;
-   horario;
-   clase;
-   ambiente;
-   instructor.

No tiene permisos para modificar el horario.

### Requisito

**RF-12.** El aprendiz debe poder consultar su horario publicado.

### Regla

El aprendiz solamente debe visualizar las sesiones que correspondan a su
contexto de formación.

El propio código del mockup deja un TODO sobre el permiso
`SCH_VIEW_OWN`, indicando que ese permiso no está todavía cableado para
la consulta del aprendiz.

### Mi opinión

Este es un punto que yo mejoraría.

El concepto de "Mi horario" está bien, pero en una implementación real
la consulta debería estar ligada claramente al aprendiz y a su ficha, no
simplemente a datos mock de una ficha.

------------------------------------------------------------------------

# 12. Detalle de clase

El detalle de clase muestra:

-   competencia;
-   instructor;
-   ambiente;
-   ubicación;
-   fecha;
-   franja;
-   notas.

### Requisito

**RF-13.** El aprendiz debe poder consultar el detalle de una sesión
asignada.

### Mi opinión

Esta pantalla es útil porque el horario semanal dice "qué tengo",
mientras que el detalle responde "dónde, con quién y qué debo tener en
cuenta".

------------------------------------------------------------------------

# 13. Notificaciones

El aprendiz tiene una lista de notificaciones y puede abrir el detalle.

Las notificaciones contienen:

-   asunto;
-   resumen;
-   fecha;
-   estado.

Algunas pueden dirigir nuevamente al horario.

### Requisito

**RF-14.** El sistema debe mostrar al aprendiz las notificaciones
relacionadas con su información de formación y horarios.

### Mi opinión

La notificación es un complemento, no debería convertirse en el centro
del sistema. Su función principal es comunicar información que el
usuario necesita conocer.

------------------------------------------------------------------------

# 14. Director de Centro

El director tiene:

-   indicadores;
-   detalle de indicadores;
-   usuarios;
-   roles;
-   datos de referencia;
-   parametrización.

## 14.1. Indicadores

El mockup presenta indicadores como:

-   asistencia;
-   avance curricular;
-   riesgo de deserción;
-   avance de etapa productiva;
-   aprendices desertados.

También utiliza estados:

-   En seguimiento;
-   En riesgo;
-   Crítico.

### Mi análisis

Los indicadores sirven para tomar decisiones sobre el estado de las
fichas.

Pero aquí aparece una advertencia importante:

**un KPI del mockup no debe interpretarse automáticamente como una regla
oficial del SENA.**

Por ejemplo, que el mockup use un umbral de 80% para asistencia es una
configuración del prototipo. No debo escribir en el documento que "el
SENA exige 80%" porque no tengo una fuente oficial que establezca ese
valor como regla general.

------------------------------------------------------------------------

# 15. Seguimiento, asistencia y avance

El mockup muestra datos de asistencia y avance curricular y permite
configurar alertas.

Ejemplos del prototipo:

-   asistencia por debajo del umbral;
-   avance curricular insuficiente;
-   riesgo de deserción;
-   ficha sin seguimiento.

## Mi opinión

Esta funcionalidad puede ser útil, pero hay que tener mucho cuidado con
la interpretación.

Yo separaría:

**dato registrado**

de

**indicador calculado**

y de

**alerta generada**.

Por ejemplo:

``` text
Asistencia registrada
        ↓
Cálculo del indicador
        ↓
Comparación con umbral configurado
        ↓
Estado / alerta
```

No almacenaría todo como si fueran datos independientes si pueden
calcularse a partir de información existente.

------------------------------------------------------------------------

# 16. Administrador de soporte

El sistema tiene un bloque bastante amplio para:

-   documentos;
-   plantillas;
-   auditoría;
-   parametrización;
-   versiones de documentos;
-   generación de documentos;
-   editor/preview;
-   detalle de auditoría;
-   CRUD de catálogos.

## Mi opinión

Estas funciones pueden tener sentido en un sistema institucional grande,
pero para un primer proyecto académico pueden representar una carga
considerable.

Por ejemplo, un editor completo de plantillas y un sistema de versiones
de documentos no son necesarios para demostrar que la gestión de
horarios funciona.

------------------------------------------------------------------------

# 17. Parametrización

El mockup agrega ocho pantallas de parametrización:

46. Hub de parametrización
47. Currículo académico
48. Jornadas / franjas horarias
49. Tipos de ambiente e inventario
50. Catálogos de monitoreo
51. Estados de actores
52. Geografía institucional
53. RBAC --- roles y permisos

## Mi análisis

La parametrización es útil porque evita colocar valores fijos
directamente en el código.

Pero hay que diferenciar entre:

**parametrización necesaria**

y

**parametrización excesiva**.

Por ejemplo, permitir configurar jornadas y franjas tiene una relación
directa con horarios.

En cambio, crear un sistema completo para modificar todos los aspectos
posibles del sistema desde una interfaz administrativa puede convertirse
en sobreingeniería para un proyecto académico.

------------------------------------------------------------------------

# 18. Lo que realmente puedo sustentar con documentación oficial del SENA

El mockup es una referencia de software, pero para las reglas del
proceso formativo debo acudir a fuentes oficiales.

El Acuerdo 9 de 2024 del SENA establece que la evaluación del proceso de
aprendizaje se realiza de forma continua y conjunta entre aprendiz e
instructor, teniendo en cuenta resultados de aprendizaje, criterios de
evaluación y avances logrados. También establece que las evidencias de
aprendizaje permiten identificar avances y pueden ser de conocimiento,
desempeño y producto, relacionadas directamente con los resultados de
aprendizaje.

Esto es muy importante para nuestro modelo porque demuestra que:

``` text
Resultado de aprendizaje
        ↓
Evidencias
        ↓
Evaluación
        ↓
Juicio evaluativo
```

no es simplemente una idea que estoy inventando para el proyecto.

El mismo marco establece que el aprendiz cumple satisfactoriamente el
proceso formativo cuando presenta evidencias idóneas y pertinentes en
las fechas establecidas y participa en las actividades presenciales o
virtuales concertadas de su ruta de aprendizaje.

También existe una relación oficial entre diseño curricular,
competencias, resultados de aprendizaje, evidencias y proyecto
formativo.

La Circular 67 de 2024 del SENA señala que el diseño curricular
contempla competencias y resultados de aprendizaje, y que el proyecto
formativo es un instrumento de gestión que organiza acciones de
planeación técnico-pedagógica y administrativa para desarrollar la
Formación Profesional Integral.

------------------------------------------------------------------------

# 19. Un punto que NO debo inventar: el porcentaje de avance del tecnólogo

Una de las ideas que surgieron durante el análisis es:

> "Cuando se aprueba una evidencia, automáticamente aumenta un
> porcentaje del avance del tecnólogo."

Después de revisar la documentación oficial consultada, **no debo
presentar esa afirmación como una regla oficial del SENA**.

Lo que sí puedo afirmar es que las evidencias se relacionan con
resultados de aprendizaje y que los juicios evaluativos permiten
expresar el logro o no logro del aprendizaje.

Por lo tanto, para nuestro sistema propondría inicialmente:

``` text
Evidencia
   ↓
Evaluación
   ↓
Juicio evaluativo
   ↓
Resultado de aprendizaje alcanzado / no alcanzado
```

Y dejaría el porcentaje global de avance como un **indicador
calculado**, solamente si se define una regla institucional clara para
calcularlo.

Esta separación evita crear una regla inventada.

------------------------------------------------------------------------

# 20. Ingeniería inversa del dominio

Después de analizar todas las pantallas, las entidades que considero
justificables inicialmente son:

## Núcleo

-   USUARIO
-   ROL
-   APRENDIZ
-   INSTRUCTOR
-   CENTRO_FORMACION
-   PROGRAMA_FORMACION
-   FICHA
-   HORARIO
-   SESION
-   COMPETENCIA
-   AMBIENTE
-   FRANJA_HORARIA

## Formación y seguimiento

-   RESULTADO_APRENDIZAJE
-   ACTIVIDAD_APRENDIZAJE
-   EVIDENCIA
-   EVALUACION
-   SEGUIMIENTO
-   INDICADOR
-   ALERTA
-   PLAN_MEJORAMIENTO

## Apoyo

-   NOTIFICACION
-   DISPONIBILIDAD
-   DOCUMENTO
-   PLANTILLA
-   AUDITORIA

Pero esta lista **no significa que todas deban implementarse en la
primera versión**.

------------------------------------------------------------------------

# 21. Mi propuesta de modelo mínimo

Para evitar sobreingeniería, yo dividiría el sistema en capas.

## Nivel 1 --- imprescindible para gestión de horarios

``` text
USUARIO
   ↓
ROL

APRENDIZ
   ↓
FICHA
   ↓
HORARIO
   ↓
SESION
   ├── INSTRUCTOR
   ├── AMBIENTE
   ├── COMPETENCIA
   └── FRANJA_HORARIA
```

Este núcleo permite solucionar el problema principal del mockup.

## Nivel 2 --- formación

Después:

``` text
PROGRAMA_FORMACION
   ↓
COMPETENCIA
   ↓
RESULTADO_APRENDIZAJE
   ↓
EVIDENCIA
   ↓
EVALUACION
```

## Nivel 3 --- seguimiento

Después:

``` text
FICHA
   ↓
SEGUIMIENTO
   ↓
INDICADORES
   ↓
ALERTAS
```

Esta separación permite crecer sin crear todo desde el comienzo.

------------------------------------------------------------------------

# 22. Historias de usuario principales

## HU-01 --- Consultar horario

**Como aprendiz, quiero consultar mi horario semanal para saber qué
clases tengo, cuándo son y dónde se realizan.**

### Criterios de aceptación

-   Debe mostrar los días de la semana.
-   Debe mostrar fecha y franja horaria.
-   Debe mostrar la clase.
-   Debe mostrar ambiente e instructor.
-   Solo debe mostrar sesiones correspondientes al aprendiz.

------------------------------------------------------------------------

## HU-02 --- Consultar detalle de clase

**Como aprendiz, quiero consultar el detalle de una clase para conocer
el ambiente, instructor, fecha, horario y observaciones.**

------------------------------------------------------------------------

## HU-03 --- Crear horario

**Como coordinador, quiero crear un horario para organizar las sesiones
de una ficha.**

------------------------------------------------------------------------

## HU-04 --- Validar horario

**Como coordinador, quiero validar un horario para detectar conflictos
antes de publicarlo.**

------------------------------------------------------------------------

## HU-05 --- Resolver conflicto

**Como coordinador, quiero resolver un conflicto de programación para
poder publicar un horario válido.**

------------------------------------------------------------------------

## HU-06 --- Publicar horario

**Como coordinador, quiero publicar un horario validado para que pueda
ser consultado por instructores y aprendices.**

------------------------------------------------------------------------

## HU-07 --- Consultar horario del instructor

**Como instructor, quiero consultar mis sesiones asignadas para conocer
mi programación.**

------------------------------------------------------------------------

## HU-08 --- Registrar seguimiento

**Como instructor, quiero registrar seguimiento de una ficha para dejar
evidencia del estado del proceso formativo.**

------------------------------------------------------------------------

## HU-09 --- Consultar indicadores

**Como director, quiero consultar indicadores para identificar fichas
que requieren atención.**

------------------------------------------------------------------------

# 23. Reglas de negocio deducidas

## RN-01

Un horario debe estar asociado a una ficha.

## RN-02

Una sesión debe tener una fecha y una franja horaria.

## RN-03

Una sesión debe identificar el instructor y el ambiente asignado.

## RN-04

No se debe permitir publicar un horario con conflictos pendientes que
bloqueen la publicación.

## RN-05

Un aprendiz solo debe consultar información correspondiente a su
contexto de formación.

## RN-06

Los permisos dependen del rol del usuario.

## RN-07

Los indicadores deben diferenciarse de los datos originales que los
generan.

## RN-08

Una evidencia no debe convertirse automáticamente en un porcentaje
global de avance si no existe una regla de cálculo definida.

## RN-09

El juicio evaluativo debe estar relacionado con los resultados de
aprendizaje y las evidencias correspondientes.

------------------------------------------------------------------------

# 24. Sobreingeniería que evitaría

## 24.1. Micro-frontends desde el primer momento

El mockup utiliza una arquitectura de micro-frontends por dominio.

Para una solución institucional de gran escala puede tener sentido. Pero
para un proyecto académico pequeño, implementar micro-frontends reales
desde el principio puede aumentar mucho:

-   complejidad;
-   configuración;
-   mantenimiento;
-   despliegue;
-   comunicación entre módulos.

### Mi decisión

**Lo documentaría como arquitectura futura o propuesta, pero no lo
convertiría en requisito obligatorio del MVP.**

------------------------------------------------------------------------

## 24.2. Sistema completo de documentos

El editor de plantillas, versiones, generación y auditoría documental
puede dejarse para una segunda etapa.

No es necesario para resolver el problema principal de gestionar
horarios.

------------------------------------------------------------------------

## 24.3. Parametrizar absolutamente todo

No todo necesita convertirse en un CRUD configurable.

Si un dato cambia muy poco y está controlado institucionalmente, puede
ser mejor manejarlo mediante catálogos bien definidos.

------------------------------------------------------------------------

## 24.4. Demasiados indicadores

No implementaría desde el comienzo todos los KPI posibles.

Primero usaría los indicadores realmente necesarios y posteriormente
agregaría otros.

------------------------------------------------------------------------

## 24.5. Automatizar el avance académico sin regla oficial

No crearía una fórmula como:

``` text
evidencias aprobadas / evidencias totales × 100
```

y la presentaría como "avance oficial del SENA".

Eso sería una decisión nuestra y tendría que quedar documentada como
propuesta.

------------------------------------------------------------------------

# 25. Mejoras que considero necesarias

## Mejora 1 --- Vincular mejor el aprendiz con su contexto real

El mockup muestra "Mi horario" asociado a una ficha específica, pero el
propio código identifica un gap relacionado con el permiso
`SCH_VIEW_OWN`.

### Propuesta

La consulta debería partir del usuario autenticado:

``` text
USUARIO
   ↓
APRENDIZ
   ↓
FICHA / MATRÍCULA
   ↓
HORARIO PUBLICADO
   ↓
SESIONES
```

Esto hace que "Mi horario" realmente sea del aprendiz.

------------------------------------------------------------------------

## Mejora 2 --- Integrar el proceso formativo

El mockup se concentra bastante en horarios.

Para que el sistema represente mejor el proceso formativo, propondría
que posteriormente se pueda consultar:

-   resultados de aprendizaje;
-   evidencias;
-   estado de evaluación;
-   planes de mejoramiento cuando correspondan;
-   avance de la ruta de aprendizaje.

Esto debe hacerse respetando las reglas oficiales y no inventando
indicadores.

------------------------------------------------------------------------

## Mejora 3 --- Diferenciar claramente horario y formación

No mezclar:

**Horario**

con

**Resultado de aprendizaje**

con

**Evidencia**

con

**Evaluación**.

Son conceptos relacionados, pero diferentes.

------------------------------------------------------------------------

## Mejora 4 --- Trazabilidad

Una mejora importante sería permitir seguir el camino:

``` text
Programa
  ↓
Competencia
  ↓
Resultado de aprendizaje
  ↓
Actividad
  ↓
Evidencia
  ↓
Evaluación
  ↓
Juicio evaluativo
```

Esto permitiría que el sistema no solo diga cuándo tiene clase un
aprendiz, sino también qué proceso de aprendizaje está detrás de esa
actividad.

------------------------------------------------------------------------

# 26. Modelo conceptual propuesto

Mi modelo conceptual inicial quedaría así:

``` text
CENTRO_FORMACION
        │
        └── PROGRAMA_FORMACION
                  │
                  ├── COMPETENCIA
                  │       │
                  │       └── RESULTADO_APRENDIZAJE
                  │                    │
                  │                    ├── ACTIVIDAD_APRENDIZAJE
                  │                    │
                  │                    └── EVIDENCIA
                  │                              │
                  │                              └── EVALUACION
                  │
                  └── FICHA
                         │
                         ├── APRENDIZ
                         │
                         └── HORARIO
                                │
                                └── SESION
                                     ├── INSTRUCTOR
                                     ├── AMBIENTE
                                     ├── FRANJA_HORARIA
                                     └── COMPETENCIA
```

Este modelo es una **propuesta derivada del análisis**, no el modelo
oficial de base de datos del SENA.

------------------------------------------------------------------------

# 27. Trazabilidad

  -----------------------------------------------------------------------------
  Funcionalidad     Requisito         Datos principales Entidades
  ----------------- ----------------- ----------------- -----------------------
  Consultar horario RF-12             fecha, hora,      HORARIO, SESION
                                      clase, ambiente   

  Ver detalle de    RF-13             instructor,       SESION, INSTRUCTOR,
  clase                               ambiente,         AMBIENTE
                                      competencia       

  Crear horario     RF-03             ficha, período    HORARIO, FICHA

  Agregar sesión    RF-05             fecha, hora,      SESION
                                      instructor,       
                                      ambiente          

  Validar horario   RF-08             asignaciones y    SESION, INSTRUCTOR,
                                      horarios          AMBIENTE

  Resolver          RF-10             tipo,             CONFLICTO
  conflicto                           descripción,      
                                      estado            

  Publicar horario  RF-06             estado            HORARIO

  Registrar         RF-11             fecha,            SEGUIMIENTO
  seguimiento                         asistencia,       
                                      avance,           
                                      observaciones     

  Consultar         RF-09             valor, período,   INDICADOR
  indicadores                         estado            

  Notificar         RF-14             asunto, mensaje,  NOTIFICACION
                                      fecha, estado     

  Evaluar evidencia Propuesta futura  evidencia,        EVIDENCIA, EVALUACION,
                                      resultado, juicio RESULTADO_APRENDIZAJE
  -----------------------------------------------------------------------------

------------------------------------------------------------------------

# 28. Conclusión personal

Después de hacer la ingeniería inversa, considero que el mockup está
bien planteado como punto de partida porque no se limita a mostrar una
agenda. El sistema intenta controlar todo el ciclo de programación:
crear horarios, asignar recursos, detectar conflictos, publicar y
permitir la consulta según el rol.

Sin embargo, también considero que hay funcionalidades que para un
proyecto académico podrían convertirse en sobreingeniería. Por eso no
copiaría las 53 pantallas como si todas fueran indispensables.

Mi propuesta sería comenzar con un núcleo pequeño:

**usuarios y roles → fichas → horarios → sesiones → instructores →
ambientes → consulta del aprendiz.**

Después agregaría:

**seguimiento → indicadores → resultados de aprendizaje → evidencias →
evaluación.**

Y finalmente dejaría para una fase posterior funcionalidades como:

**documentos, plantillas, auditoría avanzada y parametrización
completa.**

Lo más importante que aprendí del análisis es que **el modelo de datos
no debe construirse antes de entender el proceso**. Si primero entiendo
las pantallas, los requisitos y las reglas de negocio, puedo decidir qué
información realmente necesita persistirse.

También considero importante no confundir una propuesta de software con
una norma institucional. El mockup sirve para hacer ingeniería inversa
del software, mientras que las reglas del proceso formativo deben
contrastarse con documentación oficial del SENA.

Por eso, mi criterio final es:

> **Ni menos de lo necesario, ni más de lo necesario.**

------------------------------------------------------------------------

# 29. Fuentes consultadas

### Mockup y repositorio del proyecto

-   Sistema de Gestión de Horarios --- mockup navegable:
    https://code-sena.github.io/design-software-mockup/

-   Repositorio público del mockup:
    https://github.com/code-sena/design-software-mockup

-   Inventario y rutas del prototipo: `app/shell/routes.js`

-   Pantallas de gestión de horarios: `app/scheduling/screens.js`

-   Pantallas de seguimiento y notificaciones:
    `app/monitoring/screens.js`

-   Datos ficticios: `app/data/mock-data.js`

### Fuentes oficiales SENA

-   Acuerdo 9 de 2024 --- Reglamento del Aprendiz SENA:
    https://normograma.sena.edu.co/compilacion/docs/acuerdo_sena_0009_2024.htm

-   Circular 122 de 2024 --- emisión de juicios evaluativos:
    https://normograma.sena.edu.co/compilacion/docs/circular_sena_0122_2024.htm

-   Circular 67 de 2024 --- programación de grupos/fichas y ejecución de
    formación:
    https://normograma.sena.edu.co/compilacion/docs/circular_sena_0067_2024.htm

-   Resolución 317 de 2021:
    https://normograma.sena.edu.co/compilacion/docs/resolucion_sena_0317_2021.htm

------------------------------------------------------------------------

# 30. Nota metodológica

Este documento distingue entre:

-   información observada directamente en el mockup;
-   deducciones realizadas mediante ingeniería inversa;
-   información respaldada por fuentes oficiales del SENA;
-   propuestas propias de mejora.

Las partes marcadas como propuesta no deben interpretarse como
documentación oficial del SENA.

El mockup utiliza datos ficticios y no representa por sí mismo una base
de datos productiva ni el modelo oficial de información institucional.
