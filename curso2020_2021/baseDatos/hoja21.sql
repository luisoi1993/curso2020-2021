CREATE DATABASE hoja21;

USE HOJA21;

#1.Crea la tabla Categorías.

CREATE TABLE categorias(
	idcategoria int(10) PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion text
    );

#2.Crea un procedimiento que inserte una categoría en la tabla Categorías, a partir de los
#datos que recibe como parametros de entrada, controlando que tanto el id como el nombre
#no se repitan.



DELIMITER |
CREATE PROCEDURE insertarCategoria(id int(10),nomb VARCHAR(50),descrip VARCHAR(50))
BEGIN
IF EXISTS (SELECT * FROM categorias WHERE idcategoria=id  AND nombre LIKE nomb) THEN
	SELECT 'La categoria ya existe con ese nombre y codigo';
ELSEIF EXISTS(SELECT * FROM categorias WHERE idcategoria=id) THEN
	SELECT 'La cetegoria ya existe con ese codigo';
ELSE
	IF EXISTS(SELECT * FROM categorias WHERE nombre=nomb) THEN
		SELECT 'El nombre ya existe';
ELSE
 INSERT INTO categorias VALUES (id,nomb,descrip);
END IF;

END IF;

END |

DELIMITER ;
DELIMITER |


#b

DELIMITER 
CREATE PROCEDURE insertarCategoriaconHandler(id int, nomb VARCHAR(50), descrip VARCHAR(50))
BEGIN
DECLARE EXIT HANDLER FOR SQLSTATE '23000'
SELECT 'el id categoria ya existe';
IF EXISTS (SELECT * FROM categorias WHERE nonmbre=nomb) THEN
 SELECT 'El nombre ya existe';
ELSE
INSERT INTO categorias VALUES (id,nomb,descrip);
END IF;
END |
DELIMITER ;


#3.Crea un procedimiento almacenado que permita buscar una categoría por su nombre.
DELIMITER |
CREATE PROCEDURE buscarcategoria(nomb VARCHAR(50))
BEGIN
IF EXISTS (SELECT * FROM categorias WHERE nombre LIKE nomb) THEN
 SELECT * FROM categorias WHERE nombre=nomb;
ELSE
SELECT 'La categoria que buscas no existe';
END IF;
END |
DELIMITER ;

#4.Crea un procedimiento almacenado que permita eliminar una categoría a partir de su id,
#comprobando que dicho id existe y mostrando un mensaje de error en caso contrario
DELIMITER |
CREATE PROCEDURE eliminarCategoria(id int)
BEGIN
IF EXISTS (SELECT * FROM categorias WHERE idcategoria=id) THEN
BEGIN
DELETE FROM categorias WHERE idcategoria=id;
SELECT 'Eliminando el elemento';
END;
ELSE
SELECT 'Error: esa categoria no existe';
END IF;
END |
DELIMITER ;

SELECT * FROM categorias;
#5.Crea un procedimiento almacenado que permita modificar el nombre y la descripcion de
#una categoría, verificando que no se repite el nombre de la categoría
DELIMITER |
CREATE PROCEDURE modificaCategoria(id int, nomb VARCHAR(50),descrip VARCHAR(50))
BEGIN
IF NOT EXISTS (SELECT * FROM categorias WHERE nombre LIKE nomb) THEN
BEGIN
	IF EXISTS (SELECT * FROM categorias WHERE idcategoria LIKE id) THEN
BEGIN
 UPDATE categorias SET nombre = nomb, descripcion = descrip
 WHERE idcategoria LIKE id;
 SELECT 'Categoria modificada correctamente';
 END;
ELSE 
 SELECT 'El id de la caategoria a modificar no existe';
END IF;
 END;
ELSE
 SELECT 'Error: ese nombre de categoria ya existe';
END IF ;
 END |
DELIMITER ;

#6.Crea un procedimiento que visualice todas las películas cuyo coste de reemplazo sea superior a
#un valor que se pasará como parámetro de entrada. ¿Cuántas películas tienen un coste de
#reemplazo superior a 20€?
DELIMITER |
CREATE PROCEDURE visualizaPeliculas(repla int)
BEGIN
SELECT * FROM film
WHERE replacement_cost > repla ;
END |
DELIMITER ; 

#7.Crea un procedimiento que visualice todas las películas cuyo coste de reemplazo esté
#comprendido entre dos cantidades que se pasarán como parámetros de entrada. ¿Cuántas
#películas tienen un coste de reemplazo superior a 20€ e inferior a 21,99?
DELIMITER |
CREATE PROCEDURE visualizapeliculas2(sup decimal(5,2), inf decimal(5,2))
BEGIN 
SELECT * FROM film
WHERE replacement_cost > sup AND replacement_cost < inf ;
END |
DELIMITER ;

#8.Crea un procedimiento que reciba como parámetros de entrada el continente y la lengua y
#obtenga todos los países de ese continente que hablen esa lengua, ¿qué países de Asia tienen
#como lengua entre otras el inglés? Nota: El tipo enum es compatible con el tipo varchar.
SELECT * FROM countrylanguage;
SELECT * FROM 	country;

DELIMITER |
CREATE PROCEDURE continenteLenguas(cont VARCHAR(50),leng VARCHAR(50))
BEGIN
SELECT name FROM country 
WHERE continent =cont AND code2 IN(SELECT countrycode FROM countrylanguage
								   WHERE language = leng);
END |
DELIMITER ;

#9.Crea una función que calcule el volumen de una esfera cuyo radio de tipo FLOAT se pasará
#como parámetro. Realiza una consulta después para calcular el volumen de una esfera de radio 5
DELIMITER |
CREATE FUNCTION volumen(radio FLOAT)
RETURNS FLOAT DETERMINISTIC
BEGIN	
DECLARE volume float ;
SET volume =(4/3)*PI()*POW(radio,3);
RETURN volume;
END |
DELIMITER ;


#10.Crea un procedimiento almacenado (SP) que cambie el mail de un cliente, tabla costumer, por
#otro que se pasará como parámetro. El SP recibirá dos parámetros, el identificador del cliente y
#el nuevo mail. Ejecuta el SP con valores concretos.
DELIMITER |
CREATE PROCEDURE cambiaMail(idClie int,emai VARCHAR(50))
BEGIN
UPDATE customer SET email =emai
WHERE customer_id LIKE idClie;
END |
DELIMITER ;

#11.Crea un procedimiento almacenado (SP) que tenga como parámetros el nombre, apellidos y el
#nuevo mail de un cliente de la tabla costumer. Utilizar el procedimiento del ejercicio 5 para
#cambiar el nombre.
DELIMITER |
CREATE PROCEDURE cambiaMail2(nom VARCHAR(50),ape VARCHAR(50),mai VARCHAR(50))
BEGIN
UPDATE customer SET email = mai
WHERE first_name = nom AND last_name = ape;
END |
DELIMITER ;

#12.Crea una función que devuelva el número de actor de la tabla actor, pasando como parámetros
#el apellido y nombre
DELIMITER |
CREATE FUNCTION numeroActor(nombre VARCHAR(50),apellido VARCHAR(50))
RETURNS INT DETERMINISTIC
BEGIN
DECLARE id int;
SET id= -1;
IF EXISTS (SELECT * FROM actor 
		  WHERE first_name LIKE nombre) THEN
IF EXISTS (SELECT * FROM actor
			WHERE last_name LIKE apellido) THEN
SELECT actor_id FROM actor
WHERE first_name =nombre AND last_name=apellido INTO id;
END IF;
END IF;
RETURN id;
END |
DELIMITER ;


#13.Crea un procedimiento que visualice las películas cuya categoría (comedia, drama, …) se pasa
#como parámetro). Llama después a este procedimiento para obtener todas las películas de la
#categoría drama y de la categoría comedia. ¿Qué ventaja le encuentras a realizar esta consulta
#de esta forma a realizarla de forma directa a través de sentencias SQL?
DELIMITER |
CREATE PROCEDURE peliculaParametro(categ VARCHAR(50))
BEGIN 
SELECT * FROM film 
WHERE film_id IN (SELECT film_id FROM film_category
				 WHERE category_id IN(SELECT category_id FROM category
									  WHERE name LIKE categ));
end |
DELIMITER ; 

#19.&&Escribe una función que, haciendo uso de la función anterior, devuelva los trienios que hay
#entre dos fechas.
DELIMITER |
CREATE FUNCTION trienios(fecha1 DATE,fecha2 DATE)
 RETURNS INT(11) DETERMINISTIC 
BEGIN
	DECLARE trienios INT(11);
    SET trienios=truncate(anios_completos(fecha1.fecha2)/3.0);
    RETURN trienios;
END |
DELIMITER ;
  
#20.Escribe un procedimiento que permita borrar un actor cuyo identificador se pasará como
#parámetro. Si el actor cuyo número se ha pasado como parámetro no existe, aparecerá un
#mensaje diciendo “Este actor no existe”. Comprueba el funcionamiento del procedimiento.
#¿Qué ocurre cuando se intenta borrar un actor que ya existe?
DELIMITER |
CREATE PROCEDURE borrarActor(in idact int)
BEGIN 
	IF EXISTS(SELECT * FROM actor
				  WHERE actor_id =idact) THEN
		DELETE  FROM actor WHERE actor_id=idact;
    ELSE
		SELECT 'no existe el id del actor';	
	END IF;
END |
DELIMITER ;


#21.Escribe un procedimiento que añada una nueva entrada a la tabla film_category que guarda las
#categorías a las que pertenece cada película. El procedimiento recibirá como parámetros el
#identificador de película y el nombre de la categoría. Deberían tenerse en cuenta las siguientes
#situaciones:
#a) Si no existe la película correspondiente al número pasado como parámetro, se mostrará
#un mensaje diciendo ‘El film con nº x no existe’. X es el número de película pasado como
#parámetro y se abandonará el procedimiento en este caso.
#b) Si no existe la categoría pasada como parámetro, se mostrará un mensaje diciendo ‘La
#categoría x no existe’, donde x es el nombre de categoría pasado como parámetro y se
#abandonará el procedimiento.
#c) Si ya existe la entrada o fila que se pretende añadir a film_category, aparecerá un mensaje
#diciendo ‘la película x ya está registrada en esa categoría’. En caso contrario se procede al
#alta de dicha fila en la tabla film_category.
#d) Comprobar el procedimiento en las distintas situaciones.

DELIMITER |
CREATE PROCEDURE nuevaTabla(IN idpeli int, IN nombrecateg VARCHAR(50))
	BEGIN
		DECLARE iduso INT;
        SET iduso =0;
		IF NOT EXISTS(SELECT film_id FROM film_category
					  WHERE film_id LIKE idpeli) THEN
			SELECT CONCAT('El film con',idpeli',x no existe.');
		ELSEIF NOT EXISTS(SELECT name FROM category
						  WHERE name LIKE nombrecateg) THEN
			SELECT CONCAT('La categoria',nombrecateg,'no existe');
		ELSEIF EXISTS(SELECT * FROM film_id
					  WHERE film_id LIKE idpeli
                      AND category_id IN(SELECT category_id FROM category
										 WHERE name LIKE nombrcateg)) THEN
			SELECT 'la película',idpeli,'ya está registrada en esa categoría';
            
		ELSE 
			SELECT
									
                                         
			
			
		END IF;
        
        
END |
DELIMITER ;

SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM film;
SELECT * FROM actor;


