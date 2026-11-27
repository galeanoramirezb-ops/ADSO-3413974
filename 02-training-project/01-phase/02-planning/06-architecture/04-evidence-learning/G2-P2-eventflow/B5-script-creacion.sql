-- =====================================================================
-- EventFlow Manager (SIGEV) · Script de creación · PostgreSQL 16
-- Guía 2 · Producto 2 (B5) · autor: galeanoramirezb-ops
-- Estándar: tablas en singular, columnas snake_case, llaves id_<tabla>,
--           restricciones pk_/fk_/uq_/ck_<tabla>_<campo>
-- =====================================================================
DROP SCHEMA IF EXISTS eventflow CASCADE;
CREATE SCHEMA eventflow;
SET search_path TO eventflow;

-- Personas con cuenta (asistentes, organizadores, validadores y superadministradores)
CREATE TABLE usuario (
  id_usuario             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tipo_documento         VARCHAR(3) NOT NULL CONSTRAINT ck_usuario_tipo_doc CHECK (tipo_documento IN ('CC','CE','TI','PAS')),
  numero_documento       VARCHAR(20) NOT NULL,
  nombre_completo        VARCHAR(120) NOT NULL,
  correo                 VARCHAR(120) NOT NULL CONSTRAINT uq_usuario_correo UNIQUE CONSTRAINT ck_usuario_correo CHECK (correo LIKE '%_@_%._%'),
  hash_contrasena        CHAR(60) NOT NULL,
  estado                 VARCHAR(10) NOT NULL DEFAULT 'ACTIVO' CONSTRAINT ck_usuario_estado CHECK (estado IN ('ACTIVO','BLOQUEADO','INACTIVO')),
  fecha_registro         TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT uq_usuario_documento UNIQUE (tipo_documento, numero_documento)
);
COMMENT ON TABLE usuario IS 'Personas con cuenta (asistentes, organizadores, validadores y superadministradores)';

-- Teléfonos de un usuario (atributo multivaluado en tabla aparte)
CREATE TABLE telefono_usuario (
  id_telefono            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_usuario             BIGINT NOT NULL,
  numero                 VARCHAR(15) NOT NULL CONSTRAINT ck_telefono_numero CHECK (numero ~ '^[+]?[0-9]{7,15}$'),
  tipo                   VARCHAR(5) NOT NULL CONSTRAINT ck_telefono_tipo CHECK (tipo IN ('MOVIL','FIJO')),
  CONSTRAINT fk_telefono_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT uq_telefono UNIQUE (id_usuario, numero)
);
COMMENT ON TABLE telefono_usuario IS 'Teléfonos de un usuario (atributo multivaluado en tabla aparte)';

-- Roles del sistema (RBAC)
CREATE TABLE rol (
  id_rol                 SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre                 VARCHAR(20) NOT NULL CONSTRAINT uq_rol_nombre UNIQUE CONSTRAINT ck_rol_nombre CHECK (nombre IN ('SUPERADMIN','ORGANIZADOR','VALIDADOR','ASISTENTE')),
  descripcion            VARCHAR(200)
);
COMMENT ON TABLE rol IS 'Roles del sistema (RBAC)';

-- Acciones que se pueden autorizar por rol
CREATE TABLE permiso (
  id_permiso             SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  codigo                 VARCHAR(50) NOT NULL CONSTRAINT uq_permiso_codigo UNIQUE,
  modulo                 VARCHAR(30) NOT NULL,
  descripcion            VARCHAR(200)
);
COMMENT ON TABLE permiso IS 'Acciones que se pueden autorizar por rol';

-- Asignación de roles a usuarios (resuelve N:M usuario–rol)
CREATE TABLE usuario_rol (
  id_usuario             BIGINT NOT NULL,
  id_rol                 SMALLINT NOT NULL,
  fecha_asignacion       TIMESTAMPTZ NOT NULL DEFAULT now(),
  asignado_por           BIGINT,
  CONSTRAINT pk_usuario_rol PRIMARY KEY (id_usuario, id_rol),
  CONSTRAINT fk_ur_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE CASCADE,
  CONSTRAINT fk_ur_rol FOREIGN KEY (id_rol) REFERENCES rol (id_rol) ON DELETE RESTRICT,
  CONSTRAINT fk_ur_asignado_por FOREIGN KEY (asignado_por) REFERENCES usuario (id_usuario) ON DELETE SET NULL
);
COMMENT ON TABLE usuario_rol IS 'Asignación de roles a usuarios (resuelve N:M usuario–rol)';

-- Permisos de cada rol (resuelve N:M rol–permiso)
CREATE TABLE rol_permiso (
  id_rol                 SMALLINT NOT NULL,
  id_permiso             SMALLINT NOT NULL,
  CONSTRAINT pk_rol_permiso PRIMARY KEY (id_rol, id_permiso),
  CONSTRAINT fk_rp_rol FOREIGN KEY (id_rol) REFERENCES rol (id_rol) ON DELETE CASCADE,
  CONSTRAINT fk_rp_permiso FOREIGN KEY (id_permiso) REFERENCES permiso (id_permiso) ON DELETE CASCADE
);
COMMENT ON TABLE rol_permiso IS 'Permisos de cada rol (resuelve N:M rol–permiso)';

-- Autorización del titular para el tratamiento de datos (Ley 1581 de 2012)
CREATE TABLE consentimiento (
  id_consentimiento      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_usuario             BIGINT NOT NULL,
  version_politica       VARCHAR(10) NOT NULL,
  finalidad              VARCHAR(300) NOT NULL,
  fecha_aceptacion       TIMESTAMPTZ NOT NULL DEFAULT now(),
  fecha_revocatoria      TIMESTAMPTZ,
  CONSTRAINT fk_consentimiento_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE RESTRICT,
  CONSTRAINT ck_consentimiento_fechas CHECK (fecha_revocatoria IS NULL OR fecha_revocatoria >= fecha_aceptacion)
);
COMMENT ON TABLE consentimiento IS 'Autorización del titular para el tratamiento de datos (Ley 1581 de 2012)';

-- Lugares físicos donde se realizan los eventos
CREATE TABLE sede (
  id_sede                INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre                 VARCHAR(80) NOT NULL CONSTRAINT uq_sede_nombre UNIQUE,
  direccion              VARCHAR(150) NOT NULL,
  ciudad                 VARCHAR(60) NOT NULL,
  capacidad_fisica       INTEGER NOT NULL CONSTRAINT ck_sede_capacidad CHECK (capacidad_fisica > 0)
);
COMMENT ON TABLE sede IS 'Lugares físicos donde se realizan los eventos';

-- Eventos organizados
CREATE TABLE evento (
  id_evento              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_organizador         BIGINT NOT NULL,
  id_sede                INTEGER NOT NULL,
  titulo                 VARCHAR(150) NOT NULL,
  descripcion            TEXT,
  fecha_inicio           TIMESTAMPTZ NOT NULL,
  fecha_fin              TIMESTAMPTZ NOT NULL,
  aforo_maximo           INTEGER NOT NULL CONSTRAINT ck_evento_aforo CHECK (aforo_maximo > 0),
  ocupacion_actual       INTEGER NOT NULL DEFAULT 0,
  estado                 VARCHAR(10) NOT NULL DEFAULT 'BORRADOR' CONSTRAINT ck_evento_estado CHECK (estado IN ('BORRADOR','PUBLICADO','EN_CURSO','FINALIZADO','CANCELADO')),
  CONSTRAINT fk_evento_organizador FOREIGN KEY (id_organizador) REFERENCES usuario (id_usuario) ON DELETE RESTRICT,
  CONSTRAINT fk_evento_sede FOREIGN KEY (id_sede) REFERENCES sede (id_sede) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_evento_fechas CHECK (fecha_fin > fecha_inicio),
  CONSTRAINT ck_evento_ocupacion CHECK (ocupacion_actual BETWEEN 0 AND aforo_maximo)
);
COMMENT ON TABLE evento IS 'Eventos organizados';

-- Categorías de entrada de un evento (entidad débil de evento)
CREATE TABLE categoria_entrada (
  id_evento              BIGINT NOT NULL,
  num_categoria          SMALLINT NOT NULL CONSTRAINT ck_categoria_num CHECK (num_categoria > 0),
  nombre                 VARCHAR(40) NOT NULL,
  cupo                   INTEGER NOT NULL CONSTRAINT ck_categoria_cupo CHECK (cupo > 0),
  precio                 NUMERIC(12,2) NOT NULL DEFAULT 0 CONSTRAINT ck_categoria_precio CHECK (precio >= 0),
  CONSTRAINT pk_categoria_entrada PRIMARY KEY (id_evento, num_categoria),
  CONSTRAINT fk_categoria_evento FOREIGN KEY (id_evento) REFERENCES evento (id_evento) ON DELETE CASCADE,
  CONSTRAINT uq_categoria_nombre UNIQUE (id_evento, nombre)
);
COMMENT ON TABLE categoria_entrada IS 'Categorías de entrada de un evento (entidad débil de evento)';

-- Entradas emitidas a los asistentes
CREATE TABLE ticket (
  id_ticket              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  codigo                 VARCHAR(40) NOT NULL CONSTRAINT uq_ticket_codigo UNIQUE,
  id_asistente           BIGINT NOT NULL,
  id_evento              BIGINT NOT NULL,
  num_categoria          SMALLINT NOT NULL,
  semilla_qr             BYTEA NOT NULL,
  fecha_emision          TIMESTAMPTZ NOT NULL DEFAULT now(),
  estado                 VARCHAR(10) NOT NULL DEFAULT 'EMITIDO' CONSTRAINT ck_ticket_estado CHECK (estado IN ('EMITIDO','UTILIZADO','ANULADO')),
  CONSTRAINT fk_ticket_asistente FOREIGN KEY (id_asistente) REFERENCES usuario (id_usuario) ON DELETE RESTRICT,
  CONSTRAINT fk_ticket_categoria FOREIGN KEY (id_evento, num_categoria) REFERENCES categoria_entrada (id_evento, num_categoria) ON DELETE RESTRICT
);
COMMENT ON TABLE ticket IS 'Entradas emitidas a los asistentes';

-- Cada intento de ingreso en una puerta
CREATE TABLE validacion (
  id_validacion          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_ticket              BIGINT,
  id_validador           BIGINT NOT NULL,
  fecha_hora             TIMESTAMPTZ NOT NULL DEFAULT now(),
  puerta                 VARCHAR(20) NOT NULL,
  resultado              VARCHAR(9) NOT NULL CONSTRAINT ck_validacion_resultado CHECK (resultado IN ('CONCEDIDO','DENEGADO')),
  motivo_rechazo         VARCHAR(16) CONSTRAINT ck_validacion_motivo CHECK (motivo_rechazo IN ('NO_VIGENTE','YA_UTILIZADO','FOTO_NO_COINCIDE','AFORO_LLENO')),
  CONSTRAINT fk_validacion_ticket FOREIGN KEY (id_ticket) REFERENCES ticket (id_ticket) ON DELETE RESTRICT,
  CONSTRAINT fk_validacion_validador FOREIGN KEY (id_validador) REFERENCES usuario (id_usuario) ON DELETE RESTRICT,
  CONSTRAINT ck_validacion_coherencia CHECK ((resultado = 'CONCEDIDO' AND motivo_rechazo IS NULL AND id_ticket IS NOT NULL) OR (resultado = 'DENEGADO' AND motivo_rechazo IS NOT NULL))
);
COMMENT ON TABLE validacion IS 'Cada intento de ingreso en una puerta';

-- Alertas de aforo y de intento sospechoso (generalización en una sola tabla)
CREATE TABLE alerta (
  id_alerta              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_evento              BIGINT NOT NULL,
  id_validacion          BIGINT,
  tipo                   VARCHAR(10) NOT NULL CONSTRAINT ck_alerta_tipo CHECK (tipo IN ('AFORO','SOSPECHOSO')),
  fecha_hora             TIMESTAMPTZ NOT NULL DEFAULT now(),
  mensaje                VARCHAR(300) NOT NULL,
  porcentaje_ocupacion   NUMERIC(5,2) CONSTRAINT ck_alerta_porcentaje CHECK (porcentaje_ocupacion BETWEEN 0 AND 100),
  motivo                 VARCHAR(100),
  atendida               BOOLEAN NOT NULL DEFAULT false,
  CONSTRAINT fk_alerta_evento FOREIGN KEY (id_evento) REFERENCES evento (id_evento) ON DELETE CASCADE,
  CONSTRAINT fk_alerta_validacion FOREIGN KEY (id_validacion) REFERENCES validacion (id_validacion) ON DELETE SET NULL,
  CONSTRAINT ck_alerta_subtipo CHECK ((tipo = 'AFORO' AND porcentaje_ocupacion IS NOT NULL) OR (tipo = 'SOSPECHOSO' AND motivo IS NOT NULL))
);
COMMENT ON TABLE alerta IS 'Alertas de aforo y de intento sospechoso (generalización en una sola tabla)';

-- Registro inmutable de auditoría (RF12)
CREATE TABLE bitacora (
  id_registro            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_usuario             BIGINT NOT NULL,
  id_validacion          BIGINT CONSTRAINT uq_bitacora_validacion UNIQUE,
  fecha_hora             TIMESTAMPTZ NOT NULL DEFAULT now(),
  accion                 VARCHAR(40) NOT NULL,
  resultado              VARCHAR(20) NOT NULL,
  ip_origen              INET,
  huella_anterior        CHAR(64),
  huella_integridad      CHAR(64) NOT NULL CONSTRAINT uq_bitacora_huella UNIQUE,
  CONSTRAINT fk_bitacora_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE RESTRICT,
  CONSTRAINT fk_bitacora_validacion FOREIGN KEY (id_validacion) REFERENCES validacion (id_validacion) ON DELETE RESTRICT
);
COMMENT ON TABLE bitacora IS 'Registro inmutable de auditoría (RF12)';

-- Índices de apoyo (RNF-04 y reportes)
CREATE INDEX ix_validacion_ticket ON validacion (id_ticket);
CREATE INDEX ix_validacion_fecha ON validacion (fecha_hora);
CREATE INDEX ix_evento_fecha ON evento (fecha_inicio);
CREATE INDEX ix_ticket_asistente ON ticket (id_asistente);

-- Integridad: la bitácora es inmutable (solo INSERT)
CREATE FUNCTION fn_bitacora_inmutable() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  RAISE EXCEPTION 'La bitácora es inmutable: no se permite % ', TG_OP;
END; $$;
CREATE TRIGGER tg_bitacora_inmutable BEFORE UPDATE OR DELETE ON bitacora
  FOR EACH ROW EXECUTE FUNCTION fn_bitacora_inmutable();
CREATE TRIGGER tg_bitacora_no_truncate BEFORE TRUNCATE ON bitacora
  FOR EACH STATEMENT EXECUTE FUNCTION fn_bitacora_inmutable();

-- Confidencialidad: roles de base de datos con mínimo privilegio
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='eventflow_app') THEN CREATE ROLE eventflow_app NOLOGIN; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='eventflow_reportes') THEN CREATE ROLE eventflow_reportes NOLOGIN; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='eventflow_auditor') THEN CREATE ROLE eventflow_auditor NOLOGIN; END IF;
END $$;
GRANT USAGE ON SCHEMA eventflow TO eventflow_app, eventflow_reportes, eventflow_auditor;
GRANT SELECT, INSERT, UPDATE, DELETE ON usuario, telefono_usuario, usuario_rol, rol_permiso, sede, evento, categoria_entrada, ticket, alerta TO eventflow_app;
GRANT SELECT ON rol, permiso TO eventflow_app;
GRANT SELECT, INSERT ON consentimiento, validacion, bitacora TO eventflow_app;
GRANT UPDATE (fecha_revocatoria) ON consentimiento TO eventflow_app;
GRANT SELECT ON sede, evento, categoria_entrada, validacion, alerta TO eventflow_reportes;
GRANT SELECT (id_ticket, id_evento, num_categoria, fecha_emision, estado) ON ticket TO eventflow_reportes;
GRANT SELECT ON bitacora, validacion, usuario_rol TO eventflow_auditor;
GRANT SELECT (id_usuario, nombre_completo, estado) ON usuario TO eventflow_auditor;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA eventflow TO eventflow_app;
