--Req(03)
--Procedimiento que muestra los datos de un artículo cuando es buscado por su nombre.
CREATE OR REPLACE PROCEDURE buscar_articulo(l_nombre_Buscar VARCHAR2) IS
--Declaración de variables
r_reg articulo%ROWTYPE; 

BEGIN
--Cursor implícito que busca los datos de un artículo por el nombre del articulo.
    SELECT * INTO r_reg FROM articulo WHERE UPPER(l_nombre_Buscar)=UPPER(nombre);     
    CASE  
 --Mostrar artículo fuera de stock si dicho artículo no tiene cantidad.
        WHEN r_reg.stock=0 THEN                             
            DBMS_OUTPUT.PUT_LINE('*Artículo fuera de stock*');
--Mostrar datos del artículo.
        ELSE                                                    
            DBMS_OUTPUT.PUT_LINE('=============================================');
            DBMS_OUTPUT.PUT_LINE(CHR(9) || 'Nombre del artículo: ' || r_reg.nombre);
            DBMS_OUTPUT.PUT_LINE(CHR(9) ||'Categoría del artículo: ' || r_reg.categoria);
            DBMS_OUTPUT.PUT_LINE(CHR(9) ||'Código del artículo: ' || r_reg.cod_articulo);
            DBMS_OUTPUT.PUT_LINE(CHR(9) ||'Precio de venta: ' || r_reg.precio_venta);
            DBMS_OUTPUT.PUT_LINE('=============================================');
    END CASE;
--Excepciones
EXCEPTION
--Mostrar artículo inexistente si no se encuentra ningun registro.
    WHEN  NO_DATA_FOUND THEN                                
        DBMS_OUTPUT.PUT_LINE('*Articulo inexistente*');
--Mostrar "Error no previsto" si ocurriese un error no previsto en la ejecución del programa.
    WHEN OTHERS THEN                                        
        DBMS_OUTPUT.PUT_LINE('*Error no previsto*');
END;
/
