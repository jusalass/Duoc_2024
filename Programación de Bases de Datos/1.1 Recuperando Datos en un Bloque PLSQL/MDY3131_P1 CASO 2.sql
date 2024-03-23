--CASO 2
SET SERVEROUTPUT ON

VARIABLE v_rut NUMBER
VARIABLE v_renta_minima NUMBER

EXECUTE :v_rut:= &INGRESE_RUT;
EXECUTE :v_renta_minima:= &INGRESE_RENTA_MINIMA

DECLARE
    v_nombre_cli VARCHAR2(100);
    v_renta_cli NUMBER;
    v_dv_rut CHAR;
    v_est_civil estado_civil.desc_estcivil%TYPE;
BEGIN  
    SELECT  UPPER(c.nombre_cli ||' '|| c.appaterno_cli ||' '||c.apmaterno_cli),
            c.renta_cli,
            c.dvrut_cli,
            ec.desc_estcivil
    INTO v_nombre_cli, v_renta_cli, v_dv_rut, v_est_civil
    FROM CLIENTE c 
    JOIN ESTADO_CIVIL ec ON(c.id_estcivil = ec.id_estcivil)
    WHERE c.renta_cli >= :v_renta_minima 
    AND c.numrut_cli = :v_rut ;
    
    DBMS_OUTPUT.PUT_LINE('DATOS DEL CLIENTE');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre_cli);
    DBMS_OUTPUT.PUT_LINE('RUN: ' || :v_rut||'-'||v_dv_rut);
    DBMS_OUTPUT.PUT_LINE('Estado civil: ' || v_est_civil);
    DBMS_OUTPUT.PUT_LINE('Renta:'||TO_CHAR(v_renta_cli, 'L999G999G999'));
    
END;


