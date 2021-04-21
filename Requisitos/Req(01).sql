--Req(01)
--Disparador que se ejecuta cuando se inserta una fila en la tabla pedido.
CREATE OR REPLACE TRIGGER actualizar_stock
BEFORE INSERT ON pedido FOR EACH ROW 
DECLARE
--Variable en la que se almacenará la cantidad del artículo que se desea comprar.
    v_stock NUMBER;    
BEGIN
--Cursor implícito que inicializa la variable v_stock con la cantidad del artículo a comprar.
    SELECT cantidad INTO v_stock FROM articulo WHERE cod_articulo=:NEW.cod_articulo;    
--Si no hay cantidad lanzar un error controlado
    IF v_stock=0 THEN       
        RAISE_APPLICATION_ERROR(-20001,'No hay stock del articulo, por favor haga el pedido otro día');
--Si no hay suficiente cantidad para el pedido lanzar un error controlado.
    ELSIF v_stock<:NEW.cantidad THEN    
        RAISE_APPLICATION_ERROR(-20002,'No hay suficiente stock en el almacén para su pedido');
--Si no ocurre nada de lo anterior actualizar stock del producto comprado disminuyendo la cantidad comprada.
    ELSE                          
        UPDATE articulo SET cantidad= cantidad-:NEW.cantidad WHERE cod_articulo= :NEW.cod_articulo; 
    END IF;
--Excepciones
EXCEPTION
    --Mostrar error inesperado si ocurriese algun error imprevisto en la ejecución del programa.
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error inesperado*');     
END;
/
