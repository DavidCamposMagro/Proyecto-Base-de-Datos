--Req(02)
--Procedimiento que controla el IVA de los pedidos dependiendo del país del cliente.
CREATE OR REPLACE PROCEDURE gestionar_iva(l_dni_cliente VARCHAR2) IS
--Declaración de variables
    r_cliente cliente%ROWTYPE;  
    v_iva NUMBER;               
    v_cantidad NUMBER;          
BEGIN 
--Cursor implícito que introduce en la variable r_cliente los datos del cliente que tenga el dni recibido por parametros.
    SELECT * INTO r_cliente FROM cliente WHERE dni=l_dni_cliente;  
--Cursor implícito que introduce en la variable v_cantidad la cantidad de registros actualizados.
    SELECT COUNT(dni) INTO v_cantidad FROM pedido WHERE dni=l_dni_cliente;  
    CASE                         
     --Opción país del cliente es España.
        WHEN UPPER(r_cliente.pais)='ESPAÑA' THEN 
        --Asignación 21% en v_iva.
            v_iva:=21;                      
        --Opción país del cliente es Noruega.
        WHEN UPPER(r_cliente.pais)='NORUEGA' THEN  
        --Asignación 25% en v_iva.
            v_iva:=25;                  
         --Opción país del cliente es Reino Unido o Francia.
        WHEN UPPER(r_cliente.pais)='REINO UNIDO' OR UPPER(r_cliente.pais)='FRANCIA' THEN   
        --Asignación 20% en v_iva.
            v_iva:=20; 
        --Opción país del cliente es Andorra.
        WHEN UPPER(r_cliente.pais)='ANDORRA' THEN   
        --Asignación 4,5% en v_iva.
            v_iva:=4.5;                     
        --Opción país del cliente es Alemania o Chile.
        WHEN UPPER(r_cliente.pais)='ALEMANIA' OR UPPER(r_cliente.pais)='CHILE' THEN    
        --Asignación 19% en v_iva.
            v_iva:=19;                      
    END CASE;
     --Muestra datos del cliente al que se le ha actualizado los pedidos.
    DBMS_OUTPUT.PUT_LINE('El cliente '||r_cliente.nombre ||' con el dni ' || r_cliente.dni ||' tiene un IVA del ' || v_iva ||'%'); 
     --Actualización de los precios de los pedidos del cliente.
    UPDATE pedido SET precio=precio+precio*(v_iva/100) WHERE dni=l_dni_cliente; 
     --Muestra cantidad de registros actualizados.
    DBMS_OUTPUT.PUT_LINE('Se ha actualizado '||v_cantidad||' pedidos del cliente');
--Excepciones.
EXCEPTION     
 --Mostrar error no se ha encontrado ningun cliente con el dni.
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se ha encontrado ningun cliente con dni: ' || l_dni_cliente); 
--Mostrar error inesperado si ocurriese algun error imprevisto en la ejecución del programa.
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error inesperado*');     
END;
/