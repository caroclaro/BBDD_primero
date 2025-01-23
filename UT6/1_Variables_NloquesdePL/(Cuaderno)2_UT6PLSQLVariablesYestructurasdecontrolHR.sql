SELECT * FROM JOB_HISTORY jh ;
SELECT * FROM EMPLOYEES e ;
SELECT * FROM DEPARTMENTS d ;
SELECT * FROM JOBS j ;
SELECT * FROM LOCATIONS l ;
SELECT * FROM REGIONS r ;
SELECT * FROM COUNTRIES c ;

//SIN ACABAR !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--1. Crear un bloque PL que visualice el departamento de un empleado que se pida al usuario por teclado.

DECLARE
	v_empleado EMPLOYEES.EMPLOYEE_ID%TYPE;
	departamento varchar (17);
BEGIN
	v_empleado := :COD;

	SELECT d.department_name INTO departamento
	FROM EMPLOYEES e 
	JOIN DEPARTMENTS d ON d.department_id = e.department_id
	WHERE v_empleado= e.employee_id;

	dbms_output.put_line(' Este empleado pertenece a '||departamento);
END;



--2. Incrementar el salario 100€ a todos los trabajadores que sean ‘IT_PROG’, mediante un bloque anónimo PL, asignando dicho valor a una variable declarada.
DECLARE
	v_JOB_ID varchar (17);
BEGIN
	v_JOB_ID := 'IT_PROG';

	UPDATE EMPLOYEES e 
	SET e.SALARY = (e.SALARY + 100)
	WHERE e.JOB_ID  = v_JOB_ID ;

	dbms_output.put_line ('Actualizado');
END;


(SELECT * FROM EMPLOYEES e);

--3. Crea un bloque de PL/SQL que inserte un nuevo registro en la tabla de empleados. Con las siguientes características:
	--3.a. Pedirá por teclado al usuario un código de empleado válido (employee_id)
	--3.b.Buscará al empleado que menos dinero gane que pertenezca al mismo departamento que el que nos han pasado y duplicará todos sus datos menos
		--3.b.i. El id (sacarlo de la secuencia)
		--3.b.ii. El nombre y apellidos que será: PEPITO GRILLO
		--3.b.iii. La fecha de contratación será hoy.
DECLARE
    v_codempleado employees.employee_id%type;
    v_departamento employees.department_id%type;
    v_salariominimo number;
    v_nuevoempleado employees%rowtype;
BEGIN
    v_codempleado := &cod;

    select department_id into v_departamento
    from employees
    where employee_id = v_codempleado;

    select min(salary) into v_salariominimo
    from employees 
    where department_id = v_departamento;

    select * into v_nuevoempleado
    from employees e
    where e.salary = v_salariominimo
    and e.department_id = v_departamento;

    v_nuevoempleado.employee_id := 777;
    v_nuevoempleado.hire_date := sysdate;
    v_nuevoempleado.first_name := 'Pepito';
    v_nuevoempleado.last_name := 'Grillo';

    INSERT INTO employees VALUES (v_nuevoempleado);
END;
    
		

--4. Diseñar un bloque PL que introduciendo el código de un empleado por teclado, visualice el sueldo y su código, para posteriormente actualizar su comisión teniendo en
--cuenta que si su salario es menor de 3.000 € su comisión será del 10% de este, si está entre 3.000 y 5.000 del 15% y si es mayor de 5.000 el 20%. Posteriormente se
--visualizará su comisión actualizada.
DECLARE
	v_empleado EMPLOYEES.EMPLOYEE_ID%TYPE;
	v_salario EMPLOYEES.SALARY%TYPE;
BEGIN
	v_empleado := :COD;

	SELECT SALARY INTO v_salario
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = v_empleado;
   
   dbms_output.put_line('El sueldo del empleado con código '|| v_empleado || ' tiene un sueldo de ' || v_salario );
   
	IF v_salario<3000 THEN
		UPDATE EMPLOYEES e
		SET e.commission_pct = 0.10
		 WHERE EMPLOYEE_ID = v_empleado;
	ELSE IF v_salario<5000 THEN 
		UPDATE EMPLOYEES e
		SET e.commission_pct = 0.15
		WHERE EMPLOYEE_ID = v_empleado;
	ELSE 
		UPDATE EMPLOYEES e
		SET e.commission_pct = 0.20
		WHERE EMPLOYEE_ID = v_empleado;
	END IF; 

	SELECT COMMISSION_PCT INTO v_salario -- Reutilizando la variable v_salario para este ejemplo.
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = v_empleado;
    DBMS_OUTPUT.PUT_LINE('La nueva comisión del empleado ' || v_empleado || ' es del ' || (v_salario * 100) || '%.');

END;


--5. Introduciendo un año por teclado, decir si este es bisiesto o no.
DECLARE
	v_anyo number(5) := :anyo;
BEGIN
	IF(MOD(v_anyo, 4)=0
		AND mod(v_anyo, 100)!=0)
		OR mod(v_anyo, 400)=0
	THEN dbms_output.put_line(v_anyo||' Anyo bisiesto');
	ELSE dbms_output.put_line(v_anyo||' Anyo NO bisiesto');
	END IF;
END;


--6. Diseñar un bloque de PL que le pida al usuario un código de empleado y que devuelva el mayor divisor del salario del empleado.
DECLARE 
    v_codempleado employees.employee_id%TYPE;
    v_salario employees.salary%TYPE;
    v_maximodiv NUMBER;
BEGIN
    v_codempleado := &cod;
    
    SELECT salary INTO v_salario
    FROM employees
    WHERE employee_id = v_codempleado;

--7. Dado un país introducido por teclado, obtener el número de empleados que hay en ese país.
DECLARE
    v_nombrepais COUNTRIES.country_name%TYPE;
    numempleados NUMBER;
BEGIN
    v_nombrepais := :cod;

    SELECT COUNT(e.employee_ID) INTO numempleados
    FROM COUNTRIES c 
    JOIN LOCATIONS l ON l.COUNTRY_ID = c.COUNTRY_ID 
    JOIN DEPARTMENTS d ON d.LOCATION_ID = l.LOCATION_ID 
    JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID 
    WHERE c.country_name = v_nombrepais;

    DBMS_OUTPUT.PUT_LINE('El número de empleados de ' || v_nombrepais || ' es de: ' || numempleados);
END;

--8. Crear una tabla llamada TANGULOS con tres columnas ángulo, seno, coseno. Rellenar la misma mediante un bloque PL de todos los
--ángulos comprendidos entre 0 y 90, en intervalos de diez en diez.
CREATE TABLE TANGULOS (
    angulo NUMBER,
    seno NUMBER,
    coseno NUMBER
);
DECLARE
    v_angulo NUMBER := 0;
    v_seno NUMBER;
    v_coseno NUMBER;
BEGIN
    WHILE v_angulo <= 90 LOOP
        v_seno := SIN(v_angulo * (3.14 / 180)); 
        v_coseno := COS(v_angulo * (3.14 / 180)); 
        
        INSERT INTO TANGULOS VALUES (v_angulo, v_seno, v_coseno);
        
        v_angulo := v_angulo + 10; 
    END LOOP;
    
    dbms_output.put_line('La tabla TANGULOS se ha llenado exitosamente.');
END;


--9. Haz un bloque anónimo que pida un id de empleado y cuente el número de vocales que hay en su email.


--10. Los departamentos de RRHH e ADMINISTRACIÓN se van a fusionar, por lo que debemos hacer un proceso que:
	--10.a. Genere un nuevo departamento (RRHH+ADMIN)
	--10.b. Cuyo responsable ý localización será igual al del actual de RRHH
		INSERT INTO DEPARTMENTS 
		VALUES ('222', 'RRHH_ADMIN','203','2400');
	--10.c. Asigne a los trabajadores de ambos departamentos el nuevo manager y el nuevo departamento
		




SELECT * FROM JOB_HISTORY jh ;
SELECT * FROM EMPLOYEES e ;
SELECT * FROM DEPARTMENTS d ;
SELECT * FROM JOBS j ;
SELECT * FROM LOCATIONS l ;
SELECT * FROM REGIONS r ;
SELECT * FROM COUNTRIES c ;







