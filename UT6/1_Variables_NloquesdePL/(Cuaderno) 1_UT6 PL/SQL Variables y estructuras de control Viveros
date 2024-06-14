SELECT * FROM CLIENTE c;
SELECT * FROM DETALLE_PEDIDO dp ;
SELECT * FROM EMPLEADO e ;
SELECT * FROM PAGO p ;
SELECT * FROM PEDIDO p;
SELECT * FROM PRODUCTO p ;
SELECT * FROM TIENDA t ;
SELECT * FROM TIPOPRODUCTO t

--1. Crear un bloque PL que visualice el país de una tienda que se pida al usuario por teclado.
DECLARE
  paisTienda varchar (12);
  v_codTienda TIENDA.CODTIENDA%TYPE;
BEGIN
  v_codTienda := :COD;

  SELECT t.pais INTO paisTienda
  FROM TIENDA t
  WHERE t.codtienda = v_codTienda;

dbms_output.put_line(' Esta tienda se encuentra en '||paisTienda);
END;

--2. Dado un tipo de producto introducido por teclado, obtener el número de productos
--que hay asociados a este tipo de producto.
DECLARE
  total_pedidos NUMBER (6);
  v_codProducto PRODUCTO.CODproducto%TYPE;
BEGIN
  v_codProducto := :COD;

  SELECT COUNT(p.codproducto) INTO total_pedidos
  FROM PRODUCTO p
  JOIN DETALLE_PEDIDO dp ON dp.codproducto= p.codproducto
  JOIN PEDIDO pe ON dp.codpedido= pe.codpedido
  WHERE p.codproducto = v_codProducto;

  dbms_output.put_line('Total de pedidos asociado a este producto:
  '||total_pedidos);
END;

--3. Incrementar el precio de venta en 5€ a todos productos para los que su stock sea
--menor de 25 unidades.
UPDATE PRODUCTO
SET PRECIOVENTA=PRECIOVENTA + 5
WHERE STOCK<25;

--4. Haz un bloque anónimo que asigne a una variable declarada el código de un cliente y
--cuente el número de pedidos del cliente.
DECLARE
  codigocliente cliente.codcliente%TYPE;
  numpedidos NUMBER;
BEGIN
  codigocliente := :cod;

  SELECT COUNT(1) INTO numpedidos
  FROM pedido p
  WHERE p.codcliente = codigocliente;

  DBMS_OUTPUT.PUT_LINE('El número de pedidos del cliente: ' || codigocliente || '  es: ' || numpedidos);
END;

--5. Pide dos tiendas por teclado e indica cuál de las dos tiendas ingresó más dinero por los
--pedidos hechos por sus clientes.
DECLARE
  codtienda1 tienda.codtienda%type;
  codtienda2 tienda.codtienda%type;
  cantidad1 NUMBER;
  cantidad2 NUMBER;
BEGIN
  codtienda1 := :cod1;
  codtienda2 := :cod2;

  SELECT SUM(dp.cantidad * p.precioventa)
      INTO cantidad1
      FROM tienda t
      JOIN empleado e ON t.codTienda = e.codtienda
      JOIN cliente c ON e.codEmpleado = c.codEmpleadoVentas
      JOIN pedido p ON c.codCliente = p.codCliente
      JOIN detalle_pedido dp ON p.codPedido = dp.codPedido
      JOIN producto p ON dp.codProducto = p.codProducto
      WHERE t.codTienda = codtienda1;
  SELECT SUM(dp.cantidad * p.precioventa)
      INTO cantidad2
      FROM tienda t
      JOIN empleado e ON t.codTienda = e.codtienda
      JOIN cliente c ON e.codEmpleado = c.codEmpleadoVentas
      JOIN pedido p ON c.codCliente = p.codCliente
      JOIN detalle_pedido dp ON p.codPedido = dp.codPedido
      JOIN producto p ON dp.codProducto = p.codProducto
      WHERE t.codTienda = codtienda2;

  IF cantidad1 > cantidad2 THEN
    DBMS_OUTPUT.PUT_LINE('La tienda ' || codtienda1 || ' ha ingresado más
    dinero');
  ELSIF cantidad1 < cantidad2 THEN
    DBMS_OUTPUT.PUT_LINE('La tienda ' || codtienda2 || ' ha ingresado más
    dinero');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Las dos tiendas han generado lo mismo');
  END IF;
END;
--6. Para un producto introducido por teclado calcula y muestra si su margen de beneficio
--es alto (mayor o igual que el 30%), normal (entre el 30% y el 20%) o bajo (menor o igual que el 20%).
      --1. El margen se calculará como ( (precio de venta - precio proveedor)/precio
        --proveedor) *100 siempre el que precio proveedor sea distinto de 0. Si es 0 pondremos SIN DATOS.
DECLARE
    product producto.nombre%type;
    margen number;
    v_precioproveedor number;
BEGIN
    product := :nombre;

    SELECT (p.precioventa - p.precioproveedor)*100, p.precioproveedor INTO margen,v_precioproveedor
        FROM producto p
        WHERE p.nombre = product;

    IF v_precioproveedor = 0 THEN
        DBMS_OUTPUT.PUT_LINE('SIN DATOS');
    ELSE
        margen:= margen/v_precioproveedor;
            IF margen >= 30 THEN
                DBMS_OUTPUT.PUT_LINE('El producto tiene un margen de beneficio alto');
            ELSIF margen >= 20 AND margen < 30 THEN
                DBMS_OUTPUT.PUT_LINE('El producto tiene un margen de beneficio  normal');
            ELSE
                DBMS_OUTPUT.PUT_LINE('El producto tiene un margen de beneficio bajo');
            END IF;
    END IF;
END;

--7. Para un cliente que se pase por teclado indica si su ciudad coincide con la de la tienda
--en la que trabaja el empleado que tiene asignado o no.
DECLARE
  clientecod cliente.codcliente%TYPE;
  ciudadcliente cliente.ciudad%TYPE;
  ciudadempleado tienda.ciudad%TYPE;
BEGIN
  clientecod := :clientecod;

  SELECT ciudad INTO ciudadcliente
    FROM cliente
    WHERE codcliente = clientecod;
  SELECT t.ciudad INTO ciudadempleado
    FROM cliente cl
    INNER JOIN empleado e ON cl.codempleadoventas = e.codempleado
    INNER JOIN tienda t ON t.codtienda = e.codtienda
    WHERE cl.codcliente = clientecod;

  IF ciudadcliente = ciudadempleado THEN
    DBMS_OUTPUT.PUT_LINE('El cliente y la tienda en la que trabaja el empleado que le ha atendido son la misma ciudad.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El cliente y la tienda en la que trabaja el empleado que le ha atendido no son la misma ciudad.');
  END IF;
END;

--8. Renombra el tipo de producto Utensilios y llamalo Herramientas. Para ello tendrás que
--hacer los siguientes pasos
    --1. Inserta un nuevo tipo de producto llamado Herramientas. El resto de campos deben
    --ser los que tenga actualmente el tipo de Utensilios.
    --2. Actualiza todos los productos que tuvieran como tipo Utensilios para que tengan el
    --nuevo tipo de Herramientas
    --3. Borra el tipo de producto Utensilios.
    --4. Al final de todo, haz COMMIT
DECLARE
  v_newtipoproducto tipoproducto%rowtype;
BEGIN
    SELECT * INTO v_newtipoproducto
      FROM TIPOPRODUCTO t
      WHERE t.tipo='Utensilios';

    v_newtipoproducto.tipo='Herramientas';

    INSERT INTO TIPOPRODUCTO t values(v_newtipoproducto.tipo, v_newtipoproducto.descripcion_texto, v_newtipoproducto.descripcion_html, v_newtipoproducto.imagen);

    UPDATE PRODUCTO p SET p.TIPOPRODUCTO = v_newtipoproducto.tipo
      WHERE p.TIPOPRODUCTO ='Utensilios';
      DELETE FROM TIPOPRODUCTO t WHERE tipo= 'Utensilios';
END;
