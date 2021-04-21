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
--Si no se encuentra dicho empleado mostrar un mensaje que explique que ese empleado no existe en dicha base de datos.
    IF SQL%NOTFOUND THEN       
        DBMS_OUTPUT.PUT_LINE('El empleado que desea borrar no existe');      
    END IF;
--Excepciones
EXCEPTION
--Mostrar error inesperado si ocurriese algun error imprevisto en la ejecución del programa.
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error inesperado*');  
END;
/

SELECT * FROM empleado;
DELETE empleado WHERE cod_empleado='E-001';
ROLLBACK;
SELECT * FROM jefe_empleado ;
