MULTAS

SELECT * FROM MULTAS mu ;
SELECT * FROM MATRICULAS ma ;
SELECT * FROM PERSONAS p ;

-- 1. Devuelve el listado con el nombre de las personas y la matrícula de los coches que tienen
SELECT p.NOMBRE, m.MATRICULA FROM PERSONAS p join MATRICULAS m ON p.DNI = m.DNI;

--2. Devuelve el listado con el nombre de las personas y la matrícula de los coches que tienen. Ordena el resultado por el nombre de la
-- persona de forma ascendente y luego por la matrícula de forma descendente
SELECT p.NOMBRE, m.MATRICULA FROM PERSONAS p join MATRICULAS m ON p.DNI = m.DNI
ORDER BY p.NOMBRE ASC, m.MATRICULA DESC ;

--3. Devuelve un listado de todas las multas. En el listado queremos ver el DNI de la persona, la matrícula, el importe y el lugar
--de la multa. Ordenaremos por DNI de forma ascendente y luego por lugar de forma descendente.
SELECT ma.DNI , mu.MATRICULA, mu.IMPORTE , mu.LUGAR FROM MULTAS mu JOIN
MATRICULAS ma ON ma.MATRICULA = mu.MATRICULA ORDER BY ma.DNI ASC, mu.LUGAR
DESC ;

--4. Devuelve un listado de todas las multas. En el listado queremos ver el nombre de la persona, el DNI de la persona, la matrícula,
--el importe y el lugar de la multa. Ordenaremos por nombre de forma descendente y luego por
importe de forma descendente
SELECT p.NOMBRE, ma.DNI , mu.MATRICULA, mu.IMPORTE , mu.LUGAR FROM PERSONAS p
JOIN MATRICULAS ma ON p.DNI = ma.DNI JOIN MULTAS mu ON ma.MATRICULA =
mu.MATRICULA ORDER BY p.NOMBRE DESC , mu.IMPORTE DESC ;

--5 Devuelve un listado de las multas de más de 100€. En el listado queremos ver el nombre de la persona, el DNI de la persona, la
-- matrícula, el importe y el lugar de la multa. Ordenaremos por nombre de forma descendente y
luego por importe de forma descendente.
SELECT p.NOMBRE, ma.DNI , mu.MATRICULA, mu.IMPORTE , mu.LUGAR FROM PERSONAS p
JOIN MATRICULAS ma ON p.DNI = ma.DNI JOIN MULTAS mu ON ma.MATRICULA =
mu.MATRICULA WHERE mu.IMPORTE >100 ORDER BY p.NOMBRE DESC , mu.IMPORTE DESC
;

--6 Devuelve un listado de las multas de menos de 100€ y para las personas cuyo nombre empiece por C. En el listado queremos ver el
-- nombre de la persona, el DNI de la persona, la matrícula, el importe y el lugar de la multa.
SELECT p.NOMBRE, ma.DNI , mu.MATRICULA, mu.IMPORTE , mu.LUGAR FROM PERSONAS p
JOIN MATRICULAS ma ON p.DNI = ma.DNI JOIN MULTAS mu ON ma.MATRICULA =
mu.MATRICULA WHERE mu.IMPORTE <100 AND p.NOMBRE LIKE ('C%');

--7. Devuelve un listado de las multas de entre 50 y 100€ y para las personas cuyo nombre empiece por C y cuyo DNI contenga un 8 .
--En el listado queremos ver el nombre de la persona, el DNI de la persona, la matrícula, el importe y el lugar de la multa.
SELECT p.NOMBRE, ma.DNI , mu.MATRICULA, mu.IMPORTE , mu.LUGAR FROM PERSONAS p
JOIN MATRICULAS ma ON p.DNI = ma.DNI JOIN MULTAS mu ON ma.MATRICULA =
mu.MATRICULA WHERE mu.IMPORTE BETWEEN 50 AND 100 AND p.NOMBRE LIKE ('C%') AND
ma.DNI LIKE ('%8%');

--8 Devuelve un listado de las multas de 50€, las de 100€ y las que se hayan producido en la calle Alcalá. En el listado queremos ver el
-- nombre de la persona, el DNI de la persona, la matrícula, el importe y el lugar de la multa.
SELECT p.NOMBRE, ma.DNI , mu.MATRICULA, mu.IMPORTE , mu.LUGAR FROM PERSONAS p
JOIN MATRICULAS ma ON p.DNI = ma.DNI JOIN MULTAS mu ON ma.MATRICULA =
mu.MATRICULA WHERE ((mu.IMPORTE= '50') OR (mu.IMPORTE = '100') OR (mu.LUGAR
LIKE('ALCALA%')));

--9 Devuelve un listado de las multas de 50€ y las de 100€ que se hayan producido en la calle Alcalá. En el listado queremos ver el
-- nombre de la persona, el DNI de la persona, la matrícula, el importe y el lugar de la multa
SELECT p.NOMBRE, ma.DNI , mu.MATRICULA, mu.IMPORTE , mu.LUGAR FROM PERSONAS p
JOIN MATRICULAS ma ON p.DNI = ma.DNI JOIN MULTAS mu ON ma.MATRICULA =
mu.MATRICULA WHERE ((mu.IMPORTE= '50') OR (mu.IMPORTE = '100') AND (mu.LUGAR
LIKE('ALCALA%')));

--10 es la misma que la nueve

--11. Devuelve un listado con las distintas personas (el nombre) de aquellas personas que han tenido multas en lugares que contengan una A.
SELECT DISTINCT p.NOMBRE, mu.LUGAR FROM PERSONAS p JOIN MATRICULAS ma ON
p.DNI = ma.DNI JOIN MULTAS mu ON ma.MATRICULA = mu.MATRICULA WHERE
UPPER(mu.LUGAR) LIKE ('%A%');

--12 Devuelve un listado con las distintas personas (el nombre) y las distintas matrículas de aquellas personas que han tenido multas en
-- lugares que contengan una A.
SELECT DISTINCT p.NOMBRE, mu.LUGAR, mu.MATRICULA FROM PERSONAS p JOIN
MATRICULAS ma ON p.DNI = ma.DNI JOIN MULTAS mu ON ma.MATRICULA = mu.MATRICULA
WHERE UPPER(mu.LUGAR) LIKE ('%A%');

--13 Devuelve un listado de las multas en las que el nombre de la persona empieza por la misma letra que el lugar donde han les han
--puesto la multa. En el listado queremos ver el nombre de la persona, el DNI de la persona, la matrícula, el importe y el lugar de la multa
SELECT p.NOMBRE, ma.DNI , mu.MATRICULA, mu.IMPORTE , mu.LUGAR 
    FROM PERSONAS p
    JOIN MATRICULAS ma ON p.DNI = ma.DNI JOIN MULTAS mu ON ma.MATRICULA = mu.MATRICULA WHERE SUBSTR( p.NOMBRE,1,1)= SUBSTR(mu.LUGAR,1,1) ;

--14 Devuelve un listado de las multas en las que la parte numérica del DNI es divisible por el importe de la multa (el resto
-- de esa división es 0). En el listado queremos ver el nombre de la persona, el DNI de la persona, la matrícula, el importe y el lugar
-- de la multa.
SELECT p.NOMBRE, ma.DNI , mu.MATRICULA, mu.IMPORTE , mu.LUGAR FROM PERSONAS p
JOIN MATRICULAS ma ON p.DNI = ma.DNI JOIN MULTAS mu ON ma.MATRICULA =
mu.MATRICULA WHERE MOD(SUBSTR(p.DNI,1,9), mu.IMPORTE ) =0 ;

--15 Devuelve un listado de las personas cuyo nombre contiene la letra de su DNI
SELECT * FROM PERSONAS p WHERE INSTR(p.NOMBRE,SUBSTR(p.DNI ,-1))>0;
