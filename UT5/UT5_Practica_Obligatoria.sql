SELECT * FROM EMPLOYEE e;
SELECT * FROM CUSTOMER c ;
SELECT * FROM INVOICE i ;
SELECT * FROM INVOICELINE i ;
SELECT * FROM TRACK t ;
SELECT * FROM GENRE g ;
SELECT * FROM MEDIATYPE m ;
SELECT * FROM ALBUM a ;
SELECT * FROM ARTIST a;
SELECT * FROM PLAYLIST p ;
SELECT * FROM PLAYLISTTRACK p ;

--1. Inserta al artista Manolo Escobar
INSERT INTO ARTIST a 
		VALUES ('276','Manolo Escobar');

--2. Inserta 1 album para Manolo Escobar, llamado “Coplas de oro”
INSERT INTO ALBUM a 
		VALUES ('348','Coplas de Oro','276');

--3. Inserta 2 canciones para este álbum, Mi carro y La minifalda. Asocialas al género Rock.
INSERT INTO TRACK t 
		VALUES ('4444','Mi carro','348','1','1',NULL,'222222','932123','0.99');
INSERT INTO TRACK t 
		VALUES ('5555','La minifalda','348','1','1',NULL,'222222','932123','0.99');
		
--4. Crea un nuevo género llamado Copla. Asocia, con una única sentencia, todas las
--canciones de Manolo Escobar al género Copla.
INSERT INTO GENRE g 
		VALUES ('26','Copla');

UPDATE TRACK t
	SET t.GENREID = 26
	WHERE t.TRACKID in (SELECT t2.TRACKID
						from track t2
						JOIN ALBUM a ON a.albumid=t2.albumid
						WHERE a.artistid LIKE 276
						);

					--SELECT * FROM TRACK t WHERE t.TRACKID =4444 OR t.TRACKID =5555 ;
--5. Crea un nuevo campo en la tabla de canciones (track) que sea numero_listas.
alter TABLE TRACK add numero_listas VARCHAR(3);

--6. Actualiza para todas las canciones el número de distintas listas en el que está cada canción.
UPDATE TRACK T
SET numero_listas= (SELECT COUNT(DISTINCT p.playlistid) 
					FROM PLAYLISTTRACK p 
					WHERE p.trackid=t.TRACKID);


--7. Borra las listas que no tengan canciones.
DELETE FROM PLAYLIST p 
where p.playlistid NOT IN (SELECT DISTINCT  p2.playlistid
							FROM PLAYLISTTRACK p2);

--8. Crea una vista con el nombre vista_total_pedidos_pais que tenga las siguientes
--columnas: país del cliente, número total de pedidos hechos por clientes de ese país y
--la suma de los importes de los pedidos de ese país (sumar campo total de Invoice).
CREATE VIEW vista_total_pedidos_pais AS
SELECT c.COUNTRY , COUNT(c.CUSTOMERID) AS numTotalPedidos, SUM(i.TOTAL)  AS importeTotal
FROM CUSTOMER c 
	JOIN INVOICE i ON i.CUSTOMERID =c.CUSTOMERID 
GROUP BY c.COUNTRY ;

--9. Crea una vista con el nombre vista_artistas_totales que tenga a todos los artistas y que
--contenga los siguientes campos: id del artista, nombre del artista, total de álbumes del
--artista y total canciones del artista.
CREATE VIEW vista_artistas_totales AS
(SELECT a.ARTISTID , a.NAME, COUNT( DISTINCT a2.TITLE) AS totalAlbumes, COUNT(t.TRACKID) AS totalCanciones
FROM ARTIST a 
	LEFT JOIN ALBUM a2 ON a2.ARTISTID =a.ARTISTID 
	LEFT JOIN TRACK t ON t.ALBUMID =a2.ALBUMID 
GROUP BY a.ARTISTID , a.NAME) ;

--10. Crea un nuevo campo en la tabla de clientes que sea PEDIDOS (un carácter de 1
--posición donde guardaremos S o N).
alter TABLE CUSTOMER add pedidos VARCHAR(1);

--11. Actualiza el campo anterior. Si el cliente tiene algún pedido, pondremos S, si el cliente
--no tiene ningún pedido, pondremos N.
UPDATE CUSTOMER C
SET c.pedidos= 'S'
WHERE c.CUSTOMERID IN (SELECT  i.customerid
						FROM INVOICE i);
UPDATE CUSTOMER C
SET c.pedidos= 'N'
WHERE c.CUSTOMERID NOT IN (SELECT i.customerid
						FROM INVOICE i);




