--Req(03)
--Procedimiento que muestra los datos de un art�culo cuando es buscado por su nombre.
CREATE OR REPLACE PROCEDURE buscar_articulo(l_nombre_Buscar VARCHAR2) IS
--Declaraci�n de variables
r_reg articulo%ROWTYPE; 

BEGIN
--Cursor impl�cito que busca los datos de un art�culo por el nombre del articulo.
    SELECT * INTO r_reg FROM articulo WHERE UPPER(l_nombre_Buscar)=UPPER(nombre);     
    CASE  
 --Mostrar art�culo fuera de stock si dicho art�culo no tiene cantidad.
        WHEN r_reg.stock=0 THEN                             
            DBMS_OUTPUT.PUT_LINE('*Art�culo fuera de stock*');
--Mostrar datos del art�culo.
        ELSE                                                    
            DBMS_OUTPUT.PUT_LINE('=============================================');
            DBMS_OUTPUT.PUT_LINE(CHR(9) || 'Nombre del art�culo: ' || r_reg.nombre);
            DBMS_OUTPUT.PUT_LINE(CHR(9) ||'Categor�a del art�culo: ' || r_reg.categoria);
            DBMS_OUTPUT.PUT_LINE(CHR(9) ||'C�digo del art�culo: ' || r_reg.cod_articulo);
            DBMS_OUTPUT.PUT_LINE(CHR(9) ||'Precio de venta: ' || r_reg.precio_venta);
            DBMS_OUTPUT.PUT_LINE('=============================================');
    END CASE;
--Excepciones
EXCEPTION
--Mostrar art�culo inexistente si no se encuentra ningun registro.
    WHEN  NO_DATA_FOUND THEN                                
        DBMS_OUTPUT.PUT_LINE('*Articulo inexistente*');
--Mostrar "Error no previsto" si ocurriese un error no previsto en la ejecuci�n del programa.
    WHEN OTHERS THEN                                        
        DBMS_OUTPUT.PUT_LINE('*Error no previsto*');
END;
/
