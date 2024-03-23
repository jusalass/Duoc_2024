-- CASO 1

SET SERVEROUTPUT ON

VARIABLE v_rut NUMBER

EXECUTE :v_rut:= &INGRESE_RUT;

DECLARE
    v_porcentaje_bono NUMBER;
    v_nombre_empleado VARCHAR2(100);
    v_bono_extra NUMBER;
    v_sueldo_empleado NUMBER;
    v_dv_rut CHAR;
    v_est_civil estado_civil.desc_estcivil%TYPE;
BEGIN
    
    v_porcentaje_bono:= &Ingrese_porcentaje;

    
    SELECT  UPPER(emp.nombre_emp ||' '|| emp.appaterno_emp ||' '||emp.apmaterno_emp),
            emp.sueldo_emp,
            emp.dvrut_emp
    INTO v_nombre_empleado, v_sueldo_empleado, v_dv_rut
    FROM EMPLEADO emp
    WHERE numrut_emp = :v_rut;
    
    v_bono_extra := TRUNC(v_porcentaje_bono/100 * v_sueldo_empleado);
    
    DBMS_OUTPUT.PUT_LINE('DATOS CALCULO BONIFICACION EXTRA DEL ' || v_porcentaje_bono||'% DEL SUELDO');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    DBMS_OUTPUT.PUT_LINE('Nombre Empleado: ' || v_nombre_empleado);
    DBMS_OUTPUT.PUT_LINE('RUN: ' || :v_rut||'-'||v_dv_rut);
    DBMS_OUTPUT.PUT_LINE('Sueldo: '|| v_sueldo_empleado);
    DBMS_OUTPUT.PUT_LINE('Bonificación extra: ' || v_bono_extra);
END;



