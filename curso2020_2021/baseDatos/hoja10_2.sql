#1.Obtener los nombres de todas las máquinas ordenadas alfabéticamente.
SELECT nombre FROM maquinas
ORDER BY nombre;

#2.Obtener todos los códigos de las máquinas cuyo nombre no contiene ninguna ‘A’.
SELECT codm FROM maquinas
WHERE nombre NOT LIKE '%a%';

#3.Obtener el número total de proyectos que se realizan en Rivas y en Loeches.
SELECT COUNT(*) FROM proyectos
WHERE localidad IN('rivas','loeches');

#4.Visualiza las localidades que tengan 2 proyectos. Utiliza un alias para nombrar la
#columna con el número de proyectos.
SELECT localidad,COUNT(codp) AS num_proyectos FROM proyectos
GROUP BY localidad 
HAVING COUNT(codp) = 2;

#5.Obtener el código de las máquinas cuyo coste/hora no supera los 18000 euros ni es
#inferior a los 11000 euros.
SELECT codm FROM maquinas 
WHERE preciohora < 18000 
AND preciohora >1100;

#6.Obtener el tiempo medio dedicado a cada proyecto por cada máquina
SELECT AVG(tiempo),codp,codm FROM trabajos
GROUP BY codp,codm;
SELECT * FROM trabajos;
SELECT * FROM proyectos;
SELECT * FROM maquinas;