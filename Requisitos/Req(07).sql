--Req(07)
--Disparador que se ejecuta despues de producirse una inserci�n en la tabla de control_precios.
CREATE OR REPLACE TRIGGER controlar_articulos
    AFTER INSERT ON control_precios           
    FOR EACH ROW
BEGIN
    CASE
--Si la operaci�n es aumentar, aumentar el precio de los art�culos con dicho porcentaje.
        WHEN UPPER(:NEW.operacion)='AUMENTAR' THEN  
            UPDATE articulo SET precio_venta=precio_venta+(:NEW.porcentaje/100*precio_venta);
--Si la operaci�n es reducir, reducir el precio de los art�culos con dicho porcentaje.
        WHEN UPPER(:NEW.operacion)='REDUCIR' THEN   
            UPDATE articulo SET precio_venta=precio_venta-(:NEW.porcentaje/100*precio_venta);
    END CASE;
--Excepciones
EXCEPTION
--Mostrar error inesperado si ocurriese algun error imprevisto en la ejecuci�n del programa.
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error inesperado*');  
END;
/
