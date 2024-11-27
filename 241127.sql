SET SERVEROUTPUT ON;

/*
커서 FOR LOOP : 단축키, 특정한 경우에는 사용 불가 (수동처리)
CURSOR가 데이터가 없으면 아예 실행을 안함

FOR 레코드이름(임시 변수 -> 레코드타입(한 행 통째로), FETCH 커서이름 INTO 레코드이름) IN 커서이름( LOOP문이 수행할 조건(범위) , OPEN 커서이름; ) LOOP
    statement1;
    statement2;
    ...
END LOOP; (CLOSE 커서이름;)
*/

-- 커서 FOR LOOP :명시적 커서를 사용하는 단축방법
-- 1) 문법
DECLARE
    CURSOR 커서명 IS
        SELECT문;
BEGIN
    FOR 임시변수(레코드타입) IN 커서명 LOOP -- 암시적으로 OPEN과 FETCH
        -- 커서에 데이터가 존재하는 경우 수행하는 코드
    END LOOP; -- 암시적으로 CLOSE
END;
/

-- 2) 적용
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, salary
        FROM employees;
BEGIN
    FOR emp_rec IN emp_cursor LOOP -- OPEN FETCH, 근데 데이터가 없으면 안됨
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : ');
        DBMS_OUTPUT.PUT(emp_rec.employee_id);
        DBMS_OUTPUT.PUT(', '||emp_rec.last_name);
        DBMS_OUTPUT.PUT_LINE(', '||emp_rec.salary);
    END LOOP; -- CLOSE
END;
/

/*
부서번호를 입력받아 해당 부서에 소속된 사원정보(사원번호, 이름, 급여)를 출력하세요.
부서번호 0: 커서의 데이터가 없음, 50: 커서 데이터 5건
*/

DECLARE
    CURSOR emp_dept_cursor IS
        SELECT employee_id, last_name, salary
        FROM employees
        WHERE department_id = &부서번호;
BEGIN
    FOR emp_rec IN emp_dept_cursor LOOP -- 데이터가 없어서 FOR문이 아예 실행이 안됨
        DBMS_OUTPUT.PUT(emp_dept_cursor%ROWCOUNT || ' : ');
        DBMS_OUTPUT.PUT(emp_rec.employee_id);
        DBMS_OUTPUT.PUT(', '||emp_rec.last_name);
        DBMS_OUTPUT.PUT_LINE(', '||emp_rec.salary);
    END LOOP; -- 암시적으로 CLOSE 커서;
    DBMS_OUTPUT.PUT('총 데이터 갯수 : '||emp_dept_cursor%ROWCOUNT);
END;
/

-- 커서 FOR LOOP 문의 경우 명시적 커서의 데이터를 보장할 수 있을 때만 사용(SELECT 데이터 없으면 노실행)

/*
1.
사원(employees) 테이블에서
사원의 사원번호, 사원이름, 입사연도를 
다음 기준에 맞게 각각 test01, test02에 입력하시오.

입사년도가 2025년(포함) 이전 입사한 사원은 test01 테이블에 입력
입사년도가 2025년 이후 입사한 사원은 test02 테이블에 입력
*/

DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id eid, last_name ename, hire_date hdate
        FROM employees;
BEGIN
    FOR emp_rec IN emp_cursor LOOP -- OPEN, FETCH, CLOSE 쓰면 오류난다
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
부서번호를 입력할 경우(&치환변수 사용)
해당하는 부서의 사원이름, 입사일자, 부서명을 출력하시오.
*/

DECLARE
    CURSOR emp_in_dept_cursor IS
        SELECT last_name ename, hire_date hdate, department_name dname
        FROM employees e join departments d
                         on e.department_id = d.department_id
        WHERE e.department_id = &부서번호;
BEGIN
    FOR info IN emp_in_dept_cursor LOOP
        DBMS_OUTPUT.PUT(emp_in_dept_cursor%ROWCOUNT ||' : ');
        DBMS_OUTPUT.PUT(', '||info.ename);
        DBMS_OUTPUT.PUT(', '||info.hdate);
        DBMS_OUTPUT.PUT_LINE(', '||info.dname);
    END LOOP;
END;
/

-- 데이터 확인 작업
-- 커서 FOR LOOP문은 서브쿼리를 이용해서 동작 가능(단, 속성은 사용불가)
BEGIN -- 
   FOR emp_rec IN (SELECT last_name, hire_date,department_name
                   FROM employees e join departments d
                                  on e.department_id = d.department_id
                   WHERE e.department_id = &부서번호) LOOP
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
        WHERE e.department_id = &부서번호;
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
부서번호를 입력(&사용)할 경우 
사원이름, 급여, 연봉->(급여*12+(급여*nvl(커미션퍼센트,0)*12))
을 출력하는  PL/SQL을 작성하시오.
*/

-- 3-1 : 연봉을 따로 계산
DECLARE 
    CURSOR emp_in_dept_cursor IS
        SELECT last_name, salary, commission_pct
        FROM employees
        WHERE department_id = &부서번호;
    
    v_year NUMBER(10,2); --연봉
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


-- 3-2 : SELECT문에 연봉계산
DECLARE 
    CURSOR emp_in_dept_cursor IS
        SELECT last_name ename, salary sal, salary*12+salary*nvl(commission_pct,0)*12 year
        FROM employees
        WHERE department_id = &부서번호;
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
        WHERE department_id = &부서번호;
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
예외
EXCEPTION
    WHEN 예외이름1 [OR 예외이름2...] THEN
        실제작업1;
        실제작업2;
    WHEN NO_DATA_FOUND THEN
        실제작업3;
    WHEN OTHERS THEN
        실제작업4;
https://www.oracle.com/kr/ -리소스 -설명서 (documentation) - oracle database
-Oracle Database 11g Release 2 (11.2)
-Database Administration -> Supporting Documentation -> Error Messages
ORA(컴파일에러)만 처리가능, PLS는 실행에러라서 오라클에서 해결 불가능

ORA-00000: normal, successful completion - 내용
Cause: Normal exit. -원인
Action: None -해결방법

PL/SQL Language Reference -> 11 PL/SQL Error Handling->Predefined Exceptions
    => 여기서 자주 생기는 예외는 특별히 이름 부여해줬음/ PL/SQL에서만 사용가능
        -> 여기에 있는 이름으로 예외처리 가능
자주 사용하지 않는 예외는 이름을 부여해야됨

DECLARE
    e_emps_remaining(예외이름) EXCEPTION;
    PRAGMA(명령어) EXCETION INIT(예외상황초기화) ( e_emps_remaining(예외이름), -2292(실제에러코드) );
BEGIN
 SELECT 어쩌고
EXCEPTION
    WHEN e_emps_remaining THEN
       처리내용;
END;
/

DECLARE
    e_invalid_department EXCEPTION
BEGIN
    IF SQL%NOTFOUND THEN
        RAISE(강제로 예외발생) e_invalid_department;
    END IF;
EXCEPTION
    WHEN e_invalid_department THEN
        예외처리;

-Application Development

1. 미리 정의된 이름  20개정도 -> EXCEPTION 처리만 하면됨 EXCEPTION WHEN NO_DATA_FOUND THEN 오류입니다;
2. 오라클 예외는 맞지만 이름 없음 -> DECLARE에서 PRAGMA로 예외코드연결, EXCEPTION 처리
3. 오라클 문법상 맞지만, 개발자가 의도하지 않은상황 -> DECLARE, BEGIN 절에서 RAISE로 강제로 예외발생, EXCEPTION 처리
*/

-- 예외처리 : 예외가 발생했을 때 정상적으로 작업이 종료될수 있도록 처리
-- 1) 문법
DECLARE
    
BEGIN
    
EXCEPTION
    WHEN THEN -- 필요한 만큼 추가 가능
        -- 예외발생시 처리하는 코드
    WHEN OTHERS THEN -- 위에 정의된 예외말고 발생하는 경우 일괄처리
        -- 예외발생시 처리하는 코드
END;
/

-- 2) 적용
-- 2-1) 이미 오라클에 정의되어 있고(에러코드가 있음) 이름도 존재하는 예외사항
DECLARE
    v_ename employees.last_name%TYPE;
BEGIN
    SELECT last_name
    INTO v_ename
    FROM employees
    WHERE department_id=&부서번호;
    -- 부서번호 0 : ORA-01403, NO_DATA_FOUND 
    -- 부서번호 10 : 정상실행
    -- 부서번호 50 : ORA-06512, TOO_MANY_ROWS
    -- 예외를 처리하더라도 실행되지는 않음, 오류만 사라짐
    DBMS_OUTPUT.PUT_LINE(v_ename);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에 속한 사원이 없습니다.');
        DBMS_OUTPUT.PUT_LINE('블록이 종료되었습니다.');
    WHEN OTHERS THEN -- 
        DBMS_OUTPUT.PUT_LINE('기타 예외사항이 발생했습니다.');
        DBMS_OUTPUT.PUT_LINE('블록이 종료되었습니다.');
END;
/

-- 2-2) 이미 오라클에 정의되어 있고(에러코드가 있음) 이름은 존재하지 않는 예외사항
DECLARE
    e_emps_remaining EXCEPTION; -- 에러이름 변수 선언
    PRAGMA EXCEPTION_INIT(e_emps_remaining, -02292); -- PREGMA : 이름과 에러코드 연결
BEGIN
    DELETE FROM departments
    WHERE department_id = &부서번호;
    -- 부서번호 10 : ORA-02292: integrity constraint (HR.EMP_DEPT_FK) violated - child record found
EXCEPTION
    WHEN e_emps_remaining THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서는 다른 테이블에서 사용중입니다.');
END;
/
-- 2-3) 사용자 정의 예외 => 오라클 입장에선 정상코드로 인지
-- 예외발생하면 바로 실행종료, 조건문으로 처리하면 코드가 끝까지 실행
DECLARE
    e_dept_del_fail EXCEPTION; -- 에러 이름 정의
BEGIN
  DELETE FROM departments
  WHERE department_id = &부서번호;
  -- 부서번호 0 : 정상적으로 수행되지만 기능상 실패로 인지해야 하는 경우
  IF SQL%ROWCOUNT = 0 THEN -- 가장 최근 실행된 SQL문의 결과가 몇행인지 확인
      RAISE e_dept_del_fail; -- 강제로 에러 발생
  END IF;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
EXCEPTION
    WHEN e_dept_del_fail THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서는 존재하지 않습니다.');
        DBMS_OUTPUT.PUT_LINE('부서번호를 확인해주세요.');
END;
/


BEGIN
    DELETE FROM departments
    WHERE department_id = &부서번호;
    -- 부서번호 0 : 정상적으로 수행되지만 기능상 실패로 인지해야 하는 경우
    IF SQL%ROWCOUNT = 0 THEN -- 가장 최근 실행된 SQL문의 결과가 몇행인지 확인
        DBMS_OUTPUT.PUT_LINE('해당 부서는 존재하지 않습니다.');
        DBMS_OUTPUT.PUT_LINE('부서번호를 확인해주세요.');
    END IF;
END;
/

/*
예외 트랩 함수 : 지금 발생한 에러가 뭔지 확인하고 싶을때
INSERT 문에서는 사용불가
SQLCODE : 에러코드(숫자값)
SQLERRM : 에러메세지
*/

-- 2-1-1) 이미 오라클에 정의되어 있고(에러코드가 있음) 이름도 존재하는 예외사항
DECLARE
    v_ename employees.last_name%TYPE;
BEGIN
    SELECT last_name
    INTO v_ename
    FROM employees
    WHERE department_id=&부서번호;
    -- 부서번호 0 : ORA-01403, NO_DATA_FOUND 
    -- 부서번호 10 : 정상실행
    -- 부서번호 50 : ORA-06512, TOO_MANY_ROWS
    -- 예외를 처리하더라도 실행되지는 않음, 오류만 사라짐
    DBMS_OUTPUT.PUT_LINE(v_ename);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에 속한 사원이 없습니다.');
    WHEN OTHERS THEN -- 
        DBMS_OUTPUT.PUT_LINE('기타 예외사항이 발생했습니다.');
        DBMS_OUTPUT.PUT('ORA' || SQLCODE || ' : ');
        DBMS_OUTPUT.PUT_LINE(SUBSTR(SQLERRM,12));
        DBMS_OUTPUT.PUT_LINE('블록이 종료되었습니다.');
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

emp_test 테이블에서 사원번호를 사용(&치환변수 사용)하여 사원을 삭제하는 PL/SQL을 작성하시오.
(단, 사용자 정의 예외사항 사용)
(단, 사원이 없으면 "해당사원이 없습니다.'라는 오류메시지 발생)
*/
DECLARE
    e_emp_not_found EXCEPTION;
BEGIN
    DELETE FROM emp_test
    WHERE employee_id = &사원번호;
    
    IF SQL%ROWCOUNT = 0 THEN -- 가장 최근에 실행된 SQL문의 결과로 발생한 행 숫자
        RAISE e_emp_not_found;
    END IF;
EXCEPTION
    WHEN e_emp_not_found THEN
        DBMS_OUTPUT.PUT_LINE('해당사원이 없습니다.');
END;
/

DECLARE
    emp_test_del_fail EXCEPTION; -- 예외 정의
BEGIN
    DELETE FROM emp_test
    -- 만약 홑따옴표 없이 넣으면 그냥 변수로 인식한다.
    -- 만약에 치환변수에 문자를 넣고 싶으면 치환변수까지 홑따옴표로 묶거나, 입력할때 홑따옴표 입력;
    WHERE employee_id = '&사원번호';
    
    IF SQL%ROWCOUNT = 0 THEN -- 삭제된 행이 없으면 에러 발생
        RAISE emp_test_del_fail;
    END IF;
EXCEPTION -- 100%로 처리는 불가능
    WHEN emp_test_del_fail THEN -- 에러 메세지 출력
       DBMS_OUTPUT.PUT_LINE('해당사원이 없습니다.');
END;
/

/*
내장 프로시저
CREATE [OR REPLACE] PROCEDURE 이름
    (매개변수1 [MODE] 데이터타입1, -- MODE : IN, OUT, IN OUT
     매개변수2 [MODE] 데이터타입2)
IS|AS
PL/SQL Block; (BEGIN EXCEPTION END; /)

-- 레코드 타입, 테이블 타입은 다른데서 몰라서 잘 안씀

IN : 1.기본값(표기없으면), 2/.값을 서브프로그램에 전달(프로시저, 함수)
OUT : 1.지정 값을 호출환경으로 반환
IN OUT : 1.값을 서브프로그램에 전달하고 2.호출환경으로 반환
IN 형식 매개변수가 상수로 작용 -> 값을 변경할 수 없다.
OUT : 초기화되지 않은 변수


OUT / IN OUT반드시 값을 가져야 하므로 변수에다가 저장함
*/

-- PROCEDURE
-- 1)문법
CREATE PROCUDRUE 프로시저명
    (매개변수명 [모드] 데이터타입, ...)
IS
    -- 선언부 : 로컬변수, 커서, 예와서헝 등을 선언
BEGIN
    -- PROCEDURE가 수행할 코두
EXCEPTION
    --에러처리
END;
/

-- 2) 적용
DROP PROCEDURE test_pro; -- 같은이름으로 생성 불가
CREATE PROCEDURE test_pro
   (p_msg VARCHAR2) -- 암시적으로 IN으로 선언, VARCHAR2(100)은 안됨
IS
    v_msg VARCHAR2(1000) := 'Hello';
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_msg||p_msg);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('데이터가 존재하지 않습니다.');
END;
/

-- 3) 실행

DECLARE
    v_result VARCHAR2(1000);
BEGIN
    -- 오라클이 현재 실행하는 객체가 PROCEDURE인지 FUNCTION인지 구분하는 방법
    --     => 호출형태 (왼쪽에 변수가 존재하는 가)
    -- v_result := test_pro('PL/SQL'); 
    -- 프로시저를 변수에 담아버리면 함수로 인식해서 못찾음
    test_pro('PL/SQL');
END;
/
-- 프로시저 하나만 호출할때 사용가능, 옆에다가 주석달면 실행안됨
--PLS-00103: Encountered the symbol "end-of-file" when expecting one of the following:
EXECUTE test_pro('WORLD');


-- IN 모드 : 호출환경 -> 프로시저로 값을 전달, 프로시저 내부에서 상수취급
-- PLS-00363: expression 'P_EID' cannot be used as an assignment target
-- => 재할당 타겟으로 사용할수 없다 : 상수취급
DROP PROCEDURE raise_salary;
CREATE PROCEDURE raise_salary
    (p_eid IN employees.employee_id%TYPE)
IS

BEGIN
   -- ERROR : 프로시저 내부에서 상수 취급되므로 값을 변경할 수 없음
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
    v_first NUMBER(3,0) := 100; -- 초기화된 변수
    v_second CONSTANT NUMBER(3,0) := 149; -- 상수
BEGIN
    raise_salary(100);          -- 리터럴
    raise_salary(v_first+30);   -- 표현식
    raise_salary(v_first);      -- 초기화된 변수
    raise_salary(v_second);     -- 상수
END;
/

ROLLBACK;

-- OUT 모드 : 프로시저 -> 호출환경으로 값을 반환, 프로시저 내부에서 초기화되지 않은 변수로 인지
CREATE PROCEDURE test_p_out
    (p_num IN NUMBER,
     p_out OUT NUMBER)
IS
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('IN : ' || p_num);
    DBMS_OUTPUT.PUT_LINE('OUT : ' || p_out);
END; -- 블록이 종료되는 순간 OUT 모드의 매개변수가 가지고 있는 값이 그대로 반환 
/
-- 실행코드 
DECLARE
    v_result NUMBER(4,0) := 1234;
BEGIN
    DBMS_OUTPUT.PUT_LINE('1) result : ' || v_result);
    test_p_out(1000,v_result);
    DBMS_OUTPUT.PUT_LINE('2) result : ' || v_result);
END;
/

-- 더하기
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

-- IN OUT 모드 : IN 모드와 OUT 모드 두가지를 하나의 변수로 처리
-- => 원래 데이터가 사라짐 (원래 데이터가 변경되어야 하는 경우에만 사용)
-- IN은 상수, OUT은 초기화되지 않은 변수
-- '01012341234' => '010-1234-1234'
-- 날짜를 지정한 포맷으로 변경 : '24/11/27' => '24년11월27일'
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
주민등록번호를 입력하면 
다음과 같이 출력되도록 yedam_ju 프로시저를 작성하시오.

EXECUTE yedam_ju('9501011667777')
EXECUTE yedam_ju('1511013689977')

=> 매개변수가 리터럴 => IN 매개변수 하나뿐 + 정해진 출력구문 => DBMS_OUTPUT.PUT_LINE을 내부에서 실행

*/
DROP PROCEDURE yedam_ju;
CREATE PROCEDURE yedam_ju -- 주민번호 2000년생은 00으로 시작해서 0이 빠져버림 -> 문자로 처리해야됨
    (p_ssn IN VARCHAR2)
IS
    v_result VARCHAR2(30);
BEGIN
    v_result := SUBSTR(p_ssn,1,6) -- 앞 6자리
                -- || '-' || SUBSTR(p_ssn,7); -- 뒤 7자리
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
               '-'|| RPAD(SUBSTR (p_jumin, 7,1), 13-6, '*');
    DBMS_OUTPUT.PUT_LINE(v_jumin);
END;
/

EXECUTE yedam_ju('9501011667777');

/*
2.
사원번호를 입력할 경우
삭제하는 TEST_PRO 프로시저를 생성하시오.
단, 해당사원이 없는 경우 "해당사원이 없습니다." 출력
예) EXECUTE TEST_PRO(176)
*/
DROP PROCEDURE test_pro;
CREATE PROCEDURE test_pro
    (p_empid IN NUMBER)
IS
    
BEGIN
    DELETE FROM employees
    WHERE employee_id = p_empid;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당사원이 없습니다.');
    END IF;
END;
/
 EXECUTE TEST_PRO(176);

/*
3.
다음과 같이 PL/SQL 블록을 실행할 경우 
사원번호를 입력할 경우 사원의 이름(last_name)의 첫번째 글자를 제외하고는
'*'가 출력되도록 yedam_emp 프로시저를 생성하시오.

실행) EXECUTE yedam_emp(176)
실행결과) TAYLOR -> T*****  <- 이름 크기만큼 별표(*) 출력
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
부서번호를 입력할 경우 
해당부서에 근무하는 사원의 사원번호, 사원이름(last_name), 연차를 출력하는 get_emp 프로시저를 생성하시오. 
(cursor 사용해야 함)
단, 사원이 없을 경우 "해당 부서에는 사원이 없습니다."라고 출력(exception 사용)
실행) EXECUTE get_emp(30)
*/

DROP PROCEDURE get_emp;
CREATE OR REPLACE PROCEDURE get_emp
    (p_departid IN NUMBER)
IS
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, TRUNC(MONTHS_BETWEEN (sysdate,hire_date)/12) year
        FROM employees
        WHERE department_id = p_departid;
BEGIN
    FOR emp_rec IN emp_cursor LOOP
        DBMS_OUTPUT.PUT(emp_rec.employee_id);
        DBMS_OUTPUT.PUT(', '||emp_rec.last_name);
        DBMS_OUTPUT.PUT_LINE(', '||emp_rec.year);
    END LOOP;
END;
/


/*
5.
직원들의 사번, 급여 증가치만 입력하면 Employees테이블에 쉽게 사원의 급여를 갱신할 수 있는 y_update 프로시저를 작성하세요. 
만약 입력한 사원이 없는 경우에는 ‘No search employee!!’라는 메시지를 출력하세요.(예외처리)
실행) EXECUTE y_update(200, 10)
*/

DROP PROCEDURE y_update;
CREATE PROCEDURE y_update
    (p_empid IN NUMBER,
     p_inc_sal IN NUMBER)
IS
    v_sal_fail EXCEPTION;
BEGIN
    UPDATE employees
    SET salary = salary + p_inc_sal
    WHERE employee_id = p_empid;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE v_sal_fail;
    END IF;
EXCEPTION
    WHEN v_sal_fail THEN
        DBMS_OUTPUT.PUT_LINE ('No search employee!!');
END;
/
EXECUTE y_update(999, 10);
