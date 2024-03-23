-- CASO 3

SET SERVEROUTPUT ON

VARIABLE v_rut NUMBER
VARIABLE v_porc_aumento_todos NUMBER
VARIABLE v_porc_aumento_rango NUMBER
VARIABLE v_sueldo_minimo NUMBER
VARIABLE v_sueldo_maximo NUMBER


EXECUTE :v_rut:= &Ingrese_rut;
EXECUTE :v_porc_aumento_todos:= &Ingrese_porcentaje_aumento_de_todos_los_empleados;
EXECUTE :v_porc_aumento_rango:= &Ingrese_porcentaje_aumento_para_rango_de_sueldo;
EXECUTE :v_sueldo_minimo:= &Ingrese_sueldo_minimo;
EXECUTE :v_sueldo_maximo:= &Ingrese_sueldo_maximo;

DECLARE
    v_sueldo_actual_emp empleado.sueldo_emp%TYPE;
    v_nombre_completo VARCHAR(100);
    v_sueldo_reajustado_todos empleado.sueldo_emp%TYPE;
    v_sueldo_reajustado_rango empleado.sueldo_emp%TYPE;
    v_reajuste_todos empleado.sueldo_emp%TYPE;
    v_reajuste_rango empleado.sueldo_emp%TYPE;
    v_dv_rut empleado.dvrut_emp%TYPE;
BEGIN
    SELECT  UPPER(em.nombre_emp||' '||em.appaterno_emp||' '||em.apmaterno_emp),
            em.sueldo_emp,
            em.dvrut_emp
    INTO v_nombre_completo, v_sueldo_actual_emp, v_dv_rut
    FROM EMPLEADO em
    WHERE em.numrut_emp = :v_rut;
    
    v_reajuste_todos:= ROUND(v_sueldo_actual_emp * (:v_porc_aumento_todos/100));
    v_sueldo_reajustado_todos:= v_reajuste_todos + v_sueldo_actual_emp;
    
    v_reajuste_rango:= ROUND(v_sueldo_actual_emp * (:v_porc_aumento_rango/100));
    v_sueldo_reajustado_rango:= v_reajuste_rango + v_sueldo_actual_emp;
    
    DBMS_OUTPUT.put_line('NOMBRE DEL EMPLEADO: '||v_nombre_completo);
    DBMS_OUTPUT.put_line('RUN: '||:v_rut||'-'||v_dv_rut);
    DBMS_OUTPUT.put_line('SIMULACIÓN 1: Aumentar en '||:v_porc_aumento_todos||'% el salario de todos los empleados' );
    DBMS_OUTPUT.put_line('Sueldo actual: '||v_sueldo_actual_emp);
    DBMS_OUTPUT.put_line('Sueldo reajustado: '||v_sueldo_reajustado_todos);
    DBMS_OUTPUT.put_line('Reajuste: '||v_reajuste_todos);
    DBMS_OUTPUT.put_line('SIMULACIÓN 2: Aumentar en '||:v_porc_aumento_rango||'% el salario de los empleados que poseen salarios entre '||TO_CHAR(:v_sueldo_minimo, 'L999G999G999')||' y '||TO_CHAR(:v_sueldo_maximo, 'L999G999G999'));
    DBMS_OUTPUT.put_line('Sueldo actual: '||v_sueldo_actual_emp);
    DBMS_OUTPUT.put_line('Sueldo reajustado: '||v_sueldo_reajustado_rango);
    DBMS_OUTPUT.put_line('Reajuste: '||v_reajuste_rango);
END;



