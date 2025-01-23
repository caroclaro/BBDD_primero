SELECT * FROM FICHAJES f;
SELECT * FROM AGENDA a ;
SELECT * FROM DOCUMENTOSIMPRIMIDOS d ;
SELECT * FROM LLAMADASTELEFONICAS l ;
SELECT * FROM EMPLEADOS e ;
SELECT * FROM DEPARTAMENTOS d  ;
SELECT * FROM LIBROSCOMPRADOS l ;

SELECT * FROM EMPLEADOS e WHERE e.NOMBRE LIKE ('Leonard');
--ID 3        TELEFONO 938740201             DIRECTOR DEPARTAMENTO I*D             Guillem Cata 9, 1 Barcelona

SELECT * FROM DOCUMENTOSIMPRIMIDOS d ;

SELECT * FROM EMPLEADOS e WHERE e.APELLIDO1 LIKE ('Cameron');
--Tiene un hermano ID 21 llamado Marc Cameron Callaghan  TELEFONO 938740801   DIRECTOR DEPARTAMENTO comercial   Mediterrani 111, 1 Barcelona
-- Su padre es el director general Jan Cameron Murphy  TELEFONO 938740101

SELECT * FROM LLAMADASTELEFONICAS l WHERE ORIGEN LIKE ('938740201') OR DESTINO LIKE ('938740201');
-- 60	938740501	938740201	2020-10-16 18:03:00.000	2020-10-16 18:07:00.000
--Llamada que recibió el dia que murió a la hora de morir
-- 58	938740201	938740203	2020-10-16 17:15:00.000	2020-10-16 17:17:00.000
-- Llamada del mismo dia
-- 938740501 habla mucho con el

SELECT * FROM EMPLEADOS e WHERE e.TELEFONO LIKE ('938740501');
--Con la que habla mucho es Laura Essa Nasser Jefa de Oncologia ID 12

SELECT * FROM FICHAJES f WHERE f.EMPLEADO LIKE (3) OR f.EMPLEADO LIKE (12);
-- El dia de su muerte entró a las 9:21 am y no salio
--El dia de su muerte la chica entró a las 18:08
--El resto de dias siempre salian juntos y ella solia entrar por la mañana

SELECT * FROM FICHAJES f WHERE f.EMPLEADO LIKE (21);
--El dia de la muerte su hermano salió a las 18:26

SELECT * FROM LLAMADASTELEFONICAS l WHERE ORIGEN LIKE ('938740501') OR DESTINO LIKE ('938740501');
--Le llamó 5 minutos, seguía vivo y colgó un minuto antes de entrar en la compañia el dia de su muerte

SELECT * FROM LIBROSCOMPRADOS l WHERE l.DEPARTAMENTO LIKE ('5');
-- Cancer: Principles - Practices of Oncology, Cancer: The Facts, A Primer of Brain Tumors (departamento chica)

SELECT * FROM LIBROSCOMPRADOS l WHERE l.DEPARTAMENTO LIKE ('2');
-- Enciclopedia de farmacia practica, Pharmakoteka, Farmacia clinica, Membrane interaction of polymyxin B and synthetic analogues studied in biomimetic systems: implications for antibacterial action 
 
SELECT * FROM LIBROSCOMPRADOS l WHERE l.DEPARTAMENTO LIKE ('8');
--Pharmacology - Toxicology, What are Novichok agents and what do they do (su hermano)

SELECT * FROM DOCUMENTOSIMPRIMIDOS d ;
--Autorizacion de desconexion de su padre, el dia de su muerte por el cancer, por que ya habia hecho su testamento el 12 (17:58)

SELECT * FROM AGENDA a ;

SELECT * FROM EMPLEADOS e WHERE e.TELEFONO LIKE ('938740203'); --habló con Neus antes dos minutos, 15 antes de la reunion
SELECT * FROM FICHAJES f WHERE f.EMPLEADO LIKE (5);  --El dia de la muerte salió a las 18:12


--Autorizacion de desconexion de su padre, el dia de su muerte por el cancer, por que ya habia hecho su testamento el 12 (17:58)
--Pharmacology - Toxicology, What are Novichok agents and what do they do (su hermano)
--El resto de dias SIEMPRE salian juntos y ella solia entrar por la mañana y se llamaban mucho
----Le llamó 5 minutos, seguía vivo y colgó un minuto antes de entrar en la compañia el dia de su muerte
