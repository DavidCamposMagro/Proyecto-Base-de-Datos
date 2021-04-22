--Req(01)
--Disparador que se ejecuta cuando se inserta una fila en la tabla pedido.
CREATE OR REPLACE TRIGGER actualizar_stock
BEFORE INSERT ON pedido FOR EACH ROW 
DECLARE
--Variable en la que se almacenará la cantidad del artículo que se desea comprar.
    v_stock NUMBER;    
BEGIN
--Cursor implícito que inicializa la variable v_stock con la cantidad del artículo a comprar.
    SELECT stock INTO v_stock FROM articulo WHERE cod_articulo=:NEW.cod_articulo;    
--Si no hay cantidad lanzar un error controlado
    IF v_stock=0 THEN       
        RAISE_APPLICATION_ERROR(-20001,'No hay stock del articulo, por favor haga el pedido otro día');
--Si no hay suficiente cantidad para el pedido lanzar un error controlado.
    ELSIF v_stock<:NEW.cantidad THEN    
        RAISE_APPLICATION_ERROR(-20002,'No hay suficiente stock en el almacén para su pedido');
--Si el pedido fuese montar ordenador, limpiar virus o cambiar pieza no reducir el stock.        
    ELSIF :NEW.cod_articulo='A-016' OR :NEW.cod_articulo='A-017' OR :NEW.cod_articulo='A-018' THEN
        DBMS_OUTPUT.PUT_LINE('Pedido creado');
--Si no ocurre nada de lo anterior actualizar stock del producto comprado disminuyendo la cantidad comprada.
    ELSE
        DBMS_OUTPUT.PUT_LINE('Pedido creado');
        UPDATE articulo SET stock = stock - :NEW.cantidad WHERE cod_articulo = :new.cod_articulo;
    END IF; 

END;
/
