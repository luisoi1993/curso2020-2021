CREATE DATABASE reyesmagos2;

USE reyesmagos2;

CREATE TABLE grupovecinos(
	nombre VARCHAR(30)PRIMARY KEY,
	barrio VARCHAR(30),
	nintegrantes INT(10)
	);

CREATE TABLE vecinos(
	DNI VARCHAR(10)PRIMARY KEY,
	nombre VARCHAR(30),
	apellidos VARCHAR(30),
	reymago VARCHAR(30),
	dnivecinocaptor VARCHAR(10),
	grupovecinos VARCHAR(30),
	CONSTRAINT fk_vg FOREIGN KEY(grupovecinos)
	REFERENCES grupovecinos(nombre),
	CONSTRAINT fk_vv FOREIGN KEY(dnivecinocaptor) 
	REFERENCES vecinos(dni)
	);
	
CREATE TABLE eventos(
	fechahora DATETIME,
	grupovecinos VARCHAR(30),
	ubicacion VARCHAR(50),
	PRIMARY KEY(fechahora,grupovecinos),
	CONSTRAINT fk_eg FOREIGN KEY(grupovecinos)
	REFERENCES grupovecinos(nombre)
	);

CREATE TABLE ninos(
	codigo VARCHAR(10)PRIMARY KEY,
	nombre VARCHAR(30),
	direccion VARCHAR(50),
	eventofechahora DATETIME,
	eventogrupovecinos VARCHAR(50),
	regalo VARCHAR(50),
	CONSTRAINT fk_ne FOREIGN KEY (eventofechahora,eventogrupovecinos)
	REFERENCES eventos(fechahora,grupovecinos)
	);
	