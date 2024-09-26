  
    create table ivr_module (
    ivr_module_id SERIAL PRIMARY KEY,
    module_sequence INT not null,
    module_name VARCHAR(255),
    module_duration INT not null,
    module_result VARCHAR(255) not null,
  
  );

  create table alumno (
    alumno_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) not null,
    apellido VARCHAR(255) not null,
    email VARCHAR(255) not null unique,
    telefono VARCHAR(20),
    fecha_nacimiento date,
    direccion VARCHAR(255),
    tipo_alumno VARCHAR(255)
  );

  create table bootcamp (
    bootcamp_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) not null,
    descripcion VARCHAR(255),
    duracion INTERVAL not null,
    fecha_inicio date not null,
    fecha_fin date not null
  );

  create table modulo (
    modulo_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) not null,
    descripcion VARCHAR(255),
    duracion INTERVAL not null,
    bootcamp_id int references bootcamp (bootcamp_id) on delete cascade
  );

  create table profesor (
    profesor_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) not null,
    apellido VARCHAR(255) not null,
    email VARCHAR(255) not null unique,
    telefono VARCHAR(20),
    especialidad VARCHAR(255)
  );

  create table inscripcion (
    inscripcion_id SERIAL PRIMARY KEY,
    alumno_id int references alumno (alumno_id),
    bootcamp_id int references bootcamp (bootcamp_id),
    fecha_inscripcion date not null,
    estado VARCHAR(255) not null
  );

  create table asignacion (
    asignacion_id SERIAL PRIMARY KEY,
    profesor_id int references profesor (profesor_id),
    modulo_id int references modulo (modulo_id),
    fecha_asignacion date not null
  );

  create table oferta (
    oferta_id SERIAL PRIMARY KEY,
    descripcion VARCHAR(255) not null,
    tipo_alumno VARCHAR(255) not null,
    descuento NUMERIC(5, 2),
    fecha_inicio date not null,
    fecha_fin date not null
  );

  create table alumno_oferta (
    alumno_oferta_id SERIAL PRIMARY KEY,
    alumno_id int references alumno (alumno_id),
    oferta_id int references oferta (oferta_id)
  );

  create table asistencia (
    asistencia_id SERIAL PRIMARY KEY,
    alumno_id int references alumno (alumno_id),
    modulo_id int references modulo (modulo_id),
    fecha_asistencia date not null,
    estado VARCHAR(255) not null
  );

  -- Insertar registros en la tabla alumno
  insert into alumno (nombre, apellido, email, telefono, fecha_nacimiento, direccion, tipo_alumno)
  values 
  ('Juan', 'Pérez', 'juan.perez@example.com', '600123456', '1990-01-01', 'Calle Falsa 123', 'Avanzado'),
  ('María', 'García', 'maria.garcia@example.com', '600123457', '1991-02-02', 'Avenida Siempre Viva 742', 'Media'),
  ('Carlos', 'Sánchez', 'carlos.sanchez@example.com', '600123458', '1992-03-03', 'Calle Luna 456', 'Principiante'),
  ('Ana', 'Martínez', 'ana.martinez@example.com', '600123459', '1993-04-04', 'Calle Sol 789', 'Avanzado'),
  ('Luis', 'López', 'luis.lopez@example.com', '600123460', '1994-05-05', 'Calle Estrella 101', 'Media'),
  ('Laura', 'González', 'laura.gonzalez@example.com', '600123461', '1995-06-06', 'Calle Cometa 202', 'Principiante'),
  ('Jorge', 'Rodríguez', 'jorge.rodriguez@example.com', '600123462', '1996-07-07', 'Calle Planeta 303', 'Avanzado'),
  ('Elena', 'Fernández', 'elena.fernandez@example.com', '600123463', '1997-08-08', 'Calle Galaxia 404', 'Media'),
  ('Miguel', 'Hernández', 'miguel.hernandez@example.com', '600123464', '1998-09-09', 'Calle Universo 505', 'Principiante'),
  ('Sara', 'Ruiz', 'sara.ruiz@example.com', '600123465', '1999-10-10', 'Calle Nebulosa 606', 'Avanzado'),
  ('David', 'Jiménez', 'david.jimenez@example.com', '600123466', '2000-11-11', 'Calle Asteroide 707', 'Media'),
  ('Paula', 'Díaz', 'paula.diaz@example.com', '600123467', '2001-12-12', 'Calle Meteorito 808', 'Principiante'),
  ('José', 'Moreno', 'jose.moreno@example.com', '600123468', '2002-01-13', 'Calle Satélite 909', 'Avanzado'),
  ('Marta', 'Álvarez', 'marta.alvarez@example.com', '600123469', '2003-02-14', 'Calle Estrella Fugaz 1010', 'Media'),
  ('Raúl', 'Castro', 'raul.castro@example.com', '600123470', '2004-03-15', 'Calle Constelación 1111', 'Principiante'),
  ('Lucía', 'Romero', 'lucia.romero@example.com', '600123471', '2005-04-16', 'Calle Vía Láctea 1212', 'Avanzado'),
  ('Pedro', 'Ortiz', 'pedro.ortiz@example.com', '600123472', '2006-05-17', 'Calle Andrómeda 1313', 'Media'),
  ('Carmen', 'Torres', 'carmen.torres@example.com', '600123473', '2007-06-18', 'Calle Orión 1414', 'Principiante'),
  ('Antonio', 'Vargas', 'antonio.vargas@example.com', '600123474', '2008-07-19', 'Calle Pegaso 1515', 'Avanzado'),
  ('Isabel', 'Ramos', 'isabel.ramos@example.com', '600123475', '2009-08-20', 'Calle Fénix 1616', 'Media');

  -- Insertar registros en la tabla bootcamp
  insert into bootcamp (nombre, descripcion, duracion, fecha_inicio, fecha_fin)
  values 
  ('Full Stack Developer', 'Bootcamp intensivo de desarrollo web', INTERVAL '12 weeks', '2023-01-01', '2023-03-31'),
  ('Data Science', 'Bootcamp de ciencia de datos', INTERVAL '10 weeks', '2023-02-01', '2023-04-30'),
  ('Cybersecurity', 'Bootcamp de ciberseguridad', INTERVAL '8 weeks', '2023-03-01', '2023-05-31'),
  ('UX/UI Design', 'Bootcamp de diseño UX/UI', INTERVAL '6 weeks', '2023-04-01', '2023-06-30'),
  ('DevOps', 'Bootcamp de DevOps', INTERVAL '5 weeks', '2023-05-01', '2023-07-31'),
  ('AI & Machine Learning', 'Bootcamp de inteligencia artificial y machine learning', INTERVAL '7 weeks', '2023-06-01', '2023-08-31'),
  ('Mobile Development', 'Bootcamp de desarrollo móvil', INTERVAL '9 weeks', '2023-07-01', '2023-09-30'),
  ('Cloud Computing', 'Bootcamp de computación en la nube', INTERVAL '11 weeks', '2023-08-01', '2023-10-31'),
  ('Blockchain', 'Bootcamp de blockchain', INTERVAL '10 weeks', '2023-09-01', '2023-11-30'),
  ('Game Development', 'Bootcamp de desarrollo de videojuegos', INTERVAL '12 weeks', '2023-10-01', '2023-12-31'),
  ('Big Data', 'Bootcamp de big data', INTERVAL '8 weeks', '2023-11-01', '2024-01-31'),
  ('IoT', 'Bootcamp de Internet de las cosas', INTERVAL '6 weeks', '2023-12-01', '2024-02-28'),
  ('AR/VR', 'Bootcamp de realidad aumentada y virtual', INTERVAL '7 weeks', '2024-01-01', '2024-03-31'),
  ('Robotics', 'Bootcamp de robótica', INTERVAL '9 weeks', '2024-02-01', '2024-04-30'),
  ('Quantum Computing', 'Bootcamp de computación cuántica', INTERVAL '10 weeks', '2024-03-01', '2024-05-31'),
  ('Digital Marketing', 'Bootcamp de marketing digital', INTERVAL '5 weeks', '2024-04-01', '2024-06-30'),
  ('E-commerce', 'Bootcamp de comercio electrónico', INTERVAL '6 weeks', '2024-05-01', '2024-07-31'),
  ('Fintech', 'Bootcamp de tecnología financiera', INTERVAL '8 weeks', '2024-06-01', '2024-08-31'),
  ('Health Tech', 'Bootcamp de tecnología en salud', INTERVAL '7 weeks', '2024-07-01', '2024-09-30'),
  ('EdTech', 'Bootcamp de tecnología educativa', INTERVAL '9 weeks', '2024-08-01', '2024-10-31');


  -- Insertar registros en la tabla modulo
  insert into modulo (nombre, descripcion, duracion, bootcamp_id)
  values 
  ('HTML & CSS', 'Módulo de HTML y CSS', INTERVAL '2 weeks', 1),
  ('JavaScript', 'Módulo de JavaScript', INTERVAL '3 weeks', 1),
  ('Python', 'Módulo de Python', INTERVAL '4 weeks', 2),
  ('R', 'Módulo de R', INTERVAL '3 weeks', 2),
  ('Network Security', 'Módulo de seguridad de redes', INTERVAL '2 weeks', 3),
  ('Ethical Hacking', 'Módulo de hacking ético', INTERVAL '3 weeks', 3),
  ('User Research', 'Módulo de investigación de usuarios', INTERVAL '2 weeks', 4),
  ('Prototyping', 'Módulo de prototipado', INTERVAL '2 weeks', 4),
  ('CI/CD', 'Módulo de integración y entrega continua', INTERVAL '2 weeks', 5),
  ('Containerization', 'Módulo de contenedores', INTERVAL '3 weeks', 5),
  ('Machine Learning', 'Módulo de machine learning', INTERVAL '4 weeks', 6),
  ('Deep Learning', 'Módulo de deep learning', INTERVAL '3 weeks', 6),
  ('Android Development', 'Módulo de desarrollo Android', INTERVAL '4 weeks', 7),
  ('iOS Development', 'Módulo de desarrollo iOS', INTERVAL '4 weeks', 7),
  ('AWS', 'Módulo de AWS', INTERVAL '3 weeks', 8),
  ('Azure', 'Módulo de Azure', INTERVAL '3 weeks', 8),
  ('Smart Contracts', 'Módulo de contratos inteligentes', INTERVAL '3 weeks', 9),
  ('DApps', 'Módulo de aplicaciones descentralizadas', INTERVAL '3 weeks', 9),
  ('Unity', 'Módulo de Unity', INTERVAL '4 weeks', 10),
  ('Unreal Engine', 'Módulo de Unreal Engine', INTERVAL '4 weeks', 10);

  -- Insertar registros en la tabla profesor
  insert into profesor (nombre, apellido, email, telefono, especialidad)
  values 
  ('Alberto', 'Gómez', 'alberto.gomezz@example.com', '600123476', 'Desarrollo Web'),
  ('Beatriz', 'Navarro', 'beatriz.navarro@example.com', '600123477', 'Ciencia de Datos'),
  ('Carlos', 'Molina', 'carlos.molina@example.com', '600123478', 'Ciberseguridad'),
  ('Diana', 'Santos', 'diana.santos@example.com', '600123479', 'Diseño UX/UI'),
  ('Eduardo', 'Ramos', 'eduardo.ramos@example.com', '600123480', 'DevOps'),
  ('Fernanda', 'Lara', 'fernanda.lara@example.com', '600123481', 'Inteligencia Artificial'),
  ('Gustavo', 'Paredes', 'gustavo.paredes@example.com', '600123482', 'Desarrollo Móvil'),
  ('Helena', 'Vega', 'helena.vega@example.com', '600123483', 'Computación en la Nube'),
  ('Ignacio', 'Cruz', 'ignacio.cruz@example.com', '600123484', 'Blockchain'),
  ('Julia', 'Flores', 'julia.flores@example.com', '600123485', 'Desarrollo de Videojuegos'),
  ('Karla', 'Mendoza', 'karla.mendoza@example.com', '600123486', 'Big Data'),
  ('Luis', 'Silva', 'luis.silva@example.com', '600123487', 'IoT'),
  ('Marta', 'Reyes', 'marta.reyes@example.com', '600123488', 'Realidad Aumentada y Virtual'),
  ('Nicolás', 'Ortega', 'nicolas.ortega@example.com', '600123489', 'Robótica'),
  ('Olga', 'Pérez', 'olga.perez@example.com', '600123490', 'Computación Cuántica'),
  ('Pablo', 'García', 'pablo.garcia@example.com', '600123491', 'Marketing Digital'),
  ('Quintín', 'López', 'quintin.lopez@example.com', '600123492', 'Comercio Electrónico'),
  ('Rosa', 'Martín', 'rosa.martin@example.com', '600123493', 'Tecnología Financiera'),
  ('Sergio', 'Díaz', 'sergio.diaz@example.com', '600123494', 'Tecnología en Salud'),
  ('Teresa', 'Gutiérrez', 'teresa.gutierrez@example.com', '600123495', 'Tecnología Educativa');

  -- Insertar registros en la tabla inscripcion
  insert into inscripcion (alumno_id, bootcamp_id, fecha_inscripcion, estado)
  values 
  (1, 1, '2023-01-01', 'Inscrito'),
  (2, 2, '2023-02-01', 'Inscrito'),
  (3, 3, '2023-03-01', 'Inscrito'),
  (4, 4, '2023-04-01', 'Inscrito'),
  (5, 5, '2023-05-01', 'Inscrito'),
  (6, 6, '2023-06-01', 'Inscrito'),
  (7, 7, '2023-07-01', 'Inscrito'),
  (8, 8, '2023-08-01', 'Inscrito'),
  (9, 9, '2023-09-01', 'Inscrito'),
  (10, 10, '2023-10-01', 'Inscrito'),
  (11, 11, '2023-11-01', 'Inscrito'),
  (12, 12, '2023-12-01', 'Inscrito'),
  (13, 13, '2024-01-01', 'Inscrito'),
  (14, 14, '2024-02-01', 'Inscrito'),
  (15, 15, '2024-03-01', 'Inscrito'),
  (16, 16, '2024-04-01', 'Inscrito'),
  (17, 17, '2024-05-01', 'Inscrito'),
  (18, 18, '2024-06-01', 'Inscrito'),
  (19, 19, '2024-07-01', 'Inscrito'),
  (20, 20, '2024-08-01', 'Inscrito');

  -- Insertar registros en la tabla asignacion
  insert into asignacion (profesor_id, modulo_id, fecha_asignacion)
  values 
  (1, 1, '2023-01-01'),
  (2, 2, '2023-02-01'),
  (3, 3, '2023-03-01'),
  (4, 4, '2023-04-01'),
  (5, 5, '2023-05-01'),
  (6, 6, '2023-06-01'),
  (7, 7, '2023-07-01'),
  (8, 8, '2023-08-01'),
  (9, 9, '2023-09-01'),
  (10, 10, '2023-10-01'),
  (11, 11, '2023-11-01'),
  (12, 12, '2023-12-01'),
  (13, 13, '2024-01-01'),
  (14, 14, '2024-02-01'),
  (15, 15, '2024-03-01'),
  (16, 16, '2024-04-01'),
  (17, 17, '2024-05-01'),
  (18, 18, '2024-06-01'),
  (19, 19, '2024-07-01'),
  (20, 20, '2024-08-01');

  -- Insertar registros en la tabla oferta
insert into oferta (descripcion, tipo_alumno, descuento, fecha_inicio, fecha_fin)
values 
  ('Descuento de verano', 'Regular', 10.00, '2023-06-01', '2023-08-31'),
  ('Descuento de invierno', 'Regular', 15.00, '2023-12-01', '2024-02-28'),
  ('Descuento de primavera', 'Regular', 20.00, '2024-03-01', '2024-05-31'),
  ('Descuento de otoño', 'Regular', 25.00, '2024-09-01', '2024-11-30'),
  ('Descuento de Navidad', 'Regular', 30.00, '2023-12-15', '2024-01-15'),
  ('Descuento de Año Nuevo', 'Regular', 35.00, '2024-01-01', '2024-01-31'),
  ('Descuento de Pascua', 'Regular', 40.00, '2024-04-01', '2024-04-30'),
  ('Descuento de Halloween', 'Regular', 45.00, '2024-10-01', '2024-10-31'),
  ('Descuento de Black Friday', 'Regular', 50.00, '2024-11-01', '2024-11-30'),
  ('Descuento de verano', 'Regular', 10.00, '2024-06-01', '2024-08-31'),
  ('Descuento de invierno', 'Regular', 15.00, '2024-12-01', '2025-02-28'),
  ('Descuento de primavera', 'Regular', 20.00, '2025-03-01', '2025-05-31'),
  ('Descuento de otoño', 'Regular', 25.00, '2025-09-01', '2025-11-30'),
  ('Descuento de Navidad', 'Regular', 30.00, '2024-12-15', '2025-01-15'),
  ('Descuento de Año Nuevo', 'Regular', 35.00, '2025-01-01', '2025-01-31'),
  ('Descuento de San Valentín', 'Regular', 20.00, '2025-02-01', '2025-02-14'),
  ('Descuento de Semana Santa', 'Regular', 25.00, '2025-04-01', '2025-04-15'),
  ('Descuento de Verano', 'Regular', 30.00, '2025-06-01', '2025-08-31'),
  ('Descuento de Otoño', 'Regular', 35.00, '2025-09-01', '2025-11-30'),
  ('Descuento de Acción de Gracias', 'Regular', 40.00, '2025-11-01', '2025-11-30'),
  ('Descuento de Fin de Año', 'Regular', 45.00, '2025-12-01', '2025-12-31'),
  ('Descuento de Año Nuevo', 'Regular', 50.00, '2026-01-01', '2026-01-31');


  -- Insertar registros en la tabla asistencia
  insert into asistencia (alumno_id, modulo_id, fecha_asistencia, estado)
  values 
  (1, 1, '2023-01-01', 'Presente'),
  (2, 2, '2023-02-01', 'Presente'),
  (3, 3, '2023-03-01', 'Ausente'),
  (4, 4, '2023-04-01', 'Presente'),
  (5, 5, '2023-05-01', 'Ausente'),
  (6, 6, '2023-06-01', 'Presente'),
  (7, 7, '2023-07-01', 'Ausente'),
  (8, 8, '2023-08-01', 'Presente'),
  (9, 9, '2023-09-01', 'Ausente'),
  (10, 10, '2023-10-01', 'Presente'),
  (11, 11, '2023-11-01', 'Ausente'),
  (12, 12, '2023-12-01', 'Presente'),
  (13, 13, '2024-01-01', 'Ausente'),
  (14, 14, '2024-02-01', 'Presente'),
  (15, 15, '2024-03-01', 'Ausente'),
  (16, 16, '2024-04-01', 'Presente'),
  (17, 17, '2024-05-01', 'Ausente'),
  (18, 18, '2024-06-01', 'Presente'),
  (19, 19, '2024-07-01', 'Ausente'),
  (20, 20, '2024-08-01', 'Presente');


  -- Insertar registros en la tabla alumno_oferta
  insert into alumno_oferta (alumno_id, oferta_id)
  values 
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7),
  (8, 8),
  (9, 9),
  (10, 10),
  (11, 11),
  (12, 12),
  (13, 13),
  (14, 14),
  (15, 15),
  (16, 16),
  (17, 17),
  (18, 18),
  (19, 19),
  (20, 20);

