CREATE DATABASE mundial_de_futbol;

USE mundial_de_futbol;

CREATE TABLE jugadores(
	dorsal INT(2),
	pais VARCHAR(30),
	nombre VARCHAR(30),
	tipo ENUM ('portero','jugador'),
	PRIMARY KEY(dorsal,pais)
	);
	
	
CREATE TABLE equipos(
	pais VARCHAR(30)PRIMARY KEY,
	sede VARCHAR(30)
	);
CREATE TABLE partidos(
	codigo VARCHAR(30)PRIMARY KEY,
	equipolocal VARCHAR(30),
	equipovisitante VARCHAR(30),
	estadio VARCHAR(30),
	goleslocal INT(2),
	golesvisitante INT(2),
	CONSTRAINT fk_pe1 FOREIGN KEY(equipovisitante) 
	REFERENCES equipos(pais),
	CONSTRAINT fk_pe2 FOREIGN KEY(equipolocal) 
	REFERENCES equipos(pais)
);

CREATE TABLE estadisticas(
	tipo VARCHAR(30),
	minuto INT(2),
	situacion VARCHAR(100),
	dorsal INT(2),
	pais VARCHAR(30),
	codigopartido VARCHAR(30),
	CONSTRAINT fk_ep FOREIGN KEY(codigopartido)
	REFERENCES partidos(codigo),
	CONSTRAINT fk_ej FOREIGN KEY (dorsal,pais)
	REFERENCES jugadores(dorsal,pais)
	);
	
CREATE TABLE arbitos(
	codigo VARCHAR(10)PRIMARY KEY,
	nombre VARCHAR(30),
	pais VARCHAR(30)
	);
	
CREATE TABLE arbitrajes(
	codigoarbrito VARCHAR(30),
	codigopartido VARCHAR(30),
	rol VARCHAR(30),
	PRIMARY KEY(codigoarbrito,codigopartido),
	CONSTRAINT fk_aa FOREIGN KEY(codigoarbitro)
	REFERENCES arbitos(codigo),
	CONSTRAINT fk_ap FOREIGN KEY(codigopartido)
	REFERENCES partidos(codigo)
	);
