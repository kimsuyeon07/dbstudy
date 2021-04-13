SET SERVEROUTPUT ON;

-- 1. 프로시저
--    1) 한 번에 처리할 수 있는 쿼리문의 집합이다.
--    2) 결과(반환)가 있을 수도 있고 없을 수도 있다. 
--    3) EXECUTE(EXEC)를 통해서 실행한다.


-- 1-1)
-- 프로시저 정의
CREATE PROCEDURE proc1 -- 프로시져명 : proc1
AS -- 변수 선언하는 곳. is와 같다.
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Hello Procedure');
END proc1; -- END;도 가능(proc1 : 생략 가능)
-- 프로시저 실행
EXECUTE proc1();


-- 1-2) 프로시저에서 변수 선언하고 사용하기
create or replace procedure proc2  -- [create or replace] 새로만들거나 덮어쓰거나 
as 
    my_age NUMBER;
begin 
    my_age := 20;
    DBMS_OUTPUT.PUT_LINE('나는 ' || my_age || '살이다.');
end proc2;

exec proc2();


-- 1-3) 입력 파라미터
-- 프로시저에 전달하는 값 : 인수
-- 문제 : employee_id를 입력 파라미터로 전달하면 해당 사원의 last_name 출력하기
create or replace procedure proc3(in_employee_id in NUMBER)  -- 타입 작성 시 크기 지정 안 함.(NUMBER, VARCAR2 등)
is  
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
begin
    select last_name into v_last_name
      from employees
     where employee_id = in_employee_id;
     DBMS_OUTPUT.PUT_LINE('결과 : ' || v_last_name);
END proc3;

exec proc3(100);  -- 입력 파라미터 100 전달
    

-- 1-4) 출력 파라미터
-- 프로시져의 실행 결과를 저장하는 파라미터
-- 함수와 비교하면 함수의 반환값
create or replace procedure proc4(out_result out NUMBER)
as
    
begin
    select max(salary) into out_result  -- 최고연봉은 출력 파라미터 out_result에 저장
      from employees;
end proc4;

-- 프로시저를 호출할 때 
-- 프로시저의 결과를 저장할 변수를 넘겨준다.
declare
    max_salary NUMBER;
begin
    proc4(max_salary); -- max_salaty에 최고연봉이 저장되기를 기대
    DBMS_OUTPUT.PUT_LINE('최고연봉 : ' || max_salary);
END;


-- 1-5) 입출력 파라미터
-- 입력 : 사원번호
-- 출력 : 연봉
create or replace procedure proc5(in_out_param IN OUT NUMBER)
is
    v_salary NUMBER;
begin
    select salary into v_salary
      from employees
     where employee_id = in_out_param;  -- 입력된 인수(사원번호)를 조건으로 사용!
    in_out_param := v_salary;  -- 결과를 출력 파라미터에 저장
exception
    when others then
    DBMS_OUTPUT.PUT_LINE('예외 코드 : ' || SQLCODE);
    DBMS_OUTPUT.PUT_LINE('예외 메시지 : ' || SQLERRM);
END proc5;

-- 변수를 전달할 때는 사원번호를 저장해서 보내고,
-- 프로시저 실행 후에는 해당 변수에 연봉이 저장되어 있다.
declare
    result number;
begin
    result := 100; -- 사원번호를 의미
    proc5(result);  -- EXECUTE 없이 실행 (BEGIN 안에서는)
    dbms_output.put_line('실행 후 결과 : ' || result);
END;


-- 문제 세팅
-- BOOK, CUSTOMER, ORDERS 테이블 (DQL_연습문제.sql 참조)
ALTER TABLE BOOK ADD STOCK NUMBER;
ALTER TABLE CUSTOMER ADD POINT NUMBER;
ALTER TABLE ORDERS ADD AMOUNT NUMBER;
UPDATE BOOK SET STOCK = 10;
UPDATE CUSTOMER SET POINT = 1000;
UPDATE ORDERS SET AMOUNT = 1;
COMMIT;

drop sequence orders_seq;
create sequence orders_seq increment by 11 nomaxvalue nominvalue nocycle nocache;

-- EXEC proc_order (회원번호, 책번호, 구매수량);
-- 1. ORDERS테이블에 주문 기록이 삽입된다. (order_no는 시퀀스 처리), (SALES_PRICE는 BOOK테이블의 price의 90%)
-- 2. CUSTOMER테이블에 주문총액(구매수량 * 책가격); 의 10%를 POINT에 더해준다.
-- 3. BOOK테이블의 재고를 조절한다. (재고가 줄어야 한다.)
create or replace procedure proc_order
(
    in_customer_id IN NUMBER,
    in_book_id IN NUMBER,
    in_amount IN NUMBER
)

is

begin
    -- 삽입
    insert into orders
        (order_id, customer_id, book_id, sales_price, order_date, amount)
    values
        (orders_seq.nextval, in_customer_id, in_book_id, (select floor(price * 0.9) from book where book_id = in_book_id), SYSDATE, in_amount);
    -- 업데이트 01
    update customer
       set point = point + floor(in_amount * (select sales_price from orders where order_id = (select max(order_id) from orders)) * 0.1)
     where customer_id = in_customer_id;
    -- 업데이트 02
    update book
       set stock = stock - in_amount
     where book_id = in_book_id;
    commit; -- 작업의 성공
    
exception 
    when others then
    DBMS_OUTPUT.PUT_LINE('예외 코드 : ' || SQLCODE);
    DBMS_OUTPUT.PUT_LINE('예외 메시지 : ' || SQLERRM);
    rollback; -- 작업의 취소
end proc_order;

exec proc_order(1, 1, 2);  -- 1번 구매자가 1번 책을 2권 구매한다.




--------------------------------------------------------------------------------
-- 2. 사용자 함수
--    1) 하나의 결과값이 있다. (RETURN이 있다.)
--    2) 주로 쿼리문에 포함된다.
CREATE or REPLACE FUNCTION get_total(n NUMBER)  -- 1 ~ n까지의 합계를 반환하는 함수
RETURN number  -- 반환값이 number타입이다.
as  -- 변수 선언 장소
    i number; -- 1 ~ n 
    total number; -- 합계
begin
    total := 0;
    for i in 1 .. n loop -- 1 .. n (최소1 ~ 최대n까지)
        total := total + i;
    end loop;
    return total;  -- 반환
end get_total;    

-- 함수의 확인
select get_total(100) from dual;

----------------------------------------------
create or replace function get_grade(n number)
RETURN char
is
    score number(3);
    grade char(1);
begin
    score := n;
    case
        when score >= 90 then
            grade := 'A';
        when score >= 80 then
            grade := 'B';
        when score >= 70 then
            grade := 'C';
        when score >= 60 then
            grade := 'D';
        else grade := 'F';
    end case;
    return grade;
end get_grade;


-- 함수의 확인
select get_grade(90) from dual;



--------------------------------------------------------------------------------
-- 3. 트리거
--    1) INSERT, UPDATE, DELETE 작업을 수행하면 자동으로 실행되는 작업이다.
--    2) BEFORE, AFTER 트리거를 많이 사용한다.
CREATE OR REPLACE TRIGGER trig1
    -- 언제 진행 할 것인가?
    before -- 수행 이전에 자동으로 실행된다.
    INSERT or UPDATE or DELETE -- 트리거가 동작할 작업을 고른다.
    -- ↑ insert, update, delete 모두에서 동작한다
    on employees -- 트리거가 동작할 테이블이다.
    for EACH ROW -- 한 행씩 적용된다.
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello Trigger');
end trig1;

-- 트리거 동작 확인
update employees set salary = 25000 where employee_id = 100;
delete from employees where employee_id = 206;




create or replace trigger trig2
    after -- 수행 이후에 자동으로 실행된다.
    INSERT OR UPDATE OR DELETE
    ON employees
    for each row
begin
    if inserting then -- 삽입이었다면,
        DBMS_OUTPUT.PUT_LINE('INSERT 했군요.');
    elsif updating then
        DBMS_OUTPUT.PUT_LINE('UPDATE 했군요.');
    elsif deleting then
        DBMS_OUTPUT.PUT_LINE('DELETE 했군요.');
    end if;
end trig2;

update employees set salary = 25000 where employee_id = 100;
delete from employees where employee_id = 206;


-- 트리거 삭제
drop trigger trig1;
drop trigger trig2;

--------------------------------------------------------------------------------

-- 문제
-- employees 테이블에서 삭제된 데이터는 퇴사자(retrie)테이블에 자동으로 저장되는
-- 트리거를 작성하시오.
--        INSERT       UPDATE      DELETE
-- :OLD   NULL         수정전값    삭제전값
-- :NEW   추가된값     수정후값    NULL

-- 1. 퇴사자 테이블을 생성한다.
--    retire_id, employee_id, last_name, department_id, hire_date, retire_date
drop table retrie;
create table retire
(
    retire_id number,
    employee_id number,
    last_name varchar2(25),
    department_id number,
    hire_date date,
    retire_Date date
);
alter table retire add constraint retire_pk primary key(retire_id);

-- 2. retire_seq 시퀸스를 생성한다.
create SEQUENCE retire_seq NOCACHE;

-- 3. 트리거를 생성한다.
create or replace trigger retire_trig
    after  -- 삭제 이후에 동작하므로 삭제 이전의 데이터는 :OLD에 있다.
    delete
    on employees
    for each row
begin 
    insert into retire
        ( retire_id, employee_id, last_name, department_id, hire_date, retire_date)
    values
        (retire_seq.nextval, :OLD.employee_id, :OLD.last_name, :OLD.department_id, :OLD.hire_date, SYSDATE);
end retire_trig;


-- 4. 삭제를 통해 트리거 동작을 확인한다.
delete from employees where department_id = 50;
select retire_id
     , employee_id
     , last_name
     , department_id
     , hire_date
     , retire_date
  from retire;





