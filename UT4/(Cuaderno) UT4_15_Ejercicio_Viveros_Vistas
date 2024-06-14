SELECT * FROM CLIENTE c;
SELECT * FROM DETALLE_PEDIDO dp ;
SELECT * FROM EMPLEADO e ;
SELECT * FROM PAGO p ;
SELECT * FROM PEDIDO p;
SELECT * FROM PRODUCTO p ;
SELECT * FROM TIENDA t ;
SELECT * FROM TIPOPRODUCTO t ;

--1. Crea una vista que muestre un listado donde aparezcan todos los clientes y los pagos que ha realizado cada uno de ellos. La vista debe tener las
--siguientes columnas: nombre y apellidos del contacto concatenados, teléfono, ciudad, pais,
fecha_pago, importe del pago, id de la transacción
CREATE VIEW clientesYpagos as
SELECT CONCAT(c.NOMBRECONTACTO ,c.APELLIDOCONTACTO) AS contacto, c.TELEFONO ,
c.CIUDAD , c.PAIS , p.FECHAPAGO , p.IMPORTETOTAL , p.IDTRANSACCION
FROM CLIENTE c
LEFT JOIN PAGO p ON p.CODCLIENTE =c.CODCLIENTE ;

--2. Crea una vista que muestre un listado donde aparezcan todos los clientes y los pedidos que ha realizado cada uno. La vista debe tener las
--siguientes columnas: nombre y apellidos del contacto concatenados, teléfono, ciudad, país, código del pedido, fecha del pedido, fecha
--esperada, fecha de entrega e importe total del pedido, que será la suma del producto de todas las cantidades por el precio de cada unidad que aparecen
--en cada detalle de pedido.
CREATE OR REPLACE VIEW cliente_detallePedido as
SELECT CONCAT(c.NOMBRECONTACTO ,c.APELLIDOCONTACTO) AS contacto, c.TELEFONO ,
c.CIUDAD , c.PAIS,p.CODPEDIDO , p.FECHAPREVISTA , p.FECHAENTREGA,
SUM(dp.CANTIDAD*dp.PRECIOUNIDAD) AS importe_total
FROM CLIENTE c
LEFT JOIN PEDIDO p ON p.CODCLIENTE = c.CODCLIENTE
LEFT JOIN DETALLE_PEDIDO dp ON dp.CODPEDIDO = p.CODPEDIDO
GROUP BY CONCAT(c.NOMBRECONTACTO ,c.APELLIDOCONTACTO) , c.TELEFONO , c.CIUDAD ,
c.PAIS,p.CODPEDIDO , p.FECHAPREVISTA , p.FECHAENTREGA ;

--3. Utiliza las vistas que has creado en los pasos anteriores para devolver un listado de los clientes de la ciudad de Madrid que han realizado pagos.
SELECT c.CONTACTO , c.CIUDAD, c.IMPORTETOTAL
FROM CLIENTESYPAGOS c
--JOIN CLIENTE_DETALLEPEDIDO cd ON cd.CONTACTO = c.CONTACTO
WHERE c.CIUDAD LIKE ('Madrid') AND c.IMPORTETOTAL IS NOT NULL ;

--4. Utiliza las vistas que has creado en los pasos anteriores para devolver un listado de los clientes que todavía no han recibido su pedido.
SELECT cd.CONTACTO , cd.FECHAENTREGA, p.ESTADO, cd.CODPEDIDO
FROM CLIENTE_DETALLEPEDIDO cd
JOIN PEDIDO p ON p.CODPEDIDO = cd.CODPEDIDO
WHERE p.ESTADO LIKE ('Pendiente');

--5. Utiliza las vistas que has creado en los pasos anteriores para caalcular el número de pedidos que ha realizado cada uno de los clientes.
SELECT cd.CONTACTO , COUNT(cd.CODPEDIDO)
FROM CLIENTE_DETALLEPEDIDO cd
GROUP BY cd.CONTACTO ;

--6. Utiliza las vistas que has creado en los pasos anteriores para calcular el valor del pedido máximo y mínimo que ha realizado cada cliente.
SELECT cd.CONTACTO , MAX(cd.IMPORTE_TOTAL), MIN(cd.IMPORTE_TOTAL)
FROM CLIENTE_DETALLEPEDIDO cd
GROUP BY cd.CONTACTO;
