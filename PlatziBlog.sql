/*
We are using DDL for creating the database, then the 
*/
create database PlatziBlog;
use PlatziBlog;

/*
I'm gonna create the independent tables, the ones that don't have any direct relation with any other table, or, the ones that don't have
references of any other table
*/

/*
Contraints are restrintions for a field to be created,
NOT NULL means that the field can't be empty,
UNIQUE means that the field value must no be repeated,
PRIMARY KEY means NOT NULL and UNIQUE,
FOREIGN KEY is a references to a other's table PRIMARY KEY,
FK has options for ON DELETE and ON UPDATE in a record, CASCADE means that if an action is made in a PK the refences to this one
will be updated or deleted,
*/

-- we can use constraints directly in the fields
CREATE TABLE usuarios (
	id int PRIMARY KEY AUTO_INCREMENT,
	login varchar(30) NOT NULL,
	`password` varchar(50) NOT NULL,
	nickname varchar(40) NOT NULL,
	email varchar(40) NOT NULL UNIQUE
);

-- or using the command constraint for conditionating a field
/*
CREATE TABLE usuarios (
	id int NOT NULL AUTO_INCREMENT,
	login varchar(30) NOT NULL,
	password varchar(32) NOT NULL,
	nickname varchar(40) NOT NULL,
	email varchar(40) NOT NULL,
	CONSTRAINT PRIMARY KEY (id),
	UNIQUE KEY `email_UNIQUE` (email)
);


*/

CREATE TABLE `categorias` (
	`id` int PRIMARY KEY AUTO_INCREMENT,
	`nombre_categoria` varchar(30) NOT NULL
);

/*
CREATE TABLE `categorias` (
	`id` int NOT NULL AUTO_INCREMENT,
	`nombre_categoria` varchar(30) NOT NULL,
	PRIMARY KEY (id)
)
*/

CREATE TABLE etiquetas (
	id int PRIMARY KEY AUTO_INCREMENT,
	nombre_etiqueta varchar(30) NOT NULL
);

/*
CREATE TABLE etiquetas (
	id int NOT NULL AUTO_INCREMENT,
	nombre_etiqueta varchar(30) NOT NULL,
	PRIMARY KEY (id)
);
*/
-- Dependent tables, this ones have refereces for independent tables what creates relationships between tables
CREATE TABLE posts (
	id int PRIMARY KEY AUTO_INCREMENT,
	titulo varchar(130) NOT NULL,
	fecha_publicacion timestamp NULL DEFAULT NULL,
	contenido text NOT NULL,
	estatus char(8) DEFAULT 'activo',
	usuario_id int DEFAULT NULL,
	categoria_id int DEFAULT NULL,
	FOREIGN KEY (categoria_id) REFERENCES categorias (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE NO ACTION ON UPDATE CASCADE
);

/*
CREATE TABLE posts (
	id int NOT NULL AUTO_INCREMENT,
	titulo varchar(130) NOT NULL,
	fecha_publicacion timestamp NULL DEFAULT NULL,
	contenido text NOT NULL,
	estatus char(8) DEFAULT 'activo',
	usuario_id int DEFAULT NULL,
	categoria_id int DEFAULT NULL,
	PRIMARY KEY (id),
	KEY posts_usuarios_idx (usuario_id),
	KEY posts_categorias_idx (categoria_id),
	CONSTRAINT posts_categorias FOREIGN KEY (categoria_id) REFERENCES categorias (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT posts_usuarios FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE NO ACTION ON UPDATE CASCADE
);
*/

CREATE TABLE comentarios (
	id int PRIMARY KEY AUTO_INCREMENT,
	cuerpo_comentario text NOT NULL,
	usuario_id int NOT NULL,
	post_id int NOT NULL,
	FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*
CREATE TABLE comentarios (
	id int NOT NULL AUTO_INCREMENT,
	cuerpo_comentario text NOT NULL,
	usuario_id int NOT NULL,
	post_id int NOT NULL,
	PRIMARY KEY (id),
	KEY comentarios_usuario_idx (usuario_id),
	KEY comentarios_post_idx (post_id),
	CONSTRAINT comentarios_post FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT comentarios_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
*/

CREATE TABLE posts_etiquetas (
	id int PRIMARY KEY AUTO_INCREMENT,
	post_id int NOT NULL,
	etiqueta_id int NOT NULL,
	FOREIGN KEY (etiqueta_id) REFERENCES etiquetas (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*
CREATE TABLE posts_etiquetas (
	id int NOT NULL AUTO_INCREMENT,
	post_id int(11) NOT NULL,
	etiqueta_id int(11) NOT NULL,
	PRIMARY KEY (id),
	KEY postsetiquetas_post_idx (post_id),
	KEY postsetiquetas_etiquetas_idx (etiqueta_id),
	CONSTRAINT postsetiquetas_etiquetas FOREIGN KEY (etiqueta_id) REFERENCES etiquetas (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT postsetiquetas_post FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
*/

-- insert of dummy data for making future queries

-- insert into table usuaios
INSERT INTO usuarios (login, `password`, nickname, email) VALUES
  ('user001', '5f4dcc3b5aa765d61d8327deb882cf99', 'User One', 'user1@example.com'),
  ('johnDoe', 'e99a18c428cb38d5f260853678922e03', 'John Doe', 'john.doe@example.com'),
  ('janeSmith', '25f9e794323b453885f5181f1b624d0b', 'Jane Smith', 'jane.smith@example.com'),
  ('admin', '21232f297a57a5a743894a0e4a801fc3', 'Admin User', 'admin@example.com'),
  ('mikeJohnson', '0192023a7bbd73250516f069df18b500', 'Mike Johnson', 'mike.johnson@example.com'),
  ('sarahLee', '1234567890', 'Sarah Lee', 'sarah.lee@example.com'),
  ('coolUser', '098f6bcd4621d373cade4e832627b4f6', 'Cool User', 'cool.user@example.com'),
  ('user002', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'User Two', 'user2@example.com'),
  ('kateSmith', '098f6bcd4621d373cade4e832627b4f6', 'Kate Smith', 'kate.smith@example.com'),
  ('peterJohnson', '5f4dcc3b5aa765d61d8327deb882cf99', 'Peter Johnson', 'peter.johnson@example.com');

-- insert into table categorias
INSERT INTO categorias (nombre_categoria) VALUES
  ('Tecnología'),
  ('Moda'),
  ('Hogar'),
  ('Deportes'),
  ('Alimentación'),
  ('Salud'),
  ('Viajes'),
  ('Entretenimiento'),
  ('Educación'),
  ('Automóviles');

-- insert into table etiquetas
INSERT INTO etiquetas (nombre_etiqueta) VALUES
  ('Nuevo'),
  ('Oferta'),
  ('Rebajas'),
  ('Verano'),
  ('Invierno'),
  ('Fitness'),
  ('Vegano'),
  ('Aventura'),
  ('Concierto'),
  ('Cocina');

-- Dummy data of posts
INSERT INTO posts (titulo, fecha_publicacion, contenido, estatus, usuario_id, categoria_id) VALUES
  ('Nuevas tendencias en tecnología', '2023-05-15 08:30:00', 'Hoy hablaremos sobre las últimas tendencias tecnológicas...', 'activo', 1, 1),
  ('Consejos para una vida saludable', '2023-05-16 12:15:00', 'En este post, compartiremos algunos consejos para llevar una vida más saludable...', 'activo', 2, 6),
  ('Las mejores ofertas de verano', '2023-05-17 16:45:00', 'No te pierdas estas increíbles ofertas de verano...', 'activo', 3, 2),
  ('Recetas veganas deliciosas', '2023-05-18 10:00:00', 'Descubre estas deliciosas recetas veganas para toda la familia...', 'activo', 4, 5),
  ('Los destinos más asombrosos para viajar', '2023-05-19 14:20:00', 'Estos destinos te dejarán sin aliento...', 'activo', 5, 7),
  ('Consejos para mejorar tu rendimiento deportivo', '2023-05-20 11:30:00', 'Si te apasiona el deporte, no te pierdas estos consejos para mejorar tu rendimiento...', 'activo', 6, 4),
  ('Ideas para decorar tu hogar', '2023-05-21 09:00:00', 'Transforma tu hogar con estas fantásticas ideas de decoración...', 'activo', 7, 3),
  ('Los mejores eventos de entretenimiento', '2023-05-22 19:30:00', 'Descubre los eventos más emocionantes y divertidos de la ciudad...', 'activo', 8, 8),
  ('Aprende a cocinar como un chef', '2023-05-23 15:10:00', 'En este post, aprenderás algunos trucos de cocina para impresionar a tus invitados...', 'activo', 9, 10),
  ('Consejos financieros para el futuro', '2023-05-24 13:00:00', 'Planifica tu futuro financiero con estos consejos prácticos...', 'activo', 10, 2),
  ('Consejos financieros para el futuro', '2023-05-24 13:00:00', 'Planifica tu futuro financiero con estos consejos prácticos...', 'inactivo', 10, 2),
('Nuevas tendencias en tecnología', '2022-03-15 08:30:00', 'Hoy hablaremos sobre las últimas tendencias tecnológicas...', 'activo', 1, 1),
  ('Consejos para una vida saludable', '2023-05-16 12:15:00', 'En este post, compartiremos algunos consejos para llevar una vida más saludable...', 'activo', 2, 6),
  ('Las mejores ofertas de verano', '2021-07-10 16:45:00', 'No te pierdas estas increíbles ofertas de verano...', 'activo', 3, 2),
  ('Recetas veganas deliciosas', '2022-11-20 10:00:00', 'Descubre estas deliciosas recetas veganas para toda la familia...', 'activo', 4, 5),
  ('Los destinos más asombrosos para viajar', '2023-09-05 14:20:00', 'Estos destinos te dejarán sin aliento...', 'activo', 5, 7),
  ('Consejos para mejorar tu rendimiento deportivo', '2021-06-30 11:30:00', 'Si te apasiona el deporte, no te pierdas estos consejos para mejorar tu rendimiento...', 'activo', 6, 4),
  ('Ideas para decorar tu hogar', '2023-04-18 09:00:00', 'Transforma tu hogar con estas fantásticas ideas de decoración...', 'activo', 7, 3),
  ('Los mejores eventos de entretenimiento', '2022-08-22 19:30:00', 'Descubre los eventos más emocionantes y divertidos de la ciudad...', 'activo', 8, 8),
  ('Aprende a cocinar como un chef', '2021-12-12 15:10:00', 'En este post, aprenderás algunos trucos de cocina para impresionar a tus invitados...', 'activo', 9, 10),
  ('Consejos financieros para el futuro', '2023-01-25 13:00:00', 'Planifica tu futuro financiero con estos consejos prácticos...', 'activo', 10, 2);
-- Dummy data of etiquetas
INSERT INTO etiquetas (nombre_etiqueta) VALUES
  ('Tecnología'),
  ('Moda'),
  ('Hogar'),
  ('Deportes'),
  ('Alimentación'),
  ('Salud'),
  ('Viajes'),
  ('Entretenimiento'),
  ('Educación'),
  ('Automóviles');

-- Dummy data of this trannsitive table
INSERT INTO posts_etiquetas (post_id, etiqueta_id) VALUES
  (1, 1),
  (1, 2),
  (2, 6),
  (3, 3),
  (3, 8),
  (4, 5),
  (5, 7),
  (5, 9),
  (6, 4),
  (7, 3);

-- Dummy data of comentarios
INSERT INTO comentarios (cuerpo_comentario, usuario_id, post_id) VALUES
  ('Excelente artículo, gracias por compartir esta información.', 1, 1),
  ('Estoy de acuerdo contigo, el tema de la salud es fundamental.', 2, 2),
  ('Las ofertas son increíbles, no puedo esperar para ir de compras.', 3, 3),
  ('Gracias por las recetas, voy a probarlas este fin de semana.', 4, 4),
  ('Los destinos son impresionantes, ya quiero planificar mi próximo viaje.', 5, 5),
  ('Estos consejos me han ayudado a mejorar mi rendimiento en el deporte.', 6, 6),
  ('Me encanta cómo decoraste tu hogar, ¡se ve hermoso!', 7, 7),
  ('El evento de entretenimiento fue increíble, ¡gracias por el dato!', 8, 8),
  ('He preparado la receta y a todos les encantó, ¡gracias por compartir!', 9, 9),
  ('Estos consejos financieros me han sido de gran ayuda, ¡gracias!', 10, 10);

SELECT * FROM usuarios;
SELECT * FROM posts;
SELECT * FROM comentarios;
SELECT * FROM etiquetas;
SELECT * FROM categorias;

-- GROUP BY Queries
-- show how many posts are 'activo' or 'inactivo'
SELECT estatus, COUNT(*) AS post_number
FROM posts
GROUP BY estatus;

-- show how many posts were created in current and past years
SELECT	YEAR(fecha_publicacion) AS post_year, COUNT(*) AS post_number
FROM posts
GROUP BY post_year;

-- show how many posts are created per month
SELECT	MONTHNAME(fecha_publicacion) AS post_month, COUNT(*) AS post_number
FROM posts
GROUP BY post_month;

-- combine the status and monthname for showing how many per month are 'activo' or 'inactivo' 
SELECT	estatus, MONTHNAME(fecha_publicacion) AS post_date, COUNT(*) AS post_number
FROM	posts
GROUP BY estatus, post_date;

-- ORDER BY Queries

-- It shows the posts order by the date they were created
SELECT	*
FROM posts
ORDER BY fecha_publicacion ASC;

-- shows the same than above but in descendent way
SELECT	*
FROM posts
ORDER BY fecha_publicacion DESC;

-- order the posts by the tittle
SELECT	*
FROM posts
ORDER BY titulo ASC;

-- the same than above but descendant
SELECT	*
FROM posts
ORDER BY titulo DESC;

-- it limits the records shown in 5
SELECT	*
FROM posts
ORDER BY usuario_id ASC
LIMIT 5;

-- this query group the records by the status and month they were created, and order them by the month
SELECT	MONTHNAME(fecha_publicacion) AS post_month, estatus, COUNT(*) AS post_quantity
FROM posts
GROUP BY estatus, post_month
ORDER BY post_month;

-- HAVING Queries

-- having is useful for dinamic fields like the one that use MONTHNAME or COUNT

-- this one is and example that shows an error
SELECT	MONTHNAME(fecha_publicacion) AS post_month, estatus, COUNT(*) AS post_quantity
FROM posts
WHERE post_quantity > 1
GROUP BY estatus, post_month
ORDER BY post_month;

-- it shows the months that have more than 1 post created
SELECT	MONTHNAME(fecha_publicacion) AS post_month, estatus, COUNT(*) AS post_quantity
FROM posts
GROUP BY estatus, post_month
HAVING post_quantity > 1
ORDER BY post_month;

SELECT new_table_projection.date, COUNT(*) AS posts_count
FROM (
    SELECT DATE(MIN(fecha_publicacion)) AS date, YEAR(fecha_publicacion) AS post_year
    FROM posts
    GROUP BY post_year
) AS new_table_projection
GROUP BY new_table_projection.date 
ORDER BY new_table_projection.date;

SELECT *
FROM posts
WHERE fecha_publicacion = (
	SELECT MAX(fecha_publicacion)
	FROM posts
);

SELECT MAX(fecha_publicacion)
FROM posts;


DROP TABLE usuarios;
DROP TABLE etiquetas;
DROP TABLE categorias;
DROP TABLE posts;


/*
Exercises 
Debes crear una tabla de datos que permita almacenar información sobre personas, llamada people. La tabla tendrá cinco campos: person_id, last_name, first_name, address, y city.

La columna person_id debe ser de tipo entero y debe la llave primaria de la tabla y debe ser autoincremental y recuerda no permitir valores NULOS.
La columna last_name debe ser de tipo texto y debe tener un tamaño máximo de 255 caracteres y permita valores NULOS.
La columna first_name debe ser de tipo texto y debe tener un tamaño máximo de 255 caracteres y permita valores NULOS.
La columna address debe ser de tipo texto y debe tener un tamaño máximo de 255 caracteres y permita valores NULOS.
La columna city debe ser de tipo texto y debe tener un tamaño máximo de 255 caracteres y permita valores NULOS.

create table people (
  person_id INTEGER PRIMARY KEY AUTOINCREMENT not null,
  last_name VARCHAR(255) null,
  first_name VARCHAR(255) null,
  address VARCHAR(255) null,
  city VARCHAR(255) null
  );
  
  
Para resolver este desafio debes crear una tabla comentarios, agregar al menos 3 comentarios, 
imprimir todos los comentarios de la tabla y finalmente imprimir los comentarios de un usuario especial con un formato en específico.

Reto 1: crear la tabla
Crea una tabla comentarios con las columnas id, cuerpo_comentario, usuario_id y post_id.

create table comentarios (
	id int primary key auto_increment,
    cuerpo_comentario text,
    usuario_id int,
    post_id int,
    foreign key (usuarios_id) references usuarios.id,
    foreign key (posts_id) references posts.id
);


Reto 2: agrega registros
Inserta al menos 3 comentarios en la tabla. Puedes escribir tantos comentarios como quieras. Asegúrate de que solo en 2 el usuario_id sea 1.
INSERT INTO comentarios (id, cuerpo_comentario, usuario_id, post_id)
VALUES (1000, "Me gustó mucho este post", 1, 43),
(1001, "Por favor hagan más", 1, 43),
(1002, "Nah, no habrá autos así en mucho tiempo", 2, 63);

Reto 3: imprime registros
Imprime todas las columnas de todos los registros de la tabla comentarios.
SELECT * FROM comentarios;

Reto 4: imprime registros del usuario 1
Selecciona los 2 comentarios del usuario 1. Haz un JOIN para conseguir la información del post relacionado con la propiedad post_id y 
el usuario rerlacionado con la propiedad usuario_id. Imprime la propiedad comentarios.cuerpo_comentario como comentario, usuarios.login 
como usuario y posts.titulo como post.
SELECT 
  posts.titulo AS post,
  usuarios.login AS usuario,
  comentarios.cuerpo_comentario AS comentario 
FROM comentarios
inner join posts on comentarios.posts_id=posts.id
inner join usuarios on comentarios.usuarios_id=usuarios.id
where usuarios.id=1;
*/