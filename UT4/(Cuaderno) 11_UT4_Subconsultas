SELECT * FROM JOB_HISTORY jh ;
SELECT * FROM EMPLOYEES e ;
SELECT * FROM DEPARTMENTS d ;
SELECT * FROM JOBS j ;
SELECT * FROM LOCATIONS l ;
SELECT * FROM REGIONS r ;
SELECT * FROM COUNTRIES c ;

--1. Devuelve el nombre del empleado que más gana
SELECT *
FROM EMPLOYEES e
WHERE e.SALARY = (SELECT MAX(e2.SALARY)
FROM EMPLOYEES e2);

--2. Devuelve el nombre del empleado que más gana de cada departamento. Añade al listado el
--nombre del departamento.
SELECT e.FIRST_NAME, e.LAST_NAME , e.DEPARTMENT_ID , e.SALARY
FROM EMPLOYEES e
WHERE (e.DEPARTMENT_ID, e.SALARY) IN (SELECT e2.DEPARTMENT_ID,MAX(e2.SALARY)
FROM EMPLOYEES e2
GROUP BY e2.DEPARTMENT_ID);

--3. Devuelve un listado con nombre del departamento, nombre del empleado y salario para
--todos los empleados que ganen más que la media de la empresa.
SELECT d.DEPARTMENT_NAME , e.FIRST_NAME , e.LAST_NAME , e.SALARY
FROM EMPLOYEES e JOIN DEPARTMENTS d ON d.DEPARTMENT_ID=e.DEPARTMENT_ID
WHERE e.SALARY > (SELECT AVG(e2.SAlary)
FROM EMPLOYEES e2);

--4. Devuelve un listado con nombre del departamento, nombre del empleado y salario para
--todos los empleados que ganen más que la media de su departamento.
SELECT d.DEPARTMENT_NAME , e.FIRST_NAME , e.LAST_NAME , e.SALARY
FROM EMPLOYEES e JOIN DEPARTMENTS d ON d.DEPARTMENT_ID=e.DEPARTMENT_ID
WHERE e.SALARY > (SELECT AVG(e2.SAlary)
FROM EMPLOYEES e2
WHERE e2.DEPARTMENT_ID = e.DEPARTMENT_ID);

--5. Haz un listado con nombre del puesto, nombre del empleado y fecha de contratación para el
--empleado más antiguo por cada puesto de trabajo.
SELECT j.JOB_TITLE , e.FIRST_NAME , e.LAST_NAME , e.HIRE_DATE
FROM EMPLOYEES e JOIN JOBS j ON j.JOB_ID = e.JOB_ID
WHERE HIRE_DATE IN (SELECT MIN(HIRE_DATE)
FROM EMPLOYEES e2
WHERE e2.JOB_ID = e.JOB_ID);

--6. Haz un listado con nombre del departamento, nombre del empleado y salario para todos los
--empleados en cuyo departamento haya algún empleado que gane menos que ellos.
SELECT d.DEPARTMENT_NAME , e.FIRST_NAME , e.LAST_NAME , e.SALARY
FROM EMPLOYEES e JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
WHERE e.SALARY > (SELECT MIN(e2.SALARY)
FROM EMPLOYEES e2
WHERE e.DEPARTMENT_ID = e2.department_ID);

--7 Haz un listado de las ciudades en las que no está ubicado ningún departamento
SELECT DISTINCT l.CITY
FROM LOCATIONS l
WHERE l.LOCATION_ID NOT in (SELECT DISTINCT d2.LOCATION_ID
FROM DEPARTMENTS d2 );

--8 Haz un listado con el puesto de trabajo, nombre del puesto, y todos los empleados
--pertenecientes a este puesto menos el último que se ha contratado.
--no está bien
SELECT j.JOB_TITLE , e.FIRST_NAME , e.LAST_NAME
FROM EMPLOYEES e JOIN JOBS j ON j.JOB_ID = e.JOB_ID
WHERE e.HIRE_DATE < ( SELECT MAX(e2.HIRE_DATE)
FROM EMPLOYEES e2);

--9 Haz un listado con las ciudades, el empleado que más gana de cada ciudad (nombre, apellido
--y salario) y la diferencia de salario que hay entre el empleado que más gana y la media de
--salarios de su ciudad
SELECT l.city, e.first_name, e.last_name, e.salary, e.salary - TABLA.MEDIA
FROM LOCATIONS l
JOIN DEPARTMENTS d ON l.LOCATION_ID = d.LOCATION_ID
JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
JOIN ( SELECT l2.city AS CIUDAD, MAX(e2.salary) AS max_sal , AVG(e2.salary) AS media
FROM LOCATIONS l2
JOIN DEPARTMENTS d2 ON l2.LOCATION_ID = d2.LOCATION_ID
JOIN EMPLOYEES e2 ON d2.DEPARTMENT_ID = e2.DEPARTMENT_ID
GROUP BY l2.city) TABLA ON TABLA.CIUDAD = l.city
WHERE e.salary = tabla.max_sal;
--otra manera de pensarlo
SELECT DISTINCT l.city,
(SELECT MAX(e2.salary) AS media
FROM LOCATIONS l2
JOIN DEPARTMENTS d2 ON l2.location_id = d2.location_id
JOIN EMPLOYEES e2 ON e2.department_id = d2.department_id
WHERE l2.city = l.city) -
(SELECT AVG(e2.salary) AS media
FROM LOCATIONS l2
JOIN DEPARTMENTS d2 ON l2.location_id = d2.location_id
JOIN EMPLOYEES e2 ON e2.department_id = d2.department_id
WHERE l2.city = l.city) AS diferencia
FROM LOCATIONS l

--10 (difícil) Haz un listado con los departamentos cuya media de salarios está por encima de la
--media de salarios de la empresa. Incluye entre las columnas del listado dos que indiquen
--● Cuantos empleados del departamento tienen un salario por encima de la media de la empresa
--● Cuantos empleados del departamento tienen un salario por encima de la media del departamento.
SELECT *
FROM DEPARTMENTS d2
WHERE d2.DEPARTMENT_ID IN (
SELECT
d.department_id
FROM DEPARTMENTS d
JOIN EMPLOYEES e2 ON
e2.department_ID = d.department_id
GROUP BY d.department_id
HAVING AVG(e2.salary)>(SELECT
AVG(e.salary)
FROM EMPLOYEES e));

--11 Haz un listado que me de los trabajos que cumplan que la suma de los sueldos de los
--empleados de ese trabajo es superior a la suma de salario de los empleados que trabajan de
--IT_PROG. En el listado quiero ver descripción del trabajo, suma de salario de los trabajadores y
--fecha de contratación del empleado más antiguo que desempeña ese trabajo.
SELECT j.JOB_TITLE , SUM(e.SALARY), MIN(e.HIRE_DATE)
FROM EMPLOYEES e JOIN JOBS j ON j.JOB_ID = e.JOB_ID
GROUP BY j.JOB_TITLE
HAVING SUM(e.SALARY) > (SELECT SUM(e2.salary)
FROM EMPLOYEES e2
WHERE e2.JOB_ID LIKE ('IT_PROG'));

--12 (difícil) Haz un listado que me de el nombre y salario de un empleado y la diferencia salarial
--que tiene con la media del salario de los empleados que son jefes, pero sin considerar a su
--propio jefe
-- no se pensar
SELECT e.FIRST_NAME AS nombre , e.SALARY AS salario_empleado,
(SELECT AVG(e2.salary)
FROM EMPLOYEES e2
WHERE e2.employee_id IN (SELECT e3.manager_id
FROM EMPLOYEES e3
WHERE e3.manager_id !=
e.MANAGER_ID)) AS media_jefes
FROM EMPLOYEES e ;
