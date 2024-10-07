#borrar la base de dqtos padron
DROP DATABASE padron;

#1.Crea en MySQL la base de datos PADRON
CREATE DATABASE padron;

#2.Crea las tablas PROVIN Y EMPLEADO con las siguientes características y
#restricciones:
USE padron;

CREATE TABLE provincias(
	codprovincia INT(2)PRIMARY KEY,
	nombre_provincia VARCHAR(25)
);

CREATE TABLE empleados(
	nombre VARCHAR(25)PRIMARY KEY,
	edad INT(2),
	cod_provin INT(2),
	CONSTRAINT fk_ep FOREIGN KEY(cod_provin) REFERENCES provincias(codprovincia)
	ON DELETE  CASCADE ON UPDATE SET NULL
	);

#3.Creamos las tablas BLOQUESPISOS y ZONAS. Las columnas son las siguientes:
	
CREATE TABLE bloquepisos(
	calle VARCHAR(30),
	numero INT(3),
	piso INT(2),
	puerta CHAR(1),
	codigo_postal INT(5),
	metros INT(5),
	comentarios VARCHAR(60),
	cod_zona INT(2),
	dni VARCHAR(10),
	PRIMARY KEY(calle,numero,piso,puerta)
	);
	
CREATE TABLE zonas(
	dni VARCHAR(10)PRIMARY KEY,
	nombre VARCHAR(30),
	direccion VARCHAR(50),
	poblacion VARCHAR(40),
	codprovin INT(2),
	CONSTRAINT fk_zp FOREIGN KEY(codprovin) REFERENCES provincias(codprovincia)
	ON DELETE CASCADE ON UPDATE SET NULL
	);
	
#4.Elimina la restricción de clave foránea en la tabla EMPLEADOS.
use information_schema;

show TABLES;

describe key_column_usage;

select table_name,constraint_name from key_column_usage;

use padron;

alter table empleados change cod_provin cod_provin int(2);



alter table empleados add constraint fk_empleados foreign key (cod_provin) references provincias(codprovincia);


#5.Crea la tabla PERSONAS que contiene datos sobre las personas de una
#comunidad, con las siguientes características:

CREATE TABLE personas(
	dni VARCHAR(10)PRIMARY KEY,
	nombre VARCHAR(30),
	direccion VARCHAR(50),
	poblacion VARCHAR(40),
	codprovin INT(2),
	CONSTRAINT fk_pp FOREIGN KEY(codprovin) REFERENCES provincias(codprovincia)
	ON UPDATE SET NULL ON DELETE CASCADE
	);
	
#6.Borramos las restricciones de clave primaria y clave ajena en las tablas
#PERSONAS Y PROVINCIAS.
ALTER TABLE personas DROP FOREIGN KEY fk_pp;

ALTER TABLE personas DROP PRIMARY KEY;

ALTER TABLE provincias DROP PRIMARY KEY;
## No se puede porque es referenciada por la tabla EMPLEADOS

#7.Modificamos las tablas PERSONAS y PROVINCIAS dando nombre a las
#restricciones de clave primaria y clave ajena.
ALTER TABLE personas ADD CONSTRAINT fk_pp FOREIGN KEY(codprovin) REFERENCES provincias(codprovincia)
ON UPDATE SET NULL ON DELETE CASCADE;

