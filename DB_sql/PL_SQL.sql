-- HR 계정의 EMPLOYEES 테이블을 복사하기
-- 1) 테이블을 복사하면 - 기본키, 외래키는 복사가 되지 않는다. (NOT NULL만 복사가 된다.)
CREATE TABLE EMPLOYEES 
    AS( SELECT * FROM HR.EMPLOYEES );  -- HR.EMPLOYEES : 다른 계정의 테이블을 가져오기!
    
DESC user_constraints;  -- 제약조건을 저장하고 있는 데이터 사전

SELECT *
  FROM user_constraints
 WHERE table_name = 'EMPLOYEES';
 

-- 복사한 테이블에 기본키(PK) 저장하기
ALTER TABLE EMPLOYEES ADD CONSTRAINT employees_pk PRIMARY KEY (employee_id);

--------------------------------------------------------------------------------

-- PL/SQL

-- 접속마다 최초 1회만 하면 된다.
-- 결과를 화면에 띄우기
SET SERVEROUTPUT ON ;  -- 디폴트값 : SET SERVEROUTPUT OFF;

-- 기본 구성
/*
    DECLARE 
        변수 선언;
    BEGIN
        작업;
    END;
*/

-- 화면 출력
BEGIN
    DBMS_OUTPUT.put_line('Hello PL/SQL');
END;

-- 변수 선언 (스칼라 변수 : )
DECLARE 
    my_name VARCHAR2(20);
    my_age NUMBER(3);
BEGIN 
    -- 변수에 값을 대입
    my_name := '에밀리';  -- PL/SQL문에서는 ( 대입연산자 := )
    my_age := 30;
    DBMS_OUTPUT.PUT_LINE('내 이름은 ' || my_name || '입니다.' );
    DBMS_OUTPUT.PUT_LINE('내 나이는 ' || my_age || '살 입니다.');
END;


-- 변수 선언 (참조 변수)
-- 기존의 칼럼의 타입을 그대로 가져와서 사용한다.
-- 계정.테이블명.칼럼%TYPE  
-- [  %TYPE => (계정.테이블명.칼럼)해당 칼럼의 타입을 가져오겠다! - 동일한 계정이면 안적어도 된다.  ]
DECLARE
    v_first_name EMPLOYEES.FIRST_NAME%TYPE; -- v_first_name => VARCHAR2(20);
    v_last_name EMPLOYEES.LAST_NAME%TYPE;   -- v_last_name  => VARCHAR2(25);
    BEGIN
        -- 테이블의 데이터를 변수에 저장하기 (기본으로 SELECT문 사용)
        -- SELECT 칼럼 INTO 변수 FROM 테이블명;  칼럼 -> 변수 
        -- ↓→→→ 어떤 칼럼의 데이터를 변수에 저장시킬 때 SELECT문을 사용해서 저장한다.
        SELECT first_name INTO v_first_name 
          FROM EMPLOYEES 
         WHERE employee_id = 100;
        SELECT last_name INTO v_last_name
          FROM EMPLOYEES
         WHERE employee_id = 100;
        SELECT first_name, last_name 
          INTO v_first_name, v_last_name
          FROM EMPLOYEES
         WHERE employee_id = 100;
        DBMS_OUTPUT.PUT_LINE(v_first_name || ' ' || v_last_name);
END;

--------------------------------------------------------------------------------

-- IF문
DECLARE 
     score NUMBER(3);
     grade CHAR(1);
BEGIN
    score := 50;
    IF score >= 90 THEN
        grade := 'A';
    ELSIF score >= 80 THEN
        grade := 'B';
    ELSIF score >= 70 THEN
        grade := 'C';
    ELSIF score >= 60 THEN
        grade := 'D';
    ELSE 
        grade := 'F';
    END IF;  -- IF문을 사용하면 IF문이 끝날 때 [END IF;]을 사용!
    DBMS_OUTPUT.PUT_LINE('점수는 ' || score || '점 이고, 학점은 ' || grade || '학점입니다.');
END;
        

-- CASE문
DECLARE
    score NUMBER(3);
    grade CHAR(1);
BEGIN
    score := 90;
    CASE 
        WHEN score >= 90 THEN
            grade := 'A';
        WHEN score >= 80 THEN
            grade := 'B';
        WHEN score >= 70 THEN
            grade := 'C';
        WHEN score >= 60 THEN
            grade := 'D';
        ELSE
            grade := 'F';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('점수는 ' || score || '점 이고, 학점은 ' || grade || '학점입니다.');
END;

    
--------------------------------------------------------------------------------


-- QUIZ.
-- 사원번호가 200인 사원의 연봉(salary)을 가져와서,
-- 5000이상이면 '고액연봉자' 아니면 공백출력하시오.

DECLARE
    v_salary EMPLOYEES.SALARY%TYPE;
    v_result varchar2(20);
BEGIN
    SELECT SALARY
      INTO v_salary
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = 200;
     IF v_salary >= 5000 THEN
        v_result := '고액연봉자';
    ELSE 
        v_result := ' ';
    END IF;
    DBMS_OUTPUT.PUT_LINE('연봉 : ' || v_salary || ' ' || v_result || '입니다.') ;
END;


--------------------------------------------------------------------------------

-- WHILE문 (반복문)
-- 1 ~ 100까지 모두 더하기
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    total := 0; -- total의 초기화
    n := 1;     -- n의 초기화
    WHILE n <= 100 LOOP
        total := total + n;
        n := n + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('합계 : ' || total);
END;
    

-- FOR문 (반복문)
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    total := 0;
    FOR n IN 1 .. 100 LOOP
        total := total + n;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('합계 : ' || total);
END;    

--------------------------------------------------------------------------------


-- EXIT문 (java의break문)
-- 1 ~ 누적합계를 구하다가 최초 누적합계가 3000 이상인 경우 반복문을 종료하고
-- 해당 누적합계를 출력하시오.
DECLARE
    N NUMBER;
    total NUMBER;
BEGIN
    total := 0;
    N := 1;
    
    WHILE TRUE LOOP  -- 무한루프
        total := total + n;
        IF total >= 3000 THEN
            EXIT;
        END IF;
        n := n +1;
    END LOOP;
    dbms_output.put_line('합계 : ' || total);
END;    


DECLARE
    N NUMBER;
    total NUMBER;
BEGIN
    total := 0;
    N := 1;
    
    WHILE TRUE LOOP  -- 무한루프
        total := total + n;
        exit when total >= 3000;  -- [exit when] if문을 사용하지 않고 사용할 수 있는 방법 
        n := n +1;
    END LOOP;
    dbms_output.put_line('합계 : ' || total);
END;    


-- CONTINUE문
-- 1 ~ 100 사이 모든 짝수의 합계를 구하시오.
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    total := 0;
    n := 0;
    WHILE n < 100 LOOP
        n := n + 1;
        IF MOD(n, 2) = 1 THEN  -- [MOD(n, 2) = 1] n이 홀수이면 (n을 2로 나눈 나머지가 1인 수)     
            CONTINUE;          -- WHILE문으로 이동
        END IF;
            total := total + n;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('합계 : ' || total);
END;


--------------------------------------------------------------------------------


-- 테이블 타입
-- 테이블의 데이터를 가져와서 배열처럼 사용하는 타입
DECLARE
    i number; -- 인덱스
    -- first_name_type : EMPLOYEES테이블의 FIRST_NAME칼럼값을 '배열처럼' 사용할 수 있는 타입.
    TYPE first_name_type IS TABLE OF EMPLOYEES.FIRST_NAME%type index by BINARY_INTEGER;  -- [index by BINARY_INTEGER] 정수형 인덱스번호를 사용하겠다.
    -- first_names : EMPLOYEES테이블의 FIRST_NAME칼럼값을 실제로 저장하는 변수(배열)
    first_names first_name_type;  -- 변수 선언 [first_name_type]타입.
BEGIN
    i := 0;  -- 인덱스번호는 0부터 시작.
    for v_row in (select first_name, last_name from employees) loop  -- 반복할 때마다 하나의 행으로 본다. 'ROW'
        first_names(i) := v_row.first_name;
        DBMS_OUTPUT.PUT_LINE(first_names(i) || ' ' || v_row.last_name);
        i := i + 1; -- for문이 끝날때 쯤 i를 증가시킨다.
    end loop;
end;
        


-- 부서번호 (department_id)가 50인 부서의 first_name, last_name을 가져와서
-- 새로운 테이블 employees50에 삽입하시오.
create table employees50 
    as (select first_name, last_name from employees where 1 = 0);  -- 칼럼만 가져오겠다.(데이터값은 가져오지 않겠다)
DECLARE
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
BEGIN
    for v_row in (select first_name, last_name from employees where department_id = 50) loop
        v_first_name := v_row.first_name;
        v_last_name := v_row.last_name;
        insert into employees50 (first_name, last_name) values (v_first_name, v_last_name);
    end loop;
    commit;
end;

select first_name, last_name from employees50;



-- 레코드 타입
-- 여러 칼럼(열)이 모여서 하나의 레코드 (행, row)가 된다.
-- 여러 데이터를 하나로 모으는 개념 : 객체(변수 + 함수)의 하위 개념 => 구조체(변수)      (자바 : 객체, 인스턴스)
DECLARE
    type person_type is record
    (
        my_name VARCHAR2(20),
        my_age NUMBER(3)
    );
    man person_type;   -- person_type의 man
    woman person_type; -- person_type의 woman
begin 
    man.my_name := '제임스';
    man.my_age := 20;
    woman.my_name := '엘리스';
    woman.my_age := 30;
    dbms_output.put_line(man.my_name || ' ' || man.my_age);
    dbms_output.put_line(woman.my_name || ' ' || woman.my_age);
end;




-- 데이블형 레코드 타입
-- 부서번호(department_id)가 50인 부서의 전체 칼럼을 가져와서
-- 새로운 테이블 employees2에 삽입하시오.
DROP TABLE employees2;


TRUNCATE TABLE employees50;  -- 구조는 남기고, 레코드만 모두 삭제하기(복구가 않된다);
CREATE TABLE employees2 
    AS (SELECT * FROM employees WHERE 1 = 0);

DECLARE
    row_data spring.employees%ROWTYPE;  -- employees테이블의 row(행)전체를 저장할 수 있는 변수
    emp_id NUMBER(3);
BEGIN
    FOR emp_id IN 100 .. 206 LOOP
        SELECT *
          INTO row_data
          FROM spring.employees
         WHERE employee_id = emp_id;
        INSERT INTO employees2 VALUES row_data;
    END LOOP;
END;
 
SELECT first_name, last_name FROM employees2;


--------------------------------------------------------------------------------

-- 예외처리
DECLARE
    v_last_name VARCHAR2(25);  -- 칼럼의 타입보다 크거나 같으면 이상이 없음. 
BEGIN
    SELECT last_name INTO v_last_name
      FROM employees
     WHERE employee_id = 1;  -- 없는 사원 => 에러메시지가 뜨는 SQL문
    dbms_output.put_line('결과 : ' || v_last_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        dbms_output.put_line('해당 사원이 없다.');
    WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('해당 사원이 많다.');
END;







