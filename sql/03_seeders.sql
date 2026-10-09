-- =====================================================
-- FASE 1 - Datos de prueba (>= 5 registros por tabla)
-- =====================================================
USE saludvital;

INSERT INTO rol (nombre) VALUES ('ADMIN'),('MEDICO'),('RECEPCION'),('ENFERMERIA'),('AUDITOR');

INSERT INTO usuario (username, password_hash, id_rol) VALUES
('admin',    SHA2('Admin123!',256), 1),
('drlopez',  SHA2('Medico123!',256), 2),
('drperez',  SHA2('Medico123!',256), 2),
('recep1',   SHA2('Recep123!',256), 3),
('enfer1',   SHA2('Enfer123!',256), 4),
('auditor1', SHA2('Audit123!',256), 5);

INSERT INTO especialidad (nombre) VALUES
('Medicina General'),('Pediatria'),('Cardiologia'),('Dermatologia'),('Ginecologia');

INSERT INTO medico (nombres, apellidos, no_colegiado, telefono, email, id_especialidad, id_usuario) VALUES
('Carlos','Lopez','COL-1001','50255501001','clopez@saludvital.com',1,2),
('Maria','Perez','COL-1002','50255501002','mperez@saludvital.com',2,3),
('Jose','Ramirez','COL-1003','50255501003','jramirez@saludvital.com',3,NULL),
('Ana','Morales','COL-1004','50255501004','amorales@saludvital.com',4,NULL),
('Lucia','Castillo','COL-1005','50255501005','lcastillo@saludvital.com',5,NULL);

INSERT INTO paciente (dpi, nombres, apellidos, fecha_nacimiento, telefono, email, direccion) VALUES
('2001000010101','Pedro','Gomez','1985-03-12','50240001001','pgomez@mail.com','Zona 1, Guatemala'),
('2001000020101','Sofia','Hernandez','1992-07-25','50240001002','shernandez@mail.com','Zona 10, Guatemala'),
('2001000030101','Luis','Garcia','1978-11-02','50240001003','lgarcia@mail.com','Mixco, Guatemala'),
('2001000040101','Elena','Mendez','2015-05-18','50240001004','emendez@mail.com','Villa Nueva'),
('2001000050101','Diego','Alvarez','2000-01-30','50240001005','dalvarez@mail.com','Zona 7, Guatemala'),
('2001000060101','Rosa','Santos','1966-09-09','50240001006','rsantos@mail.com','Zona 12, Guatemala');

INSERT INTO cita (id_paciente, id_medico, fecha_hora, motivo, estado) VALUES
(1,1,'2026-10-12 08:00:00','Chequeo general','PROGRAMADA'),
(2,2,'2026-10-12 09:00:00','Control pediatrico','PROGRAMADA'),
(3,3,'2026-10-13 10:30:00','Dolor toracico','PROGRAMADA'),
(4,2,'2026-10-13 11:00:00','Vacunacion','ATENDIDA'),
(5,4,'2026-10-14 14:00:00','Revision de piel','PROGRAMADA'),
(6,5,'2026-10-15 15:30:00','Control anual','CANCELADA');
