#1Consulta todos los datos de las tablas EMPLE y DEPART
SELECT * FROM emple;
SELECT * FROM depart;

#2.Selecciona de la tabla EMPLE a todos los empleados del departamento 20
#(DEPT_NO=20). Además la consulta debe aparecer ordenada por la columna
#APELLIDO. Los campos que hay que consultar son : número de empleado,
#apellidos, oficio y número de departamento.

SELECT emp_no,apellido,oficio,dept_no FROM emple
WHERE dept_no LIKE 20 
ORDER BY apellido;

#3.Crea la tabla ALUM0405 que contiene los datos de los alumnos matriculados en
#el curso 2004/2005 para un centro de enseñanza. A continuación realiza las
#consultas sobre dicha tabla que se indican.

CREATE TABLE alum0405(
	dni VARCHAR(10)PRIMARY KEY,
	nombre VARCHAR(15)NOT NULL,
	apellidos VARCHAR(20)NOT NULL,
	fecha_nac DATE,
	direcccion VARCHAR(20)NOT NULL,
	poblacion VARCHAR(20),
	provincia VARCHAR(20),
	curso INT(1)NOT NULL,
	nivel VARCHAR(3)NOT NULL,
	clase CHAR(2),
	faltas1 INT(2)DEFAULT "0",
	faltas2 INT(2)DEFAULT "0",
	faltas3 INT(2)DEFAULT "0"
	);
	
#4.Obtén todos los datos de los alumnos.
SELECT * FROM alumnos

#5.Obtén los siguientes datos de alumnos: DNI, NOMBRE, APELLIDOS, CURSO,
#NIVEL y CLASE.
SELECT dni,nombre,apellidos,curso,nuvel,clase
FROM alum0405;

#6.Obtén todos los datos de alumnos cuya población sea ‘TOLEDO’
SELECT * FROM alum0405 
WHERE provincia LIKE 'toledo';


#7.Obtén el NOMBRE y APELLIDOS de todos los alumnos cuya población sea
#‘MADRID’

SELECT nombre,apellidos FROM alum0405 
WHERE provincia LIKE 'madrid';

#8.Consulta el DNI, NOMBRE, APELLIDOS, CURSO, NIVEL y CLASE de todos los
#alumnos ordenado por APELLIDOS y NOMBRE.
SELECT dni,nombre,apellidos,curso,nivel,clase
FROM alum0405
ORDER BY apellidos,nombre;

#9.Selecciona el nombre de departamento y el número de departamento de la
#tabla DEPART, para todos los departamentos, utilizando un alias para la
#columna DEPT_NO.
SELECT dnombre, dept_no AS departamento  FROM depart;

#10.A partir de la tabla NOTAS_ALUMNOS, obtener la nota media de cada alumno.
#Visualizar el nombre y su nota media.
SELECT * FROM notas_alumnos;
SELECT nombre_alumno,(nota1+nota2+nota3)/3 AS notamedia
FROM notas_alumnos;

#11.A partir de la tabla NOTAS_ALUMNOS, obtener aquellos nombres de alumnos
#que tengan un 7 en NOTA1 y cuya nota media sea mayor que 6.
SELECT nombre_alumno, (nota1+nota2+nota3)/3 as notamedia
from notas_alumnos

#12.A partir de la tabla EMPLE obtén aquellos empleados cuyo apellido empiece
#por ‘J
SELECT * FROM emple
WHERE apellido LIKE 'J%';

#13.A partir de la tabla EMPLE obtén aquellos empleados cuyo apellido contenga
#una ‘R’ en la segunda posición.
SELECT * FROM emple
WHERE apellido LIKE '_r%';

#14.A partir de la tabla EMPLE obtén aquellos empleados cuyo apellido empiece
#por ‘A’ y contenga una ‘O’ en su interior.
SELECT * FROM emple
WHERE apellido LIKE 'a%o%';
SELECT * FROM emple;

SELECT * FROM depart;