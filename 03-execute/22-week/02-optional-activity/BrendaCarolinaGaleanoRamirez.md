# Brenda Carolina Galeano Ramiréz

## Sistema: SENA — Gestión de Horarios
> Guía de documentación técnica del prototipo navegable (https://code-sena.github.io/design-software-mockup/). Elaborada a partir del inventario maestro de 53 vistas y de las capturas efectivamente revisadas para los 5 perfiles de usuario del sistema.

---

## 1. Panorama general del sistema

| Campo | Valor |
|---|---|
| Nombre del sistema | SENA — Gestión de Horarios |
| Origen del prototipo | code-sena/design-software-mockup (GitHub Pages) |
| Tipo de prototipo | Estático (información simulada, sin conexión real a backend) |
| Total de vistas/ventanas emergentes | 53 |
| Perfiles identificados | Coordinador Académico, Instructor, Aprendiz, Director de Centro, Administrador de Soporte |
| Arquitectura | Micro-frontends organizados por dominio, con shell principal, enrutamiento por hash y control de acceso basado en roles (RBAC) |
| Accesibilidad | Cumple WCAG 2.1 nivel AA · zonas táctiles mínimas de 44px |
| Comportamiento responsive | En móvil (< 768px) los menús se muestran como panel deslizante (drawer) |
| Sistema de diseño | Conjunto único de tokens visuales compartidos por todas las vistas |

---

## 2. Arquitectura — Estructura base (App Shell)

```
Estructura base (App Shell)
├── Barra superior (TopBar)
│   ├── Logo + nombre del sistema + subtítulo de contexto (centro)
│   ├── Ícono de notificaciones (con contador tipo badge)
│   └── Menú del usuario (avatar + nombre + rol + flecha desplegable)
├── Menú lateral (varía según el perfil conectado)
│   ├── Encabezado del rol (en mayúsculas, ej. "COORDINADOR ACADÉMICO")
│   └── Opciones de navegación con ícono + etiqueta (la opción activa se resalta en verde)
├── Zona de contenido
│   ├── Título de la vista (H1)
│   ├── Descripción/subtítulo
│   └── Bloques de contenido (tarjetas, tablas, alertas, formularios)
└── Elementos globales
    ├── Panel de notificaciones (se despliega desde el lateral derecho)
    └── Aviso informativo (fondo azul, ícono de información)
```

---

## 3. Patrones de interfaz que se repiten

### 3.1 Tarjeta informativa
Un rótulo corto en mayúsculas pequeñas seguido del dato principal en texto grande y en negrita.

### 3.2 Aviso de estado (banner)
- Tipo informativo: fondo azul claro, ícono ⓘ
- Tipo alerta/conflicto: fondo rojo claro, ícono ⚠, título en rojo con texto explicativo

### 3.3 Panel lateral de notificaciones
Encabezado ("Notificaciones" + "Últimos N avisos" + botón de cierre X) seguido de una lista de elementos (ícono + título + descripción + fecha/hora + etiqueta de estado) y un pie con enlace "Ver todas".

### 3.4 Tabla con filtros y acciones
- Bloque de filtros ubicado en la parte superior (buscador, listas desplegables, rango de fechas, botón "Limpiar filtros")
- Encabezados de columna en mayúsculas pequeñas
- Cada fila incluye una etiqueta de estado (tipo pill) y una columna con botón o enlace de acción
- Pie de tabla: texto "Mostrando X de Y", paginador y selector de "N por página"

### 3.5 Etiquetas de estado (pills)
Combinan ícono + texto, con un color asociado al significado:
- Verde: Activo / Enviado / Disponible / Publicado / En ejecución
- Ámbar: En riesgo / En revisión / Enviando... / Etapa productiva
- Rojo: Envío fallido / Crítico / No disponible / Error al generar
- Gris/neutro: Borrador / Inactivo / Finalizada

### 3.6 Esquema de 4 bloques por vista (validado)
Verificado en las capturas correspondientes a los 5 perfiles. Cada vista principal de un módulo se compone de 4 bloques fijos:

| # | Bloque | Descripción |
|---|---|---|
| 1 | **Encabezado** | Título (H1) más subtítulo o texto de contexto |
| 2 | **Acción principal** | Botón verde en la esquina superior derecha (aparece solo si los permisos y el tipo de vista lo requieren) |
| 3 | **Contenido central** | Sección variable: calendario, listado de tarjetas, tabla con filtros, formulario o pestañas |
| 4 | **Pie / paginación** | Cierra la vista; presente en toda tabla de datos, ausente en calendarios o formularios simples |

### 3.7 Patrón de filtros en tablas (visto en Coordinador/Director/Soporte)
Franja horizontal de controles antes del contenido principal: campo de búsqueda con ícono de lupa, listas desplegables de filtro (Rol/Estado/Dominio/etc.), selector de rango de fechas y un botón secundario "Limpiar filtros". Aparece en: Horarios, Fichas, Usuarios, Documentos, Plantillas y Auditoría.

### 3.8 Patrón de pestañas internas (visto en Director)
Dentro de una misma vista ("Datos de referencia") existe una sub-navegación por pestañas (Mi centro / Catálogos / Parámetros) que cambia el contenido central sin modificar la ruta principal.

### 3.9 Patrón de centro de navegación por tarjetas (visto en Parametrización)
Una cuadrícula de tarjetas clicables (ícono + título + descripción breve), donde cada una conduce a un sub-módulo de configuración. Se usa en el Centro de parametrización (vista 46), al que puede acceder tanto el Director como el Administrador de Soporte.

---

## 4. Menús disponibles según el rol

| Rol | Opciones visibles en el menú lateral |
|---|---|
| Coordinador Académico | Inicio, Horarios, Disponibilidad, Fichas |
| Instructor | Mi horario, Mi disponibilidad, Seguimiento |
| Aprendiz | Mi horario, Notificaciones |
| Director de Centro | Indicadores, Usuarios, Datos de referencia, Parametrización |
| Administrador de Soporte | Documentos, Plantillas, Auditoría, Parametrización |

---

## 5. Listado completo de vistas (53)

### 01 · Autenticación y estructura base
| # | Nombre | Módulo | Rol | Documentado |
|---|---|---|---|---|
| 1 | Login | iam | público | ☐ |
| 2 | Recuperar contraseña | iam | público | ☐ |
| 3 | Nueva contraseña | iam | público | ☐ |
| 4 | Estructura base por rol | shell | coordinador | ✅ |
| 5 | Panel de notificaciones | shell | coordinador | ✅ |
| 6 | Estados globales | shell | coordinador | ☐ |

### 02 · Coordinador
| # | Nombre | Módulo | Rol | Documentado |
|---|---|---|---|---|
| 7 | Panel / Inicio | shell + scheduling + academic | coordinador | ✅ |
| 8 | Horarios — listado | scheduling | coordinador | ✅ |
| 9 | Detalle de horario | scheduling | coordinador | ☐ |
| 10 | Crear / editar horario | scheduling | coordinador | ☐ |
| 11 | Ventana agregar / editar sesión | scheduling | coordinador | ☐ |
| 12 | Ventana confirmar publicación | scheduling | coordinador | ☐ |
| 13 | Panel de conflictos | scheduling | coordinador | ☐ |
| 14 | Ventana resolver conflicto | scheduling | coordinador | ☐ |
| 15 | Disponibilidad | environment + actors | coordinador | ✅ |
| 16 | Detalle de ambiente | environment | coordinador | ☐ |
| 17 | Fichas — listado | academic | coordinador | ✅ |
| 18 | Detalle de ficha | academic | coordinador | ☐ |

### 03 · Instructor
| # | Nombre | Módulo | Rol | Documentado |
|---|---|---|---|---|
| 19 | Mi horario — semana | scheduling | instructor | ✅ |
| 20 | Detalle de sesión | scheduling | instructor | ☐ |
| 21 | Mi disponibilidad | actors | instructor | ✅ |
| 22 | Ventana crear excepción | actors | instructor | ☐ |
| 23 | Seguimiento de ficha | monitoring | instructor | ✅ |
| 24 | Registrar seguimiento | monitoring | instructor | ☐ |

### 04 · Aprendiz
| # | Nombre | Módulo | Rol | Documentado |
|---|---|---|---|---|
| 25 | Mi horario — semana | scheduling | aprendiz | ✅ |
| 26 | Notificaciones | monitoring | aprendiz | ✅ |
| 27 | Detalle de clase | scheduling | aprendiz | ☐ |
| 28 | Detalle de notificación | monitoring | aprendiz | ☐ |

### 05 · Dirección (Director de Centro)
| # | Nombre | Módulo | Rol | Documentado |
|---|---|---|---|---|
| 29 | Panel de indicadores | monitoring | director | ✅ |
| 30 | Detalle de un KPI | monitoring | director | ☐ |
| 31 | Usuarios — listado | iam | director | ✅ |
| 32 | Crear / editar usuario | iam | director | ☐ |
| 33 | Detalle de usuario | iam | director | ☐ |
| 34 | Ventana asignar / revocar rol | iam | director | ☐ |
| 35 | Datos de referencia | reference | director | ✅ |
| 36 | Editar catálogo / valor / parámetro | reference | director | ☐ |

### 06 · Back-office (Administrador de Soporte)
| # | Nombre | Módulo | Rol | Documentado |
|---|---|---|---|---|
| 37 | Documentos — listado | document | soporte | ✅ |
| 38 | Plantillas de documento | document | soporte | ✅ |
| 39 | Auditoría | audit | soporte | ✅ |
| 40 | Parametrización / catálogos | reference | soporte | ☐ |
| 41 | Detalle de documento + versiones | document | soporte | ☐ |
| 42 | Ventana generar documento | document | soporte | ☐ |
| 43 | Editor / vista previa de plantilla | document | soporte | ☐ |
| 44 | Ventana detalle de auditoría | audit | soporte | ☐ |
| 45 | CRUD de catálogo / valor / parámetro | reference | soporte | ☐ |

### 07 · Parametrización
| # | Nombre | Módulo | Rol | Documentado |
|---|---|---|---|---|
| 46 | Centro de parametrización | reference | director | ✅ |
| 47 | Currículo académico | academic | director | ☐ |
| 48 | Jornadas / franjas horarias | scheduling | director | ☐ |
| 49 | Tipos de ambiente e inventario | environment | director | ☐ |
| 50 | Catálogos de monitoreo (KPI/alertas) | monitoring | director | ☐ |
| 51 | Estados de actores | actors | director | ☐ |
| 52 | Geografía institucional | reference | director | ☐ |
| 53 | RBAC — roles y permisos | iam | director | ☐ |

**Avance actual: 18 de 53 vistas documentadas con evidencia real (34%).**

---

## 6. Vistas documentadas por rol

### 6.1 Rol: Coordinador Académico

#### 7 — Panel / Inicio
- **Módulo:** shell + scheduling + academic
- **Tipo:** vista completa
- **Propósito:** pantalla de bienvenida que resume conflictos pendientes y ofrece accesos directos.
- **Estructura de 4 bloques:**
  1. Encabezado: "Inicio" (sin subtítulo)
  2. Acción principal: botón "+ Nuevo horario"
  3. Contenido central: aviso "Conflictos pendientes (4)" con 3 elementos listados (tipo de conflicto, ficha/ambiente afectado, fecha, enlace "Ver panel") más 2 tarjetas informativas (Fichas activas: 12, Horarios en borrador: 3)
  4. Pie/paginación: "Mostrando 3 de 4 · Ver todos" (integrado en el aviso de conflictos)
- **Estados observados:** con datos (4 conflictos); no se registró la variante vacía.
- **Interacciones principales:** crear un nuevo horario, abrir el panel de un conflicto puntual, ver el listado completo de conflictos/fichas/horarios.

#### 8 — Horarios — listado
- **Módulo:** scheduling
- **Tipo:** vista completa
- **Propósito:** consultar y filtrar los horarios del centro según ficha, instructor, ambiente, estado o fecha.
- **Estructura de 4 bloques:**
  1. Encabezado: "Horarios" (sin subtítulo)
  2. Acción principal: botón "+ Nuevo horario"
  3. Contenido central: fila de filtros (Ficha, Instructor, Ambiente, Estado, Rango de fechas, "Limpiar filtros") junto a una tabla (Ficha, Período, Nombre, Estado, Última edición, y una columna de acción con botón "Continuar edición" o "Ver detalle" según el estado)
  4. Pie/paginación: no visible en la captura disponible (tabla incompleta), se asume por el patrón 3.4
- **Estados observados:** Borrador (gris), En revisión (ámbar), Publicado (verde).
- **Interacciones principales:** aplicar filtros, retomar la edición de un borrador, revisar el detalle de un horario publicado o en revisión.

#### 15 — Disponibilidad
- **Módulo:** environment + actors
- **Tipo:** vista completa
- **Propósito:** revisar qué ambientes e instructores están libres para una franja horaria puntual.
- **Estructura de 4 bloques:**
  1. Encabezado: "Disponibilidad" + "Consulta ambientes e instructores disponibles para una sesión."
  2. Acción principal: botón "Consultar" (ligado al formulario de búsqueda, no crea un registro nuevo)
  3. Contenido central: formulario de búsqueda (Fecha, Hora inicio, Hora fin) junto a pestañas (Ambientes / Instructores) y una cuadrícula de resultados (nombre, tipo, capacidad, ubicación, etiqueta Disponible/No disponible, botón "Ver detalle")
  4. Pie/paginación: no se observó (los resultados son limitados)
- **Estados observados:** Disponible (verde), No disponible (rojo).
- **Interacciones principales:** ingresar fecha/hora, cambiar entre las pestañas Ambientes/Instructores, abrir el detalle de un recurso.

#### 17 — Fichas — listado
- **Módulo:** academic
- **Tipo:** vista completa
- **Propósito:** listar las fichas de formación del centro con opciones de filtrado.
- **Estructura de 4 bloques:**
  1. Encabezado: "Fichas" (sin subtítulo)
  2. Acción principal: no aplica (no se identificó botón de creación)
  3. Contenido central: fila de filtros (Programa, Estado, Inicio desde, "Limpiar filtros") junto a una tabla (Ficha, Programa, Estado, Jornada, Modalidad, Cupo máximo, Fecha de inicio)
  4. Pie/paginación: "Mostrando 1–5 de 56" con paginador (1, 2, 3...) y selector "10 por página"
- **Estados observados:** Ejecución (verde), Etapa productiva (ámbar), Inducción (azul), Finalizada (gris).
- **Interacciones principales:** filtrar por programa, estado o fecha; hacer clic en el número de ficha para ir al Detalle de ficha (#18).

---

### 6.2 Rol: Instructor

#### 19 — Mi horario — semana
- **Módulo:** scheduling
- **Estructura de 4 bloques:** Encabezado ("Mi horario" + rango de la semana) → Acción principal: no aplica, se navega con "‹ Semana anterior / Semana siguiente ›" → Contenido central: grilla semanal (día × hora) con tarjetas de sesión → Pie: no aplica.
- **Interacciones:** cambiar de semana, abrir una sesión puntual.

#### 21 — Mi disponibilidad
- **Módulo:** actors
- **Estructura de 4 bloques:** Encabezado ("Mi disponibilidad" + descripción) → Acción principal: "+ Nueva excepción" → Contenido central: listado de excepciones (ícono + título + fecha + descripción + botón Eliminar) → Pie: "Mostrando 1–3 de 34" con paginador.
- **Interacciones:** registrar una excepción, eliminarla, avanzar entre páginas.

#### 23 — Seguimiento de ficha
- **Módulo:** monitoring
- **Estructura de 4 bloques:** Encabezado ("Seguimiento de ficha" + descripción) → Acción principal: "+ Registrar seguimiento" → Contenido central: selector de ficha junto a 3 tarjetas resumen (Estado, Último seguimiento, Próximo) más una tabla histórica (Fecha, Tipo, Asistencia, Avance curricular %, Requiere seguimiento) → Pie: "Mostrando 1–4 de 27" con paginador.
- **Interacciones:** cambiar de ficha, registrar un seguimiento nuevo, avanzar entre páginas.

---

### 6.3 Rol: Aprendiz

#### 25 — Mi horario — semana
- **Módulo:** scheduling
- **Tipo:** vista completa
- **Propósito:** mostrar las sesiones de la semana correspondientes a la ficha del aprendiz.
- **Estructura de 4 bloques:**
  1. Encabezado: "Mi horario" + "Ficha 2874412 · Semana del 10 al 14 de agosto de 2026"
  2. Acción principal: no aplica
  3. Contenido central: listado de sesiones agrupadas por día (ícono de calendario + día/hora + nombre de la clase + ambiente + instructor + botón "Ver detalle")
  4. Pie/paginación: no aplica (la vista está limitada a una semana)
- **Interacciones principales:** abrir el detalle de una sesión, lo que lleva a Detalle de clase (#27).

#### 26 — Notificaciones
- **Módulo:** monitoring
- **Tipo:** vista completa
- **Propósito:** mostrar los avisos que ha recibido el aprendiz.
- **Estructura de 4 bloques:**
  1. Encabezado: "Notificaciones" + "Avisos enviados a tu usuario."
  2. Acción principal: no aplica
  3. Contenido central: listado de notificaciones (ícono de campana + título + descripción + fecha/hora + etiqueta de estado Enviado/Enviando...)
  4. Pie/paginación: no se registró en la captura (el listado es corto)
- **Interacciones principales:** abrir una notificación para ver su Detalle (#28).

---

### 6.4 Rol: Director de Centro

#### 29 — Panel de indicadores
- **Módulo:** monitoring
- **Tipo:** vista completa
- **Propósito:** ofrecer una vista ejecutiva del estado de seguimiento de las fichas del centro.
- **Estructura de 4 bloques:**
  1. Encabezado: "Panel de indicadores" + "Estado de seguimiento de las fichas del centro."
  2. Acción principal: botón "Actualizar" (recarga según los filtros aplicados, no genera un recurso nuevo)
  3. Contenido central: fila de filtros (Tipo de KPI, Estado, Desde, Hasta) junto a 3 tarjetas de indicador (En seguimiento: 31, En riesgo: 12, Crítico: 4) y un gráfico de barras horizontales ("Distribución por nivel de riesgo")
  4. Pie/paginación: no aplica (vista de indicadores, no es tabular)
- **Interacciones principales:** filtrar por tipo, estado o rango de fecha; profundizar en un KPI específico (#30).

#### 31 — Usuarios — listado
- **Módulo:** iam
- **Tipo:** vista completa
- **Propósito:** administrar las cuentas de usuario del centro de formación.
- **Estructura de 4 bloques:**
  1. Encabezado: "Administración — Usuarios" + "Gestiona las cuentas del centro de formación."
  2. Acción principal: "+ Nuevo usuario"
  3. Contenido central: fila de filtros (Rol, Estado, Buscar por nombre/correo, "Limpiar filtros") junto a una tabla (Nombre completo, Correo, Tipo de actor —etiqueta—, Estado —etiqueta Activo/Inactivo—, Último acceso)
  4. Pie/paginación: "Mostrando 1–5 de 84" con paginador y selector "10 por página"
- **Interacciones principales:** crear un usuario nuevo, abrir el Detalle de usuario (#33) desde el nombre, aplicar filtros.

#### 35 — Datos de referencia
- **Módulo:** reference
- **Tipo:** vista completa con pestañas internas
- **Propósito:** consultar y actualizar la información institucional del centro.
- **Estructura de 4 bloques:**
  1. Encabezado: "Administración — Datos de referencia" + "Consulta y mantenimiento de la información institucional del centro."
  2. Acción principal: no aplica a nivel de vista (existen botones propios de cada pestaña, como "Guardar" o "+ Nueva sede")
  3. Contenido central: pestañas (Mi centro / Catálogos / Parámetros) → la pestaña activa "Mi centro" muestra un formulario (Código del centro, Nombre, Dirección, Teléfono) con botón "Guardar" y una sección "Sedes y unidades institucionales" con botón "+ Nueva sede"
  4. Pie/paginación: no aplica
- **Interacciones principales:** cambiar de pestaña, editar y guardar la información del centro, agregar una sede nueva.
- **Nota de patrón:** confirma el patrón 3.8 (pestañas internas) como una variante posible del bloque "Contenido central".

#### 46 — Centro de parametrización
- **Módulo:** reference
- **Tipo:** vista completa (centro de navegación)
- **Propósito:** servir de punto de acceso a los 8 sub-módulos de configuración maestra del sistema.
- **Estructura de 4 bloques:**
  1. Encabezado: "Parametrización" + "Configure los catálogos y datos maestros que los flujos operativos requieren como prerrequisito."
  2. Acción principal: no aplica
  3. Contenido central: aviso informativo (sobre dependencias entre catálogos) junto a una cuadrícula de 7 tarjetas de navegación (Currículo académico, Jornadas/franjas, Tipos de ambiente e inventario, Catálogos de monitoreo, Estados de actores, Geografía institucional, RBAC — roles y permisos) más una tarjeta adicional "Datos de referencia (mi centro)"
  4. Pie/paginación: no aplica
- **Interacciones principales:** hacer clic en cualquier tarjeta para navegar al sub-módulo correspondiente (#47 a #53).
- **Nota:** esta vista puede abrirla tanto el Director como el Administrador de Soporte (ver 6.5), lo que confirma el patrón 3.9.

---

### 6.5 Rol: Administrador de Soporte

#### 37 — Documentos — listado
- **Módulo:** document
- **Tipo:** vista completa
- **Propósito:** ubicar, generar y descargar los documentos del sistema.
- **Estructura de 4 bloques:**
  1. Encabezado: "Documentos" + "Localiza, genera y descarga documentos del sistema."
  2. Acción principal: "+ Generar documento"
  3. Contenido central: fila de filtros (Dominio, Estado, Plantilla, Fecha, "Limpiar filtros") junto a una tabla (Título, Plantilla, Dominio, Estado, Versión, Creado, columna de acción con "Descargar" o "Reintentar")
  4. Pie/paginación: "Mostrando 1–4 de 42" con paginador y selector "10 por página"
- **Estados observados:** Disponible (verde), Generando... (azul), Error de generación (rojo, con botón "Reintentar").
- **Interacciones principales:** generar un documento, descargarlo, reintentar una generación fallida, aplicar filtros.

#### 38 — Plantillas de documento
- **Módulo:** document
- **Tipo:** vista completa
- **Propósito:** administrar el catálogo de plantillas que usa el generador de documentos.
- **Estructura de 4 bloques:**
  1. Encabezado: "Plantillas de documento" + "Catálogo usado por el generador de documentos."
  2. Acción principal: "+ Nueva plantilla"
  3. Contenido central: fila de filtros (Tipo de salida, Código, Activa, "Limpiar filtros") junto a una tabla (Código, Nombre, Tipo de salida, Versión, Activa —etiqueta—, Actualizada)
  4. Pie/paginación: "Mostrando 1–4 de 18" con paginador y selector "10 por página"
- **Interacciones principales:** crear una plantilla nueva, abrir el Editor/vista previa (#43) desde el código, filtrar o activar/desactivar plantillas.

#### 39 — Auditoría
- **Módulo:** audit
- **Tipo:** vista completa
- **Propósito:** registro de solo lectura con las acciones realizadas en el sistema.
- **Estructura de 4 bloques:**
  1. Encabezado: "Auditoría" + "Registro de solo lectura de las acciones del sistema."
  2. Acción principal: botón "Exportar" (exporta información, no crea un recurso)
  3. Contenido central: fila de filtros (Actor UUID, Tipo de entidad, Tipo de evento, Servicio origen, Desde) junto a una tabla (Recibido, Ocurrido en origen, Evento, Servicio origen —etiqueta—, Actor, Entidad, columna de acción "Ver payload")
  4. Pie/paginación: no visible en la captura, se asume por el patrón 3.4
- **Interacciones principales:** filtrar por actor, entidad, evento, servicio o fecha; exportar; abrir el detalle de un evento (#44).

---

## 7. Estado de avance

Este documento cubre el **inventario completo (53/53)** en cuanto a listado, roles y módulos. De esas 53 vistas, **18** cuentan con documentación visual detallada respaldada en captura real, repartidas entre los 5 roles del sistema: Coordinador (5), Instructor (3), Aprendiz (2), Director (4), Soporte (3), además de la vista compartida de Estructura base (App Shell) y el Panel de notificaciones.

Vistas que aún faltan por documentar con evidencia real (35): sobre todo ventanas de creación/edición (crear horario, crear usuario, resolver conflicto, etc.), vistas de detalle (sesión, ambiente, ficha, usuario, clase, notificación) y los 7 sub-módulos de Parametrización (#47–53).

Para llegar al 100% del avance, se requiere incorporar las capturas restantes o contar con acceso directo por rol a las rutas en modo revisión (por ejemplo, `#/admin/parametrizacion?as=director`).
