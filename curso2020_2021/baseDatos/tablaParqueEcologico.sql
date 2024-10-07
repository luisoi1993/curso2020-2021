CREATE DATABASE parqueecologico;

USE parqueecologico;


CREATE TABLE biologos(
	codigo VARCHAR(20)PRIMARY KEY,
	nombre VARCHAR(30),
	direccion VARCHAR(50),
	provincia VARCHAR(30),
	f_titulacion VARCHAR(50)
	);
CREATE TABLE especies(
	nombre VARCHAR(30)PRIMARY KEY,
	caracteristicas VARCHAR(50),
	periodosmig VARCHAR(50)NOT NULL,
	codigobiologico VARCHAR(20),
	CONSTRAINT fk_eb FOREIGN KEY(codigobiologico)
	REFERENCES biologos(codigo)
	);
	
	
CREATE TABLE individuos(
	codigo VARCHAR(20),
	peso FLOAT(4,2),
	dimensiones VARCHAR(40),
	nombreespecie VARCHAR(40),
	CONSTRAINT fk_ie FOREIGN KEY(nombreespecie)
	REFERENCES especies(nombre)
	);
	

CREATE TABLE torretas(
	numero INT(5),
	latitud VARCHAR(30),
	longitud INT(5)
	);
	
CREATE TABLE pasos(
	codigoindividuo VARCHAR(20),
	numerotorreta INT(5),
	fechahora DATETIME,
	PRIMARY KEY(codigoindividuo,numerotorreta,fechahora),
	CONSTRAINT fk_pe FOREIGN KEY(codigoindividuo)
	REFERENCES especies(codigobiologico),
	CONSTRAINT fk_pt FOREIGN KEY(numerotorreta)
	REFERENCES torretas(numero)
	);