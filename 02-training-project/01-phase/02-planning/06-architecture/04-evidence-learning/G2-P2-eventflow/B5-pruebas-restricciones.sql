-- Pruebas de restricciones sobre el esquema eventflow (datos ficticios)
SET search_path TO eventflow;
INSERT INTO rol (nombre, descripcion) VALUES ('SUPERADMIN','Gobierno del sistema'),('ORGANIZADOR','Crea eventos'),('VALIDADOR','Valida en puerta'),('ASISTENTE','Obtiene tickets');
INSERT INTO usuario (tipo_documento, numero_documento, nombre_completo, correo, hash_contrasena)
VALUES ('CC','1000000001','Organizadora Demo','org@demo.test', '$2a$12$abcdefghijklmnopqrstuuF0kq1yqz3c9w0y8m4C5H6eYb7xQ2W1e'),
       ('CC','1000000002','Asistente Demo','asis@demo.test','$2a$12$abcdefghijklmnopqrstuuF0kq1yqz3c9w0y8m4C5H6eYb7xQ2W1f'),
       ('CC','1000000003','Validador Demo','val@demo.test', '$2a$12$abcdefghijklmnopqrstuuF0kq1yqz3c9w0y8m4C5H6eYb7xQ2W1g');
INSERT INTO usuario_rol (id_usuario, id_rol) VALUES (1,2),(2,4),(3,3);
INSERT INTO sede (nombre, direccion, ciudad, capacidad_fisica) VALUES ('Coliseo Central','Calle 1 # 2-3','Ciudad Demo',1500);
INSERT INTO evento (id_organizador, id_sede, titulo, fecha_inicio, fecha_fin, aforo_maximo, estado)
VALUES (1,1,'Feria Empresarial 2026','2026-12-12 08:00-05','2026-12-12 18:00-05',1200,'PUBLICADO');
INSERT INTO categoria_entrada VALUES (1,1,'General',900,0),(1,2,'VIP',250,50000),(1,3,'Prensa',50,0);
INSERT INTO ticket (codigo, id_asistente, id_evento, num_categoria, semilla_qr) VALUES ('EVF-2026-000001',2,1,1,'\x0102');
INSERT INTO validacion (id_ticket, id_validador, puerta, resultado) VALUES (1,3,'Puerta 2','CONCEDIDO');
INSERT INTO bitacora (id_usuario, id_validacion, accion, resultado, huella_integridad)
VALUES (3,1,'VALIDAR_ACCESO','CONCEDIDO', repeat('a',64));
SELECT 'Filas cargadas' AS prueba, (SELECT count(*) FROM usuario) AS usuarios, (SELECT count(*) FROM ticket) AS tickets, (SELECT count(*) FROM validacion) AS validaciones;
\echo '--- Pruebas negativas: cada sentencia DEBE fallar ---'
\set ON_ERROR_STOP off
-- 1 CHECK fechas del evento
INSERT INTO evento (id_organizador,id_sede,titulo,fecha_inicio,fecha_fin,aforo_maximo) VALUES (1,1,'Mal','2026-12-12 18:00-05','2026-12-12 08:00-05',10);
-- 2 CHECK coherencia de la validación (concedido con motivo)
INSERT INTO validacion (id_ticket,id_validador,puerta,resultado,motivo_rechazo) VALUES (1,3,'P1','CONCEDIDO','YA_UTILIZADO');
-- 3 CHECK precio negativo
INSERT INTO categoria_entrada VALUES (1,4,'Gratis',10,-1);
-- 4 UNIQUE correo
INSERT INTO usuario (tipo_documento,numero_documento,nombre_completo,correo,hash_contrasena) VALUES ('CC','9','X','org@demo.test',repeat('x',60));
-- 5 FK ticket hacia categoría inexistente
INSERT INTO ticket (codigo,id_asistente,id_evento,num_categoria,semilla_qr) VALUES ('EVF-X',2,1,9,'\x01');
-- 6 ON DELETE RESTRICT: no se borra un usuario con eventos
DELETE FROM usuario WHERE id_usuario = 1;
-- 7 Bitácora inmutable (disparador)
UPDATE bitacora SET resultado = 'DENEGADO' WHERE id_registro = 1;
DELETE FROM bitacora WHERE id_registro = 1;
-- 8 CHECK ocupación mayor que el aforo
UPDATE evento SET ocupacion_actual = 5000 WHERE id_evento = 1;
\echo '--- Prueba positiva: ON DELETE CASCADE de categorías al borrar un evento sin tickets ---'
INSERT INTO evento (id_organizador,id_sede,titulo,fecha_inicio,fecha_fin,aforo_maximo) VALUES (1,1,'Borrador','2026-12-20 08:00-05','2026-12-20 10:00-05',100);
INSERT INTO categoria_entrada SELECT max(id_evento),1,'General',100,0 FROM evento;
SELECT count(*) AS categorias_antes FROM categoria_entrada WHERE id_evento = (SELECT max(id_evento) FROM evento);
DELETE FROM evento WHERE titulo = 'Borrador';
SELECT count(*) AS categorias_despues_de_borrar_evento FROM categoria_entrada c WHERE NOT EXISTS (SELECT 1 FROM evento e WHERE e.id_evento = c.id_evento);
