1. Haz un procedimiento que reciba un artista y vaya listando todos los álbumes y por
cada álbum todas sus canciones.

-- Creo el procedimiento que recibe un parametro artista
Create or replace procedure listaCancionesArtista
    (p_artista artist.artistid%type) is
    
    -- El cursor 1 recorre los albumens del artista
    cursor c1 is select * from album a where a.artistid=p_artista;
    -- El cursor 2 recive un parametro de album
    -- y saca las canciones asociadas a ese album
    cursor c2 (p_album album.albumid%type) 
        is select *
        from track t where t.albumid = p_album;
    
    e_artista exception;    
begin
    if p_artista is null then
        raise e_artista;
    end if;    -- Recorro el cursor 1 de albumnes de un artista
    For i in C1 loop
        dbms_output.put_line('Album:'||i.title);
        -- Por cada albumn, recorro el cursor de sus canciones
        -- Paso el album actual al cursor 2 para sacar sus canciones
        for j in c2(i.albumid) loop
            dbms_output.put_line('Track:'||j.name);            
        End Loop;    
    End Loop;
Exception
    when e_artista then 
        DBMS_OUTPUT.PUT_LINE ('El artista no viene informado');
    when others then
        DBMS_OUTPUT.PUT_LINE (SQLERRM);    
End;

2. Haz una función que reciba una lista y devuelva el total de canciones que tiene la
lista.

Create or replace FUNCTION f_contarCancionesLista
    (p_lista playlist.playlistid%type) 
    return number is
    -- Excepcion para lista vacia
    e_lista exception;
    -- Variable para contar el nº de canciones
    v_total number;
Begin
    -- Valido que la lista me viene informada
    if p_lista is null then
        raise e_lista;
    end if;
    -- Saco el total de canciones de la lista y lo
    -- guardo en v_total
    Select count(1) into v_total
    from playlisttrack pt
    where pt.playlistid = p_lista;

    return v_total;
    
exception
    when e_lista then
        dbms_output.put_line('La lista no puede ser nula');
        return -1;
    when others then
        dbms_output.put_line('SQLERRM');
        return -1;        
End;

3. Haz un procedimiento que recorra las listas y vaya pintando un informe con nombre
de la lista y total de canciones de la lista. Debe utilizar la función del punto anterior.

Create or replace PROCEDURE listarListas is
    cursor c1 is select * from playlist;
Begin
    For i in C1 loop
        dbms_output.put_line('Playlist:'||i.playlistid||' - '||i.name);
        dbms_output.put_line('Nº Canciones:'||f_contarcancioneslista(i.playlistid));
    End Loop;
    
exception
    when others then
        dbms_output.put_line('SQLERRM');        
End;


4. Crea un tabla llamada Mejor_cliente_ciudad que debe tener, al menos, los
siguientes campos
a. Ciudad
b. Cliente
c. Importe
Crea un procedimiento que rellene esta tabla con el mejor cliente de cada ciudad. Se
entiende que el mejor cliente será aquel cuya suma de sus facturas (la suma del
campo total de invoice) sea mayor.
En caso de que para una ciudad haya dos clientes con el mismo importe, meteremos
el más antiguo (código de cliente menor)

Create or replace procedure rellenar_mejorCliente is
    -- Cursor que recorre las ciudades
    Cursor c1 is select distinct c.city
                    from customer c;
    
    -- Por cada ciudad, voy sacar sus clientes ordenados
    -- por el total de importe descendente y el código
    -- de cliente ascendente. Podría ser un select into,
    -- pero la select es más complicada
    Cursor c2 (p_ciudad customer.city%type) is 
        select c.customerid, sum(i.total) importe
        from customer c
        join invoice i on c.customerid = i.customerid
        where c.city = p_ciudad
        group by c.customerid
        order by importe desc, c.customerid asc;
            
Begin
    For i in C1 loop
        dbms_output.put_line('Ciudad :'||i.city);    
        for j in c2(i.city) loop
            -- listamos al cliente
            dbms_output.put_line('Cliente :'||j.customerid||' - '||j.importe);                
            -- Inserto al cliente
            insert into mejor_cliente_ciudad 
                values (i.city,j.customerid,j.importe);                
            -- Me salgo dado que solo quiero insertar 1
            Exit;
        end loop;    
    end Loop;
Exception
    When Others then 
        dbms_output.put_line(SQLERRM);
End;


5. Crea un campo en la tabla employees de fecha de despido (firedate) que admite
nulos y que se rellenará cuando se despide a un empleado con la fecha de despido.
Crea un trigger en esta tabla sobre este campo. Si se despide a un empleado y este
tiene asociados clientes, no puede ser despedido y debe dar error.

create or replace trigger DESPIDO
    BEFORE update of firedate on employee
    for each row
Declare
    despido_no_valido   EXCEPTION;
    -- variable para contar si tiene clientes el empleado
    v_contador number;
Begin
    -- Si la fecha de despido es no nula, tengo que ver
    -- si el empleado tiene clientes asociados
    if :new.firedate is not null then
        -- Cuento si el empleado tiene clientes
        Select count(c.customerid) into v_contador
        from customer c
        where c.supportrepid = :new.employeeid;
        
        If v_contador > 0 then            
            Raise despido_no_valido;
        End If;
    End if;
Exception
    When despido_no_valido then 
        RAISE_APPLICATION_ERROR(-20001, 'No se puede despedir al empleado');    
        dbms_output.put_line('No se puede despedir al empleado');
        return;
    When Others then
        dbms_output.put_line(SQLERRM);
        return;
End;

6. Haz un procedimiento o bloque anónimo que me vaya mostrando todas las listas y
por cada lista, las 3 canciones más largas

Create or replace procedure mostrarListas is
    -- Cursor que recorre las listas
    Cursor c1 is select * from playlist;
    
    -- Por cada lista, saco sus canciones ordenadas por duración 
    -- descendente
    Cursor c2 (p_lista playlist.playlistid%type) is 
        select t.trackid, t.name, t.milliseconds
        from track t
        join playlisttrack pl on t.trackid = pl.trackid
        where pl.playlistid = p_lista
        order by t.milliseconds desc;
        
    -- Contador para salirme a las 3 canciones de una lista
    v_contador number := 0;
            
Begin
    For i in C1 loop
        dbms_output.put_line('Lista :'||i.name);  
        -- Pongo el contador a 0 con cada lista
        v_contador := 0;
        for j in c2(i.playlistid) loop
            -- Sumo uno al contador cada vuelta
            v_contador := v_contador +1;
            -- listamos la canción
            dbms_output.put_line('Canción :'||j.name||' - '||j.milliseconds);                
            -- Cuando lleve 3, me salgo
            If  v_contador = 3 then
                Exit;
            end If;    
        end loop;    
    end Loop;
Exception
    When Others then 
        dbms_output.put_line(SQLERRM);
End;

7.- Crea una función que reciba una canción y devuelva el número de veces que se ha vendido la canción.

Create or replace FUNCTION f_contarCancionesVendidas
    (p_track track.trackid%type) 
    return number is
    -- Excepcion para lista vacia
    e_track exception;
    -- Variable para contar el nº de canciones
    v_total number;
Begin
    -- Valido que la lista me viene informada
    if p_track is null then
        raise e_track;
    end if;
    -- Saco el total de canciones de la lista y lo
    -- guardo en v_total
    Select count(1) into v_total
    from invoiceline il
    where il.trackid = p_track;

    return v_total;
    
exception
    when e_track then
        dbms_output.put_line('La canción no puede ser nula');
        return -1;
    when others then
        dbms_output.put_line('SQLERRM');
        return -1;        
End;

8.- Crea un campo en la tabla de TRACK llamado “num_ventas” cuyo valor defecto será un 0. Crea un procedimiento que “rellene” este campo con el número de veces que se ha vendido cada canción. Debes utilizar la función anterior.

Begin
    Update track set
        num_ventas = f_contarCancionesVendidas(trackid);
Exception
    When others then 
        dbms_output.put_line(SQLERRM);
    
End;

-- Este ejercicio se podría hacer también con un cursor sobre track y en cada vuelta del cursor llamas a la función, almacenas la salida en una variable
-- y con esa variable haces el update para el regsitro que estás tratando

Declare
    ln_numventas    Number;
    cursor c1 is select trackid from track;
Begin
    for i in c1 loop    
        ln_numventas := f_contarCancionesVendidas(i.trackid);
        Update track set
            num_ventas = ln_numventas
        where  trackid = i.trackid   ;
    end loop;        
Exception
    When others then 
        dbms_output.put_line(SQLERRM);
    
End;

9.- Crea un trigger que cada vez que se inserta un registro en invoiceline, actualice el campo “num_ventas” de la canción que se ha vendido. 

create or replace trigger ACT_VENTAS
    AFTER INSERT on invoiceline
    for each row
Begin
    -- Simplemente hacemos un update en track
    -- sumando la cantidad al numero de ventas que ya tuviera
    Update track set
        num_ventas = num_ventas + :new.quantity
    where trackid = :new.trackid;        
    
Exception
    When Others then
        dbms_output.put_line(SQLERRM);
        return;
End;

10.- Crea un procedimiento que me haga un listado de los artistas y las 3 canciones más vendidas de cada artista. Utiliza el campo creado en los ejercicios anteriores.

Create or replace procedure listarCancTopVentas is
    -- Cursor que recorre las listas
    Cursor c1 is select * from artist;
    
    -- Por cada lista, saco sus canciones ordenadas por duración 
    -- descendente
    Cursor c2 (p_artist artist.artistid%type) is 
        select t.trackid, t.name, t.num_ventas
        from track t
        join album al on t.albumid = al.albumid
        where al.artistid = p_artist
        order by 3 desc;
        
    -- Contador para salirme a las 3 canciones de una lista
    v_contador number := 0;
            
Begin
    For i in C1 loop
        dbms_output.put_line('Artista :'||i.name);  
        -- Pongo el contador a 0 con cada lista
        v_contador := 0;
        for j in c2(i.artistid) loop
            -- Sumo uno al contador cada vuelta
            v_contador := v_contador +1;
            -- listamos la canción
            dbms_output.put_line('Canción :'||j.name||' - '||j.num_ventas);                
            -- Cuando lleve 3, me salgo
            If  v_contador = 3 then
                Exit;
            end If;    
        end loop;    
    end Loop;
Exception
    When Others then 
        dbms_output.put_line(SQLERRM);
End;




