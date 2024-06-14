
SELECT * FROM JOB_HISTORY jh ;
SELECT * FROM EMPLOYEES e ;
SELECT * FROM DEPARTMENTS d ;
SELECT * FROM JOBS j ;
SELECT * FROM LOCATIONS l ;
SELECT * FROM REGIONS r ;
SELECT * FROM COUNTRIES c ;

--1. Codificar un procedimiento que permita borrar un empleado cuyo número se pasa en la llamada.
CREATE OR REPLACE PROCEDURE PROC1
			(v_ID IN employees.EMPLOYEE_ID%type) IS 
BEGIN 
			DELETE FROM employees where EMPLOYEE_ID = V_ID;
END;

BEGIN
  PROC1(v_ID => 202); 
END;

--2. Escribir un procedimiento que modifique la descripción de un departamento. El
--procedimiento recibirá como parámetros el número de departamento y la nueva descripción.
--160 beneficios
		--SIN ACABAR
CREATE OR REPLACE PROCEDURE MODIFICA_DEP_DES
    (V_DEPID IN DEPARTMENTS.DEPARTMENT_ID%TYPE,
    V_DEPDES IN DEPARTMENTS.DEPARTMENT_NAME%TYPE
    ) IS
BEGIN
    UPDATE departments DE SET de.department_name=V_DEPDES WHERE de.department_id=V_DEPID;
END MODIFICA_DEP_DES;

SELECT * FROM departments;

BEGIN MODIFICA_DEP_DES(222,'CaroCaroClaro'); END;
--nofunciona nofunciona 

--3. Haz un procedimiento donde visualicemos los 2 departamentos más caros y el total de
--dinero destinado en salarios por esos departamentos (se considera como
--departamentreato más caro aquel cuya suma de sueldos de sus empleados sea la más alta).
CREATE OR REPLACE PROCEDURE expensiveDeptnos IS 
	CURSOR deptnos IS SELECT 
						d.department_name,
						SUM(e.salary) AS salarios
					from departments d
					JOIN employees e ON d.department_id = e.department_id
					GROUP BY d.department_name
					ORDER BY 2 DESC;
			v_count NUMBER := 0;
BEGIN 
	FOR i IN deptnos LOOP
		DBMS_OUTPUT.PUT_LINE(i.department_name || ' '|| i.salarios);
		v_count := v_Count +1;
		IF v_count = 2 THEN
			EXIT;
		END IF;
		
	END LOOP;
END expensiveDeptnos;

BEGIN
    expensiveDeptnos();
END;
	

--4. Haz una función donde se nos muestre el IRPF de un empleado. Si gana por debajo de
--4000 devolverá 10% de su salario y si gana igual o más devolverá 15% de su salario.
DECLARE
	v_id employees.employee_id%TYPE;
 		numsalario NUMBER;

BEGIN 
	v_id := :cod;

    SELECT e.salary into numsalario
			FROM EMPLOYEES e 
			WHERE (e.employee_id= v_id);
		
	IF numsalario<4000 THEN
			DBMS_OUTPUT.PUT_LINE('El IRPF del empleado ' || v_id || ' es de ' || (numsalario*0.10));
    ELSE
        		DBMS_OUTPUT.PUT_LINE('El IRPF del empleado ' || v_id || ' es de ' || (numsalario*0.15));
    END IF;

END;


CREATE OR REPLACE FUNCTION empleIRPF(v_id IN employees.employee_id%TYPE) RETURN NUMBER IS
    numsalario NUMBER;
    irpf NUMBER;
BEGIN
    SELECT e.salary INTO numsalario
    FROM EMPLOYEES e 
    WHERE e.employee_id = v_id;
    
    IF numsalario < 4000 THEN
        irpf := numsalario * 0.10;
    ELSE
        irpf := numsalario * 0.15;
    END IF;

    DBMS_OUTPUT.PUT_LINE('El IRPF del empleado ' || v_id || ' es de ' || irpf);
    RETURN irpf;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el empleado con ID ' || v_id);
        RETURN NULL; -- or appropriate error value
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL; -- or appropriate error value
END;

DECLARE
    tax NUMBER;
BEGIN
    tax := empleIRPF(102); 
END;

--5. Escribir un programa que incremente el salario de los empleados de un determinado
--departamento que se pasará como primer parámetro. El incremento será una cantidad
--en euros que se pasará como segundo parámetro en la llamada. El programa deberá
--informar del número de filas afectadas por la actualización.
CREATE OR REPLACE FUNCTION SUBIDA 
    (V_DEP EMPLOYEES.DEPARTMENT_ID%TYPE,
    V_SUBIDA EMPLOYEES.SALARY%TYPE
    )RETURN NUMBER IS
    V_ACTU NUMBER:=0;
BEGIN
    UPDATE employees EM SET em.salary=em.salary+V_SUBIDA WHERE em.department_id=V_DEP;
    
    SELECT COUNT(em.employee_id)
    INTO V_ACTU
        FROM EMPLOYEES EM
        WHERE em.department_id=V_DEP;
    
    RETURN V_ACTU;
END SUBIDA;

SELECT * FROM departments;
SELECT * FROM EMPLOYEES EM WHERE em.department_id=80;

DECLARE
    DEP_ID NUMBER:=&DEP;
    V_SUB NUMBER:=&DINERO;
    V_ACTU NUMBER;
BEGIN
    V_ACTU:=SUBIDA(DEP_id, V_SUB);
    dbms_output.put_line('ACTUALIZADAS: '||V_ACTU);
END;

CREATE OR REPLACE PROCEDURE SUBIDA_ACT 
    (V_DEP EMPLOYEES.DEPARTMENT_ID%TYPE,
    V_SUBIDA EMPLOYEES.SALARY%TYPE
    ) IS
BEGIN
    UPDATE employees EM SET em.salary=em.salary+V_SUBIDA WHERE em.department_id=V_DEP;
    dbms_output.put_line('ACTUALIZADAS: '||SQL%ROWCOUNT);

END SUBIDA_ACT;

SELECT * FROM departments;
SELECT * FROM EMPLOYEES EM WHERE em.department_id=80;

CALL subida_act(80,5);

--6. Haz una función que reciba el id de empleado y devuelva el número de empleados que tiene a su cargo.

DECLARE
	v_id employees.employee_id%TYPE;
 		numempleados NUMBER;

BEGIN 
	v_id := :cod;

    SELECT COUNT(e.employee_id) into numempleados
			FROM EMPLOYEES e 
			WHERE (e.manager_ID = v_id);
		
	DBMS_OUTPUT.PUT_LINE('El número de empleados que tiene el empleado ' || v_id || ' a su cargo es de ' || numempleados);
END;

CREATE OR REPLACE FUNCTION empleAcargo(v_id IN employees.employee_id%TYPE)
RETURN NUMBER IS
    numempleados NUMBER;
BEGIN
    SELECT COUNT(e.employee_id) INTO numempleados
    FROM EMPLOYEES e 
    WHERE e.manager_ID = v_id;

    DBMS_OUTPUT.PUT_LINE('El número de empleados que tiene el empleado ' || v_id || ' a su cargo es de ' || numempleados);

    RETURN numempleados;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos.');
        RETURN 0;  -- Even though COUNT should not raise this, just as a precaution
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN NULL;
END;

DECLARE
    num_managed NUMBER;
BEGIN
    num_managed := empleAcargo(105);
END;

--7. Haz un procedimiento que reciba como parámetro un código de empleado y Modifica
--el salario de un empleado en función del número de empleados que tiene a su cargo:
	--● si no tiene ningún empleado a su cargo subirle 50 euros
	--● si tiene 1 empleado a su cargo subirle 80 euros
	--● si tiene 2 empleados a su cargo subirle 100 euros
	--● si tiene más de tres empleados a su cargo subirle 110 euros
	--● si es el PRESIDENTE su salario se incrementa en 30 euros
--Para saber el número de empleados a cargo de un trabajador debes llamar a la función del ejercicio anterior

CREATE OR REPLACE PROCEDURE eje7
	(p_employee_id IN EMPLOYEES.EMPLOYEE_ID%TYPE) IS
	    v_id EMPLOYEES.EMPLOYEE_ID%TYPE;
	    num_empleados NUMBER;
	    incremento_salario NUMBER;
	    es_presidente BOOLEAN;
BEGIN
    v_id := p_employee_id;

    -- Determinar si el empleado es el presidente
    SELECT (CASE WHEN JOB_ID = 'PRESIDENT' THEN 1 ELSE 0 END) INTO es_presidente
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = v_id;

    -- Contar el número de empleados a cargo
    SELECT COUNT(e.employee_id) INTO num_empleados
    FROM EMPLOYEES e 
    WHERE e.manager_ID = v_id;

    -- Determinar el incremento del salario
    IF es_presidente THEN
        incremento_salario := 30;
    ELSIF num_empleados = 0 THEN
        incremento_salario := 50;
    ELSIF num_empleados = 1 THEN
        incremento_salario := 80;
    ELSIF num_empleados = 2 THEN
        incremento_salario := 100;
    ELSIF num_empleados >= 3 THEN
        incremento_salario := 110;
    ELSE
        incremento_salario := 0;
    END IF;

    -- Actualizar el salario
    UPDATE EMPLOYEES SET SALARY = SALARY + incremento_salario
    WHERE EMPLOYEE_ID = v_id;

    -- Imprimir el número de empleados a cargo y el incremento aplicado
    DBMS_OUTPUT.PUT_LINE('El número de empleados que tiene el empleado ' || v_id || ' a su cargo es de ' || num_empleados);
    DBMS_OUTPUT.PUT_LINE('Incremento de salario aplicado: ' || incremento_salario || ' euros.');

END;


SELECT * FROM JOB_HISTORY jh ;
SELECT * FROM EMPLOYEES e ;
SELECT * FROM DEPARTMENTS d ;
SELECT * FROM JOBS j ;
SELECT * FROM LOCATIONS l ;
SELECT * FROM REGIONS r ;
SELECT * FROM COUNTRIES c ;
