-- =====================================================
-- FASE 1 - Stored Procedures CRUD y vistas
-- =====================================================
USE saludvital;

-- ---------- VISTAS ----------
CREATE OR REPLACE VIEW vw_pacientes AS
SELECT id_paciente, dpi, nombres, apellidos, fecha_nacimiento, telefono, email, direccion
FROM paciente;

CREATE OR REPLACE VIEW vw_medicos AS
SELECT m.id_medico, m.nombres, m.apellidos, m.no_colegiado, m.telefono, m.email,
       e.id_especialidad, e.nombre AS especialidad
FROM medico m JOIN especialidad e ON e.id_especialidad = m.id_especialidad;

CREATE OR REPLACE VIEW vw_citas_detalle AS
SELECT c.id_cita, c.fecha_hora, c.motivo, c.estado,
       CONCAT(p.nombres,' ',p.apellidos) AS paciente,
       CONCAT(m.nombres,' ',m.apellidos) AS medico,
       e.nombre AS especialidad
FROM cita c
JOIN paciente p     ON p.id_paciente = c.id_paciente
JOIN medico m       ON m.id_medico = c.id_medico
JOIN especialidad e ON e.id_especialidad = m.id_especialidad;

DELIMITER $$

-- ---------- PACIENTE ----------
DROP PROCEDURE IF EXISTS sp_insertar_paciente$$
CREATE PROCEDURE sp_insertar_paciente(
    IN p_dpi CHAR(13), IN p_nombres VARCHAR(60), IN p_apellidos VARCHAR(60),
    IN p_fecha_nac DATE, IN p_telefono VARCHAR(15), IN p_email VARCHAR(80),
    IN p_direccion VARCHAR(150), OUT p_id INT)
BEGIN
    INSERT INTO paciente (dpi, nombres, apellidos, fecha_nacimiento, telefono, email, direccion)
    VALUES (p_dpi, p_nombres, p_apellidos, p_fecha_nac, p_telefono, p_email, p_direccion);
    SET p_id = LAST_INSERT_ID();
END$$

DROP PROCEDURE IF EXISTS sp_actualizar_paciente$$
CREATE PROCEDURE sp_actualizar_paciente(
    IN p_id INT, IN p_dpi CHAR(13), IN p_nombres VARCHAR(60), IN p_apellidos VARCHAR(60),
    IN p_fecha_nac DATE, IN p_telefono VARCHAR(15), IN p_email VARCHAR(80),
    IN p_direccion VARCHAR(150))
BEGIN
    UPDATE paciente
       SET dpi=p_dpi, nombres=p_nombres, apellidos=p_apellidos, fecha_nacimiento=p_fecha_nac,
           telefono=p_telefono, email=p_email, direccion=p_direccion
     WHERE id_paciente = p_id;
END$$

DROP PROCEDURE IF EXISTS sp_eliminar_paciente$$
CREATE PROCEDURE sp_eliminar_paciente(IN p_id INT)
BEGIN
    DELETE FROM paciente WHERE id_paciente = p_id;
END$$

-- ---------- MEDICO ----------
DROP PROCEDURE IF EXISTS sp_insertar_medico$$
CREATE PROCEDURE sp_insertar_medico(
    IN p_nombres VARCHAR(60), IN p_apellidos VARCHAR(60), IN p_colegiado VARCHAR(20),
    IN p_telefono VARCHAR(15), IN p_email VARCHAR(80), IN p_id_especialidad INT, OUT p_id INT)
BEGIN
    INSERT INTO medico (nombres, apellidos, no_colegiado, telefono, email, id_especialidad)
    VALUES (p_nombres, p_apellidos, p_colegiado, p_telefono, p_email, p_id_especialidad);
    SET p_id = LAST_INSERT_ID();
END$$

DROP PROCEDURE IF EXISTS sp_actualizar_medico$$
CREATE PROCEDURE sp_actualizar_medico(
    IN p_id INT, IN p_nombres VARCHAR(60), IN p_apellidos VARCHAR(60), IN p_colegiado VARCHAR(20),
    IN p_telefono VARCHAR(15), IN p_email VARCHAR(80), IN p_id_especialidad INT)
BEGIN
    UPDATE medico
       SET nombres=p_nombres, apellidos=p_apellidos, no_colegiado=p_colegiado,
           telefono=p_telefono, email=p_email, id_especialidad=p_id_especialidad
     WHERE id_medico = p_id;
END$$

DROP PROCEDURE IF EXISTS sp_eliminar_medico$$
CREATE PROCEDURE sp_eliminar_medico(IN p_id INT)
BEGIN
    DELETE FROM medico WHERE id_medico = p_id;
END$$

-- ---------- CITA ----------
DROP PROCEDURE IF EXISTS sp_insertar_cita$$
CREATE PROCEDURE sp_insertar_cita(
    IN p_id_paciente INT, IN p_id_medico INT, IN p_fecha_hora DATETIME,
    IN p_motivo VARCHAR(200), OUT p_id INT)
BEGIN
    INSERT INTO cita (id_paciente, id_medico, fecha_hora, motivo)
    VALUES (p_id_paciente, p_id_medico, p_fecha_hora, p_motivo);
    SET p_id = LAST_INSERT_ID();
END$$

DROP PROCEDURE IF EXISTS sp_actualizar_cita$$
CREATE PROCEDURE sp_actualizar_cita(
    IN p_id INT, IN p_fecha_hora DATETIME, IN p_motivo VARCHAR(200), IN p_estado VARCHAR(12))
BEGIN
    UPDATE cita SET fecha_hora=p_fecha_hora, motivo=p_motivo, estado=p_estado
     WHERE id_cita = p_id;
END$$

DROP PROCEDURE IF EXISTS sp_eliminar_cita$$
CREATE PROCEDURE sp_eliminar_cita(IN p_id INT)
BEGIN
    DELETE FROM cita WHERE id_cita = p_id;
END$$

DELIMITER ;
