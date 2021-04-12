-- 뷰
-- 1. 기존 테이블을 이용해서 생성한 가상테이블이다.
-- 2. 디스크 대신 데이터사전에만 등록된다.


-- 뷰 생성 연습
create view TEST_VIEW
    AS (SELECT emp_no
             , name
          FROM employee);
          
select /*  HINT */
       emp_no
     , name
  from test_view;
          
          
          
create view TEST_VIEW2
    AS (select *
          from employee
         where position = '과장');
         
select *
  from test_view;
  

-- 내부 조인
create view DEPT_VIEW 
    AS ( select e.emp_no
              , e.name
              , e.position
              , d.dept_name
          from department d inner join employee e
            on d.dept_no = e.depart);
            
select *
  from dept_view;
  
-- 외부조인 ('김민아'까지 나오도록)
create view DEPT_VIEW2
    AS (select e.emp_no
             , e.name
             , e.position
             , d.dept_name
          from department d right OUTER join employee e
            on d.dept_no = e.depart );
            
select *
  from dept_view2;
