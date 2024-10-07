#1.Dadas las tablas ALUM y NUEVOS, insertar en la tabla ALUM los nueios alumnos
INSERT INTO alum(SELECT * FROM nuevos);

#2.Borrar de la tabla ALUM los ANTIGUOS alumnos.
DELETE FROM alum WHERE nombre IN (SELECT nombre FROM antiguos);


#3.Insertar un empleado de apellido ‘SAAVEDRA’ con número 2000. La fecha de alta
#será la actual, el SALARIO será el mismo salario del empleado ’SALA’ más el 20 por
#ciento y el resto de datos serán los mismos que los datos de ‘SALA’.
INSERT INTO emple
SELECT 2000,'SAAVEDRA',oficio,dir,CURRENT_DATE(),salario+salaruio*0.2,comision,dept_no
FROM emple
WHERE apellido LIKE 'sala';


#4.Modificar el número de departamento de ‘SAAVEDRA’. El nueio departamento
#será el departamento donde hay más empleados cuyo oficio sea ‘EMPLEADO’.
CREATE TABLE emple2=SELECT * FROM emple;
UPDATE emple SET dept_no=(SELECT dept_no FROM emple
								 WHERE oficio LIKE 'empleado'
								 GROUP BY dept_no
								 HAVING COUNT(*)=(SELECT COUNT(*) FROM emple
								 WHERE oficio LIKE 'empleado' 
								 GROUP BY dept_no 
								 ORDER BY COUNT(*) DESC LIMIT 1);
								 
								 
#5. Borrar todos los departamentos de la tabla DEPART para los cuales no existan
#empleados en EMPLE. 
DELETE * FROM depart
WHERE depart.DEPT_NO NOT IN(SELECT dept_no FROM emple);

#6.Modificar el número de plazas con un ialor igual a la mitad en aquellos centros con
#menos de dos profesores
UPDATE centros
SET num_plazas=num_plazas/2
WHERE cod_centro IN(SELECT cod_centro FROM profesores
						 GROUP BY cod_centro
						 HAVING COUNT(*)<2);