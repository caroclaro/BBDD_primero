SELECT * FROM PAISES p ;
SELECT * FROM PARTICIPANTES p ;
SELECT * FROM JUGADORES j ;
SELECT * FROM ALOJAMIENTOS a ;
SELECT * FROM PARTIDAS p ;
SELECT * FROM CONTRINCANTES c ;
SELECT * FROM HOTELES h ;
SELECT * FROM SALAS s ;
SELECT * FROM MOVIMIENTOS m ;

--Ejercicio 1.
--Sacar un informe con el nombre del país, nombre del jugador y campeonatos ganados, para
--participantes que sean jugadores. La consulta debe ordenarse por nº de campeonatos
--ganados de más a menos, nombre del país y nombre del jugador alfabéticamente.
SELECT p2.NOMBRE , p.NOMBRE , p.CAMPEONATOS 
FROM PARTICIPANTES p JOIN PAISES p2 ON p2.NUM_PAIS = p.PAIS 
WHERE p.TIPO LIKE ('JUGADOR')
ORDER BY p.campeonatos DESC , p2.nombre, p.nombre;


--Ejercicio 2.
--Sacar un informe con el nombre del participante, fecha de entrada y fecha de salida,
--nombre del hotel y dirección para hoteles cuya dirección sea una calle (ni plaza ni paseo) y
--para alojamientos que empezasen el 22 o el 23 de abril del 2007 y acabasen el 25 o el 26
--de abril del 2007.

almfonfoof
SELECT p.NOMBRE 
FROM PARTICIPANTES p JOIN ALOJAMIENTOS a ON p.NUM_ASOCIADO = a.PARTICIPANTE 
WHERE (a.FECHAIN LIKE('2007-04-22 00:00:00.000') OR a.FECHAIN LIKE ('2007-04-23 00:00:00.000'));



--Ejercicio 3.
--Queremos un informe con el nombre del jugador, nombre del país, número de campeonatos
--ganados y número de partidas ganadas para todos los jugadores que pertenezcan a países
--que tengan algún jugador que haya ganado algún campeonato.
SELECT p.NOMBRE , p2.NOMBRE , p.CAMPEONATOS , COUNT(p3.COD_PARTIDA) 										
FROM PARTICIPANTES p JOIN PAISES p2 ON p2.NUM_PAIS = p.PAIS JOIN JUGADORES j ON j.N_ASOCIADO =p.NUM_ASOCIADO JOIN PARTIDAS p3 ON p3.GANADOR = p.NUM_ASOCIADO 
GROUP BY p.NOMBRE , p2.NOMBRE , p.CAMPEONATOS
HAVING p.CAMPEONATOS >0 ;


--Ejercicio 4.
--Por cada hotel muestra un informe que nos dé: el nombre del hotel, la media de entradas
--vendidas en las partidas jugadas en salas de ese hotel y el total de entradas que se
--quedaron sin vender.
efjnoeunf
SELECT h.NOMBRE , AVG(p.ENTRADAS)
FROM HOTELES h JOIN SALAS s ON s.HOTEL = h.NOMBRE JOIN PARTIDAS p ON p.SALA = s.COD_SALA 
GROUP BY h.NOMBRE ;
	JOIN (SELECT (s2.capacidad - p2.entradas)
			FROM SALAS s2 JOIN PARTIDAS p2 ON p2.SALA = s2.COD_SALA
			WHERE SUBSTR(s2.cod_sala,1,1)= SUBSTR(s2.cod_sala,1,1)) entraditas


--Ejercicio 5.
--Haz una consulta que me de el nombre de los participantes, si son JUGADOR o ÁRBITRO
--y un campo de totales que contará: si es jugador el número de partidas ganadas y si es
--árbitro el número de partidas arbitradas. Sólo para jugadores de países que tengan más de
--3 participantes
			fjunedñfiu
SELECT p.NOMBRE, p.TIPO 
FROM PARTICIPANTES p 


--Ejercicio 6.
--Queremos saber el número de partidas que se han iniciado con el movimiento: P3x4Q
SELECT COUNT(p.COD_PARTIDA) 
FROM PARTIDAS p JOIN MOVIMIENTOS m ON m.PARTIDA = p.COD_PARTIDA 
WHERE m.JUGADA LIKE ('P3x4Q') AND m.COMENTARIO LIKE ('comienza partida');


--Ejercicio 7.
--Necesitamos un informe que indique
--● Código de partida
--● Nombre del jugador que jugaba con blancas
--● Nombre del jugador que jugaba con negras
--● Árbitro
--● Nombre del ganador
--● Número de movimientos de la partida
SELECT p.COD_PARTIDA , c.JUGADOR , c2.JUGADOR, pa.NOMBRE, p.GANADOR  , COUNT(m.JUGADA)
FROM PARTIDAS p 
		LEFT JOIN CONTRINCANTES c ON c.PARTIDA = p.COD_PARTIDA LEFT JOIN CONTRINCANTES c2 ON c2.PARTIDA = p.COD_PARTIDA  
		LEFT JOIN PARTICIPANTES pa ON pa.NUM_ASOCIADO = p.ARBITRO  LEFT JOIN PARTICIPANTES pa2 ON pa2.NUM_ASOCIADO = p.ARBITRO
		LEFT JOIN MOVIMIENTOS m ON m.PARTIDA = p.COD_PARTIDA 
GROUP BY p.COD_PARTIDA, c.color, c2.color, c2.JUGADOR, pa.nombre, c.jugador, p.GANADOR
HAVING c.color LIKE ('BLANCAS') AND c2.color LIKE ('NEGRAS');
		


--Ejercicio 8.
--Haz un listado de las salas en las que no se hayan vendido 50 entradas contando todas las
--partidas jugadas en esa sala.
SELECT s.COD_SALA 
FROM SALAS s 
WHERE s.COD_SALA IN  (SELECT s3.COD_SALA
									FROM SALAS s3 joiN PARTIDAS p2 ON p2.SALA = s3.COD_SALA
									GROUP BY s3.cod_sala
									HAVING sum(p2.entradas) <50 );



--Ejercicio 9.
--Haz un listado con el código de partida y el ganador de la partida que más entradas vendió en cada sala.
SELECT p.COD_PARTIDA, p.GANADOR  
FROM PARTIDAS p 
WHERE p.COD_PARTIDA  IN (SELECT p2.cod_partida
					FROM SALAS s3 joiN PARTIDAS p2 ON p2.SALA = s3.COD_SALA
					GROUP BY s3.cod_sala,p2.entradas, p2.cod_partida
					HAVING p2.entradas IN (SELECT MAX(p3.entradas)
											FROM PARTIDAS p3
											GROUP BY p3.sala));



--Ejercicio 10.
--Haz una consulta que me de por país:
--● nombre del país
--● número de jugadores del país
--● nivel medio de los jugadores (redondeado a 1 decimal)
--● total de partidas jugadas
--Siempre que el jugador de menos nivel del país sea al menos de nivel 3

SELECT p.NUM_PAIS , COUNT(j.N_ASOCIADO) , AVG(j.NIVEL), SUM(NUM_PARTIDAS)  
FROM PAISES p JOIN PARTICIPANTES p2 ON p2.PAIS = p.NUM_PAIS JOIN JUGADORES j ON j.N_ASOCIADO = p2.NUM_ASOCIADO
GROUP BY p.NUM_PAIS
HAVING MIN(j.NIVEL)>=3 ;
										
										

SELECT * FROM PAISES p ;
SELECT * FROM PARTICIPANTES p ;
SELECT * FROM JUGADORES j ;
SELECT * FROM ALOJAMIENTOS a ;
SELECT * FROM PARTIDAS p ;
SELECT * FROM CONTRINCANTES c ;
SELECT * FROM HOTELES h ;
SELECT * FROM SALAS s ;
SELECT * FROM MOVIMIENTOS m ;
