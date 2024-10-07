#Practica 15.

#1.Crea la BD personal (tablas dvds y cuentas):
CREATE DATABASE dvdsycuentas;

USE dvdsycuentas;

CREATE TABLE dvds(
	autor VARCHAR(24),
	titulo VARCHAR(24),
	YEAR smallint
	);
	

CREATE TABLE cuentas(
	fecha DATE,
	concepto VARCHAR(32),
	importe FLOAT,
	tipo_mov ENUM('d','h')
	);
	
#2.Inserta cinco registros que tú quieras en cada una de las tablas.
INSERT INTO dvds(autor,titulo,YEAR) VALUES ('noon sevium','El imperio del mal',2003);
INSERT INTO dvds(autor,titulo,YEAR) VALUES ('Kaos Urbano','El kaos en el orden',2004);

INSERT INTO cuentas(fecha,concepto,importe,tipo_mov) VALUES ('2005-11-25','nomina',1500.0,'d');
INSERT INTO cuentas(fecha,concepto,importe,tipo_mov) VALUES ('2006-11-26','compra coche',12000.0,'h');

#3.Crea los usuarios tesorero y habitante. El primero puede acceder a todas las tablas,
#pero el segundo sólo a cuentas.
GRANT ALL ON personal.* TO tesorero@localhost IDENTIFIED BY 'tes';
GRANT ALL ON personal.* TO tesorero@'%' IDENTIFIED BY 'tes';

GRANT ALL ON personal.cuentas TO habitante@localhost IDENTIFIED BY 'hab';ç
GRANT ALL ON personal.cuentas TO habitante@'%' IDENTIFIED BY 'hab';

GRANT ALL ON personal.cuentas TO habitante@localhost IDENTIFIED BY 'hab';
GRANT ALL ON personal.cuentas TO habitante@'%' IDENTIFIED BY 'hab';

GRANT INSERT ON personal.dvds TO invitado@localhost IDENTIFIED BY 'inv';
GRANT INSERT ON personal.dvds TO invitado@'%' IDENTIFIED BY 'inv';

#4.Crea otro usuario llamado iniitado que sólo puede insertar datos en la tabla dids (no
#puede leer, por ejemplo). Comprobar también que no tene acceso a cuentas.
GRANT INSERT ON personal.dvds TO invitado@localhost IDENTIFIED BY 'inv';
GRANT INSERT ON personal.dvds TO invitado@'%' IDENTIFIED BY 'inv';


#5.Crea un usuario iniitado2 que sólo tenga acceso para lectura (SELECT) a la columna
#concepto de la tabla cuentas y solamente conectándose desde el ordenador local
REVOKE ALL ON personal.* FROM tesorero@'%';
REVOKE ALL ON personal.* FROM tesorero@localhost;

REVOKE INSERT ON personal.dvds FROM invitado@'%';
REVOKE INSERT ON personal.dvds FROM invitado@localhost;

GRANT SELECT(concepto) ON personal.cuentas TO invitado2@localhost
IDENTIFIED BY 'inv2';

GRANT SELECT(concepto) ON personal.cuentas TO invitado2@'%'
IDENTIFIED BY 'INV2';


	SELECT * FROM dvds;
	SELECT * FROM cuentas;
