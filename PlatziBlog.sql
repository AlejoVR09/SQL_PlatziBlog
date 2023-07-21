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



SELECT * FROM usuarios;

DROP TABLE usuarios;
DROP TABLE etiquetas;
DROP TABLE categorias;


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