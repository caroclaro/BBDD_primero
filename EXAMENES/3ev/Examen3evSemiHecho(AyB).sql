
:D ^   ^
    º .º
   
	
--1.- Crea una función que reciba un código de producto (idproducto) y devuelva el importe
--total vendido para ese producto (el importe total vendido para un producto será la suma de
--todos los detalles de pedidos para ese producto y en detalle de producto debemos
--multiplicar cantidad por precio unidad).

CREATE OR REPLACE FUNCTION importetotal(v_id IN productos.IDPRODUCTO%TYPE) RETURN NUMBER IS
    numsproductos NUMBER;
BEGIN
    SELECT sum(dp.PRECIOXUNIDAD*CANTIDAD)  numsproductos
	FROM DETALLE_PEDIDOS dp 
	JOIN PRODUCTOS p ON p.IDPRODUCTO = dp.IDPRODUCTO 
	WHERE dp.IDPRODUCTO = v_id;

    DBMS_OUTPUT.PUT_LINE('El producto con id ' || v_id || ' ha vendido ' || numsproductos);
    RETURN numsproductos;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN -1;
END;

select importetotal(1) FROM DUAL ;
SELECT importetotal(p.idproducto), p.* FROM PRODUCTOS p ;

--    WHEN NO_DATA_FOUND THEN
--        DBMS_OUTPUT.PUT_LINE('No se encontró el producto con ID ' || v_id);
--        RETURN -1;

--2.- Haz un procedimiento almacenado o un bloque anónimo que me saque un listado por
--consola de categorías, nombre y descripción, y por cada categoría debe sacar todos los
--productos (nombre y descripción) y por cada producto debe decirme el importe total que se
--ha vendido de ese producto. Debe utilizar la función del ejercicio 1.

-- PARA HACERLO MÁS EFICIENTE PUEDES PASAR UN PARAMETRO AL CURSOR, AL SEGUNDIO
--PARA NO RECORRER TODDOS LOS PRODUCTOS CVARIAS VECES
--NO TE LO PONE BIEN DEL TODO SI LO HACES COMO YO, HAZLO OTRA VEZ AÑADIENDO VaRIABLES A LOS CURSORES PARA OPTIMIZAR SU FUNCIONAMIENTO
SELECT * FROM PRODUCTOS p ;

DECLARE
	    Cursor c1 is (SELECT c.NOMBRE , c.DESCRIPCION, c.idcategoria
						FROM CATEGORIAS c); 
		
		CURSOR c2 IS (SELECT p.IDPRODUCTO ,p.NOMBRE, p.idcategoria 
						FROM PRODUCTOS p); --I AÑADIRIAS EL CURSOR
		numproductos NUMBER ;
BEGIN 
	FOR i IN c1 loop
			DBMS_OUTPUT.PUT_LINE('CATEGORIA:'||i.NOMBRE || ': ' || i.DESCRIPCION);
		FOR m IN c2 LOOP 
			IF (m.idcategoria = i.idcategoria) THEN 
				select importetotal(m.IDPRODUCTO) INTO numproductos FROM DUAL ;
				DBMS_OUTPUT.PUT_LINE('PRODUCTO:'||m.IDPRODUCTO || ' nombre: ' || m.NOMBRE || ' total vendidos '|| numproductos);
			END IF;
		END LOOP;
	 	DBMS_OUTPUT.PUT_LINE(' ');
	END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
		
--3.- Para incentivar las ventas se va a dar una comisión a los empleados del 2% del importe
--de los pedidos que hagan. En la tabla empleados crea un campo de comisión
--Luego crea un trigger de inserción sobre la tabla de pedidos de forma que acumule el 2%
--del cargo del pedido como comisión para el empleado.
--El trigger no debe generar error en ningún caso.

ALTER TABLE empleados
ADD comision NUMBER(10,3);

SELECT * FROM EMPLEADOS e ;

CREATE OR REPLACE TRIGGER agregar_comision
AFTER INSERT ON pedidos 
	FOR EACH ROW 

BEGIN 
	UPDATE EMPLEADOS e
	SET e.comision =: e.comision + (:NEW.cargo * 0.02)
	WHERE e.idempleado =:NEW.idempleado;
EXCEPTION
	WHEN OTHERS THEN 
	dbms_output.put_line(sqlerrm);  --IMPORTANTE ESCRIBIR ESTO PARA LO DE ASEGURARSE Q NO FALLE DEL ENUNCIADO
END;

SELECT * FROM EMPLEADOS e ;



¡INSERT NEW       DELETE OLD           UPDATE (AMBOS) LOS DOS PARA UNA COMPARACION!

--4.-. Haz un procedimiento que reciba como parámetro una fecha y lista todos los pedidos
--anteriores a esa fecha (fechapedido menor que la fecha indicada). En el listado debe
--incluirse el nombre del cliente, el nombre de la compañía de envío, la ciudad destino del
--pedido y la fecha de pedido

CREATE OR REPLACE PROCEDURE pedidosAnteriores()
	CURSOR c1 IS (	SELECT p.IDPEDIDO , c.NOMBRE , ce.IDCOMPANIA , p.CIUDADDEST , p.FECHAPEDIDO 
					FROM PEDIDOS p 
					JOIN CLIENTES c on p.IDCLIENTE = c.IDCLIENTE 
					JOIN COMP_ENVIO ce ON p.COMPENVIO = ce.IDCOMPANIA 
					WHERE p.fechapedido < );
BEGIN 
	
	FOR i IN c1 LOOP
		DBMS_OUTPUT.PUT.LINE('ID del pedido' || p.IDPEDIDO || ' del cliente ' || c.NOMBRE || ' repartido por ' || ce.IDCOMPANIA || ' en ' || p.CIUDADDEST || ' el ' || p.FECHAPEDIDO );
	END LOOP;
	
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


 -- 5.- Crea una nueva tabla y llámala: cliente_mes
 -- La tabla debe tener, al menos, los siguientes campos: año, mes, cliente y total de gastado.
-- El cliente del mes es aquel que se haya gastado más en el mes en cuestión. (El importe
 -- gastado por el cliente en cada pedido es el campo CARGO del pedido).
-- Rellena esta tabla para todos los meses del año 1997

CREATE TABLE CLIENTE_MES(
ID_CLIENTE VARCHAR2(5) NOT NULL,
ANIO NUMBER(4) NOT NULL,
MES NUMBER(2) NOT NULL,
TOTAL_GASTADO NUMBER(20,2) NOT NULL,
CONSTRAINT F_CLI
FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES(IDCLIENTE),
PRIMARY KEY (ANIO, MES)
);


CREATE OR REPLACE PROCEDURE P_CLI_DELMES_PORANIO_V2
    (V_ANIO NUMBER) IS
    
    CURSOR C_MES (V_ANIO NUMBER, V_MES NUMBER) IS 
        (SELECT pe.idcliente CLI, SUM(pe.cargo) TOTAL
            FROM pedidos PE 
            WHERE TO_CHAR(pe.fechapedido, 'YYYY') = V_ANIO AND TO_CHAR(pe.fechapedido, 'mm') = V_MES
            GROUP BY  pe.idcliente)
            ORDER BY 2 DESC;

    E_NULO EXCEPTION;
BEGIN
    IF ( V_ANIO IS NULL) THEN
        RAISE E_NULO;
    END IF;
    
    FOR J IN 1..12 LOOP
        FOR I IN C_MES(V_ANIO, J) LOOP
            INSERT INTO cliente_mes VALUES (I.CLI, V_ANIO, J, I.TOTAL);
            EXIT;
        END LOOP;
    END LOOP;
EXCEPTION
    WHEN E_NULO THEN 
        dbms_output.PUT_LINE('ERROR: NULO');
    WHEN OTHERS THEN
        dbms_output.PUT_LINE(SQLERRM);
END;

DELETE FROM CLIENTE_MES;
CALL p_cli_delmes_poranio_V2(1997);
SELECT * FROM cliente_mes;  


 -- 1.- Crea una función que reciba un código de producto (idproducto) y devuelva el total de
-- pedidos que hay para ese producto

SELECT * FROM COMP_ENVIO ce ;
SELECT * FROM PEDIDOS p ;
SELECT * FROM DETALLE_PEDIDOS dp ;
SELECT * FROM PRODUCTOS p ;
SELECT * FROM CLIENTES c ;
SELECT * FROM CATEGORIAS c ;
SELECT * FROM PROVEEDORES p ;
SELECT * FROM EMPLEADOS e ;

CREATE OR REPLACE FUNCTION FACTURACIONES.totalPedidos (v_codProducto IN productos.IDPRODUCTO%TYPE)
							RETURN NUMBER IS totaldePedidos NUMBER ;
						e_nulo EXCEPTION;
BEGIN 						
		IF v_codProducto IS NULL THEN 
		raise e_nulo;
		END IF;
	
	SELECT COUNT(1) INTO totaldePedidos
	FROM PEDIDOS p 
		JOIN DETALLE_PEDIDOS dp ON dp.IDPEDIDO = p.IDPEDIDO 
	WHERE dp.IDPRODUCTO = v_codProducto;

	dbms_output.put_line(totaldePedidos);
	RETURN 	totaldePedidos;

	EXCEPTION 
		WHEN e_nulo THEN
		RETURN -1;
		WHEN OTHERS THEN
		RETURN -2;
	END;


CALL totalPedidos(20);
select totalPedidos(2) FROM DUAL ;



 --2.- Haz un procedimiento almacenado o un bloque anónimo que me saque un listado por
 --consola de las proveedores, código, nombre y ciudad, y por cada proveedor sus productos y
 --el total de pedidos que hay en el producto. (utilizando la función del ejercicio 1).

SELECT * FROM COMP_ENVIO ce ;
SELECT * FROM PEDIDOS p ;
SELECT * FROM DETALLE_PEDIDOS dp ;
SELECT * FROM PRODUCTOS p ;
SELECT * FROM CLIENTES c ;
SELECT * FROM CATEGORIAS c ;
SELECT * FROM PROVEEDORES p ;
SELECT * FROM EMPLEADOS e ;

DECLARE 
	CURSOR c1 IS (SELECT p.IDPROVEEDOR , p.NOMBRE , p.CIUDAD 
						FROM PROVEEDORES p) ;
	CURSOR c2 (v_idPROVE proveedores.IDPROVEEDOR%TYPE) IS 
							(SELECT p.IDPRODUCTO, p.NOMBRE, P.IDPROVEEDOR
							FROM PRODUCTOS p
							WHERE p.idproveedor = v_idPROVE);
						total number(3):= 0;
BEGIN
	FOR i IN c1 LOOP
		dbms_output.put_line('PROVEEDOR '|| i.IDPROVEEDOR || ' , '|| i.NOMBRE || ' de '|| i.ciudad);
			FOR c IN c2(i.IDPROVEEDOR) LOOP
				total := totalPedidos(c.idproducto);
				dbms_output.put_line(c.NOMBRE || ' ' || total);
			END LOOP;	
		dbms_output.put_line(' ');
	END LOOP;
	
END;


--3
CREATE OR REPLACE PROCEDURE P_FECHA_MAYOR
    (V_FECHA PEDIDOS.FECHAPEDIDO%TYPE) IS

    CURSOR C_PEDIDO (V_FECHA PEDIDOS.FECHAPEDIDO%TYPE) IS
        (SELECT pe.idpedido ID, cl.nombre NOM, co.nombre COM, pe.ciudaddest CIU, pe.fechaentrega ENT
            FROM PEDIDOS PE
            LEFT JOIN clientes CL ON cl.idcliente = pe.idcliente
            LEFT JOIN comp_envio CO ON co.idcompania = pe.compenvio
            WHERE PE.fechaentrega > V_FECHA);

    E_NULO EXCEPTION;
BEGIN
    IF ( V_FECHA IS NULL) THEN
        RAISE E_NULO;
    END IF;
    
    FOR I IN C_PEDIDO(V_FECHA) LOOP
        dbms_output.PUT_LINE('- '||I.ID||', '||I.NOM||', '||I.COM||', '||I.CIU||', '||I.ENT);
    END LOOP;
EXCEPTION
    WHEN E_NULO THEN 
        dbms_output.PUT_LINE('ERROR: NULO');
    WHEN OTHERS THEN
        dbms_output.PUT_LINE(SQLERRM);
END;

SELECT * FROM pedidos;

CALL p_fecha_mayor('2006/05/05');

 4.- Para incentivar las ventas se va a dar un descuento a los clientes del 5% del importe de
 los pedidos que hagan para próximos pedidos. En la tabla clientes crea un campo de
 descuento_acumulado.
 Luego crea un trigger de inserción sobre la tabla de pedidos de forma que acumule el 5%
 del cargo del pedido como descuento para el cliente.
 El trigger no debe generar error en ningún caso

ALTER TABLE CLIENTES ADD DESCUENTO_ACUMULADO NUMBER(10,2) DEFAULT 0 NOT NULL;

CREATE OR REPLACE TRIGGER T_DESC_ACUM
    AFTER INSERT ON PEDIDOS
    FOR EACH ROW
BEGIN
    UPDATE clientes CL 
        SET cl.descuento_acumulado = cl.descuento_acumulado + (:NEW.CARGO * 0.05)  --SUPONGO QUE SI SE LE ACUMULA, NO SE RESETEA EN CADA PEDIDO
        WHERE cl.idcliente = :NEW.IDCLIENTE;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.PUT_LINE(SQLERRM);
END;

SELECT * FROM clientes;
--ALFKI	Alfreds Futterkiste	Maria Anders	Representante de ventas	Obere Str. 57	Berlin		12209	Alemania	030-0074321	030-0076545	0
SELECT * FROM pedidos;
INSERT INTO PEDIDOS VALUES (1,	'ALFKI',NULL,NULL,NULL,NULL,NULL,100,NULL,NULL,NULL,NULL,NULL,NULL);
--ALFKI	Alfreds Futterkiste	Maria Anders	Representante de ventas	Obere Str. 57	Berlin		12209	Alemania	030-0074321	030-0076545	5

