-- 예제 데이터베이스 생성

drop table employee;
drop table department;

-- (먼저)테이블 생성 : department
create table department 
(
    dept_no number,
    dept_name varchar2(15) not null,
    location varchar2(15) not null
);

--테이블 생성 : employee
create table employee 
(
    emp_no number,
    name varchar2(20),
    depart number,
    position varchar2(20),
    gender char(2),
    hire_date date,
    salary number
);


-- 제약조건 생성
alter table employee add constraint emp_ok primary key(emp_no);
alter table department add constraint dept_pk primary key(dept_no);

alter table employee modify name varchar2(20) not null;
alter table employee add constraint emp_dept_fk foreign key(depart) references department(dept_no);


desc employee;
desc department;


-- 내용 추가
insert into department (dept_no, dept_name, location) values (1, '영업부', '대구');
insert into department (dept_no, dept_name, location) values (2, '인사부', '서울');
insert into department (dept_no, dept_name, location) values (3, '총무부', '대구');
insert into department (dept_no, dept_name, location) values (4, '기획부', '서울');


-- 날짜 타입 작성 방법
-- 1. '2021-04-02'  /  '21-04-02'
-- 2. '2021/04/02'  /  '21/04/02' -> 오라클 기본값
insert into employee values (1001, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
insert into employee values (1002, '김민서', 1, '사원', 'M', '17-09-01', 2500000);
insert into employee values (1003, '이은영', 2, '부장', 'F', '90-09-01', 5500000);
insert into employee values (1004, '한성일', 2, '과장', 'M', '93-04-01', 5000000);


-- 행(row) 수정
-- 1. '영업부'의 위치(location)을 '인천'으로 수정하시오.
    -- WHERE절에서는 가능하면 PK를 사용하는 것이 좋다.
update department set location = '인천' where dept_no = 1; 
-- 2. '과장'과 '부장'의 월급(salary)을 10% 인상하시오.
update employee set salary = salary * 1.1 where position = '과장' or position = '부장';
update employee set salary = salary * 1.1 where position in('과장', '부장'); -- *추천*
-- 3. '총무부' -> '총괄팀' ,  '대구' -> '광주'
update department set location = '광주', dept_name = '총괄팀' where dept_no = 3;

-- 행(row) 삭제
-- 1. 모든 employee를 삭제한다.
delete from employee;  --ROLLBACK으로 취소할 수 있다. (DML)
-- TRUNCATE table employee; -- 빠르게 삭제되지만 취소가 불가능하다. (DDL)
-- 2. '기획부'를 삭제한다.
delete from department where dept_no = 4;
-- 


