SELECT * FROM JOB_HISTORY jh ;
SELECT * FROM EMPLOYEES e ;
SELECT * FROM DEPARTMENTS d ;
SELECT * FROM JOBS j ;
SELECT * FROM LOCATIONS l ;
SELECT * FROM REGIONS r ;
SELECT * FROM COUNTRIES c ;

--1. Devuelve los departamentos y en caso de que el departamento tenga manager, los
--datos del manger (nombre, apellidos, salario y fecha de contratación)
SELECT d.DEPARTMENT_NAME, e.FIRST_NAME , e.LAST_NAME , e.SALARY , e.HIRE_DATE
FROM DEPARTMENTS d
LEFT JOIN EMPLOYEES e ON d.MANAGER_ID = e.EMPLOYEE_ID ;

--2. Devuelve los países (código y descripción) y en caso de que haya direcciones en ese
--país, la ciudad de la dirección.
SELECT c.COUNTRY_ID , c.COUNTRY_NAME, l.CITY
FROM COUNTRIES c
LEFT JOIN LOCATIONS l ON l.COUNTRY_ID = c.COUNTRY_ID ;

--3. Al listado anterior, añade código y descripción del departamento.
SELECT c.COUNTRY_ID , c.COUNTRY_NAME, l.CITY , d.DEPARTMENT_ID , d.DEPARTMENT_NAME
FROM COUNTRIES c
LEFT JOIN LOCATIONS l ON l.COUNTRY_ID = c.COUNTRY_ID
LEFT JOIN DEPARTMENTS d ON l.LOCATION_ID = d.LOCATION_ID ;

--4. Al listado anterior, añade el nombre y apellidos del manager.
SELECT c.COUNTRY_ID , c.COUNTRY_NAME, l.CITY , d.DEPARTMENT_ID , d.DEPARTMENT_NAME,
e.FIRST_NAME , e.LAST_NAME
FROM COUNTRIES c
LEFT JOIN LOCATIONS l ON l.COUNTRY_ID = c.COUNTRY_ID
LEFT JOIN DEPARTMENTS d ON l.LOCATION_ID = d.LOCATION_ID
LEFT JOIN EMPLOYEES e ON d.MANAGER_ID = e.EMPLOYEE_ID ;

--5. Devuelve todos los empleados (nombre y apellido) con el nombre del departamento al
--que pertenecen, los departamentos que no tienen empleados y los empleados que no
--tienen departamento. Si puedes haz la select de 2 formas distintas
SELECT e.FIRST_NAME , e.LAST_NAME, d.DEPARTMENT_NAME
FROM EMPLOYEES e
FULL OUTER JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID;
--Realiza las consultas utilizando UNION, UNION ALL, INTERSEC, MINUS

--6. Devuelve un listado que muestre el salario medio, máximo y mínimo de los empleados
--con comisión y los mismos datos de los empleados sin comisión.
SELECT AVG(e.SALARY), MAX(e.SALARY), MIN(e.SALARY)
FROM EMPLOYEES e
WHERE e.COMMISSION_PCT IS NOT NULL
UNION
SELECT AVG(e.SALARY), MAX(e.SALARY), MIN(e.SALARY)
FROM EMPLOYEES e
WHERE e.COMMISSION_PCT IS NULL ;

--7. Devuelve un listado con el nombre, apellidos y fecha de contratación de los empleados
--y un literal al lado que indique “TIENE EMPLEADOS A SU CARGO” o “NO TIENE EMPLEADOS A SU
CARGO”.
--wdlakpjfpefjpjf
SELECT e.first_name, e.last_name,e.hire_date,'TIENE EMPLEADOS A SU CARGO'as CARGO FROM
employees e
where e.employee_id in (select e.manager_id from employees e)
UNION
SELECT e.first_name, e.last_name,e.hire_date,'NO TIENE EMPLEADOS A SU CARGO'as CARGO FROM
employees e
where e.employee_id NOT IN (select e.manager_id from employees e where e.manager_id is not null);

--8. Devuelve un listado con todos los empleados salvo los que su nombre empieza por
--vocal o ganan más de 12.000$.
SELECT * FROM EMPLOYEES e3
MINUS
(SELECT *
FROM EMPLOYEES e
WHERE e.FIRST_NAME LIKE ('A%') OR e.FIRST_NAME LIKE ('E%') or e.FIRST_NAME LIKE ('I%') OR
e.FIRST_NAME LIKE ('O%') or e.FIRST_NAME LIKE ('U%')
UNION
SELECT *
FROM EMPLOYEES e2
WHERE e2.salary >12000);

--9. Devuelve un listado con todos los empleados salvo los que su nombre empieza por
--vocal y cuyo salario está por encima de la media de su departamento.
--o ganan más de 12.000$
SELECT *
FROM EMPLOYEES e2
WHERE (e2.salary >12000)
MINUS
SELECT *
FROM EMPLOYEES e
WHERE (e.FIRST_NAME LIKE ('A%') OR e.FIRST_NAME LIKE ('E%') or e.FIRST_NAME LIKE ('I%') OR
e.FIRST_NAME LIKE ('O%') or e.FIRST_NAME LIKE ('U%')) AND (e.salary > (SELECT AVG(salary) FROM
EMPLOYEES));
