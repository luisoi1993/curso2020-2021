#1.En MySQL, establece como activa la base de datos PRACTICAS.
USE practicas;

#2.Visualizar los departamentos en los que el salario medio es mayor o igual que la
#media de todos los salarios.
SELECT AVG(salario),dept_no FROM emple
GROUP BY dept_no
HAVING AVG(salario) >= (SELECT AVG(salario) FROM emple);

#3. A partir de la tabla EMPLE, visualizar el número de vendedores del
#departamento ‘VENTAS’.
SELECT COUNT(emp_no) FROM emple 
WHERE dept_no LIKE(SELECT dept_no FROM depart
						 WHERE dnombre LIKE 'ventas')
AND oficio LIKE 'vendedor';

#4. Partiendo de la tabla EMPLE, visualizar por cada oficio de los empleados del
#departamento ‘VENTAS’ la suma de salarios
SELECT SUM(salario),oficio FROM emple
WHERE dept_no LIKE(SELECT dept_no FROM depart
						 WHERE dnombre LIKE 'ventas')
GROUP BY oficio; 


#5.Seleccionar aquellos apellidos de la tabla EMPLE cuyo salario sea igual a la
#media del salario en su departamento.	
SELECT apellido,salario
FROM emple
WHERE (salario,dept_no) IN (SELECT AVG(salario),dept_no
							FROM emple
							GROUP BY dept_no);
							
#6.A partir de la tabla EMPLE, visualizar el número de empleados de cada
#departamento cuyo oficio sea ‘EMPLEADO’.
SELECT COUNT(emp_no),dept_no FROM emple
WHERE oficio LIKE 'empleado'
GROUP BY dept_no;

#7.Desde la tabla EMPLE, visualizar el departamento que tenga más empleados
#cuyo oficio sea ‘EMPLEADO’.
						
SELECT dept_no,COUNT(*)
FROM emple
WHERE oficio LIKE 'empleado'
GROUP BY dept_no
ORDER BY COUNT(*) DESC LIMIT 1;


#8.A partir de las tablas EMPLE y DEPART, visualizar el número de departamento y
#el nombre de departamento que tenga más empleados cuyo oficio sea
#‘EMPLEADO’.
SELECT DEPT_NO,  DNOMBRE 
FROM DEPART
WHERE DEPT_NO = (SELECT  DEPT_NO 
						FROM EMPLE 
						WHERE OFICIO='EMPLEADO'
						GROUP BY DEPT_NO 
						HAVING COUNT(*) = (SELECT COUNT(*) 
						FROM EMPLE 
						WHERE OFICIO='EMPLEADO'
						GROUP BY DEPT_NO
						ORDER BY COUNT(*) DESC LIMIT 1));
						
#9.Buscar los departamentos que tienen más de dos personas trabajando en la
#misma profesión.
SELECT dept_no,COUNT(*)
FROM emple
GROUP BY dept_no,oficio
HAVING COUNT(*) >2;

#10.A partir de la tabla EMPLE, obtener los nombres de departamentos que tengan
#más de 4 personas trabajando.
SELECT COUNT(emp_no),dept_no FROM emple
GROUP BY dept_no
HAVING COUNT(emp_no) > 4;

#11.Obtener el número de departamento, el nombre de departamento [y el
#número de empleados] del departamento con más empleados. (Dificultad Alta)
SELECT DEPT_NO, DNOMBRE
FROM DEPART 
WHERE DEPT_NO IN (SELECT DEPT_NO FROM EMPLE 
						GROUP BY DEPT_NO 
						HAVING COUNT(*) = (SELECT COUNT(*) FROM EMPLE
												GROUP BY DEPT_NO
												ORDER BY COUNT(*) LIMIT 1));
												
#12.Dada la tabla LIBRERÍA, visualizar por cada estante la suma de los ejemplares.
SELECT SUM(ejemplares),estante FROM libreria
GROUP BY estante;

#13.Visualizar el estante con más ejemplares de la tabla LIBRERIA.
SELECT estante,SUM(ejemplares) FROM libreria 
GROUP BY estante
ORDER BY SUM(ejemplares) DESC LIMIT 1;

#14.Visualizar los nombres de los alumnos de la tabla ALUM que aparezcan en
#alguna de estas tablas: NUEVOS y ANTIGUOS.
SELECT nombre FROM alum
WHERE nombre IN( SELECT nombre FROM nuevos)
OR nombre IN(SELECT nombre FROM antiguos);

#15.Visualizar los nombres de los alumnos de la tabla ALUM que aparezcan en estas
#dos tablas: NUEVOS y ANTIGUOS.
SELECT nombre FROM alum
WHERE nombre IN( SELECT nombre FROM nuevos)
AND nombre IN(SELECT nombre FROM antiguos);

#16.Obtener la especialidad con menos empleados.
SELECT COUNT(especialidad),especialidad FROM profesores
GROUP BY especialidad
ORDER BY COUNT(especialidad);

#17. Obtener por cada función el número de trabajadores.
SELECT COUNT(especialidad),especialidad FROM profesores
GROUP BY especialidad;

#18.Visualizar los diferentes estantes de la tabla LIBRERÍA ordenados
#descendentemente por estante.

SELECT estante FROM libreria 
ORDER BY estante DESC;

#19.Averiguar cuántos temas tiene cada estante
SELECT COUNT(tema),estante FROM libreria
GROUP BY estante;

#20.Visualizar los estantes que tengan tres temas
SELECT COUNT(tema),estante FROM libreria
GROUP BY estante
HAVING COUNT(tema)=3;

SELECT * FROM libreria;
SELECT * FROM personal;
SELECT * FROM profesores;
SELECT * FROM antiguos;
SELECT * FROM nuevos;
SELECT * FROM alum;
SELECT * FROM libreria;
SELECT * FROM depart;
SELECT * FROM emple;