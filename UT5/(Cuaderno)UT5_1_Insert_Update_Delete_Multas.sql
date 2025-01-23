SELECT * FROM MULTAS mu ;
SELECT * FROM MATRICULAS ma ;
SELECT * FROM PERSONAS p ;

--1. Crea un nueva persona indicando con DNI “123456789D” y Nombre “Alumno Aprendiendo”
INSERT INTO PERSONAS p
VALUES ('123456789D','Alumno Aprendiendo');

--2. Inserta 2 coches asociados a esta persona con matrículas '3344-PPP' y '2221-JJJ',
INSERT INTO MATRICULAS m
VALUES ('3344-PPP','123456789D');
INSERT INTO MATRICULAS m
VALUES ('2221-JJJ', '123456789D');

--3. Crea una multa en la CALLE PADRE CLARET de 150€ para el coche con matrícula '2221-JJJ' y otra de 100€ en CALLE CORAZON DE MARIA para el
--coche con matrícula '3344-PPP'.
INSERT INTO MULTAS m (m.lugar, m.importe, m.matricula, m.ref)
VALUES ('CALLE PADRE CLARET','150','2221-JJJ','1111111111');
INSERT INTO MULTAS m (m.lugar, m.importe, m.matricula, m.ref)
VALUES ('CALLE CORAZON DE MARIA','100','3344-PPP',
'2222222222');

--4. Modifica esta última multa y ponla de 200€.
UPDATE MULTAS m
SET m.importe=200
WHERE m.REF=2222222222;

--5. Crea una vista con el nombre vista_personas_total_multas que tenga las siguientes columnas: DNI de la persona, nombre de la persona
--e importe total de multas que tiene considerando todos los coches/matrículas que tenga esa persona.
CREATE OR replace VIEW vista_personas_total_multas AS
SELECT p.DNI, p.NOMBRE, SUM(m2.IMPORTE) AS
importeTotal
FROM PERSONAS p
LEFT JOIN MATRICULAS m ON m.DNI = p.DNI
LEFT JOIN MULTAS m2 ON m2.MATRICULA =m.MATRICULA
GROUP BY p.DNI, p.NOMBRE;
SELECT * FROM VISTA_PERSONAS_TOTAL_MULTAS;

--6. Elimina la persona 222549765B. ¿Es posible eliminarlo? ¿Por qué? Si no pudiste, ¿qué cambios deberías realizar para que fuese posible
--borrarlo?
DELETE FROM PERSONAS p
WHERE p.DNI = '222549765B';
-- no, pq tiene otros registros asociados a el, habría que borrar en
cascada

--7. Elimina la persona 147956320S ¿Es posible eliminarlo?¿Por qué?Si no pudiste, ¿qué cambios deberías realizar para que se pudiera borrar?
DELETE FROM PERSONAS p
WHERE p.DNI = '147956320S';
--si, pq no tiene otros registros asociados a el

--8. Actualiza el DNI de la persona con DNI 452103687F y asígnale el valor 452103687D. ¿Es posible actualizarlo? Si no es posible,
-- ¿qué cambios deberías realizar para que se pudiera actualizar?
UPDATE PERSONAS p
SET p.DNI= '452103687D'
WHERE p.DNI='452103687F';
--si es posible

--9. Actualiza el DNI de la persona 203254778N y asígnale el valor 203254778H. ¿Es posible actualizarlo? Si no es posible,
--¿qué cambios deberías realizar para que fuese posible actualizarlo?
UPDATE PERSONAS p
SET p.DNI= '203254778H'
WHERE p.DNI='203254778N';
--no, habria que cambiarlo en multas tambien, ya que ahi es FK

--10. Crea una nueva columna en la tabla de multas que indique si la multa está pagado. El nombre de la columna será “PAGADO”,
-- será de 1 sólo carácter y el valor para todos los campos debe ser N
ALTER TABLE multas
ADD PAGADO varCHAR(1);
UPDATE multas
SET PAGADO = 'N';

--11. Crea una nueva columna en la tabla de multas que sea “DESC_PUNTOS”. También es un carácter de una única posición y se debe rellenar
-- con la siguiente lógica.
  --1. Para las multas de 200€ o menos => Se rellena con N
  --2. Para las multas de más de 200€ => Se rellena con S
ALTER TABLE MULTAS ADD desc_puntos varchar(1);
SELECT * FROM MULTAS m ORDER BY desc_puntos DESC;
UPDATE MULTAS SET DESC_puntos='N'
WHERE IMPORTE <=200;
UPDATE MULTAS SET DESC_puntos='S'
WHERE IMPORTE >200;

--12. Elimina todas las multas de importe menor a 10€
DELETE multas m WHERE m.importe<10;
SELECT * FROM MULTAS mu ;
SELECT * FROM MATRICULAS ma ;
SELECT * FROM PERSONAS p ;
