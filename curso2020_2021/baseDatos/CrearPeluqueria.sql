#Crea el modelo logico peluqueria

CREATE DATABASE peluqueria2;

USE peluqueria2;

CREATE TABLE servicios(
	codigo VARCHAR(10)PRIMARY KEY,
	fechahora DATETIME,
	tiposervicio VARCHAR(30)
	);
	
CREATE TABLE empleados(
	dni VARCHAR(10)PRIMARY KEY,
	nombre VARCHAR(30),
	especialidad VARCHAR(30)
);

CREATE TABLE clientes(
	dni VARCHAR(10)PRIMARY KEY,
	nombre VARCHAR(30),
	profesion VARCHAR(30),
	telefono INT(10),
	direccion VARCHAR(50),
	tratamientos VARCHAR(30)
	);
	
CREATE TABLE cosmeticos(
	codigo VARCHAR(20)PRIMARY KEY,
	nombre VARCHAR(30),
	precio FLOAT(8.2)
	);
	
CREATE TABLE citas(
	dniempleado VARCHAR(10),
	dnicliente VARCHAR(10),
	codigoservicio VARCHAR(10),
	fechahoracita DATETIME,
	PRIMARY KEY(dniempleado,dnicliente,codigoservicio),
	CONSTRAINT fk_ce FOREIGN KEY(dniempleado)
	REFERENCES empleados(dni),
	CONSTRAINT fk_cc FOREIGN KEY(dnicliente)
	REFERENCES clientes(dni),
	CONSTRAINT fk_cs FOREIGN KEY(codigoservicio)
	REFERENCES servicios(codigo)
	);
	
CREATE TABLE ventas(
	dniempleado VARCHAR(10),
	dnicliente VARCHAR(10),
	codigocosmetico VARCHAR(10),
	cantidad INT(10),
	comision FLOAT(8.2),
	PRIMARY KEY(dniempleado,dnicliente,codigocosmetico),
	CONSTRAINT fk_ve FOREIGN KEY(dniempleado)
	REFERENCES empleados(dni),
	CONSTRAINT fk_vee FOREIGN KEY(dnicliente)
	REFERENCES clientes(dni),
	CONSTRAINT fk_vc FOREIGN KEY(codigocosmetico)
	REFERENCES cosmeticos(codigo)
	);
	