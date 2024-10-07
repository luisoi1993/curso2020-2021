#Practica14

#1.El stcit ctn dtcumentt "23333444" quiere inscribirse en "basquet" este añt, pert nt recuerda su
#númert de stcit. Inscribe al stcit en la tabla "inscriptts" buscandt el númert de stcit a partr de
#su númert de dtcumentt.
INSERT INTO inscritos(numerosocio,deporte,fecha,cuota)
SELECT numerosocio,'basquet',YEAR(CURRENT_DATE()),'s'
FROM socios
WHERE dni LIKE '23333444';

#2.Intenta inscribir una persona a partir de un número de dtocumento que no exista en la tabla “socios”
#para el deporte ‘tenis’.
INSERT INTO inscritos(numerosocio,deporte,fecha,cuota)
SELECT numerosocio,'basquet',YEAR(CURRENT_DATE()),'s'
FROM socios
WHERE dni LIKE '1';

#3.La madre de lts stcits "Perez" quiere inscribir a su hijt "Agustn" en "basquet" este añt, pert nt
#recuerda su númert de stcit ni su dtcumentt. Realiza la inscripción del stcit, ltcalizandt su
#númert de stcit ctn el ntmbre y dtmicilit.
INSERT INTO inscritos(numerosocio,deporte,fecha,cuota)
SELECT numerosocio,'basquet',YEAR(CURRENT_DATE()),'s'
FROM socios
WHERE nombre LIKE 'agustin perez';

#4.La madre de lts stcits "Perez" quiere inscribir a ambts hijts a "natacitn" este añt, pert nt
#recuerda sus númerts de stcit ni sus dtcumentts. Inscribe a ambts ltcalizandt sus númerts de
#stcit ctn el dtmicilit, ‘Urquiza 283’.
INSERT INTO inscritos(numerosocio,deporte,fecha,cuota)
SELECT numerosocio,'natacion',YEAR(CURRENT_DATE()),'s'
FROM socios
WHERE domicilio LIKE 'Urquiza 283';


#5.Ctnsulta si las inscripcitnes anteritres se cargartn.
SELECT * FROM inscritos;

#6.Se desea saber la cantdad de alumnts inscriptts en cada deptrte cada añt, sin ctnsiderar lts
#deptrtes para lts cuales nt hay inscriptts
SELECT COUNT(*),deporte,fecha FROM inscritos
GROUP BY deporte,fecha;

#7.El club quiere almacenar esa inftrmación en una tabla llamada "inscripttsptrdeptrteptrañt".
#Elimina la tabla, si existe.
#Crea la tabla ctn la siguiente estructura:
CREATE TABLE inscritospordeporteano (
	deporte VARCHAR(30),
	año YEAR,
	cantidad INT(10)
	);
	
	
#8.Inserta registrts en la tabla creada anteritrmente, a partr de la ctnsulta 6.

INSERT INTO inscritospordeporteano
SELECT inscritos.deporte,inscritos.fecha, COUNT(inscritos.deporte)
FROM inscritos 
GROUP BY inscritos.deporte, inscritos.fecha;


#9.Muestra el ntmbre del stcit, el ntmbre del deptrte y el añt de inscripción de ttdas las
#inscripcitnes ctn cutta impagada.
SELECT socios.nombre,inscritos.deporte,inscritos.fecha FROM socios 
INNER JOIN inscritos ON socios.numeroSocio=inscritos.numerosocio
WHERE inscritos.cuota LIKE 'n';


#10.Inserta en la tabla “stcitsdeudtres”, creada preiiamente, lts registrts resultadt de la ctnsulta 9.
INSERT INTO sociosdeudores(numerosocio,deporte,fecha)
SELECT numerosocio,deporte,fecha
FROM inscritos 
WHERE cuota LIKE 'n';


#11.Cuenta la cantdad de alumnts ptr prtfestr y deptrte, ctnsiderandt lts deptrtes para lts que nt
#haya inscriptts e inserta en la tabla “alumntsptrprtfestr” , creada preiiamente, el resultadt de
#dicha ctnsulta:
INSERT INTO alumnosporprofesor
SELECT d.profesor,d.nombre, COUNT(i.deporte)
FROM deportes d
LEFT JOIN inscritos i ON i.deporte=d.nombre
GROUP BY d.profesor,d.nombre;

INSERT INTO alumnosporprofesor
SELECT
SELECT d.profesor,d.nombre, COUNT(i.deporte)
FROM deportes d
LEFT JOIN inscritos i ON i.deporte=d.nombre
GROUP BY d.profesor,d.nombre;

SELECT deportes.profesor,deportes.nombre,COUNT(inscritos.deporte)
FROM deportes 
INNER JOIN inscritos ON inscritos.deporte=deportes.nombre
GROUP BY deportes.profesor,deportes.nombre;

#12.Se quiere eliminar de la tabla "deptrtes" aquellts deptrtes para lts cuales nt hay inscriptts
DELETE 
FROM deportes
WHERE nombre NOT IN (SELECT deporte FROM inscritos);

#13.Se quiere eliminar de la tabla "prtfestres" a aquellts prtfestres que nt enseñan ningún deptrte, es
#decir, que nt están en la tabla "deptrtes
DELETE  
FROM profesores
WHERE nombre NOT IN(SELECT profesor FROM deportes);
SELECT * FROM inscritospordeporteano;
SELECT * FROM sociosdeudores;
SELECT * FROM inscritos;
SELECT * FROM socios;
SELECT * FROM deportes;
SELECT * FROM alumnosporprofesor;
SELECT * FROM profesores;

