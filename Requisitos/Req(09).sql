--Req(09)
--Funci�n que devuelve la media de dinero gastado en compras de un cliente en un intervalo de tiempo.
CREATE OR REPLACE FUNCTION calcular_media_intervalo(l_dni_buscar VARCHAR2,l_fecha_inicio DATE, l_fecha_fin DATE) RETURN NUMBER IS      
--Declaraci�n de variables.
    v_media NUMBER;     
BEGIN
--Condicion de que si el fin del intervalo es menor que el inicio del intervalo la funci�n devolver� -1 que se entender� como un c�digo de error.
   IF l_fecha_fin<l_fecha_inicio THEN       
            v_media:=-1;
--Si la condici�n anterior no se cumple, se le asignar� el valor correcto a la variable.
    ELSE                                    
--Si el cursor impl�cito no encontrase datos, la funci�n devolver� -2 que se entender� como un c�digo de error.
        SELECT NVL(AVG(precio),-2) INTO v_media FROM pedido WHERE dni=l_dni_buscar AND fecha BETWEEN l_fecha_inicio AND l_fecha_fin;    
    END IF; 
--Devolver la variable v_media y finalizaci�n de la funci�n.
    RETURN v_media;     
END;
/