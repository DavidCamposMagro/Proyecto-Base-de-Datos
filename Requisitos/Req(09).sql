--Req(09)
--Función que devuelve la media de dinero gastado en compras de un cliente en un intervalo de tiempo.
CREATE OR REPLACE FUNCTION calcular_media_intervalo(l_dni_buscar VARCHAR2,l_fecha_inicio DATE, l_fecha_fin DATE) RETURN NUMBER IS      
--Declaración de variables.
    v_media NUMBER;     
BEGIN
--Condicion de que si el fin del intervalo es menor que el inicio del intervalo la función devolverá -1 que se entenderá como un código de error.
   IF l_fecha_fin<l_fecha_inicio THEN       
            v_media:=-1;
--Si la condición anterior no se cumple, se le asignará el valor correcto a la variable.
    ELSE                                    
--Si el cursor implícito no encontrase datos, la función devolverá -2 que se entenderá como un código de error.
        SELECT NVL(AVG(precio),-2) INTO v_media FROM pedido WHERE dni=l_dni_buscar AND fecha BETWEEN l_fecha_inicio AND l_fecha_fin;    
    END IF; 
--Devolver la variable v_media y finalización de la función.
    RETURN v_media;     
END;
/