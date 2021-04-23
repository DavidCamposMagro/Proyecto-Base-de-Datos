SET SERVEROUTPUT ON;


CREATE SEQUENCE pedidos START WITH 20 INCREMENT BY 1;

--Comienzo del bloque anónimo.
DECLARE
--Cursor para mostrar los pedidos.
    CURSOR c_ped IS SELECT cod_pedido,dni,cod_articulo,cod_departamento,cantidad,fecha,NVL(TO_CHAR(fecha_llegada,'dd/mm/yyyy'),'Sin fecha') AS "FECHA_LLEGADA",precio FROM pedido;
    r_pedidos c_ped%ROWTYPE;
--Cursor para mostrar los artículos.
    CURSOR c_art IS SELECT cod_articulo,cod_proveedor,cod_departamento,TO_CHAR(precio_proveedor,'999g990d99l') AS "PRECIO_PRO" ,TO_CHAR(precio_venta,'999g990d99l') AS "PRECIO_VENT",nombre,stock,categoria FROM articulo;
    r_articulos c_art%ROWTYPE;
--Variable para almacenar un pedido en concreto para mostrarlo.   
    r_pedido_iva pedido%ROWTYPE;
--Variable para almacenar la media del cliente.
    v_media NUMBER;
--Cursor para mostrar la auditoria de los artículos.
    CURSOR c_aud IS SELECT * FROM auditoria_articulos;
    r_auditoria c_aud%ROWTYPE;
--Cursor para mostrar los empleados.
    Cursor c_emp IS SELECT * FROM empleado;
    r_emp c_emp%ROWTYPE;
BEGIN
--Prueba requisito nº4 calcular precio y requisito nº1.
    INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'58340212S','A-008','DE-06',3,'23/4/2021','23/4/2021',(SELECT calcula_precio('A-008',3) from dual));
    INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'48124785E','A-017','DE-02',1,'23/4/2021','25/4/2021',(SELECT calcula_precio('A-017',1) from dual));
    DBMS_OUTPUT.PUT_LINE(CHR(10));
--Mostrar pedidos.
    OPEN c_ped;
    DBMS_OUTPUT.PUT_LINE('Pedido '||CHR(9)||''||CHR(9)||' DNI '||CHR(9)||' Artículo '||' Departamento '||' Cantidad '||' Fecha pedido '||' Fecha de llegada '||' Precio');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------------------------');
    LOOP
        FETCH c_ped INTO r_pedidos;
        EXIT WHEN c_ped%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(r_pedidos.cod_pedido||CHR(9)||r_pedidos.dni||CHR(9)||r_pedidos.cod_articulo||CHR(9)||r_pedidos.cod_departamento||CHR(9)||CHR(9)||CHR(9)||r_pedidos.cantidad||CHR(9)||CHR(9)||r_pedidos.fecha||CHR(9)||CHR(9)||r_pedidos.fecha_llegada||CHR(9)||CHR(9)||r_pedidos.precio);
    END LOOP;
    CLOSE c_ped;
    
     DBMS_OUTPUT.PUT_LINE(CHR(10));

--Mostrar artículos.     
    OPEN c_art;
    DBMS_OUTPUT.PUT_LINE('Artículo '||CHR(9)||' Proveedor '||CHR(9)||' Departamento '||' Stock '||CHR(9)||' Categoría '||CHR(9)||CHR(9)||' Precio Proveedor '||CHR(9)||CHR(9)||' Precio '||CHR(9)||CHR(9)||' Nombre');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------------------------------------------');
    LOOP
        FETCH c_art INTO r_articulos;
        EXIT WHEN c_art%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(r_articulos.cod_articulo||CHR(9)||CHR(9)||r_articulos.cod_proveedor||CHR(9)||CHR(9)||r_articulos.cod_departamento||CHR(9)||CHR(9)||CHR(9)||r_articulos.stock||CHR(9)||CHR(9)||r_articulos.categoria||r_articulos.precio_pro||CHR(9)||r_articulos.precio_vent||CHR(9)||'   '||r_articulos.nombre);
    END LOOP;
    CLOSE c_art;
    
--Prueba requisito 2.
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    gestionar_iva('48124785E');
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    gestionar_iva('87567391F');
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    SELECT * INTO r_pedido_iva FROM pedido WHERE dni='87567391F';
    
--Mostrar pedido del cliente que se ha modificado el IVA.
    DBMS_OUTPUT.PUT_LINE('Pedido: '||r_pedido_iva.cod_pedido||'- DNI: '||r_pedido_iva.dni||'- Artículo: '||r_pedido_iva.cod_articulo||'- Departamento: '||r_pedido_iva.cod_departamento ||'- Cantidad: '|| r_pedido_iva.cantidad||'- Fecha pedido: '||r_pedido_iva.fecha ||'- Fecha de llegada: '|| r_pedido_iva.fecha_llegada||'- Precio: ' ||r_pedido_iva.precio);
    
    DBMS_OUTPUT.PUT_LINE(CHR(10));
        
--Prueba requisito 3
    buscar_articulo('cambiar ');
    buscar_articulo('placa');
    
    DBMS_OUTPUT.PUT_LINE(CHR(10));
--Prueba requisito nº5
    muestra_empleado_a_cargo;

--Prueba requisito nº6
    DELETE FROM empleado WHERE cod_empleado='E-001';
    
--Prueba requisito nº7
    INSERT INTO control_precios VALUES('Aumentar','Ganancia',3,SYSDATE,USER);
    
--Prueba requisito nº9
    SELECT calcular_media_intervalo('48124785E','12/4/2012','22/4/2021') INTO v_media FROM dual;
    DBMS_OUTPUT.PUT_LINE('Cliente con dni 48124785E ha gastado una media de '||v_media||'€ entre el 12/4/2021 y 22/4/2021');
    
    DBMS_OUTPUT.PUT_LINE(CHR(10));

--Mostrar articulos.
 OPEN c_art;
    DBMS_OUTPUT.PUT_LINE('Artículo '||CHR(9)||' Proveedor '||CHR(9)||' Departamento '||' Stock '||CHR(9)||' Categoría '||CHR(9)||CHR(9)||' Precio Proveedor '||CHR(9)||CHR(9)||' Precio '||CHR(9)||CHR(9)||' Nombre');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------------------------------------------');
    LOOP
        FETCH c_art INTO r_articulos;
        EXIT WHEN c_art%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(r_articulos.cod_articulo||CHR(9)||CHR(9)||r_articulos.cod_proveedor||CHR(9)||CHR(9)||r_articulos.cod_departamento||CHR(9)||CHR(9)||CHR(9)||r_articulos.stock||CHR(9)||CHR(9)||r_articulos.categoria||r_articulos.precio_pro||CHR(9)||r_articulos.precio_vent||CHR(9)||'   '||r_articulos.nombre);
    END LOOP;
    CLOSE c_art;
    
        DBMS_OUTPUT.PUT_LINE(CHR(10));
--Prueba requisito nº10
    INSERT INTO articulo VALUES('A-027','C-002','DE-04',60.24,85.89,'Placa Base Bazooka MSI',38,'Placas Bases');
    UPDATE articulo SET stock=25 WHERE cod_articulo='A-021';
    DELETE FROM articulo WHERE cod_articulo='A-004';
    
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    
--Mostrar la tabla auditoria_articulos
    OPEN c_aud;
    DBMS_OUTPUT.PUT_LINE('Usuario'||CHR(9)||CHR(9)||CHR(9)||'Fecha_Hora'||CHR(9)||'Operación'||CHR(9)||CHR(9)||CHR(9)||'Datos antiguos'||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||'Datos nuevos');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    LOOP
        FETCH c_aud INTO r_auditoria;
        EXIT WHEN c_aud%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(r_auditoria.usuario||CHR(9)||r_auditoria.fecha_hora||CHR(9)||CHR(9)||r_auditoria.operacion||CHR(9)||r_auditoria.datos_antiguos||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||CHR(9)||r_auditoria.datos_nuevos);
    END LOOP;
    CLOSE c_aud;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10));
--Prueba requisito nº6.
    DELETE FROM empleado WHERE cod_empleado='E-001';
    OPEN c_emp;
    DBMS_OUTPUT.PUT_LINE('Empleado'||CHR(9)||'Departamento'||CHR(9)||'Nombre'||CHR(9)||CHR(9)||'Apellido'||CHR(9)||CHR(9)||CHR(9)||'Teléfono');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------------------');
    LOOP
        FETCH c_emp INTO r_emp;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(r_emp.cod_empleado||CHR(9)||CHR(9)||CHR(9)||r_emp.cod_departamento||CHR(9)||CHR(9)||r_emp.nombre||CHR(9)||CHR(9)||r_emp.apellido||CHR(9)||CHR(9)||r_emp.telefono);
    END LOOP;
    CLOSE c_emp;
    
--Por favor, para comprobar el funcionamiento del requisito nº8, es necesario cambiar la hora del sistema entre las 4 y 7 AM.
    INSERT INTO pedido VALUES('E-000000'||TO_CHAR(pedidos.nextval),'65893234T','A-022','DE-04',1,'23/4/2021',null,(SELECT calcula_precio('A-022',1) from dual));
END;
/

DROP SEQUENCE pedidos;
DROP FUNCTION calcula_precio;
DROP FUNCTION calcular_media_intervalo;
DROP PROCEDURE buscar_articulo;
DROP PROCEDURE gestionar_iva;
DROP PROCEDURE muestra_empleado_a_cargo;
DROP TRIGGER actualizar_stock;
DROP TRIGGER controlar_articulos;
DROP TRIGGER auditoria_articulos;
DROP TRIGGER controlar_hora;
DROP TRIGGER controlar_saldo;
DROP TRIGGER eliminar_empleado;



