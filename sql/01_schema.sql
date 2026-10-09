-- =====================================================
-- FASE 1 - Script DDL - Clinica Medica SaludVital (3FN)
-- MySQL 8.0
-- =====================================================
DROP DATABASE IF EXISTS saludvital;
CREATE DATABASE saludvital CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE saludvital;

CREATE TABLE rol (
    id_rol   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre   VARCHAR(30)  NOT NULL,
    CONSTRAINT pk_rol PRIMARY KEY (id_rol),
    CONSTRAINT uq_rol_nombre UNIQUE (nombre)
) ENGINE=InnoDB;

CREATE TABLE usuario (
    id_usuario    INT UNSIGNED NOT NULL AUTO_INCREMENT,
    username      VARCHAR(40)  NOT NULL,
    password_hash CHAR(64)     NOT NULL,
    id_rol        INT UNSIGNED NOT NULL,
    activo        TINYINT(1)   NOT NULL DEFAULT 1,
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
    CONSTRAINT uq_usuario_username UNIQUE (username),
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol (id_rol)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE especialidad (
    id_especialidad INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(60)  NOT NULL,
    CONSTRAINT pk_especialidad PRIMARY KEY (id_especialidad),
    CONSTRAINT uq_especialidad_nombre UNIQUE (nombre)
) ENGINE=InnoDB;

CREATE TABLE medico (
    id_medico       INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombres         VARCHAR(60)  NOT NULL,
    apellidos       VARCHAR(60)  NOT NULL,
    no_colegiado    VARCHAR(20)  NOT NULL,
    telefono        VARCHAR(15),
    email           VARCHAR(80),
    id_especialidad INT UNSIGNED NOT NULL,
    id_usuario      INT UNSIGNED NULL,
    CONSTRAINT pk_medico PRIMARY KEY (id_medico),
    CONSTRAINT uq_medico_colegiado UNIQUE (no_colegiado),
    CONSTRAINT uq_medico_usuario UNIQUE (id_usuario),
    CONSTRAINT fk_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_medico_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE paciente (
    id_paciente      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    dpi              CHAR(13)     NOT NULL,
    nombres          VARCHAR(60)  NOT NULL,
    apellidos        VARCHAR(60)  NOT NULL,
    fecha_nacimiento DATE         NOT NULL,
    telefono         VARCHAR(15),
    email            VARCHAR(80),
    direccion        VARCHAR(150),
    CONSTRAINT pk_paciente PRIMARY KEY (id_paciente),
    CONSTRAINT uq_paciente_dpi UNIQUE (dpi)
) ENGINE=InnoDB;

CREATE TABLE cita (
    id_cita     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_paciente INT UNSIGNED NOT NULL,
    id_medico   INT UNSIGNED NOT NULL,
    fecha_hora  DATETIME     NOT NULL,
    motivo      VARCHAR(200) NOT NULL,
    estado      ENUM('PROGRAMADA','ATENDIDA','CANCELADA') NOT NULL DEFAULT 'PROGRAMADA',
    CONSTRAINT pk_cita PRIMARY KEY (id_cita),
    CONSTRAINT uq_cita_medico_hora UNIQUE (id_medico, fecha_hora),
    CONSTRAINT fk_cita_paciente FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cita_medico FOREIGN KEY (id_medico) REFERENCES medico (id_medico)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Indices de apoyo a consultas frecuentes
CREATE INDEX idx_paciente_apellidos ON paciente (apellidos, nombres);
CREATE INDEX idx_medico_apellidos   ON medico (apellidos, nombres);
CREATE INDEX idx_cita_fecha         ON cita (fecha_hora);
CREATE INDEX idx_cita_paciente      ON cita (id_paciente);
