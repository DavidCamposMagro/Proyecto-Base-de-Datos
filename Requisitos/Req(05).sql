CREATE OR REPLACE PROCEDURE muestra_empleado_a_cargo IS
--Cursor que recorre los departamentos.
    CURSOR c_departamento IS SELECT * FROM departamento; 
--Variable que recibe los registros del cursor de departamentos.
    r_dep departamento%ROWTYPE;
--Cursor que recorre los jefes de dichos departamanetos recibiendo por parametros el código del departamento.
    CURSOR c_jefe(v_cod_dep VARCHAR2) IS SELECT DISTINCT COUNT(je.cod_empleado) AS "N_EMPLEADOS",j.nombre || ' ' || j.apellido AS "NOMBRE_JEFE",j.telefono,j.cod_jefe,j.cod_departamento
                            FROM jefe_empleado je,jefe j, departamento d 
                            WHERE  j.cod_jefe=je.cod_jefe AND j.cod_departamento=v_cod_dep
                            GROUP BY j.nombre || ' ' || j.apellido,j.telefono,j.cod_departamento,d.nombre,j.cod_jefe
                            ORDER BY j.cod_jefe;  
--Variable que recibe los registros del cursor de jefes.
    r_jefe c_jefe%ROWTYPE;    
--Cursor que recorre todos los empleados que están a cargo de un jefe recibiendo por parametros el código de dicho jefe.
    CURSOR c_empleados(v_cod_jefe VARCHAR2) IS SELECT e.nombre ||' ' || e.apellido AS "NOMBRE_EMP",e.telefono,e.cod_empleado 
                                                    FROM empleado e,jefe_empleado je
                                                    WHERE je.cod_jefe=v_cod_jefe AND je.cod_empleado=e.cod_empleado
                                                    ORDER BY e.cod_empleado;   
 --Variable que recibe los registros del cursor de empleados.
    r_emp c_empleados%ROWTYPE;                           
BEGIN
    OPEN c_departamento; 
--Bucle para mostrar datos de los departamentos.
     LOOP                   
        FETCH c_departamento INTO r_dep;
 --Salida del bucle cuando no existan datos.
        EXIT WHEN c_departamento%NOTFOUND;     
        DBMS_OUTPUT.PUT_LINE('*************************************************************************************************************');
--Mostrar datos de los departamentos.
        DBMS_OUTPUT.PUT_LINE('Departamento: '|| r_dep.nombre||' con código: ' || r_dep.cod_departamento||' tiene: ' || r_dep.area_ventas||' areas de ventas');  
        DBMS_OUTPUT.PUT_LINE('============================================================================================================');
--Bucle que recorre todos los jefes de dicho departamento.
        FOR r_jefe IN c_jefe(r_dep.cod_departamento) LOOP  
--Mostrar datos de los jefes.
            DBMS_OUTPUT.PUT_LINE(CHR(9)||'Jefe: ' ||r_jefe.nombre_jefe ||' con Código: '|| r_jefe.cod_jefe|| ' con Teléfono: '||r_jefe.telefono);               
            DBMS_OUTPUT.PUT_LINE(CHR(9)||'Tiene: ' || r_jefe.n_empleados || ' empleados a cargo: ');
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------------------------------------------');
--Bucle que recorre todos los empleados a cargo de dicho jefe.
            FOR r_emp IN c_empleados(r_jefe.cod_jefe) LOOP             
--Mostrar datos de los empleados.
                DBMS_OUTPUT.PUT_LINE(CHR(9)||CHR(9)||'Empleado: ' ||r_emp.nombre_emp ||' con código: '|| r_emp.cod_empleado|| ' con teléfono: '||r_emp.telefono);  
            END LOOP;                                                                                                                                              
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------------------------------------------');
        END LOOP;                                                                                                                                                   
        DBMS_OUTPUT.PUT_LINE('============================================================================================================');
        DBMS_OUTPUT.PUT_LINE('*************************************************************************************************************');
 --Salto de línea.
        DBMS_OUTPUT.PUT_LINE(CHR(10));                                                                                                                             
    END LOOP;                                                                                                           
    CLOSE c_departamento;  
--Excepciones
EXCEPTION 
 --Mostrar "Error no previsto" si ocurriese un error no previsto en la ejecución del programa.
    WHEN OTHERS THEN                                       
        DBMS_OUTPUT.PUT_LINE('*Error no previsto*');
END;
/
