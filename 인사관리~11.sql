/*
레코드 : Javascript의 객체와 유사, 필드(필드명)으로 호출
1) 정의 : TYPE 레코드이름 IS RECORD ( 이름 데이터타입 [제약조건(NOT NULL) 초기화(:= | DEFAULT)])
2) 선언 : 

변수 선언   : 변수명 [CONSTANT]  데이터 타입 [NOT NULL] [:= | DEFAULT expr]
레코드 선언 : 필드명 [상수선언안됨] 데이터 타입 [NOT NULL] [:= | DEFAULT expr]
*/

-- 조합 데이터 유형 : 열 값을 가질 수 있는 데이터 타입
-- RECORD : 내부에 필드를 가지는 데이터 구조, SELECT문처럼 데이터를 조회하는 경우 많이 쓰임.
-- 1) 문법
DECLARE
     -- 1. 레코드 타입 정의
     TYPE 레코드타입명 IS RECORD
          (필드명 데이터타입,
           필드명 데이터타입 :='초기값',
           필드명 데이터타입 NOT NULL :='초기값');
     -- 2. 변수 선언
     변수명 레코드타입명(위에 정의된 이름);
BEGIN
     -- 3. 사용
     변수명.필드명 := 변경값;
     DBMS_OUTPUT.PUT_LINE(변수명.필드명); 
     -- 내부에 있는 필드만 출력가능, 레코드 타입 통째로 출력은 안됨
     -- 필드 타입은 제한 없음, 심지어 레코드, 테이블(안배움) 도 가능
END;
/

-- 2. 적용
DECLARE
     -- 1.타입정의 => INTO  절에서 사용되는 경우 SELECET문의 컬럼과 동일한 형태로 구성
     TYPE emp_record_type IS RECORD
          ( empno NUMBER(6,0),
            ename employees.last_name%TYPE NOT NULL := 'Hong',
            sal employees.salary%TYPE := 0);
            
     -- 2. 변수선언
     v_emp_info emp_record_type;
     v_emp_rec emp_record_type;
BEGIN
     DBMS_OUTPUT.PUT(v_emp_info.empno);
     DBMS_OUTPUT.PUT(', ' || v_emp_info.ename);
     DBMS_OUTPUT.PUT_LINE(', ' || v_emp_info.sal);
     
     v_emp_rec.empno := &사원번호;
     
     SELECT employee_id, last_name, salary -- 조회 되는 결과물 칼럼 3개, 레코드도 필드 3개 (무조건 순서 맞춰야됨)
     -- 무조건 SELECT 순서를 레코드랑 맞춰야됨, 순서를 필드 이름-데이터 타입 맞춰서 작성해놓았기 때문에
     INTO v_emp_info -- INTO 절에 사용하는 레코드 타입은 반드시 하나, 추가하면 안됨
     FROM employees
     WHERE employee_id = v_emp_rec.empno;
     
     DBMS_OUTPUT.PUT(v_emp_info.empno);
     DBMS_OUTPUT.PUT(', ' || v_emp_info.ename);
     DBMS_OUTPUT.PUT_LINE(', ' || v_emp_info.sal);
END;
/

-- %ROWTYPE : 테이블 혹은 뷰의 한 행을 RECORD TYPE으로 반환 => 타입 정의 없이 변수 선언으로 바로 사용
DECLARE
     v_emp_rec employees%ROWTYPE; -- 해당 테이블의 전체를 조회할 경우에만
BEGIN
     SELECT * -- 반드시 아스타 (*)로 조회
     INTO v_emp_rec
     FROM employees
     WHERE employee_id = &사원번호;
     
     DBMS_OUTPUT.PUT_LINE(v_emp_rec.employee_id); -- 필드명을 정하지 않았기 때문에 컬럼명 그대로 출력
     
END;
/

-- SELECT문(데이터베이스)을 통째로 하나의 변수(메모리)에 넣어두면 리소스 낭비가 훨씬 줄어든다.
-- => 레코드타입으로 구성된 테이블타입 사용
-- 테이블 : 배열과 유사, 인덱스 사용 (음수, 0, 양수) - BINARY_INTEGER보다 PLS_INTEGER가 좀 더 빠르다.

-- RECORD 타입에는 레코드가 올수 있지만, 테이블(배열)타입에는 테이블(배열) 추가로 못씀
-- TYPE 테이블이름 IS TABLE OF 컬럼타입 [NOT NULL] INDEX BY PLS_INTEGER;

-- TABLE :  동일한 데이터 타입의 값을 여러개 가짐, 주로, 레코드타입과 함계 테이블의 모든 데이터를 변수에 담을 때 사용
-- 1) 문법
DECLARE
     -- 1. 타입 정의
     TYPE 테이블타입명 IS TABLE OF 데이터 타입
          INDEX BY BYNARY_INTEGER;
          
     -- 2. 변수 선언
     변수명 테이블타입명;
BEGIN
     -- 3. 사용
     변수명(인덱스) := '초기값'; -- 인덱스 초기화 필요, 괄호 형태로 인덱스 호출 (대괄호 아님)
     DBMS_OUTPUT.PUT_LINE(변수명(인덱스)); -- 컴포짓(레코드,테이블)타입은 반드시 내부 필드,인덱스에 접근해야됨
END;
/

-- 2) 적용
DECLARE
     -- 1) 정의
     TYPE num_table_type IS TABLE OF NUMBER
          INDEX BY PLS_INTEGER;
     -- 2) 변수선언
     v_num_info num_table_type;
BEGIN
     v_num_info(-123456789) := 1000;
     v_num_info(1111111111) := 1234;
     DBMS_OUTPUT.PUT_LINE(v_num_info(-123456789));
     DBMS_OUTPUT.PUT_LINE(v_num_info(1111111111)); -- 인덱스 없으면 no data found
     -- 이거는 인덱스가 순서도 없고 연결되지도 않아서 메소드로 접근해야됨
END;
/
/*
EXISTS(n), COUNT, FIRST, LAST. PRIOR(n)- 10번이면 9번...중에 제일 가까운거
NEXT(n) - 10번이면 11번...중에 제일 가까운거
DELETE 모든요소 제거 DELETE(n) n번째 인덱스 값 삭제/ DELETE(n,m) n부터m까지 삭제
*/

-- 테이블 타입의 메서드 활용
DECLARE
    -- 1) 테이블 타입 정의
    TYPE num_table_type IS TABLE OF NUMBER
         INDEX BY BINARY_INTEGER;
    
    -- 2) 변수 선언
    v_num_info num_table_type;
    v_idx NUMBER; -- NUMBER는 크기 설정 안해도 됨
BEGIN
    v_num_info(-23)  :=1;
    v_num_info(-5)   :=2;
    v_num_info(11)   :=3;
    v_num_info(1121) :=4;
    
    DBMS_OUTPUT.PUT_LINE('값의 개수 : ' || v_num_info.COUNT);
    
    -- FOR LOOP문 : 데이터 범위가 넓으면 전부다 반복
    FOR idx IN v_num_info.FIRST..v_num_info.LAST LOOP
        IF v_num_info.EXISTS(idx) THEN
            DBMS_OUTPUT.PUT_LINE(idx || ' : ' || v_num_info(idx));
        END IF;
    END LOOP;
    
    -- 기본 LOOP문 : 실제 값만 검색
    v_idx := v_num_info.FIRST;
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_idx || ' : ' || v_num_info(v_idx));
        
        EXIT WHEN v_num_info.LAST <= v_idx;
        v_idx := v_num_info.NEXT(v_idx); -- 첫번째 값에서 다음값, 다음값, 다음값으로 진행
    END LOOP;
END;
/

-- TABLE + RECORD
DECLARE
    -- 1) 타입 정의
    TYPE emp_table_type IS TABLE OF employees%ROWTYPE
        INDEX BY BINARY_INTEGER;
    -- 2) 변수를 선언
    v_emp_list emp_table_type;
    v_emp_rec employees%ROWTYPE;
BEGIN
    -- 테이블 조회
    FOR eid IN 100..104 LOOP
       SELECT *
       INTO v_emp_rec -- employees%ROWTYPE 이걸로 셀렉트 내용 전부 다 담았음.
       FROM employees
       WHERE employee_id = eid;
       
       v_emp_list(eid) := v_emp_rec;
    END LOOP;
    
    -- 테이블 타입의 데이터 조회
    FOR idx IN v_emp_list.FIRST..v_emp_list.LAST LOOP
        IF v_emp_list.EXISTS(idx) THEN -- EXISTS(n) 만약 n번 인덱스에 데이터가 존재하면 true반환
            --해당 인덱스에 데이터가 있는 경우
            DBMS_OUTPUT.PUT(v_emp_list(idx).employee_id);
            DBMS_OUTPUT.PUT(', ' || v_emp_list(idx).last_name);
            DBMS_OUTPUT.PUT_LINE(', ' || v_emp_list(idx).salary);
        END IF;
    END LOOP;
END;
/
-- Employees 테이블 전체 데이터 => 테이블 타입의 변수에 담기
DECLARE
    -- 1) 타입 정의
    TYPE emp_table_type IS TABLE OF employees%ROWTYPE
        INDEX BY BINARY_INTEGER;
    -- 2) 변수를 선언
    v_emp_list emp_table_type;
    v_emp_rec employees%ROWTYPE;
    
    v_min employees.employee_id%TYPE;
    v_max v_min%TYPE;
    
    v_count NUMBER;
BEGIN
    -- employee_id 최소값, 최대값
    SELECT MIN(employee_id), MAX(employee_id)
    INTO v_min, v_max
    FROM employees;
    
    
    -- 테이블 조회
    FOR eid IN v_min..v_max LOOP -- 이거는 중간에 값이 비어서 no data found 뜬다
       -- 해당 사원번호 기준 데이터가 없는 경우 다음 조건으로
       SELECT COUNT(*)
       INTO v_count
       FROM employees
       WHERE employee_id = eid;
       
       CONTINUE WHEN v_count= 0;
       
       SELECT *
       INTO v_emp_rec -- employees%ROWTYPE 이걸로 셀렉트 내용 전부 다 담았음.
       FROM employees
       WHERE employee_id = eid;
       
       v_emp_list(eid) := v_emp_rec;
    END LOOP;
    
    -- 테이블 타입의 데이터 조회
    FOR idx IN v_emp_list.FIRST..v_emp_list.LAST LOOP
        IF v_emp_list.EXISTS(idx) THEN -- EXISTS(n) 만약 n번 인덱스에 데이터가 존재하면 true반환
            --해당 인덱스에 데이터가 있는 경우
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

-- 명시적커서 : 활성집합 (셀렉트문 결과) 에서 제일 위에 데이터 바로 위에 커서(포인터가위치)
-- 커서(포인터)는 밑으로만 움직일수 있음 - 3가지 명령으로 제어 OPEN , FETCH, CLOSE
/*
DECLARE 
    CURSOR 커서이름 IS
    SELECT *
    FROM employees;

BEGIN
    OPEN 커서이름; : 활성집합 식별, 포인터를 첫번째 위치로 이동 (아래로만 이동가능)
    FETCH 커서이름 INTO 변수, 변수 : 현재행을 PL/SQL 출력변수로 읽고, 커서 다음으로 이동
    CLOSE 커서이름 : 활성집합은 깨뜨림, 커서를 사용중이면 SELECT 문 못씀, 무조건 닫아줘야됨
*/

/*
명시적 커서 : 다중행 SELECT문
1) DECLARE : 커서 정의
2) OPEN : 1.커서 실행 -> 2.활성집합 -> 3.포인터를 맨위로 이동
3) FETCH : 1.포인터를 밑으로 이동 -> 2. 현재 가리키는 행 가지고옴
4) CLOSE : 활성집합 소멸
*/


-- 명시적 커서 : 다중 행  SELECT문을 실행하기 위한 PL/SQL 문법
SELECT *
FROM employees;
-- 1) 문법
DECLARE
    -- 1. 커서 정의
    CURSOR 커서명 IS
        SELECT문 (SQL의 SELECT문, INTO절 사용불가)
    
BEGIN
    -- 2. 커서 실행
    -- 2-1) 커서를 실제 실행해서 활성집합(결과)를 식별(생성)
    -- 2-2) 포인터를 가장 위로 배치
    OPEN 커서명;
    
    -- 3. 데이터 인출
    -- 3-1) 포인터를 아래로 이동
    -- 3-2) 현재 가리키는 데이터를 인출
    FETCH 커서명 INTO 변수;
    
    -- 4. 커서 종료 : 활성집합(결과)를 삭제
    CLOSE 커서명;
    
END;
/

-- 2) 적용
DECLARE
    -- 1. 커서 정의
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees;
    -- INTO절에 사용할 변수가 필요 => 커서의 SELECT절 컬럼 구성만큼
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    -- 2. 커서 실행
    -- 커서 위치 : 첫번째 데이터보다 위에
    OPEN emp_cursor;
    -- OPEN emp_cursor; 에러메세지 already open
    
    -- 3. 커서에서 데이터 인출
    -- 커서 위치 : 첫번째 데이터를 가리키고 있음
    FETCH emp_cursor INTO v_eid, v_ename, v_hdate ;
    
    -- 3.5 데이터를 기반으로 연산
    DBMS_OUTPUT.PUT_LINE(v_eid||', '||v_ename||', '||v_hdate);
    
    -- 4. 커서 종료
    CLOSE emp_cursor;
    
END;
/

-- 명시적 커서의 속성과 기본 LOOP문
DECLARE
    -- 1. 커서 정의
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees;
    -- INTO절에 사용할 변수가 필요 => 커서의 SELECT절 컬럼 구성만큼
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    -- 2. 커서 실행
    -- 커서 위치 : 첫번째 데이터보다 위에
    OPEN emp_cursor;
    -- OPEN emp_cursor; 에러메세지 already open
    LOOP -- 반복문의 경우는 open close 사이에서 재오픈 하지 않게
        -- 3. 커서에서 데이터 인출
        -- 커서 위치 : 첫번째 데이터를 가리키고 있음
       FETCH emp_cursor INTO v_eid, v_ename, v_hdate ;
       EXIT WHEN emp_cursor%NOTFOUND; -- FETCH와 EXIT WHEN은 항상 같이 있어야됨
       -- 만약떨어져 있으면 마지막 데이터가 두번 들어갈수도 있다.
       -- %NOTFOUND는 새로운 데이터가 있는지 여부
    
        -- 3.5 데이터를 기반으로 연산
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : '); -- FETCH를 실행해서 가져온 행수 (실행할때마다 1건씩)
        DBMS_OUTPUT.PUT_LINE(v_eid||', '||v_ename||', '||v_hdate);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT);
    
    -- ERROR 1 : 커서가 실행된 상태에서 다시 실행 => cursor already open
    IF  NOT emp_cursor%ISOPEN THEN
        OPEN emp_cursor; 
    END IF;
    -- 4. 커서 종료
    CLOSE emp_cursor;
    
    -- ERROR 2 : 커서가 종료된 상태에서 속성사용 => invalid cursor
    -- CLOSE 이후에 속성사용하는것이 있는지 확인해볼것. 오타면 'EM_CURSOR' must be declared
END;
/

-- 주의사항 : 명시적 커서는 결과가 없는 경우 에러가 발생하지 않음.
-- 특정 부서에 속한 사원의 사원번호와 이름, 업무를 출력
-- 명시적 커서 => SQL의 SELECT문을 요구
SELECT employee_id, last_name, job_id
FROM employees
WHERE department_id = &부서번호;
--부서번호 0 => no data found
--부서번호 10 => 데이터 한건
--부서번호 50 => 데이터 여러건

DECLARE
    -- 1. 커서정의
    CURSOR emp_of_dept_cursor IS
        SELECT employee_id, last_name, job_id
        FROM employees
        WHERE department_id = &부서번호;
    
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_job employees.job_id%TYPE;
BEGIN
    -- 2. 커서실행
    OPEN emp_of_dept_cursor;
    
    LOOP
        -- 3. 데이터 인출
        FETCH emp_of_dept_cursor INTO v_eid, v_ename, v_job;
        EXIT WHEN emp_of_dept_cursor%NOTFOUND;
        
        -- 4. 데이터 인출 성공 시 연산
        DBMS_OUTPUT.PUT(emp_of_dept_cursor%ROWCOUNT || ' : ');
        -- ROWCOUNT는 LOOP문 내부 유동값, 현재 반환된 데이터 갯수
        DBMS_OUTPUT.PUT_LINE(v_eid || ', ' || v_ename || ', ' || v_job);
    END LOOP;
    -- LOOP문 바깥 고정값, 커서의 총 데이터 갯수
    DBMS_OUTPUT.PUT_LINE(emp_of_dept_cursor%ROWCOUNT);
    IF emp_of_dept_cursor%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서는 소속사원이 없습니다.');
    END IF;
    -- 5. 커서 종료
    CLOSE emp_of_dept_cursor;
END;
/

/*
1.
사원(employees) 테이블에서
사원의 사원번호, 사원이름, 입사연도를 => 다중행 select 문
다음 기준에 맞게 각각 test01, test02에 입력하시오.

입사년도가 2005년(포함) 이전 입사한 사원은 test01 테이블에 입력
입사년도가 2005년 이후 입사한 사원은 test02 테이블에 입력
SELECT employee_id, last_name, TO_CHAR(hire_date,'yyyy')
FROM employees;
*/
-- SELECT문 : 사원 테이블에서 사원번호, 사원이름, 입사년도 조회
SELECT employee_id, last_name, hire_date
FROM employees;
--조건문
IF 입사년도가 2025년(포함) 이전 THEN
    test01 테이블에 입력
ELSE
    test02 테이블에 입력
END IF;

-- PL/SQL 블록
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
        
        -- 커서에서 반환되는 데이터가 있는 경우
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
        
        -- 커서에서 반환되는 데이터가 있는 경우
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

-- Update, insert 처럼 행단위로 하는거는 레코드로 하는것도 가능하다.


SELECT sysdate, TO_CHAR(sysdate, 'yyyy"년"MM"월"dd"일"')
FROM dual;
SELECT sysdate, TO_CHAR(sysdate, 'HH24:mm:ss')
FROM dual;
SELECT sysdate, TO_CHAR(sysdate, 'yyyy"년"') year
FROM dual;


DECLARE
    CURSOR emp_cursor IS -- 커서 정의
        SELECT employee_id, last_name, hire_date -- 가져올값 입력
        FROM employees;
    v_eid employees.employee_id%TYPE; --가져온 값 담을 변수 입력
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    -- 커서 오픈
    OPEN emp_cursor;
    LOOP
        -- 데이터 가져오기
        FETCH emp_cursor INTO v_eid,v_ename,v_hdate;
        EXIT WHEN emp_cursor%NOTFOUND;
        -- 연산
        IF v_hdate <= to_date('2025-01-01','yyyy-MM-dd') THEN 
        -- 날짜비교 근데 12월31일까지 포함이라서 이렇게 하면 안됨 2025-12-31 이렇게 써야됨
            INSERT INTO test01 
            VALUES(v_eid, v_ename, v_hdate );
        ELSE
            INSERT INTO test02 
            VALUES(v_eid, v_ename, v_hdate );
        END IF;
    END LOOP;
    -- 커서 종료
    CLOSE emp_cursor;
END;
/



/*
2.
부서번호를 입력할 경우(&치환변수 사용)
해당하는 부서의 사원이름, 입사일자, 부서명을 출력하시오.
*/

--SELECT문 : 부서번호 -> employees(사원이름,입사일자), departments(부서명)/JOIN
SELECT e.last_name,e.hire_date, d.department_name
FROM employees e join departments d
                  on e.department_id = d.department_id
WHERE e.department_id = &부서번호;

-- PL/SQL 블록
DECLARE
    CURSOR emp_in_dept_cursor IS
        SELECT e.last_name, e.hire_date, d.department_name
        FROM employees e join departments d
                  on e.department_id = d.department_id
        WHERE e.department_id = &부서번호;
    v_ename employees.last_name%TYPE; --가져온 값 담을 변수 입력
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
        WHERE d.department_id=&부서번호;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
    v_dname departments.department_name%TYPE;
BEGIN
    OPEN emp_cursor;
    LOOP
        -- 하나씩 값을 넣어주는 작업
        FETCH emp_cursor INTO v_ename, v_hdate, v_dname;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        --연산식
        DBMS_OUTPUT.PUT_LINE(v_ename|| ', ' || v_hdate || ', ' ||v_dname);
    END LOOP;
    CLOSE emp_cursor;
END;
/


/*
3.
부서번호를 입력(&사용)할 경우 
사원이름, 급여, 연봉->(급여*12+(급여*nvl(커미션퍼센트,0)*12))
을 출력하는  PL/SQL을 작성하시오.
*/
-- 3-1 연봉을 따로 계산
SELECT last_name, salary, commission_pct
FROM employees
WHERE department_id = &부서번호;

DECLARE
    CURSOR emp_in_dept_cursor IS
        SELECT last_name, salary, commission_pct
        FROM employees
        WHERE department_id = &부서번호;
    v_emp_rec emp_in_dept_cursor%ROWTYPE; -- CURSOR도 %ROWTYPE 사용가능
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
WHERE department_id = &부서번호;

DECLARE
    CURSOR emp_in_dept_cursor IS
        SELECT last_name, salary, (salary*12+(salary*nvl(commission_pct,0)*12)) as year
        FROM employees
        WHERE department_id = &부서번호;
    v_emp_rec emp_in_dept_cursor%ROWTYPE; -- CURSOR도 %ROWTYPE 사용가능
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
        WHERE department_id = &부서번호;
    v_ename employees.last_name%TYPE;
    v_esal employees.salary%TYPE;
    v_com employees.commission_pct%TYPE;
    v_ansal NUMBER;
BEGIN
    OPEN emp_cursor;
    LOOP
        -- 하나씩 값을 넣어주는 작업
        FETCH emp_cursor INTO v_ename, v_esal, v_com;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- 연산식
        v_ansal := 12*v_esal +v_esal*nvl(v_com,0)*12;
        DBMS_OUTPUT.PUT_LINE('사원이름 : '||v_ename || ', 급여 : ' || v_esal || ', 연봉 : ' || v_ansal);
    END LOOP;
    CLOSE emp_cursor;
END;
/