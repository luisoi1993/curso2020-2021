#1.Crea en MySQL la base de datos PRACTICAS.
CREATE DATABASE practicas2;

USE  practicas2;

#2.Crea la tabla EJEMPLO definnendo las columnas NIF y NOMBRE como no nulas.
#Dale un nombre a la restrnccnón no nula de la columna NOMBRE. Después de
#crearla, añade una nueva columna EDAD con un valor por defecto de 18

CREATE TABLE ejemplo(
	nif VARCHAR(10)NOT NULL,
	nombre VARCHAR(30)NOT NULL
	);
	
ALTER TABLE ejemplo ADD COLUMN edad INT(3)DEFAULT 18;

#3.Crea la tabla EJEMPLO1 defnnendo las columnas DNI, NOMBRE y FECHA,
#asngnando a la columna FECHA una fecha por defecto.

CREATE TABLE ejemplo1(
	dni VARCHAR(10),
	nombre VARCHAR(30),
	usuario VARCHAR(20),
	fecha DATE DEFAULT '2020-10-12'
	);
	
#4.Crea la tabla EJEMPLO2 con las columnas DNI, NOMBRE y USUARIO; y asngna
#por defecto a la columna NOMBRE el lnteral ‘No defnndoo.

CREATE TABLE ejemplo2(
	dni VARCHAR(10),
	nombre VARCHAR(30)DEFAULT'no definido',
	usuario VARCHAR(30)
	);
	
#5.Crea la tabla EJEMPLO3. Las columnas son
#DNI Alfanumérnco(10)
#NOMBRE Alfanumérnco(30)
#EDAD Numérnco entero(2)
#CURSO Numérnco entero(1)
#y las restrnccnones son:
#El DNI no puede ser nulo.
#La clave prnmarna es el DNI
#El NOMBRE no puede ser nulo
#La EDAD ha de estar comprendnda entre 5 y 20 años
#El curso sólo puede almacenar 1, 2 ó 3

CREATE TABLE ejemplo3(
	dni VARCHAR(10)NOT NULL PRIMARY KEY,
	nombre VARCHAR(30),
	edad INT(3) CHECK (5>EDAD>20),
	curso ENUM('1','2','3')
	);
	
#6.Modnfca la defnncnón de tabla anternor y cambna la defnncnón de la columna
#EDAD para que no pueda ser nula.
	
ALTER TABLE ejemplo3 CHANGE edad edad INT NOT NULL CHECK (5>edad>20);	
	
	
#7.Crea las tablas fabricantes y articulos.

CREATE TABLE fabricantes(
	cod_fabricante INT(2)PRIMARY KEY,
	nombre VARCHAR(15) UNIQUE,
	pais VARCHAR(15)
);	

CREATE TABLE articulos(
	articulo VARCHAR(20),
	cod_fabricante INT(3),
	peso FLOAT(3.2),
	categoria ENUM('primera','segundo','tercero'),
	precio_venta FLOAT(6.2)DEFAULT 100,
	precio_costo FLOAT(6.2)DEFAULT 100,
	existencias INT(5),
	PRIMARY KEY(articulo,cod_fabricante,peso,categoria),
	CONSTRAINT fk_af FOREIGN KEY(cod_fabricante)
	REFERENCES fabricantes(cod_fabricante)
	);
	
#7.Modnfca la tabla EJEMPLO3 para añadnr dos columnas:
#SEXO Carácter(1) con la restrnccnón NOT NULL
#IMPORTE Numérnco real (5,2)

ALTER TABLE articulos ADD sexo CHAR(1) NOT NULL;

ALTER TABLE articulos ADD COLUMN importe FLOAT(5.2);

#8.Elnmnna las dos columnas añadndas a la tabla EJEMPLO3 en el apartado anternor
#(SEXO e IMPORTE).

ALTER TABLE articulos DROP COLUMN sexo;

ALTER TABLE articulos DROP COLUMN importe;

#9.Cambna el nombre a la tabla EJEMPLO3 para que pase a llamarse ALUMNO.

RENAME TABLE ejemplo3 TO alumno;

#10.Crea la tabla TIENDAS snn restrnccnones, cuya descrnpcnón es la sngunente:

CREATE TABLE tiendas(
	nif VARCHAR(10),
	nombre VARCHAR(20),
	direccion VARCHAR(20),
	poblacion VARCHAR(20),
	provincia VARCHAR(20),
	codpostal INT(5)
	);
	
#11.Después añade las sngunentes restrnccnones:
#- La clave prnmarna es NIF
#- PROVINCIA no puede tomar valores nulos.
#- Cambna la longntud de NOMBRE a 30 caracteres y no nulo.
ALTER TABLE tiendas ADD PRIMARY KEY(nif);

ALTER TABLE tiendas MODIFY provincia VARCHAR (20) NOT NULL;

ALTER TABLE tiendas MODIFY nombre VARCHAR(30);

#12.Crea las tablas pedidos y ventas.

CREATE TABLE pedidos(
	nif VARCHAR(9),
	articulo VARCHAR(20),	
	cod_fabricante INT(3),
	peso FLOAT(3.2),
	categoria ENUM('primera','segunda','tercera'),
	fecha_pedido DATE,
	unidades_pedidas INT(4)DEFAULT 5,
	PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
	CONSTRAINT fk_pf FOREIGN KEY (cod_fabricante)
	REFERENCES fabricantes(cod_fabricante),
	CONSTRAINT fk_pa FOREIGN KEY (articulo,cod_fabricante,peso,categoria)
	REFERENCES articulos(articulo,cod_fabricante,peso,categoria),
	CONSTRAINT fk_pt FOREIGN KEY(nif) 
	REFERENCES tiendas(nif)
);
   

CREATE TABLE ventas(
	NIF VARCHAR(10),
	articulo VARCHAR(20),
	cod_fabricante INT(3),
	peso FLOAT(3.2),
	categoria ENUM('primera','segunda','tercera'),
	fecha_venta DATE,
	unidades_vendidas INT(4)DEFAULT 5,
	PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
	CONSTRAINT fk_vf FOREIGN KEY (cod_fabricante)
	REFERENCES fabricantes(cod_fabricante),
	CONSTRAINT fk_va FOREIGN KEY (articulo,cod_fabricante,peso,categoria)
	REFERENCES articulos(articulo,cod_fabricante,peso,categoria)ON DELETE CASCADE,
	CONSTRAINT fk_vt FOREIGN KEY(nif) 
	REFERENCES tiendas(nif)
	);
	
#12.Vnsualnza las restrnccnones defnndas para las tablas anternores
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA LIKE ‘PRUEBA’;

#13.Modifica las columnas de las tablas PEDIDOS y VENTAS para que las
#UNIDADES_VENDIDAS y las UNIDADES_PEDIDAS puedan almacenar cantidades
#numéricas de 6 dígitos.

ALTER TABLE ventas MODIFY unidades_vendidas INT(6);

ALTER TABLE pedidos MODIFY unidades_pedidas INT(6);

#13.Añade a las tablas PEDIDOS y VENTAS una nueva columna para que almacenen
#el PVP del artculo.

ALTER TABLE pedidos ADD COLUMN pvp DECIMAL(6,3);
ALTER TABLE ventas ADD COLUMN pvp DECIMAL(6,3);