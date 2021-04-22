--Req(08)
--Disparador que se ejecuta antes de producirse una insercción en la tabla de pedidos.
CREATE OR REPLACE TRIGGER controlar_saldo
    BEFORE INSERT ON pedido   
--Declaración de variables.
DECLARE
    v_hora_actual VARCHAR2(2);      
BEGIN
--Inicialización  de la variable con la hora actual del sistema.
    v_hora_actual:=TO_CHAR(systimestamp,'hh24');  
--Si la hora del sistema es entre las 4 y 7 de la madrugada, lanzar el error controlado.
    IF  TO_NUMBER(v_hora_actual) BETWEEN 4 AND 7 THEN   
        RAISE_APPLICATION_ERROR(-20005,'No puede realizar usted un pedido entre las 4 y 7 de la madrugada');
    END IF;
--Excepciones
EXCEPTION
--Mostrar error inesperado si ocurriese algun error imprevisto en la ejecución del programa.
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error inesperado*');  
END;
/
