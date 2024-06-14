SELECT * FROM CLIENTE c;
SELECT * FROM DETALLE_PEDIDO dp ;
SELECT * FROM EMPLEADO e ;
SELECT * FROM PAGO p ;
SELECT * FROM PEDIDO p;
SELECT * FROM PRODUCTO p ;
SELECT * FROM TIENDA t ;
SELECT * FROM TIPOPRODUCTO t ;

--1. Inserta una nueva tienda en ‘Tres Cantos’
INSERT INTO TIENDA t
VALUES ('3CA-ES', 'Tres Cantos', 'España', 'Madrid', '28760','+34 777 123
456','Tricantino el q no bote, 87', null)

--2. Inserta un empleado para la tienda de ‘Tres Cantos’ que sea representante de ventas.
INSERT INTO EMPLEADO e
VALUES ('32' , 'Ferita' , 'Morelli', 'Chaparro' , '4444' , 'guapa@vivero.es' , '3CA-ES',
NULL, 'Representante Ventas')

--3. Inserta un cliente que tenga como empleado de ventas al empleado que hemos creado
--en el punto anterior.
INSERT INTO CLIENTE c
VALUES ('39', 'La sede SA' , 'Manu', 'Jusdado', '675762972', '999888777', 'Calle
Fonseca',null, 'Madrid','Madrid','Spain','28500','31','90000');

--4. Inserta un pedido para el cliente que acabamos de crear, que contenga al menos dos
--productos diferentes.

--5. Actualiza el código del cliente que hemos creado en el punto anterior y averigua si hubo
--cambios en las tablas relacionadas.
UPDATE
cliente
set codcliente=40
where codcliente=39;

--6. Borra el cliente y averigua si hubo cambios en las tablas relacionadas.
DELETE from detalle_pedido where codpedido=39;
--no se puede porque este cliente tiene pedidos , cascada :O

--7. Elimina los clientes que no hayan realizado ningún pedido.
select c.codcliente
from cliente c
left join pedido p
on(p.codcliente=c.codcliente) where p.codpedido is null;
select c.codcliente
from cliente c
left join pago p
on(c.codcliente=p.codcliente)
where p.codcliente is null;
select * from cliente;
delete cliente c where c.codcliente in(select c.codcliente from cliente c
left join pedido p
on(p.codcliente=c.codcliente) where p.codpedido is null);
delete cliente c where c.codcliente in(select p.codcliente from cliente c
left join pago p
on(c.codcliente=p.codcliente)
where p.codcliente is null);

--rara
--8. Incrementa en un 25% el precio de los productos que no tengan pedidos.
update producto p
set p.precioventa=p.precioventa*1.25
where p.codproducto not in(select distinct dp.codproducto
from detalle_pedido dp);

--9. Borra los pagos del cliente con menor límite de crédito.
select *
from cliente c
inner join pago p
on(c.codcliente=p.codcliente)
order by c.limitecredito asc;
select * from pago;
delete from pago p where p.codcliente= 16;

--10. Modifica la tabla detalle_pedido para insertar un campo numérico llamado IVA.
--Mediante una transacción, establece el valor de ese campo a 18 para aquellos registros
--cuyo pedido tenga fecha a partir de Enero de 2019. Después, con otra sentencia,
--actualiza el resto de pedidos estableciendo el IVA al 21.
select * from detalle_pedido;
alter TABLE detalle_pedido add IVA VARCHAR(2);
update detalle_pedido dp
set dp.iva='18'
where dp.codpedido =(select p.codpedido
from pedido p
where to_char(p.fechapedido,'MM')=01 and
to_char(p.fechapedido,'YY')=19);
update detalle_pedido dp
set dp.iva='21'
where dp.iva is null;

--11. Modifica la tabla detalle_pedido para incorporar un campo numérico llamado
--total_linea y actualiza todos sus registros para calcular su valor con la fórmula:
--total_linea = precio_unidad*cantidad * (1 + (IVA/100));
select * from detalle_pedido;
alter TABLE detalle_pedido add total_linea VARCHAR2(4000);
ALTER TABLE detalle_pedido DROP COLUMN total_linea;
UPDATE detalle_pedido dp
set dp.total_linea=dp.preciounidad*dp.cantidad * (1 + (dp.IVA/100))
where dp.total_linea is null;


SELECT * FROM CLIENTE c;
SELECT * FROM DETALLE_PEDIDO dp ;
SELECT * FROM EMPLEADO e ;
SELECT * FROM PAGO p ;
SELECT * FROM PEDIDO p;
SELECT * FROM PRODUCTO p ;
SELECT * FROM TIENDA t ;
SELECT * FROM TIPOPRODUCTO t ;
