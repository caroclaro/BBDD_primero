SELECT * FROM INFORME_ESCENA_CRIMEN iec WHERE "TYPE" = 'murder' AND CITY='Gotham';

-- Security footage shows that there were 2 witnesses. The first witness lives at the last house on Capital Av. The second witness, named Susan, lives somewhere on Franklin Ave.

SELECT * FROM PERSONA p ;
SELECT * FROM PERSONA p WHERE UPPER( NAME) LIKE '%SUSAN%' AND upper( ADDRESS_STREET_NAME) LIKE '%FRANKLIN%';
-- id 16371   license 490173 Susan 
SELECT * FROM PERSONA p WHERE  upper( ADDRESS_STREET_NAME) LIKE '%CAPITAL%' ORDER BY ADDRESS_NUMBER  DESC ;
-- id 14882  license 118009 Peter

SELECT * FROM DECLARACIONES d WHERE PERSON_ID='16371' OR PERSON_ID = '14882';
-- I heard a gunshot and then saw a man run out. He had a Get Fit Now Gym bag. The membership number on the bag started with 4. Only gold members have those bags.
-- The man got into a car with a plate that included the letter H.  (Peter)

-- I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

SELECT * FROM SOCIOS_GIMNASIO sg;
SELECT * FROM SOCIOS_GIMNASIO sg WHERE MEMBERSHIP_STATUS = 'gold' AND id LIKE '4%'

-- FUERA 4JX11 id   32828 person id   Earnest Dambrose name    2017/08/31 start
-- 44VO2 id   86834 person id   Aaron Larcher name    2017/11/22 start
-- 48Z17 id   67297 person id   Larry Preston name    2016/01/01 start

SELECT * FROM PERSONA p WHERE id= '32828' OR id= '86834' OR id= '67297' ;

--  232668   Earnest Dambrose       423327   Larry Preston            338012  Aaron Larcher

SELECT * FROM PERMISO_CIRCULACION pc WHERE id= '232668' OR id= '423327' OR id= '338012' ;

--Larry Preston    Aaron Larcher

SELECT * FROM GIMNASIO_ENTRADAS_SALIDAS ges WHERE (MEMBERSHIP_ID = '44VO2' OR MEMBERSHIP_ID = '48Z17');

SELECT * FROM DECLARACIONES d WHERE PERSON_ID='67297';
-- I was hired by a woman with a lot of money. I dont know her name but I know shes around 55 (65) or 57 (67).
-- She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.

SELECT * FROM PERMISO_CIRCULACION pc WHERE CAR_MAKE  = 'Tesla' AND CAR_MODEL = 'Model S' ;
SELECT * FROM REDES_SOCIALES_EVENTOS rse  WHERE EVENT_NAME = 'SQL Symphony Concert' AND FECHA LIKE '201712__'; 
AND PERSON_ID = '291182' OR  PERSON_ID = '202298' OR  PERSON_ID = '467669' OR PERSON_ID = '638311' OR PERSON_ID = '682231' OR PERSON_ID = '736081' OR PERSON_ID = '918773' ;
-- 291182   202298   467669    638311     682231   736081   918773

SELECT * FROM PERSONA p WHERE id='99708'
Monica Bryant
SELECT * FROM PERMISO_CIRCULACION pc WHERE ID='202298'
