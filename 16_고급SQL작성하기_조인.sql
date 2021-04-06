CREATE TABLE department
(
    dept_no NUMBER(1),
    dept_name VARCHAR2(20),
    LOCATION VARCHAR(20)
);
CREATE TABLE employee
(
    emp_no NUMBER(4),
    NAME VARCHAR2(20),
    depart NUMBER(1),
    POSITION VARCHAR2(20),
    gender CHAR(1),
    hire_date DATE,
    salary VARCHAR2(100)
);


    
-- 제약조건 - PK
ALTER TABLE department ADD CONSTRAINT dept_pk PRIMARY KEY(dept_no);
ALTER TABLE employee ADD CONSTRAINT emp_pk PRIMARY KEY(emp_no);
-- 제약조건- FK
ALTER TABLE employee ADD CONSTRAINT emp_dept_fk FOREIGN KEY (depart) REFERENCES department(dept_no);


-- INSERT
-- department테이블
INSERT INTO department VALUES (1, '영업부', '대구'); 
INSERT INTO department VALUES (2, '인사부', '서울'); 
INSERT INTO department VALUES (3, '총무부', '대구'); 
INSERT INTO department VALUES (4, '기획부', '서울'); 
-- employee테이블
INSERT INTO employee VALUES (1001, '구창민', 1, '과장', 'M', '95-05-01', '5000000');
INSERT INTO employee VALUES (1002, '김민서', 1, '사원', 'M', '17-09-01', '2500000');
INSERT INTO employee VALUES (1003, '이은영', 2, '부장', 'F', '90-09-01', '5500000');
INSERT INTO employee VALUES (1004, '한성일', 2, '과장', 'M', '93-04-01', '5000000');

COMMIT;



--------------------------------------------------------------------------------
-- 카테젼 곱
-- 두 테이블의 조인 조건(관계)이 잘못되거나 없을 때 나타난다.

--1) FROM절에 ','로 분리할 것
SELECT
       e.emp_no
     , e.NAME
     , d.dept_name
     , e.POSITION
     , e.hire_date
     , e.salary
  FROM employee e, department d;
  
-- 2) FROM절에는 한개의 테이블만, CROSS JOIN을 사용할 것
SELECT
       e.emp_no
     , e.NAME
     , b.dept_name
     , e.POSITION
     , e.hire_date
     , e.salary
  FROM employee e 
 CROSS JOIN department d;
