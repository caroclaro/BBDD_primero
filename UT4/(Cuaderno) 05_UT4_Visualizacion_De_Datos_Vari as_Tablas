HR

--1 Devuelve el listado con el nombre, apellidos, email y nombre del departamento al que pertenecen todos los empleados.
SELECT e.FIRST_NAME , e.LAST_NAME , e.EMAIL, d.DEPARTMENT_NAME FROM
EMPLOYEES e JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID ;

--2 A la consulta anterior añade la descripción de su puesto de trabajo.
SELECT e.FIRST_NAME , e.LAST_NAME , e.EMAIL, d.DEPARTMENT_NAME FROM
EMPLOYEES e JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID JOIN
JOBS j ON e.JOB_ID = j.JOB_ID ;

--3 Haz un listado con todos los departamentos y el nombre y apellido del manager del departamento
SELECT d.DEPARTMENT_NAME , e.FIRST_NAME , e.LAST_NAME FROM EMPLOYEES e JOIN
DEPARTMENTS d ON d.MANAGER_ID = e.EMPLOYEE_ID ;

--4 Al listado anterior, añade la ciudad dónde se ubican los departamentos.
SELECT d.DEPARTMENT_NAME , e.FIRST_NAME , e.LAST_NAME, l.CITY FROM EMPLOYEES e
JOIN DEPARTMENTS d ON d.MANAGER_ID = e.EMPLOYEE_ID JOIN LOCATIONS l ON
l.LOCATION_ID = d.LOCATION_ID ;

--5 listado anterior, añade el país dónde se ubican los departamentos.
SELECT d.DEPARTMENT_NAME , e.FIRST_NAME , e.LAST_NAME, l.CITY, c.COUNTRY_NAME
FROM EMPLOYEES e JOIN DEPARTMENTS d ON d.MANAGER_ID = e.EMPLOYEE_ID JOIN
LOCATIONS l ON l.LOCATION_ID = d.LOCATION_ID JOIN COUNTRIES c ON c.COUNTRY_ID =
l.COUNTRY_ID ;

--6 Haz un listado con los departamentos y su dirección pero sólo deben salir los departamentos ubicados en Italia.
SELECT l.STREET_ADDRESS , d.DEPARTMENT_NAME FROM DEPARTMENTS d JOIN
LOCATIONS l ON l.LOCATION_ID = d.LOCATION_ID WHERE l.COUNTRY_ID = 'IT';

--7 Haz un listado con los departamentos y su dirección pero sólo deben salir los departamentos ubicados en América.
SELECT l.STREET_ADDRESS , d.DEPARTMENT_NAME FROM DEPARTMENTS d JOIN
LOCATIONS l ON l.LOCATION_ID = d.LOCATION_ID WHERE l.COUNTRY_ID = 'US';

--8 Haz un listado con nombre, apellido, teléfono, ciudad donde está el departamento y salario para los empleados que trabajan en Europa y ganan más de 10.000$.
SELECT e.FIRST_NAME , e.LAST_NAME , e.PHONE_NUMBER , e.SALARY FROM
DEPARTMENTS d JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID JOIN
LOCATIONS l ON l.LOCATION_ID = d.LOCATION_ID JOIN COUNTRIES c ON c.COUNTRY_ID =
l.COUNTRY_ID WHERE ((c.REGION_ID =1) AND (e.SALARY >10000)) ;

--9 Haz un listado con las descripciones de los trabajos que se hacen en la región de América. Ojo, no deben salir duplicados.
SELECT DISTINCT j.JOB_TITLE FROM JOBS j JOIN EMPLOYEES e ON e.JOB_ID = j.JOB_ID
JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID JOIN LOCATIONS l ON
l.LOCATION_ID = d.LOCATION_ID JOIN COUNTRIES c ON c.COUNTRY_ID = l.COUNTRY_ID
WHERE c.REGION_ID =2;

--10 Haz un listado con nombre, apellido, teléfono, ciudad donde está el departamento y salario para
los empleados que trabajan en Toronto o Munich.
SELECT e.FIRST_NAME , e.LAST_NAME , e.PHONE_NUMBER, l.STREET_ADDRESS, e.SALARY
FROM EMPLOYEES e JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
JOIN LOCATIONS l ON l.LOCATION_ID = d.LOCATION_ID WHERE l.CITY LIKE ('Toronto') OR
l.CITY LIKE ('Munich') ;

--11 Haz un listado con el nombre y apellidos del empleado, nombre y apellidos de su jefe y la diferencia de salario entre el empleado y el jefe
SELECT e.FIRST_NAME , e.LAST_NAME, e2.FIRST_NAME , e2.LAST_NAME, (e2.SALARYe.salary) FROM EMPLOYEES e JOIN EMPLOYEES e2 ON E.MANAGER_ID = e2.EMPLOYEE_ID ;

--12 Haz un listado con las ciudades de Europa, sin repetir, dónde hay trabajadores cuyo puesto de trabajo incluye en la descripción la palabra “Representative”
SELECT l.CITY FROM JOBS j JOIN EMPLOYEES e ON e.JOB_ID = j.JOB_ID JOIN
DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID JOIN LOCATIONS l ON
l.LOCATION_ID = d.LOCATION_ID JOIN COUNTRIES c ON c.COUNTRY_ID = l.COUNTRY_ID
WHERE (c.REGION_ID =1 AND (upper(j.JOB_TITLE) = '%REPRESENTATIVE%'));

--13 Haz un listado con los países que en esta BBDD tienen alguna dirección cuyo código postal empieza por 2,4, 6 u 8,
SELECT COUNTRY_NAME FROM COUNTRIES c JOIN LOCATIONS l ON l.COUNTRY_ID =
c.COUNTRY_ID WHERE l.POSTAL_CODE LIKE ('2%') OR l.POSTAL_CODE LIKE ('4%') OR
l.POSTAL_CODE LIKE ('6%') OR l.POSTAL_CODE LIKE ('8%') ;

--14 Haz un listado con los empleados cuyo salario está por debajo del rango salarial que mcorresponde a su puesto de trabajo.
SELECT e.FIRST_NAME , e.LAST_NAME , e.SALARY, j.MIN_SALARY FROM EMPLOYEES e
JOIN JOBS j ON e.JOB_ID = j.JOB_ID WHERE (j.MIN_SALARY > e.SALARY);

--15. Haz un listado con los empleados cuyo salario está por encima del rango salarial que corresponde a su puesto de trabajo
SELECT e.FIRST_NAME , e.LAST_NAME , e.SALARY, j.MAX_SALARY FROM EMPLOYEES e
JOIN JOBS j ON e.JOB_ID = j.JOB_ID WHERE (j.MAX_SALARY < e.SALARY);

--16Haz un listado con los empleados cuyo salario es igual al mínimo del rango salarial que corresponde a su puesto de trabajo o es
-- igual al máximo del rango salarial que corresponde a su puesto de trabajo.
SELECT e.FIRST_NAME , e.LAST_NAME , e.SALARY, j.MIN_SALARY, j.MAX_SALARY FROM
EMPLOYEES e JOIN JOBS j ON e.JOB_ID = j.JOB_ID WHERE (j.MIN_SALARY =e.SALARY) OR
(j.MAX_SALARY =e.SALARY) ;
