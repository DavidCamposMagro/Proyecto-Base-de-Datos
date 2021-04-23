--Req(06)
--Disparador que se ejecuta antes de borrar una fila en la tabla empleados.
CREATE OR REPLACE TRIGGER eliminar_empleado
    BEFORE DELETE ON empleado               
    FOR EACH ROW
BEGIN
--Ejecución de borrado de dicho empleado en la tabla de jefe_empleado.
    DELETE jefe_empleado WHERE cod_empleado=:OLD.cod_empleado;  
--Confirmación de borrado correctamente.
    DBMS_OUTPUT.PUT_LINE('El empleado ' ||:OLD.nombre ||' ' || :OLD.apellido || ' con código ' || :OLD.cod_empleado||' ha sido borrado correctamente.');    
--Excepciones
EXCEPTION
--Mostrar error inesperado si ocurriese algun error imprevisto en la ejecución del programa.
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error inesperado*');  
END;
/
