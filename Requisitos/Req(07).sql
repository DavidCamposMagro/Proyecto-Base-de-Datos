--Req(07)
--Disparador que se ejecuta despues de producirse una inserción en la tabla de control_precios.
CREATE OR REPLACE TRIGGER controlar_articulos
    AFTER INSERT ON control_precios           
    FOR EACH ROW
BEGIN
    CASE
--Si la operación es aumentar, aumentar el precio de los artículos con dicho porcentaje.
        WHEN UPPER(:NEW.operacion)='AUMENTAR' THEN  
            UPDATE articulo SET precio_venta=precio_venta+(:NEW.porcentaje/100*precio_venta);
--Si la operación es reducir, reducir el precio de los artículos con dicho porcentaje.
        WHEN UPPER(:NEW.operacion)='REDUCIR' THEN   
            UPDATE articulo SET precio_venta=precio_venta-(:NEW.porcentaje/100*precio_venta);
    END CASE;
--Excepciones
EXCEPTION
--Mostrar error inesperado si ocurriese algun error imprevisto en la ejecución del programa.
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error inesperado*');  
END;
/
