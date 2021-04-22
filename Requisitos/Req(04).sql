--Req(04)
--Funci�n que devuelve el precio de un pedido recibiendo por par�metrops el c�digo del art�culo y la cantidad.
CREATE OR REPLACE FUNCTION calcula_precio(cod VARCHAR2, cantidad NUMBER) RETURN NUMBER IS
--Declaraci�n de variables
    v_precio NUMBER;   
BEGIN
    v_precio:=0;   
--Asignaci�n del precio del art�culo a la variable.
    SELECT precio_venta INTO v_precio FROM articulo WHERE cod_articulo=cod;     
--Multiplicaci�n del precio del art�culo por la cantidad de dicho pedido.
    v_precio:=v_precio*cantidad;       
 --Devolver el valor total del pedido.
    RETURN v_precio;       
--Excepciones
EXCEPTION
--Mostrar error inesperado si ocurriese algun error imprevisto en la ejecuci�n del programa.
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error inesperado*');     
END;
/