CHINOOK

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

--1 Sacar un informe con: título de la canción, título del álbum y nombre del artista para canciones de género POP
SELECT t.NAME , a.ALBUMID , a2.NAME FROM TRACK t JOIN ALBUM a ON t.ALBUMID =
a.ALBUMID JOIN ARTIST a2 ON a2.ARTISTID = a.ARTISTID WHERE t.GENREID = '9' ;

--2 Haz una consulta que saque canciones que empiezan por T, que pertenezcan a los géneros de blues y pop y que se hayan vendido en Enero o Junio
SELECT t.NAME, i2.INVOICEDATE FROM TRACK t JOIN INVOICELINE i ON t.TRACKID =
i.TRACKID JOIN INVOICE i2 ON i.INVOICEID = i2.INVOICEID WHERE (t.NAME LIKE 'T%') AND
((t.GENREID LIKE '6') OR (t.GENREID LIKE '9')) AND TO_CHAR(i2.invoicedate, 'mm') IN (1,6) ;

--3 Nombre y género (descripción) de todas las canciones que valgan menos de 1€
SELECT t.NAME, g.NAME FROM TRACK t JOIN INVOICELINE i ON t.TRACKID = i.TRACKID JOIN
GENRE g ON t.GENREID = g.GENREID WHERE i.UNITPRICE < 1;

--4 Saca los distintos álbumes para los que se han vendido canciones a clientes de Estados Unidos
SELECT DISTINCT a.TITLE , i2.BILLINGCOUNTRY FROM TRACK t JOIN INVOICELINE i ON
t.TRACKID = i.TRACKID JOIN INVOICE i2 ON i.INVOICEID = i2.INVOICEID JOIN ALBUM a ON
a.ALBUMID = t.ALBUMID WHERE i2.BILLINGCOUNTRY = 'USA';

--5 Saca los distintos clientes y artistas en los que se cumpla que el cliente ha comprado alguna canción del artista y el nombre del cliente
--(firstname) empieza por la misma letra que el nombre del artista. Ordena la consulta por nombre del cliente y luego por nombre del artista
SELECT DISTINCT c.FIRSTNAME , a2.NAME FROM TRACK t JOIN INVOICELINE i ON
t.TRACKID = i.TRACKID JOIN INVOICE i2 ON i.INVOICEID = i2.INVOICEID JOIN CUSTOMER c
ON c.CUSTOMERID = i2.CUSTOMERID JOIN ALBUM a ON a.ALBUMID = t.ALBUMID JOIN
ARTIST a2 ON a.ARTISTID = a2.ARTISTID WHERE SUBSTR(c.FIRSTNAME,1,1) =
SUBSTR(a2.NAME,1,1) ORDER BY c.FIRSTNAME , a2.NAME ;

--6 Pedidos hechos en la 2ª quincena de cada mes por clientes residentes en Alemania.
SELECT DISTINCT i2.* FROM TRACK t JOIN INVOICELINE i ON t.TRACKID = i.TRACKID JOIN
INVOICE i2 ON i.INVOICEID = i2.INVOICEID JOIN CUSTOMER c ON c.CUSTOMERID =
i2.CUSTOMERID WHERE c.COUNTRY = 'Germany' AND TO_CHAR(i2.invoicedate, 'dd') >15 ;

--7. Lista las distintas listas que contengan alguna canción cuyo género contenga una ‘O’.
SELECT DISTINCT p.NAME FROM TRACK t JOIN PLAYLISTTRACK pt ON t.TRACKID =
pt.TRACKID JOIN PLAYLIST p ON p.PLAYLISTID = pt.PLAYLISTID JOIN GENRE g ON g.GENREID = t.GENREID WHERE UPPER(g.NAME) LIKE ('%O%') ;

--8.Haz un listado con el título de cada álbum, el título de cada canción y el nombre de los artistas. El listado debe ordenarse por nombre del artista,
-- título del álbum y título de la canción.
SELECT a.TITLE , t.NAME , a2.NAME FROM TRACK t JOIN ALBUM a ON a.ALBUMID =
t.ALBUMID JOIN ARTIST a2 ON a.ARTISTID = a2.ARTISTID ORDER BY a2.NAME, a.TITLE ,
t.NAME ;

--9 Haz un listado con las distintas canciones que han comprado clientes que tienen cuenta de correo en hotmail
SELECT DISTINCT t.NAME , c.EMAIL FROM TRACK t JOIN INVOICELINE i ON t.TRACKID =
i.TRACKID JOIN INVOICE i2 ON i.INVOICEID = i2.INVOICEID JOIN CUSTOMER c ON
c.CUSTOMERID = i2.CUSTOMERID WHERE c.EMAIL LIKE ('%@hotmail.%') ;

--10Haz un listado con el nombre del artista y el país donde ha vendido canciones (elimina duplicados). Ordena el listado por el nombre del artista.
SELECT DISTINCT aa.NAME , i2.BILLINGCOUNTRY FROM TRACK t JOIN INVOICELINE i ON
t.TRACKID = i.TRACKID JOIN INVOICE i2 ON i.INVOICEID = i2.INVOICEID JOIN ALBUM a ON
a.ALBUMID = t.ALBUMID JOIN ARTIST aa ON a.ARTISTID = aa.ARTISTID ORDER BY aa.NAME
ASC ;

--11 Haz una lista de las canciones que se llaman igual al álbum al que pertenecen.
SELECT t.NAME , a.TITLE FROM TRACK t JOIN ALBUM a ON a.ALBUMID = t.ALBUMID WHERE
t.NAME = a.TITLE ;

--12 Haz un listado con el nombre del artista y el título de la canción para las canciones que haya vendido por más de 1€ (elimina duplicados)
SELECT DISTINCT aa.NAME , t.NAME , i.UNITPRICE FROM TRACK t JOIN INVOICELINE i ON
t.TRACKID = i.TRACKID JOIN INVOICE i2 ON i.INVOICEID = i2.INVOICEID JOIN ALBUM a ON
a.ALBUMID = t.ALBUMID JOIN ARTIST aa ON a.ARTISTID = aa.ARTISTID WHERE i.UNITPRICE >1;

--13 Haz una lista de las canciones, eliminando duplicados, dónde la descripción del género al que
pertenece la canción está incluída en el nombre de alguna playlist en la que esté la canción.
SELECT DISTINCT t.NAME, p.NAME, g.NAME FROM TRACK t JOIN PLAYLISTTRACK pt ON
t.TRACKID = pt.TRACKID JOIN PLAYLIST p ON p.PLAYLISTID = pt.PLAYLISTID JOIN GENRE g
ON g.GENREID = t.GENREID WHERE INSTR(UPPER(p.NAME), UPPER(g.NAME)) > 0;
