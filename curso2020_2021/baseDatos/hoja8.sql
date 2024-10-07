#1.En MySQL, establece como actia la base de datos PRACTICAS.
USE practicas;

#2.A partr de la tabla EMPLE, iisualizaa cuántos empleados tenen apellido
#empezaando por ‘A’.
SELECT COUNT(emp_no) FROM emple
WHERE APELLIDO LIKE '%A%';

#3.Dada la tabla EMPLE, obtén el sueldo medio, el número de comisiones no
#nulas, el máximo sueldo y el mínimo sueldo de los empleados del
#departamento 30.
SELECT AVG(salario),COUNT(comision),MAX(salario),MIN(salario) FROM emple
WHERE dept_no LIKE 30;


#4. Visualizaa el número de empleados de cada departamento cuyo ofcio sea
#‘EMPLEADO
SELECT COUNT(emp_no),dept_no FROM emple
WHERE OFICIO LIKE 'empleado'
GROUP BY dept_no;

#5.Busca los departamentos que tenen más de dos personas trabajando en la
#misma profesión.
SELECT dept_no,COUNT(emp_no) FROM emple
GROUP BY dept_no,oficio
HAVING COUNT(EMP_NO)>2;

#6.Obtener el número total de departamentos.
SELECT COUNT(DISTINCT dept_no) FROM depart;

#7.Obtener el número total de departamentos que tenen empleados
SELECT COUNT(DISTINCT dept_no) FROM emple;

#8.Obtener el número total de empleados del departamento 10 que son
#ANALISTAS.
SELECT COUNT(emp_no) FROM emple
WHERE dept_no LIKE 10 AND oficio LIKE 'analista';

#9.Obtener, para cada ofcio de la tabla EMPLE, el sueldo máximo y el sueldo
#mínimo, excluyendo los sueldos de los ANALISTAS.
SELECT MAX(salario),MIN(salario),oficio FROM emple
WHERE OFICIO NOT LIKE 'analista'
GROUP BY oficio;

#10.Obtener los códigos de las asignaturas que tenen matriculados más de un
#alumno.
SELECT cod,COUNT(dni) FROM notas
GROUP BY cod
HAVING COUNT(dni) >1;

#11. Obtener el DNI de los alumnos aprobados en cualquier asignatura.
SELECT DISTINCT dni FROM notas
WHERE nota > 4;

#12.Obtener el número de alumnos aprobados en cada asignatura.
SELECT COUNT(dni),cod FROM notas
WHERE nota >4
GROUP BY cod;

#13.Obtener el DNI de los alumnos cuya nota esté comprendida entre 5 y 7.
SELECT dni FROM notas
WHERE nota BETWEEN 5 AND 7;

#14. Obtener la nota media de en cada asignatura.
SELECT AVG(nota) FROM notas
GROUP BY cod;

#15. Obtener los códigos de las asignaturas en las que sólo hay matriculados un
#alumno.
SELECT COUNT(dni),cod FROM notas
GROUP BY cod
HAVING COUNT(dni) =1;
SELECT * FROM notas;
SELECT * FROM asignaturas;
SELECT * FROM emple;
SELECT * FROM depart;