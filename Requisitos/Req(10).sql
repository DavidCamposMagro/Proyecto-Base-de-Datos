--Req(10)
--Disparador que se ejecuta despues de alguna acción sobre la tabla articulos e inserta la auditoría en la tabla auditoria_articulos.
CREATE OR REPLACE TRIGGER control_articulos
    BEFORE INSERT OR DELETE OR UPDATE ON articulo       
    FOR EACH ROW
--Declaración de variables.
DECLARE
    v_fecha_hora VARCHAR2(20);
    v_operacion NUMBER;
    v_registros_antiguos VARCHAR2(80);
    v_registros_nuevos VARCHAR2(80);
--Comienzo del programa
BEGIN
--Asignación de la hora del dia y hora del sistema a la variable.
    v_fecha_hora := TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS');
    CASE
        --En el caso de inserción, cambiar la variable v_operación con el valor 1 e introducir los registros antiguos como nulos y los registros nuevos con sus datos correspondientes.
        WHEN INSERTING THEN  
            v_operacion:=1;
            v_registros_antiguos:=('#'||CHR(9)||'#'||CHR(9)||'#'||CHR(9)||'#'||CHR(9)||'#'||CHR(9)||'#'||CHR(9)||'#');
            v_registros_nuevos:=(:NEW.cod_articulo||'#'||:NEW.cod_proveedor||'#'||:NEW.cod_departamento||'#'||:NEW.precio_proveedor||'#'||:NEW.precio_venta||'#'||:NEW.nombre||'#'||:NEW.stock||'#'||:NEW.categoria);
        --En el caso de inserción, cambiar la variable v_operación con el valor 2 e introducir los registros antiguos y nuevos con sus datos correspondientes.
       WHEN UPDATING THEN 
            v_operacion:=2;
            v_registros_antiguos:=(:OLD.cod_articulo||'#'||:OLD.cod_proveedor||'#'||:OLD.cod_departamento||'#'||:OLD.precio_proveedor||'#'||:OLD.precio_venta||'#'||:OLD.nombre||'#'||:OLD.stock||'#'||:OLD.categoria);
            v_registros_nuevos:=(:NEW.cod_articulo||'#'||:NEW.cod_proveedor||'#'||:NEW.cod_departamento||'#'||:NEW.precio_proveedor||'#'||:NEW.precio_venta||'#'||:NEW.nombre||'#'||:NEW.stock||'#'||:NEW.categoria);
         --En el caso de borrado, cambiar la variable v_operación con el valor 3 e introducir los registros nuevos como nulos y los registros antiguos con sus datos correspondientes.
        WHEN DELETING THEN 
            v_operacion:=3;
            v_registros_antiguos:=(:OLD.cod_articulo||'#'||:OLD.cod_proveedor||'#'||:OLD.cod_departamento||'#'||:OLD.precio_proveedor||'#'||:OLD.precio_venta||'#'||:OLD.nombre||'#'||:OLD.stock||'#'||:OLD.categoria);
            v_registros_nuevos:=('#'||CHR(9)||'#'||CHR(9)||'#'||CHR(9)||'#'||CHR(9)||'#'||CHR(9)||'#'||CHR(9)||'#');
    END CASE;
    --Inserción de los datos en la tabla auditoria_articulos.
     INSERT INTO auditoria_articulos VALUES(USER,v_fecha_hora,v_operacion,v_registros_antiguos,v_registros_nuevos);
--Excepciones
EXCEPTION
    --Mostrar error inesperado si ocurriese algun error imprevisto en la ejecución del programa.
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error inesperado*');     
END;
/



