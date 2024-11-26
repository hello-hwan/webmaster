/*
���ڵ� : Javascript�� ��ü�� ����, �ʵ�(�ʵ��)���� ȣ��
1) ���� : TYPE ���ڵ��̸� IS RECORD ( �̸� ������Ÿ�� [��������(NOT NULL) �ʱ�ȭ(:= | DEFAULT)])
2) ���� : 

���� ����   : ������ [CONSTANT]  ������ Ÿ�� [NOT NULL] [:= | DEFAULT expr]
���ڵ� ���� : �ʵ�� [�������ȵ�] ������ Ÿ�� [NOT NULL] [:= | DEFAULT expr]
*/

-- ���� ������ ���� : �� ���� ���� �� �ִ� ������ Ÿ��
-- RECORD : ���ο� �ʵ带 ������ ������ ����, SELECT��ó�� �����͸� ��ȸ�ϴ� ��� ���� ����.
-- 1) ����
DECLARE
     -- 1. ���ڵ� Ÿ�� ����
     TYPE ���ڵ�Ÿ�Ը� IS RECORD
          (�ʵ�� ������Ÿ��,
           �ʵ�� ������Ÿ�� :='�ʱⰪ',
           �ʵ�� ������Ÿ�� NOT NULL :='�ʱⰪ');
     -- 2. ���� ����
     ������ ���ڵ�Ÿ�Ը�(���� ���ǵ� �̸�);
BEGIN
     -- 3. ���
     ������.�ʵ�� := ���氪;
     DBMS_OUTPUT.PUT_LINE(������.�ʵ��); 
     -- ���ο� �ִ� �ʵ常 ��°���, ���ڵ� Ÿ�� ��°�� ����� �ȵ�
     -- �ʵ� Ÿ���� ���� ����, ������ ���ڵ�, ���̺�(�ȹ��) �� ����
END;
/

-- 2. ����
DECLARE
     -- 1.Ÿ������ => INTO  ������ ���Ǵ� ��� SELECET���� �÷��� ������ ���·� ����
     TYPE emp_record_type IS RECORD
          ( empno NUMBER(6,0),
            ename employees.last_name%TYPE NOT NULL := 'Hong',
            sal employees.salary%TYPE := 0);
            
     -- 2. ��������
     v_emp_info emp_record_type;
     v_emp_rec emp_record_type;
BEGIN
     DBMS_OUTPUT.PUT(v_emp_info.empno);
     DBMS_OUTPUT.PUT(', ' || v_emp_info.ename);
     DBMS_OUTPUT.PUT_LINE(', ' || v_emp_info.sal);
     
     v_emp_rec.empno := &�����ȣ;
     
     SELECT employee_id, last_name, salary -- ��ȸ �Ǵ� ����� Į�� 3��, ���ڵ嵵 �ʵ� 3�� (������ ���� ����ߵ�)
     -- ������ SELECT ������ ���ڵ�� ����ߵ�, ������ �ʵ� �̸�-������ Ÿ�� ���缭 �ۼ��س��ұ� ������
     INTO v_emp_info -- INTO ���� ����ϴ� ���ڵ� Ÿ���� �ݵ�� �ϳ�, �߰��ϸ� �ȵ�
     FROM employees
     WHERE employee_id = v_emp_rec.empno;
     
     DBMS_OUTPUT.PUT(v_emp_info.empno);
     DBMS_OUTPUT.PUT(', ' || v_emp_info.ename);
     DBMS_OUTPUT.PUT_LINE(', ' || v_emp_info.sal);
END;
/

-- %ROWTYPE : ���̺� Ȥ�� ���� �� ���� RECORD TYPE���� ��ȯ => Ÿ�� ���� ���� ���� �������� �ٷ� ���
DECLARE
     v_emp_rec employees%ROWTYPE; -- �ش� ���̺��� ��ü�� ��ȸ�� ��쿡��
BEGIN
     SELECT * -- �ݵ�� �ƽ�Ÿ (*)�� ��ȸ
     INTO v_emp_rec
     FROM employees
     WHERE employee_id = &�����ȣ;
     
     DBMS_OUTPUT.PUT_LINE(v_emp_rec.employee_id); -- �ʵ���� ������ �ʾұ� ������ �÷��� �״�� ���
     
END;
/

-- SELECT��(�����ͺ��̽�)�� ��°�� �ϳ��� ����(�޸�)�� �־�θ� ���ҽ� ���� �ξ� �پ���.
-- => ���ڵ�Ÿ������ ������ ���̺�Ÿ�� ���
-- ���̺� : �迭�� ����, �ε��� ��� (����, 0, ���) - BINARY_INTEGER���� PLS_INTEGER�� �� �� ������.

-- RECORD Ÿ�Կ��� ���ڵ尡 �ü� ������, ���̺�(�迭)Ÿ�Կ��� ���̺�(�迭) �߰��� ����
-- TYPE ���̺��̸� IS TABLE OF �÷�Ÿ�� [NOT NULL] INDEX BY PLS_INTEGER;

-- TABLE :  ������ ������ Ÿ���� ���� ������ ����, �ַ�, ���ڵ�Ÿ�԰� �԰� ���̺��� ��� �����͸� ������ ���� �� ���
-- 1) ����
DECLARE
     -- 1. Ÿ�� ����
     TYPE ���̺�Ÿ�Ը� IS TABLE OF ������ Ÿ��
          INDEX BY BYNARY_INTEGER;
          
     -- 2. ���� ����
     ������ ���̺�Ÿ�Ը�;
BEGIN
     -- 3. ���
     ������(�ε���) := '�ʱⰪ'; -- �ε��� �ʱ�ȭ �ʿ�, ��ȣ ���·� �ε��� ȣ�� (���ȣ �ƴ�)
     DBMS_OUTPUT.PUT_LINE(������(�ε���)); -- ������(���ڵ�,���̺�)Ÿ���� �ݵ�� ���� �ʵ�,�ε����� �����ؾߵ�
END;
/

-- 2) ����
DECLARE
     -- 1) ����
     TYPE num_table_type IS TABLE OF NUMBER
          INDEX BY PLS_INTEGER;
     -- 2) ��������
     v_num_info num_table_type;
BEGIN
     v_num_info(-123456789) := 1000;
     v_num_info(1111111111) := 1234;
     DBMS_OUTPUT.PUT_LINE(v_num_info(-123456789));
     DBMS_OUTPUT.PUT_LINE(v_num_info(1111111111)); -- �ε��� ������ no data found
     -- �̰Ŵ� �ε����� ������ ���� ��������� �ʾƼ� �޼ҵ�� �����ؾߵ�
END;
/
/*
EXISTS(n), COUNT, FIRST, LAST. PRIOR(n)- 10���̸� 9��...�߿� ���� ������
NEXT(n) - 10���̸� 11��...�߿� ���� ������
DELETE ����� ���� DELETE(n) n��° �ε��� �� ����/ DELETE(n,m) n����m���� ����
*/

-- ���̺� Ÿ���� �޼��� Ȱ��
DECLARE
    -- 1) ���̺� Ÿ�� ����
    TYPE num_table_type IS TABLE OF NUMBER
         INDEX BY BINARY_INTEGER;
    
    -- 2) ���� ����
    v_num_info num_table_type;
    v_idx NUMBER; -- NUMBER�� ũ�� ���� ���ص� ��
BEGIN
    v_num_info(-23)  :=1;
    v_num_info(-5)   :=2;
    v_num_info(11)   :=3;
    v_num_info(1121) :=4;
    
    DBMS_OUTPUT.PUT_LINE('���� ���� : ' || v_num_info.COUNT);
    
    -- FOR LOOP�� : ������ ������ ������ ���δ� �ݺ�
    FOR idx IN v_num_info.FIRST..v_num_info.LAST LOOP
        IF v_num_info.EXISTS(idx) THEN
            DBMS_OUTPUT.PUT_LINE(idx || ' : ' || v_num_info(idx));
        END IF;
    END LOOP;
    
    -- �⺻ LOOP�� : ���� ���� �˻�
    v_idx := v_num_info.FIRST;
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_idx || ' : ' || v_num_info(v_idx));
        
        EXIT WHEN v_num_info.LAST <= v_idx;
        v_idx := v_num_info.NEXT(v_idx); -- ù��° ������ ������, ������, ���������� ����
    END LOOP;
END;
/

-- TABLE + RECORD
DECLARE
    -- 1) Ÿ�� ����
    TYPE emp_table_type IS TABLE OF employees%ROWTYPE
        INDEX BY BINARY_INTEGER;
    -- 2) ������ ����
    v_emp_list emp_table_type;
    v_emp_rec employees%ROWTYPE;
BEGIN
    -- ���̺� ��ȸ
    FOR eid IN 100..104 LOOP
       SELECT *
       INTO v_emp_rec -- employees%ROWTYPE �̰ɷ� ����Ʈ ���� ���� �� �����.
       FROM employees
       WHERE employee_id = eid;
       
       v_emp_list(eid) := v_emp_rec;
    END LOOP;
    
    -- ���̺� Ÿ���� ������ ��ȸ
    FOR idx IN v_emp_list.FIRST..v_emp_list.LAST LOOP
        IF v_emp_list.EXISTS(idx) THEN -- EXISTS(n) ���� n�� �ε����� �����Ͱ� �����ϸ� true��ȯ
            --�ش� �ε����� �����Ͱ� �ִ� ���
            DBMS_OUTPUT.PUT(v_emp_list(idx).employee_id);
            DBMS_OUTPUT.PUT(', ' || v_emp_list(idx).last_name);
            DBMS_OUTPUT.PUT_LINE(', ' || v_emp_list(idx).salary);
        END IF;
    END LOOP;
END;
/
-- Employees ���̺� ��ü ������ => ���̺� Ÿ���� ������ ���
DECLARE
    -- 1) Ÿ�� ����
    TYPE emp_table_type IS TABLE OF employees%ROWTYPE
        INDEX BY BINARY_INTEGER;
    -- 2) ������ ����
    v_emp_list emp_table_type;
    v_emp_rec employees%ROWTYPE;
    
    v_min employees.employee_id%TYPE;
    v_max v_min%TYPE;
    
    v_count NUMBER;
BEGIN
    -- employee_id �ּҰ�, �ִ밪
    SELECT MIN(employee_id), MAX(employee_id)
    INTO v_min, v_max
    FROM employees;
    
    
    -- ���̺� ��ȸ
    FOR eid IN v_min..v_max LOOP -- �̰Ŵ� �߰��� ���� �� no data found ���
       -- �ش� �����ȣ ���� �����Ͱ� ���� ��� ���� ��������
       SELECT COUNT(*)
       INTO v_count
       FROM employees
       WHERE employee_id = eid;
       
       CONTINUE WHEN v_count= 0;
       
       SELECT *
       INTO v_emp_rec -- employees%ROWTYPE �̰ɷ� ����Ʈ ���� ���� �� �����.
       FROM employees
       WHERE employee_id = eid;
       
       v_emp_list(eid) := v_emp_rec;
    END LOOP;
    
    -- ���̺� Ÿ���� ������ ��ȸ
    FOR idx IN v_emp_list.FIRST..v_emp_list.LAST LOOP
        IF v_emp_list.EXISTS(idx) THEN -- EXISTS(n) ���� n�� �ε����� �����Ͱ� �����ϸ� true��ȯ
            --�ش� �ε����� �����Ͱ� �ִ� ���
            DBMS_OUTPUT.PUT(v_emp_list(idx).employee_id);
            DBMS_OUTPUT.PUT(', ' || v_emp_list(idx).last_name);
            DBMS_OUTPUT.PUT_LINE(', ' || v_emp_list(idx).salary);
        END IF;
    END LOOP;
END;
/

/*
SELECT COUNT(*), COUNT (commission_pct)
FROM employees
where employee_id = 0;

SELECT *
FROM employees;
*/

-- �����Ŀ�� : Ȱ������ (����Ʈ�� ���) ���� ���� ���� ������ �ٷ� ���� Ŀ��(�����Ͱ���ġ)
-- Ŀ��(������)�� �����θ� �����ϼ� ���� - 3���� ������� ���� OPEN , FETCH, CLOSE
/*
DECLARE 
    CURSOR Ŀ���̸� IS
    SELECT *
    FROM employees;

BEGIN
    OPEN Ŀ���̸�; : Ȱ������ �ĺ�, �����͸� ù��° ��ġ�� �̵� (�Ʒ��θ� �̵�����)
    FETCH Ŀ���̸� INTO ����, ���� : �������� PL/SQL ��º����� �а�, Ŀ�� �������� �̵�
    CLOSE Ŀ���̸� : Ȱ�������� ���߸�, Ŀ���� ������̸� SELECT �� ����, ������ �ݾ���ߵ�
*/

/*
����� Ŀ�� : ������ SELECT��
1) DECLARE : Ŀ�� ����
2) OPEN : 1.Ŀ�� ���� -> 2.Ȱ������ -> 3.�����͸� ������ �̵�
3) FETCH : 1.�����͸� ������ �̵� -> 2. ���� ����Ű�� �� �������
4) CLOSE : Ȱ������ �Ҹ�
*/


-- ����� Ŀ�� : ���� ��  SELECT���� �����ϱ� ���� PL/SQL ����
SELECT *
FROM employees;
-- 1) ����
DECLARE
    -- 1. Ŀ�� ����
    CURSOR Ŀ���� IS
        SELECT�� (SQL�� SELECT��, INTO�� ���Ұ�)
    
BEGIN
    -- 2. Ŀ�� ����
    -- 2-1) Ŀ���� ���� �����ؼ� Ȱ������(���)�� �ĺ�(����)
    -- 2-2) �����͸� ���� ���� ��ġ
    OPEN Ŀ����;
    
    -- 3. ������ ����
    -- 3-1) �����͸� �Ʒ��� �̵�
    -- 3-2) ���� ����Ű�� �����͸� ����
    FETCH Ŀ���� INTO ����;
    
    -- 4. Ŀ�� ���� : Ȱ������(���)�� ����
    CLOSE Ŀ����;
    
END;
/

-- 2) ����
DECLARE
    -- 1. Ŀ�� ����
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees;
    -- INTO���� ����� ������ �ʿ� => Ŀ���� SELECT�� �÷� ������ŭ
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    -- 2. Ŀ�� ����
    -- Ŀ�� ��ġ : ù��° �����ͺ��� ����
    OPEN emp_cursor;
    -- OPEN emp_cursor; �����޼��� already open
    
    -- 3. Ŀ������ ������ ����
    -- Ŀ�� ��ġ : ù��° �����͸� ����Ű�� ����
    FETCH emp_cursor INTO v_eid, v_ename, v_hdate ;
    
    -- 3.5 �����͸� ������� ����
    DBMS_OUTPUT.PUT_LINE(v_eid||', '||v_ename||', '||v_hdate);
    
    -- 4. Ŀ�� ����
    CLOSE emp_cursor;
    
END;
/

-- ����� Ŀ���� �Ӽ��� �⺻ LOOP��
DECLARE
    -- 1. Ŀ�� ����
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees;
    -- INTO���� ����� ������ �ʿ� => Ŀ���� SELECT�� �÷� ������ŭ
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    -- 2. Ŀ�� ����
    -- Ŀ�� ��ġ : ù��° �����ͺ��� ����
    OPEN emp_cursor;
    -- OPEN emp_cursor; �����޼��� already open
    LOOP -- �ݺ����� ���� open close ���̿��� ����� ���� �ʰ�
        -- 3. Ŀ������ ������ ����
        -- Ŀ�� ��ġ : ù��° �����͸� ����Ű�� ����
       FETCH emp_cursor INTO v_eid, v_ename, v_hdate ;
       EXIT WHEN emp_cursor%NOTFOUND; -- FETCH�� EXIT WHEN�� �׻� ���� �־�ߵ�
       -- ���ඳ���� ������ ������ �����Ͱ� �ι� ������ �ִ�.
       -- %NOTFOUND�� ���ο� �����Ͱ� �ִ��� ����
    
        -- 3.5 �����͸� ������� ����
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : '); -- FETCH�� �����ؼ� ������ ��� (�����Ҷ����� 1�Ǿ�)
        DBMS_OUTPUT.PUT_LINE(v_eid||', '||v_ename||', '||v_hdate);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT);
    
    -- ERROR 1 : Ŀ���� ����� ���¿��� �ٽ� ���� => cursor already open
    IF  NOT emp_cursor%ISOPEN THEN
        OPEN emp_cursor; 
    END IF;
    -- 4. Ŀ�� ����
    CLOSE emp_cursor;
    
    -- ERROR 2 : Ŀ���� ����� ���¿��� �Ӽ���� => invalid cursor
    -- CLOSE ���Ŀ� �Ӽ�����ϴ°��� �ִ��� Ȯ���غ���. ��Ÿ�� 'EM_CURSOR' must be declared
END;
/

-- ���ǻ��� : ����� Ŀ���� ����� ���� ��� ������ �߻����� ����.
-- Ư�� �μ��� ���� ����� �����ȣ�� �̸�, ������ ���
-- ����� Ŀ�� => SQL�� SELECT���� �䱸
SELECT employee_id, last_name, job_id
FROM employees
WHERE department_id = &�μ���ȣ;
--�μ���ȣ 0 => no data found
--�μ���ȣ 10 => ������ �Ѱ�
--�μ���ȣ 50 => ������ ������

DECLARE
    -- 1. Ŀ������
    CURSOR emp_of_dept_cursor IS
        SELECT employee_id, last_name, job_id
        FROM employees
        WHERE department_id = &�μ���ȣ;
    
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_job employees.job_id%TYPE;
BEGIN
    -- 2. Ŀ������
    OPEN emp_of_dept_cursor;
    
    LOOP
        -- 3. ������ ����
        FETCH emp_of_dept_cursor INTO v_eid, v_ename, v_job;
        EXIT WHEN emp_of_dept_cursor%NOTFOUND;
        
        -- 4. ������ ���� ���� �� ����
        DBMS_OUTPUT.PUT(emp_of_dept_cursor%ROWCOUNT || ' : ');
        -- ROWCOUNT�� LOOP�� ���� ������, ���� ��ȯ�� ������ ����
        DBMS_OUTPUT.PUT_LINE(v_eid || ', ' || v_ename || ', ' || v_job);
    END LOOP;
    -- LOOP�� �ٱ� ������, Ŀ���� �� ������ ����
    DBMS_OUTPUT.PUT_LINE(emp_of_dept_cursor%ROWCOUNT);
    IF emp_of_dept_cursor%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� �Ҽӻ���� �����ϴ�.');
    END IF;
    -- 5. Ŀ�� ����
    CLOSE emp_of_dept_cursor;
END;
/

/*
1.
���(employees) ���̺���
����� �����ȣ, ����̸�, �Ի翬���� => ������ select ��
���� ���ؿ� �°� ���� test01, test02�� �Է��Ͻÿ�.

�Ի�⵵�� 2005��(����) ���� �Ի��� ����� test01 ���̺� �Է�
�Ի�⵵�� 2005�� ���� �Ի��� ����� test02 ���̺� �Է�
SELECT employee_id, last_name, TO_CHAR(hire_date,'yyyy')
FROM employees;
*/
-- SELECT�� : ��� ���̺��� �����ȣ, ����̸�, �Ի�⵵ ��ȸ
SELECT employee_id, last_name, hire_date
FROM employees;
--���ǹ�
IF �Ի�⵵�� 2025��(����) ���� THEN
    test01 ���̺� �Է�
ELSE
    test02 ���̺� �Է�
END IF;

-- PL/SQL ���
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees;
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_eid, v_ename, v_hdate;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- Ŀ������ ��ȯ�Ǵ� �����Ͱ� �ִ� ���
        -- IF v_hdate <= TO_DATE('20251231','yyyyMMDD') THEN
        IF TO_CHAR(v_hdate,'yyyy') <= '2025' THEN
            INSERT INTO test01 
            VALUES (v_eid, v_ename, v_hdate);
        ELSE
            INSERT INTO test02
            VALUES (v_eid, v_ename, v_hdate);
        END IF;
    END LOOP;
    CLOSE emp_cursor;
END;
/

DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees;
    TYPE emp_record_type IS RECORD
        (eid employees.employee_id%TYPE,
         ename employees.last_name%TYPE,
         hdate employees.hire_date%TYPE);
    v_emp_info emp_record_type;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- Ŀ������ ��ȯ�Ǵ� �����Ͱ� �ִ� ���
        -- IF v_hdate <= TO_DATE('20251231','yyyyMMDD') THEN
        IF TO_CHAR(v_emp_info.hdate,'yyyy') <= '2025' THEN
            INSERT INTO test01 (empid,ename,hiredate)
            VALUES (v_emp_info.eid, v_emp_info.ename, v_emp_info.hdate);
        ELSE
            INSERT INTO test02
            VALUES v_emp_info;
        END IF;
    END LOOP;
    CLOSE emp_cursor;
END;
/

-- Update, insert ó�� ������� �ϴ°Ŵ� ���ڵ�� �ϴ°͵� �����ϴ�.


SELECT sysdate, TO_CHAR(sysdate, 'yyyy"��"MM"��"dd"��"')
FROM dual;
SELECT sysdate, TO_CHAR(sysdate, 'HH24:mm:ss')
FROM dual;
SELECT sysdate, TO_CHAR(sysdate, 'yyyy"��"') year
FROM dual;


DECLARE
    CURSOR emp_cursor IS -- Ŀ�� ����
        SELECT employee_id, last_name, hire_date -- �����ð� �Է�
        FROM employees;
    v_eid employees.employee_id%TYPE; --������ �� ���� ���� �Է�
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    -- Ŀ�� ����
    OPEN emp_cursor;
    LOOP
        -- ������ ��������
        FETCH emp_cursor INTO v_eid,v_ename,v_hdate;
        EXIT WHEN emp_cursor%NOTFOUND;
        -- ����
        IF v_hdate <= to_date('2025-01-01','yyyy-MM-dd') THEN 
        -- ��¥�� �ٵ� 12��31�ϱ��� �����̶� �̷��� �ϸ� �ȵ� 2025-12-31 �̷��� ��ߵ�
            INSERT INTO test01 
            VALUES(v_eid, v_ename, v_hdate );
        ELSE
            INSERT INTO test02 
            VALUES(v_eid, v_ename, v_hdate );
        END IF;
    END LOOP;
    -- Ŀ�� ����
    CLOSE emp_cursor;
END;
/



/*
2.
�μ���ȣ�� �Է��� ���(&ġȯ���� ���)
�ش��ϴ� �μ��� ����̸�, �Ի�����, �μ����� ����Ͻÿ�.
*/

--SELECT�� : �μ���ȣ -> employees(����̸�,�Ի�����), departments(�μ���)/JOIN
SELECT e.last_name,e.hire_date, d.department_name
FROM employees e join departments d
                  on e.department_id = d.department_id
WHERE e.department_id = &�μ���ȣ;

-- PL/SQL ���
DECLARE
    CURSOR emp_in_dept_cursor IS
        SELECT e.last_name, e.hire_date, d.department_name
        FROM employees e join departments d
                  on e.department_id = d.department_id
        WHERE e.department_id = &�μ���ȣ;
    v_ename employees.last_name%TYPE; --������ �� ���� ���� �Է�
    v_hdate employees.hire_date%TYPE;
    v_dept_name departments.department_name%TYPE;
BEGIN
    OPEN emp_in_dept_cursor;
    
    LOOP
        FETCH emp_in_dept_cursor INTO v_ename,v_hdate, v_dept_name;
        EXIT WHEN emp_in_dept_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(v_ename||', '||v_hdate||', '||v_dept_name);
    END LOOP;
    
    CLOSE emp_in_dept_cursor;
END;
/

DECLARE
    CURSOR emp_cursor IS
        SELECT e.last_name, e.hire_date, d.department_name
        FROM employees e join departments d
                         on e.department_id = d.department_id
        WHERE d.department_id=&�μ���ȣ;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
    v_dname departments.department_name%TYPE;
BEGIN
    OPEN emp_cursor;
    LOOP
        -- �ϳ��� ���� �־��ִ� �۾�
        FETCH emp_cursor INTO v_ename, v_hdate, v_dname;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        --�����
        DBMS_OUTPUT.PUT_LINE(v_ename|| ', ' || v_hdate || ', ' ||v_dname);
    END LOOP;
    CLOSE emp_cursor;
END;
/


/*
3.
�μ���ȣ�� �Է�(&���)�� ��� 
����̸�, �޿�, ����->(�޿�*12+(�޿�*nvl(Ŀ�̼��ۼ�Ʈ,0)*12))
�� ����ϴ�  PL/SQL�� �ۼ��Ͻÿ�.
*/
-- 3-1 ������ ���� ���
SELECT last_name, salary, commission_pct
FROM employees
WHERE department_id = &�μ���ȣ;

DECLARE
    CURSOR emp_in_dept_cursor IS
        SELECT last_name, salary, commission_pct
        FROM employees
        WHERE department_id = &�μ���ȣ;
    v_emp_rec emp_in_dept_cursor%ROWTYPE; -- CURSOR�� %ROWTYPE ��밡��
    v_year NUMBER(10,2);
BEGIN
    OPEN emp_in_dept_cursor;
    LOOP
        FETCH emp_in_dept_cursor INTO v_emp_rec;
        EXIT WHEN emp_in_dept_cursor%NOTFOUND;
        
        v_year := (v_emp_rec.salary*12+(v_emp_rec.salary*nvl(v_emp_rec.commission_pct,0)*12));
        DBMS_OUTPUT.PUT_LINE(v_emp_rec.last_name|| ', ' || v_emp_rec.salary || ', ' ||v_year);
        
    END LOOP;
    
    CLOSE emp_in_dept_cursor;
END;
/


-- 3-2
SELECT last_name, salary, (salary*12+(salary*nvl(commission_pct,0)*12))
FROM employees
WHERE department_id = &�μ���ȣ;

DECLARE
    CURSOR emp_in_dept_cursor IS
        SELECT last_name, salary, (salary*12+(salary*nvl(commission_pct,0)*12)) as year
        FROM employees
        WHERE department_id = &�μ���ȣ;
    v_emp_rec emp_in_dept_cursor%ROWTYPE; -- CURSOR�� %ROWTYPE ��밡��
    v_year NUMBER(10,2);
BEGIN
    OPEN emp_in_dept_cursor;
    LOOP
        FETCH emp_in_dept_cursor INTO v_emp_rec;
        EXIT WHEN emp_in_dept_cursor%NOTFOUND;
        
        v_year := (v_emp_rec.salary*12+(v_emp_rec.salary*nvl(v_emp_rec.commission_pct,0)*12));
        DBMS_OUTPUT.PUT_LINE(v_emp_rec.last_name|| ', ' || v_emp_rec.salary || ', ' ||v_year);
        
    END LOOP;
    
    CLOSE emp_in_dept_cursor;
END;
/



DECLARE
    CURSOR emp_cursor IS
        SELECT last_name, salary, commission_pct
        FROM employees
        WHERE department_id = &�μ���ȣ;
    v_ename employees.last_name%TYPE;
    v_esal employees.salary%TYPE;
    v_com employees.commission_pct%TYPE;
    v_ansal NUMBER;
BEGIN
    OPEN emp_cursor;
    LOOP
        -- �ϳ��� ���� �־��ִ� �۾�
        FETCH emp_cursor INTO v_ename, v_esal, v_com;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- �����
        v_ansal := 12*v_esal +v_esal*nvl(v_com,0)*12;
        DBMS_OUTPUT.PUT_LINE('����̸� : '||v_ename || ', �޿� : ' || v_esal || ', ���� : ' || v_ansal);
    END LOOP;
    CLOSE emp_cursor;
END;
/