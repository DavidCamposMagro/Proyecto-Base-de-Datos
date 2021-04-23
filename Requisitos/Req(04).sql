--Req(04)
--Función que devuelve el precio de un pedido recibiendo por parámetrops el código del artículo y la cantidad.
CREATE OR REPLACE FUNCTION calcula_precio(cod VARCHAR2, cantidad NUMBER) RETURN NUMBER IS
--Declaración de variables
    v_precio NUMBER;   
BEGIN
    v_precio:=0;   
--Asignación del precio del artículo a la variable.
    SELECT precio_venta INTO v_precio FROM articulo WHERE cod_articulo=cod;     
--Multiplicación del precio del artículo por la cantidad de dicho pedido.
    v_precio:=v_precio*cantidad;       
 --Devolver el valor total del pedido.
    RETURN v_precio;       
--Excepciones
EXCEPTION
--Mostrar error inesperado si ocurriese algun error imprevisto en la ejecución del programa.
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error inesperado*');     
END;
/