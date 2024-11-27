SET SERVEROUTPUT ON;

/*
Ŀ�� FOR LOOP : ����Ű, Ư���� ��쿡�� ��� �Ұ� (����ó��)
CURSOR�� �����Ͱ� ������ �ƿ� ������ ����

FOR ���ڵ��̸�(�ӽ� ���� -> ���ڵ�Ÿ��(�� �� ��°��), FETCH Ŀ���̸� INTO ���ڵ��̸�) IN Ŀ���̸�( LOOP���� ������ ����(����) , OPEN Ŀ���̸�; ) LOOP
    statement1;
    statement2;
    ...
END LOOP; (CLOSE Ŀ���̸�;)
*/

-- Ŀ�� FOR LOOP :����� Ŀ���� ����ϴ� ������
-- 1) ����
DECLARE
    CURSOR Ŀ���� IS
        SELECT��;
BEGIN
    FOR �ӽú���(���ڵ�Ÿ��) IN Ŀ���� LOOP -- �Ͻ������� OPEN�� FETCH
        -- Ŀ���� �����Ͱ� �����ϴ� ��� �����ϴ� �ڵ�
    END LOOP; -- �Ͻ������� CLOSE
END;
/

-- 2) ����
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, salary
        FROM employees;
BEGIN
    FOR emp_rec IN emp_cursor LOOP -- OPEN FETCH, �ٵ� �����Ͱ� ������ �ȵ�
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : ');
        DBMS_OUTPUT.PUT(emp_rec.employee_id);
        DBMS_OUTPUT.PUT(', '||emp_rec.last_name);
        DBMS_OUTPUT.PUT_LINE(', '||emp_rec.salary);
    END LOOP; -- CLOSE
END;
/

/*
�μ���ȣ�� �Է¹޾� �ش� �μ��� �Ҽӵ� �������(�����ȣ, �̸�, �޿�)�� ����ϼ���.
�μ���ȣ 0: Ŀ���� �����Ͱ� ����, 50: Ŀ�� ������ 5��
*/

DECLARE
    CURSOR emp_dept_cursor IS
        SELECT employee_id, last_name, salary
        FROM employees
        WHERE department_id = &�μ���ȣ;
BEGIN
    FOR emp_rec IN emp_dept_cursor LOOP -- �����Ͱ� ��� FOR���� �ƿ� ������ �ȵ�
        DBMS_OUTPUT.PUT(emp_dept_cursor%ROWCOUNT || ' : ');
        DBMS_OUTPUT.PUT(emp_rec.employee_id);
        DBMS_OUTPUT.PUT(', '||emp_rec.last_name);
        DBMS_OUTPUT.PUT_LINE(', '||emp_rec.salary);
    END LOOP; -- �Ͻ������� CLOSE Ŀ��;
    DBMS_OUTPUT.PUT('�� ������ ���� : '||emp_dept_cursor%ROWCOUNT);
END;
/

-- Ŀ�� FOR LOOP ���� ��� ����� Ŀ���� �����͸� ������ �� ���� ���� ���(SELECT ������ ������ �����)

/*
1.
���(employees) ���̺���
����� �����ȣ, ����̸�, �Ի翬���� 
���� ���ؿ� �°� ���� test01, test02�� �Է��Ͻÿ�.

�Ի�⵵�� 2025��(����) ���� �Ի��� ����� test01 ���̺� �Է�
�Ի�⵵�� 2025�� ���� �Ի��� ����� test02 ���̺� �Է�
*/

DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id eid, last_name ename, hire_date hdate
        FROM employees;
BEGIN
    FOR emp_rec IN emp_cursor LOOP -- OPEN, FETCH, CLOSE ���� ��������
        IF emp_rec.hdate <= TO_DATE('20251231','yyyyMMdd') THEN
            INSERT INTO test01(empid, ename, hiredate)
            VALUES (emp_rec.eid, emp_rec.ename,emp_rec.hdate);
        ELSE
            INSERT INTO test02
            VALUES emp_rec;
        END IF;
    END LOOP;
END;
/
delete test02;
SELECT * FROM test01;


/*
2.
�μ���ȣ�� �Է��� ���(&ġȯ���� ���)
�ش��ϴ� �μ��� ����̸�, �Ի�����, �μ����� ����Ͻÿ�.
*/

DECLARE
    CURSOR emp_in_dept_cursor IS
        SELECT last_name ename, hire_date hdate, department_name dname
        FROM employees e join departments d
                         on e.department_id = d.department_id
        WHERE e.department_id = &�μ���ȣ;
BEGIN
    FOR info IN emp_in_dept_cursor LOOP
        DBMS_OUTPUT.PUT(emp_in_dept_cursor%ROWCOUNT ||' : ');
        DBMS_OUTPUT.PUT(', '||info.ename);
        DBMS_OUTPUT.PUT(', '||info.hdate);
        DBMS_OUTPUT.PUT_LINE(', '||info.dname);
    END LOOP;
END;
/

-- ������ Ȯ�� �۾�
-- Ŀ�� FOR LOOP���� ���������� �̿��ؼ� ���� ����(��, �Ӽ��� ���Ұ�)
BEGIN -- 
   FOR emp_rec IN (SELECT last_name, hire_date,department_name
                   FROM employees e join departments d
                                  on e.department_id = d.department_id
                   WHERE e.department_id = &�μ���ȣ) LOOP
        DBMS_OUTPUT.PUT(emp_rec.last_name);
        DBMS_OUTPUT.PUT(', '||emp_rec.hire_date);
        DBMS_OUTPUT.PUT_LINE(', '||emp_rec.department_name);
    END LOOP;
END;
/


DECLARE
    CURSOR emp_cursor IS
        SELECT last_name ename, hire_date hdate, department_name dname
        FROM employees e join departments d
                         on e.department_id = d.department_id
        WHERE e.department_id = &�μ���ȣ;
BEGIN
    FOR emp_rec IN emp_cursor LOOP
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT ||' : ');
        DBMS_OUTPUT.PUT(', '||emp_rec.ename);
        DBMS_OUTPUT.PUT(', '||emp_rec.hdate);
        DBMS_OUTPUT.PUT_LINE(', '||emp_rec.dname);
    END LOOP;
END;
/

/*
3.
�μ���ȣ�� �Է�(&���)�� ��� 
����̸�, �޿�, ����->(�޿�*12+(�޿�*nvl(Ŀ�̼��ۼ�Ʈ,0)*12))
�� ����ϴ�  PL/SQL�� �ۼ��Ͻÿ�.
*/

-- 3-1 : ������ ���� ���
DECLARE 
    CURSOR emp_in_dept_cursor IS
        SELECT last_name, salary, commission_pct
        FROM employees
        WHERE department_id = &�μ���ȣ;
    
    v_year NUMBER(10,2); --����
BEGIN
    FOR v_emp_rec IN emp_in_dept_cursor LOOP
        v_year := v_emp_rec.salary*12+(v_emp_rec.salary*nvl(v_emp_rec.commission_pct,0)*12);
        DBMS_OUTPUT.PUT(emp_in_dept_cursor%ROWCOUNT ||' : ');
        DBMS_OUTPUT.PUT(v_emp_rec.last_name);
        DBMS_OUTPUT.PUT(', '||v_emp_rec.salary);
        DBMS_OUTPUT.PUT_LINE(', '||v_year);
    END LOOP;

END;
/


-- 3-2 : SELECT���� �������
DECLARE 
    CURSOR emp_in_dept_cursor IS
        SELECT last_name ename, salary sal, salary*12+salary*nvl(commission_pct,0)*12 year
        FROM employees
        WHERE department_id = &�μ���ȣ;
BEGIN
    FOR v_emp_rec IN emp_in_dept_cursor LOOP
        DBMS_OUTPUT.PUT(emp_in_dept_cursor%ROWCOUNT ||' : ');
        DBMS_OUTPUT.PUT(v_emp_rec.ename);
        DBMS_OUTPUT.PUT(', '||v_emp_rec.sal);
        DBMS_OUTPUT.PUT_LINE(', '||v_emp_rec.year);
    END LOOP;

END;
/


DECLARE
    CURSOR emp_cursor IS
        SELECT last_name ename, salary sal, salary*12+salary*nvl(commission_pct,0)*12 year
        FROM employees
        WHERE department_id = &�μ���ȣ;
BEGIN
    FOR emp_rec IN emp_cursor LOOP
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT|| ' : ');
        DBMS_OUTPUT.PUT(', '||emp_rec.ename);
        DBMS_OUTPUT.PUT(', '||emp_rec.sal);
        DBMS_OUTPUT.PUT_LINE(', '||emp_rec.year);
    END LOOP;
END;
/

/*
����
EXCEPTION
    WHEN �����̸�1 [OR �����̸�2...] THEN
        �����۾�1;
        �����۾�2;
    WHEN NO_DATA_FOUND THEN
        �����۾�3;
    WHEN OTHERS THEN
        �����۾�4;
https://www.oracle.com/kr/ -���ҽ� -���� (documentation) - oracle database
-Oracle Database 11g Release 2 (11.2)
-Database Administration -> Supporting Documentation -> Error Messages
ORA(�����Ͽ���)�� ó������, PLS�� ���࿡���� ����Ŭ���� �ذ� �Ұ���

ORA-00000: normal, successful completion - ����
Cause: Normal exit. -����
Action: None -�ذ���

PL/SQL Language Reference -> 11 PL/SQL Error Handling->Predefined Exceptions
    => ���⼭ ���� ����� ���ܴ� Ư���� �̸� �ο�������/ PL/SQL������ ��밡��
        -> ���⿡ �ִ� �̸����� ����ó�� ����
���� ������� �ʴ� ���ܴ� �̸��� �ο��ؾߵ�

DECLARE
    e_emps_remaining(�����̸�) EXCEPTION;
    PRAGMA(��ɾ�) EXCETION INIT(���ܻ�Ȳ�ʱ�ȭ) ( e_emps_remaining(�����̸�), -2292(���������ڵ�) );
BEGIN
 SELECT ��¼��
EXCEPTION
    WHEN e_emps_remaining THEN
       ó������;
END;
/

DECLARE
    e_invalid_department EXCEPTION
BEGIN
    IF SQL%NOTFOUND THEN
        RAISE(������ ���ܹ߻�) e_invalid_department;
    END IF;
EXCEPTION
    WHEN e_invalid_department THEN
        ����ó��;

-Application Development

1. �̸� ���ǵ� �̸�  20������ -> EXCEPTION ó���� �ϸ�� EXCEPTION WHEN NO_DATA_FOUND THEN �����Դϴ�;
2. ����Ŭ ���ܴ� ������ �̸� ���� -> DECLARE���� PRAGMA�� �����ڵ忬��, EXCEPTION ó��
3. ����Ŭ ������ ������, �����ڰ� �ǵ����� ������Ȳ -> DECLARE, BEGIN ������ RAISE�� ������ ���ܹ߻�, EXCEPTION ó��
*/

-- ����ó�� : ���ܰ� �߻����� �� ���������� �۾��� ����ɼ� �ֵ��� ó��
-- 1) ����
DECLARE
    
BEGIN
    
EXCEPTION
    WHEN THEN -- �ʿ��� ��ŭ �߰� ����
        -- ���ܹ߻��� ó���ϴ� �ڵ�
    WHEN OTHERS THEN -- ���� ���ǵ� ���ܸ��� �߻��ϴ� ��� �ϰ�ó��
        -- ���ܹ߻��� ó���ϴ� �ڵ�
END;
/

-- 2) ����
-- 2-1) �̹� ����Ŭ�� ���ǵǾ� �ְ�(�����ڵ尡 ����) �̸��� �����ϴ� ���ܻ���
DECLARE
    v_ename employees.last_name%TYPE;
BEGIN
    SELECT last_name
    INTO v_ename
    FROM employees
    WHERE department_id=&�μ���ȣ;
    -- �μ���ȣ 0 : ORA-01403, NO_DATA_FOUND 
    -- �μ���ȣ 10 : �������
    -- �μ���ȣ 50 : ORA-06512, TOO_MANY_ROWS
    -- ���ܸ� ó���ϴ��� ��������� ����, ������ �����
    DBMS_OUTPUT.PUT_LINE(v_ename);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� ���� ����� �����ϴ�.');
        DBMS_OUTPUT.PUT_LINE('����� ����Ǿ����ϴ�.');
    WHEN OTHERS THEN -- 
        DBMS_OUTPUT.PUT_LINE('��Ÿ ���ܻ����� �߻��߽��ϴ�.');
        DBMS_OUTPUT.PUT_LINE('����� ����Ǿ����ϴ�.');
END;
/

-- 2-2) �̹� ����Ŭ�� ���ǵǾ� �ְ�(�����ڵ尡 ����) �̸��� �������� �ʴ� ���ܻ���
DECLARE
    e_emps_remaining EXCEPTION; -- �����̸� ���� ����
    PRAGMA EXCEPTION_INIT(e_emps_remaining, -02292); -- PREGMA : �̸��� �����ڵ� ����
BEGIN
    DELETE FROM departments
    WHERE department_id = &�μ���ȣ;
    -- �μ���ȣ 10 : ORA-02292: integrity constraint (HR.EMP_DEPT_FK) violated - child record found
EXCEPTION
    WHEN e_emps_remaining THEN
        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� �ٸ� ���̺��� ������Դϴ�.');
END;
/
-- 2-3) ����� ���� ���� => ����Ŭ ���忡�� �����ڵ�� ����
-- ���ܹ߻��ϸ� �ٷ� ��������, ���ǹ����� ó���ϸ� �ڵ尡 ������ ����
DECLARE
    e_dept_del_fail EXCEPTION; -- ���� �̸� ����
BEGIN
  DELETE FROM departments
  WHERE department_id = &�μ���ȣ;
  -- �μ���ȣ 0 : ���������� ��������� ��ɻ� ���з� �����ؾ� �ϴ� ���
  IF SQL%ROWCOUNT = 0 THEN -- ���� �ֱ� ����� SQL���� ����� �������� Ȯ��
      RAISE e_dept_del_fail; -- ������ ���� �߻�
  END IF;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
EXCEPTION
    WHEN e_dept_del_fail THEN
        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� �������� �ʽ��ϴ�.');
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ�� Ȯ�����ּ���.');
END;
/


BEGIN
    DELETE FROM departments
    WHERE department_id = &�μ���ȣ;
    -- �μ���ȣ 0 : ���������� ��������� ��ɻ� ���з� �����ؾ� �ϴ� ���
    IF SQL%ROWCOUNT = 0 THEN -- ���� �ֱ� ����� SQL���� ����� �������� Ȯ��
        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� �������� �ʽ��ϴ�.');
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ�� Ȯ�����ּ���.');
    END IF;
END;
/

/*
���� Ʈ�� �Լ� : ���� �߻��� ������ ���� Ȯ���ϰ� ������
INSERT �������� ���Ұ�
SQLCODE : �����ڵ�(���ڰ�)
SQLERRM : �����޼���
*/

-- 2-1-1) �̹� ����Ŭ�� ���ǵǾ� �ְ�(�����ڵ尡 ����) �̸��� �����ϴ� ���ܻ���
DECLARE
    v_ename employees.last_name%TYPE;
BEGIN
    SELECT last_name
    INTO v_ename
    FROM employees
    WHERE department_id=&�μ���ȣ;
    -- �μ���ȣ 0 : ORA-01403, NO_DATA_FOUND 
    -- �μ���ȣ 10 : �������
    -- �μ���ȣ 50 : ORA-06512, TOO_MANY_ROWS
    -- ���ܸ� ó���ϴ��� ��������� ����, ������ �����
    DBMS_OUTPUT.PUT_LINE(v_ename);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� ���� ����� �����ϴ�.');
    WHEN OTHERS THEN -- 
        DBMS_OUTPUT.PUT_LINE('��Ÿ ���ܻ����� �߻��߽��ϴ�.');
        DBMS_OUTPUT.PUT('ORA' || SQLCODE || ' : ');
        DBMS_OUTPUT.PUT_LINE(SUBSTR(SQLERRM,12));
        DBMS_OUTPUT.PUT_LINE('����� ����Ǿ����ϴ�.');
END;
/

/*
1.
drop table emp_test;

create table emp_test
as
  select employee_id, last_name
  from   employees
  where  employee_id < 200;

emp_test ���̺��� �����ȣ�� ���(&ġȯ���� ���)�Ͽ� ����� �����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
(��, ����� ���� ���ܻ��� ���)
(��, ����� ������ "�ش����� �����ϴ�.'��� �����޽��� �߻�)
*/
DECLARE
    e_emp_not_found EXCEPTION;
BEGIN
    DELETE FROM emp_test
    WHERE employee_id = &�����ȣ;
    
    IF SQL%ROWCOUNT = 0 THEN -- ���� �ֱٿ� ����� SQL���� ����� �߻��� �� ����
        RAISE e_emp_not_found;
    END IF;
EXCEPTION
    WHEN e_emp_not_found THEN
        DBMS_OUTPUT.PUT_LINE('�ش����� �����ϴ�.');
END;
/

DECLARE
    emp_test_del_fail EXCEPTION; -- ���� ����
BEGIN
    DELETE FROM emp_test
    -- ���� Ȭ����ǥ ���� ������ �׳� ������ �ν��Ѵ�.
    -- ���࿡ ġȯ������ ���ڸ� �ְ� ������ ġȯ�������� Ȭ����ǥ�� ���ų�, �Է��Ҷ� Ȭ����ǥ �Է�;
    WHERE employee_id = '&�����ȣ';
    
    IF SQL%ROWCOUNT = 0 THEN -- ������ ���� ������ ���� �߻�
        RAISE emp_test_del_fail;
    END IF;
EXCEPTION -- 100%�� ó���� �Ұ���
    WHEN emp_test_del_fail THEN -- ���� �޼��� ���
       DBMS_OUTPUT.PUT_LINE('�ش����� �����ϴ�.');
END;
/

/*
���� ���ν���
CREATE [OR REPLACE] PROCEDURE �̸�
    (�Ű�����1 [MODE] ������Ÿ��1, -- MODE : IN, OUT, IN OUT
     �Ű�����2 [MODE] ������Ÿ��2)
IS|AS
PL/SQL Block; (BEGIN EXCEPTION END; /)

-- ���ڵ� Ÿ��, ���̺� Ÿ���� �ٸ����� ���� �� �Ⱦ�

IN : 1.�⺻��(ǥ�������), 2/.���� �������α׷��� ����(���ν���, �Լ�)
OUT : 1.���� ���� ȣ��ȯ������ ��ȯ
IN OUT : 1.���� �������α׷��� �����ϰ� 2.ȣ��ȯ������ ��ȯ
IN ���� �Ű������� ����� �ۿ� -> ���� ������ �� ����.
OUT : �ʱ�ȭ���� ���� ����


OUT / IN OUT�ݵ�� ���� ������ �ϹǷ� �������ٰ� ������
*/

-- PROCEDURE
-- 1)����
CREATE PROCUDRUE ���ν�����
    (�Ű������� [���] ������Ÿ��, ...)
IS
    -- ����� : ���ú���, Ŀ��, ���ͼ��� ���� ����
BEGIN
    -- PROCEDURE�� ������ �ڵ�
EXCEPTION
    --����ó��
END;
/

-- 2) ����
DROP PROCEDURE test_pro; -- �����̸����� ���� �Ұ�
CREATE PROCEDURE test_pro
   (p_msg VARCHAR2) -- �Ͻ������� IN���� ����, VARCHAR2(100)�� �ȵ�
IS
    v_msg VARCHAR2(1000) := 'Hello';
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_msg||p_msg);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('�����Ͱ� �������� �ʽ��ϴ�.');
END;
/

-- 3) ����

DECLARE
    v_result VARCHAR2(1000);
BEGIN
    -- ����Ŭ�� ���� �����ϴ� ��ü�� PROCEDURE���� FUNCTION���� �����ϴ� ���
    --     => ȣ������ (���ʿ� ������ �����ϴ� ��)
    -- v_result := test_pro('PL/SQL'); 
    -- ���ν����� ������ ��ƹ����� �Լ��� �ν��ؼ� ��ã��
    test_pro('PL/SQL');
END;
/
-- ���ν��� �ϳ��� ȣ���Ҷ� ��밡��, �����ٰ� �ּ��޸� ����ȵ�
--PLS-00103: Encountered the symbol "end-of-file" when expecting one of the following:
EXECUTE test_pro('WORLD');


-- IN ��� : ȣ��ȯ�� -> ���ν����� ���� ����, ���ν��� ���ο��� ������
-- PLS-00363: expression 'P_EID' cannot be used as an assignment target
-- => ���Ҵ� Ÿ������ ����Ҽ� ���� : ������
DROP PROCEDURE raise_salary;
CREATE PROCEDURE raise_salary
    (p_eid IN employees.employee_id%TYPE)
IS

BEGIN
   -- ERROR : ���ν��� ���ο��� ��� ��޵ǹǷ� ���� ������ �� ����
   -- p_eid := 100;
   
   UPDATE employees
   SET salary = salary * 1.1
   WHERE employee_id = p_eid;
END;
/

SELECT employee_id, salary
FROM employees
WHERE employee_id IN (100, 130, 149);

DECLARE
    v_first NUMBER(3,0) := 100; -- �ʱ�ȭ�� ����
    v_second CONSTANT NUMBER(3,0) := 149; -- ���
BEGIN
    raise_salary(100);          -- ���ͷ�
    raise_salary(v_first+30);   -- ǥ����
    raise_salary(v_first);      -- �ʱ�ȭ�� ����
    raise_salary(v_second);     -- ���
END;
/

ROLLBACK;

-- OUT ��� : ���ν��� -> ȣ��ȯ������ ���� ��ȯ, ���ν��� ���ο��� �ʱ�ȭ���� ���� ������ ����
CREATE PROCEDURE test_p_out
    (p_num IN NUMBER,
     p_out OUT NUMBER)
IS
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('IN : ' || p_num);
    DBMS_OUTPUT.PUT_LINE('OUT : ' || p_out);
END; -- ����� ����Ǵ� ���� OUT ����� �Ű������� ������ �ִ� ���� �״�� ��ȯ 
/
-- �����ڵ� 
DECLARE
    v_result NUMBER(4,0) := 1234;
BEGIN
    DBMS_OUTPUT.PUT_LINE('1) result : ' || v_result);
    test_p_out(1000,v_result);
    DBMS_OUTPUT.PUT_LINE('2) result : ' || v_result);
END;
/

-- ���ϱ�
CREATE PROCEDURE pro_plus
    (p_x IN NUMBER,
     p_y IN NUMBER,
     p_sum OUT NUMBER)
IS

BEGIN
    p_sum := p_x + p_y;
END; 
/
DECLARE
    v_total NUMBER(10,0);
BEGIN
    pro_plus(10,25,v_total);
    DBMS_OUTPUT.PUT_LINE(v_total);
END;
/

-- IN OUT ��� : IN ���� OUT ��� �ΰ����� �ϳ��� ������ ó��
-- => ���� �����Ͱ� ����� (���� �����Ͱ� ����Ǿ�� �ϴ� ��쿡�� ���)
-- IN�� ���, OUT�� �ʱ�ȭ���� ���� ����
-- '01012341234' => '010-1234-1234'
-- ��¥�� ������ �������� ���� : '24/11/27' => '24��11��27��'
DROP PROCEDURE format_phone;
CREATE PROCEDURE format_phone
    (p_phone_no IN OUT VARCHAR2)
IS

BEGIN
    DBMS_OUTPUT.PUT_LINE('before : ' || p_phone_no);
    p_phone_no := SUBSTR(p_phone_no,1,3)
                  || '-' || SUBSTR(p_phone_no,4,4)
                  || '-' || SUBSTR(p_phone_no,8);
    DBMS_OUTPUT.PUT_LINE('after : ' || p_phone_no);
END;
/

DECLARE
    v_no VARCHAR2(100) := '01012341234';
BEGIN
    format_phone(v_no);
    DBMS_OUTPUT.PUT_LINE(v_no);
END;
/

CREATE FUNCTION hello
RETURN VARCHAR2

IS

BEGIN
    RETURN 'Hello !!!';
END;
/
SELECT hello
FROM dual;

/*
1.
�ֹε�Ϲ�ȣ�� �Է��ϸ� 
������ ���� ��µǵ��� yedam_ju ���ν����� �ۼ��Ͻÿ�.

EXECUTE yedam_ju('9501011667777')
EXECUTE yedam_ju('1511013689977')

=> �Ű������� ���ͷ� => IN �Ű����� �ϳ��� + ������ ��±��� => DBMS_OUTPUT.PUT_LINE�� ���ο��� ����

*/
DROP PROCEDURE yedam_ju;
CREATE PROCEDURE yedam_ju -- �ֹι�ȣ 2000����� 00���� �����ؼ� 0�� �������� -> ���ڷ� ó���ؾߵ�
    (p_ssn IN VARCHAR2)
IS
    v_result VARCHAR2(30);
BEGIN
    v_result := SUBSTR(p_ssn,1,6) -- �� 6�ڸ�
                -- || '-' || SUBSTR(p_ssn,7); -- �� 7�ڸ�
                || '-' || RPAD(SUBSTR(p_ssn,7,1),7,'*');
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
EXECUTE yedam_ju('9501011667777');


DROP PROCEDURE yedam_ju;
CREATE PROCEDURE yedam_ju
    (p_jumin IN NUMBER)
IS
    v_jumin VARCHAR2(100);
BEGIN
    v_jumin := SUBSTR (p_jumin, 1,6)||
               '-'|| SUBSTR (p_jumin, 7,1)
               || '******';
    DBMS_OUTPUT.PUT_LINE(v_jumin);
END;
/

EXECUTE yedam_ju('9501011667777');

/*
2.
�����ȣ�� �Է��� ���
�����ϴ� TEST_PRO ���ν����� �����Ͻÿ�.
��, �ش����� ���� ��� "�ش����� �����ϴ�." ���
��) EXECUTE TEST_PRO(176)
*/
DROP PROCEDURE test_pro;
CREATE PROCEDURE test_pro
    (p_empid IN NUMBER)
IS
    
BEGIN
    DELETE FROM employees
    WHERE employee_id = p_empid;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('�ش����� �����ϴ�.');
    END IF;
END;
/
 EXECUTE TEST_PRO(176);

/*
3.
������ ���� PL/SQL ����� ������ ��� 
�����ȣ�� �Է��� ��� ����� �̸�(last_name)�� ù��° ���ڸ� �����ϰ��
'*'�� ��µǵ��� yedam_emp ���ν����� �����Ͻÿ�.

����) EXECUTE yedam_emp(176)
������) TAYLOR -> T*****  <- �̸� ũ�⸸ŭ ��ǥ(*) ���
*/

DROP PROCEDURE yedam_emp;
CREATE PROCEDURE yedam_emp
    (p_empid IN NUMBER)
IS
    v_ename employees.last_name%TYPE;
    v_newname VARCHAR2(100);
BEGIN
    SELECT last_name
    INTO v_ename
    FROM employees
    WHERE employee_id = p_empid;
    
    v_newname := RPAD(SUBSTR(v_ename,1,1),LENGTH(v_ename),'*');
    DBMS_OUTPUT.PUT_LINE(v_newname);
END;
/

/*
4.
�μ���ȣ�� �Է��� ��� 
�ش�μ��� �ٹ��ϴ� ����� �����ȣ, ����̸�(last_name), ������ ����ϴ� get_emp ���ν����� �����Ͻÿ�. 
(cursor ����ؾ� ��)
��, ����� ���� ��� "�ش� �μ����� ����� �����ϴ�."��� ���(exception ���)
����) EXECUTE get_emp(30)
*/



/*
5.
�������� ���, �޿� ����ġ�� �Է��ϸ� Employees���̺� ���� ����� �޿��� ������ �� �ִ� y_update ���ν����� �ۼ��ϼ���. 
���� �Է��� ����� ���� ��쿡�� ��No search employee!!����� �޽����� ����ϼ���.(����ó��)
����) EXECUTE y_update(200, 10)
*/


