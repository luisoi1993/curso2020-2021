#1.Obtener todos los campos de todos los concesionarios.
SELECT * FROM concesionario;

#2.Obtener todos los campos de todos los clientes de ‘MADRID’
SELECT * FROM clientes
WHERE ciudad LIKE 'madrid';

#3.Obtener los nombres de todas las MARCAS de coches ordenadas
#alfabéticamente.
SELECT nombre FROM marcas 
ORDER BY nombre ;

#4.Obtener el cifc de todos los concesionarios cuya cantidad en la tabla
#DISTRIBUCIÓN es mayor que 18.
SELECT cifc FROM distribucion 
WHERE cantidad > 18;

#5.Obtener el cifc de todos los concesionarios que han adquirido más de 10
#coches o menos de 5
SELECT cifc FROM distribucion 
WHERE cantidad >10
OR cantidad <5;

#6.Obtener todas las parejas de dni de clientes y cifm de marcas que NO sean
#de la misma ciudad.
SELECT cifc,dni FROM ventas 
WHERE codcoche  IN(SELECT codcoche FROM marco
						 WHERE cifm IN(SELECT cifm FROM marcas
											GROUP BY ciudad
											HAVING COUNT(ciudad) =1));

#7.Obtener los codcoche suministrados por algún concesionario de
#‘BARCELONA’.
SELECT codcoche FROM ventas
WHERE cifc IN(SELECT cifc FROM concesionario
					WHERE ciudad LIKE 'barcelona');
					

#8.Obtener el codcoche de aquellos coches vendidos a clientes de ‘MADRID’
SELECT codcoche FROM ventas
WHERE dni IN(SELECT dni FROM clientes
				WHERE ciudad LIKE 'madrid');
				
				
#9.Obtener el codcoche de los coches que han sido adquiridos por un cliente
#de ‘MADRID’ a un concesionario de Madrid.
SELECT codcoche FROM ventas
WHERE dni IN(SELECT dni FROM clientes
				WHERE ciudad LIKE 'madrid')
AND cifc IN(SELECT cifc FROM concesionario
				WHERE ciudad LIKE 'madrid');
				
#10.Obtener los codcoche de los coches comprados en un concesionario de la
#misma ciudad que el cliente que lo compra.
SELECT ventas.codcoche,clientes.ciudad,concesionario.ciudad FROM ventas 
INNER JOIN concesionario ON ventas.cifc=concesionario.cifc
INNER JOIN clientes ON ventas.dni=clientes.dni
HAVING clientes.ciudad = concesionario.ciudad;

#11.Obtener las parejas de modelos de coches cuyo nombre es el mismo y cuya
#marca es de ‘BILBAO’
SELECT A.modelo, B.modelo
FROM coches A INNER JOIN coches B ON A.nombre=B.nombre
INNER JOIN marco ON A.codcoche=marco.codcoche
INNER JOIN marcas ON marco.cifm=marcas.cifm
where A.modelo>B.modelo
and marcas.ciudad='BILBAO';


#12.Obtener todos los codcoches de los coches cuyo nombre empiece por ‘C’.
SELECT codcoche,nombre FROM coches 
WHERE nombre LIKE 'a%';

#13. Obtener todos los codcoche de los coches cuyo nombre no contiene
#ninguna ‘A’.
SELECT codcoche ,nombre FROM coches
WHERE nombre NOT LIKE '%a%';

#14.Obtener la media de la cantidad de coches que tienen todos los
#concesionarios.
SELECT AVG(cantidad) FROM distribucion;

#15.Obtener el dni con numeración más alta de todos los clientes de MADRID.
SELECT MAX(dni) FROM clientes
WHERE ciudad LIKE 'madrid';

#16.Obtener el cifc de todos los concesionarios cuyo número de coches en stock
#no es nulo.
SELECT cifc FROM concesionario
WHERE cifc IN(SELECT cifc FROM distribucion);

#17.Obtener el cifm y el nombre de las marcas de coches cuya segunda letra del
#nombre de la ciudad de origen sea una ‘I’.
SELECT cifm , nombre,ciudad FROM marcas
WHERE ciudad LIKE '_i%';

#18.Obtener el dni de los clientes que han comprado algún coche a un
#concesionario de `MADRID`
SELECT dni FROM clientes 
WHERE dni IN (SELECT dni FROM ventas
					WHERE cifc IN(SELECT cifc FROM concesionario
									  WHERE ciudad LIKE 'madrid'));
									  
#19.Obtener el color de los coches vendidos por el concesionario ‘ACAR’
SELECT color FROM ventas
WHERE cifc IN(SELECT cifc FROM concesionario
				  WHERE nombre LIKE 'acar');
				  
#20.Obtener el nombre y el modelo de los coches vendidos por algún
#concesionario de ‘BARCELONA’.
SELECT nombre,modelo FROM coches
WHERE codcoche IN(SELECT codcoche FROM ventas 
						WHERE cifc IN(SELECT cifc FROM concesionario
									  WHERE ciudad LIKE 'barcelona'));
									  
#21.Obtener todos los nombres de los clientes que hayan adquirido algún coche
#del concesionario ‘DCAR’.
SELECT nombre FROM clientes
WHERE dni IN(SELECT dni FROM ventas
				 WHERE cifc IN(SELECT cifc FROM concesionario 
				 					WHERE nombre LIKE 'dcar'));
				 					
#22.Obtener el nombre y el apellido de los clientes que han adquirido un
#automóvil a un concesionario de ‘MADRID’ que posea actualmente coches
#en stock del modelo ‘GTI’
SELECT nombre,apellido FROM clientes
WHERE dni IN(SELECT dni FROM ventas 
				 WHERE cifc IN(SELECT cifc FROM concesionario 
				 					WHERE ciudad LIKE 'madrid')
				 AND codcoche IN(SELECT codcoche FROM coches
				 						WHERE modelo LIKE 'gti'));
				 						
#23.Obtener el nombre y el apellido de los clientes cuyo dni es menor que el de
#los clientes que son de ‘BARCELONA
SELECT nombre,apellido,dni FROM clientes 
WHERE dni < ALL(SELECT dni FROM clientes 
				WHERE ciudad LIKE 'barcelona');
				
#24. Obtener el nombre y el apellido de los clientes cuyo nombre empieza por
#‘A’ y cuyo dni es mayor que el de ALGUNO de los clientes que son de
#‘MADRID.
SELECT nombre,apellido FROM clientes
WHERE nombre LIKE 'a%' 
AND dni > ANY(SELECT dni FROM clientes
				  WHERE ciudad LIKE 'madrid');
				  
#25.Obtener el nombre y el apellido de los clientes cuyo nombre empieza por
#‘A’ y cuyo dni es mayor que el de ALGUNO de los clientes que son de
#‘MADRID’ o menor que el de todos los de ‘VALENCIA’
SELECT nombre,apellido FROM clientes
WHERE nombre LIKE 'a%' 
AND dni > ANY(SELECT dni FROM clientes
				  WHERE ciudad LIKE 'madrid')
OR dni < ALL(SELECT dni FROM clientes
				 WHERE ciudad LIKE 'valencia') ;
				 
#26.Obtener la media de los automóviles que cada concesionario tiene
#actualmente en stock.
SELECT AVG(cantidad) FROM distribucion
GROUP BY cifc;

#27.Obtener el cifc del concesionario que no sea de ‘MADRID’ cuya media de
#vehículos en stock sea la más alta de todas las medias.
SELECT cifc, AVG(cantidad) FROM distribucion
WHERE cifc NOT IN(SELECT cifc FROM concesionario
						WHERE ciudad LIKE 'madrid')
GROUP BY cifc 
ORDER BY AVG(cantidad) DESC LIMIT 1;


#28.
SELECT * FROM marco;
SELECT * FROM coches;					
SELECT * FROM ventas;
SELECT * FROM concesionario;
SELECT * FROM distribucion;
SELECT * FROM marcas;
SELECT * FROM clientes;