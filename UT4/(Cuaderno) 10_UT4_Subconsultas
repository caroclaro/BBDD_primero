SELECT * FROM MULTAS mu ;
SELECT * FROM MATRICULAS ma ;
SELECT * FROM PERSONAS p ;

--1. Devuelve las multas cuyo importe sea mayor que la multa más alta en CASTELLANA.
SELECT *
FROM MULTAS m
WHERE m.IMPORTE > (SELECT max(m2.importe)
FROM MULTAS m2
WHERE m2.lugar LIKE('CASTELLANA%'))

--2. Devuelve nombre de la persona, matrícula del coche y lugar de la multa para la multa más alta.
SELECT p.NOMBRE, m.MATRICULA , m2.LUGAR
FROM PERSONAS p JOIN MATRICULAS m ON m.DNI = p.DNI JOIN MULTAS m2
ON m2.MATRICULA =m.MATRICULA
WHERE m2.importe =(SELECT max(m3.importe)
FROM MULTAS m3 );

--3. Devuelve nombre de la persona, matrícula del coche y lugar de la multa para la multa má baja.
SELECT p.NOMBRE, m.MATRICULA , m2.LUGAR
FROM PERSONAS p JOIN MATRICULAS m ON m.DNI = p.DNI JOIN MULTAS m2
ON m2.MATRICULA =m.MATRICULA
WHERE m2.importe =(SELECT min(m3.importe)
FROM MULTAS m3 );

--4. Devuelve nombre de la persona, matrícula del coche y lugar de la multa para todas las
--multas por encima de la media de importe de las multas.
SELECT p.NOMBRE, m.MATRICULA , m2.LUGAR
FROM PERSONAS p JOIN MATRICULAS m ON m.DNI = p.DNI JOIN MULTAS m2
ON m2.MATRICULA =m.MATRICULA
WHERE m2.importe >(SELECT AVG(m3.importe)
FROM MULTAS m3 );

--5. Devuelve las personas y el número de multas que ha tenido cada persona (incluyendo
--también las personas que no han tenido multas)
SELECT COUNT(m2."REF"), p.NOMBRE
FROM PERSONAS p LEFT JOIN MATRICULAS m ON m.DNI = p.DNI LEFT JOIN
MULTAS m2 ON m2.MATRICULA =m.MATRICULA
GROUP BY p.NOMBRE ;

--6. Devuelve para cada persona la multa más alta que tenga, el coche (matrícula) con el que se
--la han puesto y el lugar donde se la han puesto.
SELECT p.NOMBRE, m.MATRICULA, m2.LUGAR , m2.IMPORTE
FROM PERSONAS p JOIN MATRICULAS m ON m.DNI = p.DNI JOIN MULTAS m2
ON m2.MATRICULA =m.MATRICULA
WHERE (m2.importe, p.nombre) IN (SELECT max(m3.importe), p2.nombre
FROM MULTAS m3 JOIN MATRICULAS m4 ON
m4.matricula = m3.matricula JOIN PERSONAS p2 ON p2.DNI = m4.DNI
GROUP BY p2.NOMBRE
);
--otra manera, en el join
SELECT p.nombre, m.matricula, m.importe, m.lugar
FROM MULTAS m INNER JOIN MATRICULAS ma ON
ma.MATRICULA=m.matricula INNER JOIN PERSONAS p ON p.DNI = ma.DNI
INNER JOIN (SELECT
MAX(m2.importe)MAX_IMPORTE, p2.DNI DOCUMENTO FROM MULTAS m2
INNER JOIN MATRICULAS ma2 ON ma2.matricula =
m2.matricula
INNER JOIN PERSONAS p2 ON p2.DNI = ma2.DNI
GROUP BY p2.dni)MI_TABLA ON
MI_TABLA.DOCUMENTO = p.dni
WHERE mi_TABLA.max_importe = m.importe
ORDER BY 1;

--7. Consulta persona, matrícula, importe de la multa y lugar para todas las multas cuyo importe
--coincida con el importe de alguna multa puesta en la calle VELAZQUEZ.
SELECT p.NOMBRE, m.MATRICULA ,m2.IMPORTE , m2.LUGAR
FROM PERSONAS p JOIN MATRICULAS m ON m.DNI = p.DNI JOIN MULTAS m2
ON m2.MATRICULA =m.MATRICULA
WHERE m2.importe IN (SELECT m3.importe
FROM MULTAS m3
WHERE m3.LUGAR LIKE ('VELAZQUEZ%'));
--8. Consulta persona, matrícula, importe de la multa y lugar para todas las multas de personas
--que tengan más de 1 multa
SELECT * FROM PERSONAS p JOIN (
SELECT ma.DNI DOCUMENTO, COUNT(m.ref)FROM MULTAS m JOIN
MATRICULAS ma ON ma.matricula = m.matricula
GROUP BY ma.DNI
HAVING COUNT (m.ref)>1) MI_TABLA ON MI_TABLA.documento= p.dni
JOIN MATRICULAS ma ON ma.DNI=p.DNI
JOIN MULTAS m ON m.MATRICULA = ma.matricula;

--9. Consulta las personas que NO han tenido multas. Si puedes, hazlo de 2 formas distintas.
SELECT * FROM PERSONAS p
WHERE p.DNI NOT IN (
SELECT p2.DNI
FROM MULTAS m
INNER JOIN MATRICULAS ma ON ma.matricula = m.matricula
INNER JOIN PERSONAS p2 ON p2.DNI = ma.DNI );

--10. Devuelve la suma de todas las multas agrupadas por el primer caracter de la matrícula
--siempre que para ese primer caracter de la matrícula exista una multa que supere la media de
--importes de las multas.
SELECT
SUBSTR(m.MATRICULA,1,1) AS MATRICULA_CARACATER_1,
SUM(m.IMPORTE) AS suma_multas,
MAX(m.IMPORTE) AS IMPORTE_MAXIMO
FROM MULTAS m
GROUP BY SUBSTR(m.MATRICULA,1,1)
HAVING MAX(m.IMPORTE)>=(SELECT AVG(m.IMPORTE) FROM MULTAS m );
