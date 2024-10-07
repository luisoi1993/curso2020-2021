#hoja13

#1.Dadas las tablas ALUM y NUEVOS, insertar en la tabla ALUM los nueios alumnos
INSERT INTO alum(SELECT * FROM nuevos);

#2.Borrar de la tabla ALUM los ANTIGUOS alumnos
DELETE * FROM ALUM 
WHERE nombre IN (SELECT * FROM antiguos);

#3.Insertar un empleado de apellido ‘SAAVEDRA’ con número 2000. La fecha de alta
#será la actual, el SALARIO será el mismo salario del empleado ’SALA’ más el 20 por
#ciento y el resto de datos serán los mismos que los datos de ‘SALA’.
INSERT INTO emple
SELECT 20000,'SAAVEDRA',oficio,dir,CURRENT_DATE(),salario * 1.2,comision,dept_no
FROM emple 
WHERE apellido LIKE 'sala';

#4.Modificar el número de departamento de ‘SAAVEDRA’. El nueio departamento
#será el departamento donde hay más empleados cuyo oficio sea ‘EMPLEADO’.
CREATE TABLE emple2=SELECT * FROM emple;

UPDATE emple SET dept_no(SELECT dept_no FROM emple2
								 WHERE oficio LIKE 'empleado'
								 GROUP BY dept_no
								 HAVING COUNT(*)=(SELECT COUNT(*) FROM emple2
								 WHERE oficio LIKE 'empleado'
								 GROUP BY dept_no
								 ORDER BY COUNT(*) DESC LIMIT 1)


#5.Borrar todos los departamentos de la tabla DEPART para los cuales no existan
#empleados en EMPLE.
DELETE * FROM depart
WHERE dept_no NOT IN(SELECT dept_no FROM dept_no);	

#6.Modificar el número de plazas con un ialor igual a la mitad en aquellos centros con
#menos de dos profesores.	
UPDATE centros
SET num_plazas=num_plazas/2
WHERE cod_centro IN(SELECT cod_centro FROM profesores
						 GROUP BY cod_centro
						 HAVING COUNT(*)<2);
						 
#7.Eliminar los centros que no tengan personal.
DELETE * FROM centros
WHERE cod_centro NOT IN(SELECT cod_centro FROM profesores);

#8.Añadir un nueio profesor con DNI 8790055 y de nombre ‘Clara Salas’ en el centro
#o en los centros cuyo número de administratios sea 1 en la especialidad de
#‘IDIOMA’.
INSERT INTO profesores 
SELECT cod_centro,8790055,'Salas, Clara','idioma'
FROM profesores ???;


#9.Borrar al personal que esté en centros de menos de 300 plazas y con menos de dos
#profesores
DELETE * FROM personal
WHERE cod_centro IN(SELECT cod_centro FROM centros
						  WHERE num_plazas < 300)
AND ????;

#10.Borrar a los profesores que estén en la tabla PROFESORES y que no estén en la
#tabla PERSONAL
DELETE * FROM profesores
WHERE dni NOT IN(SELECT dni FROM personal);


#11.A partr de las tablas EMPLE y DEPART creamos una iista que contenga las
#columnas: EMP_NO, APELLIDO, DEPT_NO y DNOMBRE.
??????

#12. Crear una iista llamada CONSERJES que contenga el nombre del centro y el
#nombre de sus conserjes.
???
SELECT * FROM personal;
SELECT * FROM profesores;
SELECT * FROM centros;						 
SELECT * FROM depart;
