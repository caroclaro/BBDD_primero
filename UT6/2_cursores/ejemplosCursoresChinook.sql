-- CURSOR FOR

Declare
    Cursor c1 is (select t.name,t.composer
                    from track t
                        join playlisttrack p on p.trackid = t.trackid
                    where p.playlistid = 10); 
    /* No necesito tener variables para recorrer el cursor     
    Nombre      track.name%type;      
    compositor  track.composer%type;*/
                
Begin
    for i in c1 loop
        DBMS_OUTPUT.PUT_LINE('Nombre:'||i.name);
        DBMS_OUTPUT.PUT_LINE('Compositor:'||i.composer);       
    end loop;
    -- Ni abro ni cierro el cursor Close c1;
    
End;

--CURSOR LOOP

Declare
    Cursor c1 is (select t.name,t.composer
                    from track t
                        join playlisttrack p on p.trackid = t.trackid
                    where p.playlistid = 10); 
    Nombre      track.name%type;          
    compositor  track.composer%type;
                
Begin
    Open c1;
    Loop 
        fetch c1 into Nombre, compositor;
        EXIT WHEN c1%notfound;
        DBMS_OUTPUT.PUT_LINE('Nombre:'||Nombre);
        DBMS_OUTPUT.PUT_LINE('Compositor:'||compositor);
    end loop;
    Close c1;
    
End;

--CURSOR WHILE

Declare
    Cursor c1 is (select t.name,t.composer
                    from track t
                        join playlisttrack p on p.trackid = t.trackid
                    where p.playlistid = 10); 
    Nombre      track.name%type;          
    compositor  track.composer%type;
                
Begin
    Open c1;
    fetch c1 into Nombre, compositor;
    While c1%found loop
        DBMS_OUTPUT.PUT_LINE('Nombre:'||Nombre);
        DBMS_OUTPUT.PUT_LINE('Compositor:'||compositor);
        fetch c1 into Nombre, compositor;
    end loop;
    Close c1;
    
End;

--CURSORES ANIDADOS

Declare
    Cursor c1 (v_artista artist.artistid%type) is (select *
                    from album a
                    where a.artistid = v_artista); 
    
    Cursor c2 (v_album album.albumid%type) IS (Select *
                                            from track t
                                            where t.albumid = v_album);                                        

    Nombre artist.name%type;
    codigo artist.artistid%type;
Begin
    
    Select artist.name, artist.artistid 
        into Nombre, codigo
       from artist 
       where artistid = &artista;
       DBMS_OUTPUT.PUT_LINE('Artista: '||Nombre);

    for i in c1(codigo) loop
        DBMS_OUTPUT.PUT_LINE('Titulo album: '||i.title);
        for j in c2(i.albumid) loop
            DBMS_OUTPUT.PUT_LINE('Titulo cancion: '||j.name);
        End Loop;
    end loop;
    -- Ni abro ni cierro el cursor Close c1;
    
End;
