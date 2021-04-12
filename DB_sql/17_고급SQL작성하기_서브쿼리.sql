-- 서브쿼리
-- 쿼리문 내부에 다른 쿼리문을 포함하는 것


-- 1. 단일행 서브쿼리
--  1) 서브쿼리의 결과가 1개인 쿼리
--  2) 단일 행 서브쿼리 연산자 : =, !=, <=, >=, <, >

-- 문제1. 평균급여보다 더 높은 급여를 받는 사원들의 정보를 조회하시오.
select name
     , position
     , salary
  from employee
 where salary > (select avg(salary) 
                   from employee );
 
-- 문제2. 사원번호가 1001인 사원과 같은 직급을 가진 사원들의 정보를 조회하시오.
select name
     , position
     , salary
  from employee
 where position = (select position 
                     from employee 
                    where emp_no = 1001 );
                    
                    
-- 문제3. 가장 급여가 높은 사원과 가장 급여가 낮은 사원을 조회하시오.
select name
     , position
     , salary
  from employee
 where salary = (select max(salary) from employee)
    or salary = (select min(salary) from employee);
    
    
select name
     , position
     , salary
  from employee
 where salary in ( (select max(salary) from employee), (select min(salary) from employee) );
 
 
 
--------------------------------------------------------------------

--  다중 행 서브쿼리
-- 1. 서브쿼리의 결과가 여러 개인 쿼리
-- 2, 다중 행 서브쿼리 연산자 : IN, ALL, ANY, EXITS

-- 문제1. 부서번호가 1인 부서에 존재하는 같은 직급을 가지고 있는 모든 사원을 조회하시오
select
       name
     , depart
     , position
  from employee
 where position in (select position
                      from employee
                      where depart = 1 );
 
 
 
 -- 문제2. '구창민'과 같은 부서에서 근무하는 사원을 조회하시오.
select 
       name
     , depart
  from employee
 where depart in (select depart
                    from employee
                    where name = '구창민' );



-- 문제3. '구창민'과 같은 부서에서 근무하는 사원들의 모든 급여 보다 큰 급여르 받는 사원들을 조회하시오.
-- 1) 다중 행 서브쿼리
select
        name
      , depart
      , salary
  from employee
 where salary > all (select salary 
                     from employee 
                     where depart = 1 ); 



-- 2) 단일 행 서브쿼리
select
        name
      , depart
      , salary
  from employee
 where salary > (select max(salary)
                     from employee 
                     where depart = 1 ); 



----------------------------------------------------------------

-- 스칼라 서브쿼리
-- 1. SELECT절에서 사용하는 서브쿼리이다.
-- 2. '단일 행' 서브쿼리여야 한다.

-- 예시
-- 문제1. 모든 사원들의 평균연봉과 모든 부서수를 조회하시오
select (select avg(e.salary) 
          from employee e) as 평균연봉
     , ( select count(d.dept_no)
           from department d) as 부서수
  from dual;
       
----------------------------------------------------------------

-- 인라인 뷰 (inline view) : 제일 먼저 실행된다.(FROM절이 실행순서_1번)
-- 1. FROM절에서 사용하는 서브쿼리이다.
-- 2. 일종의 임시테이블이다. (뷰)
-- 3. 인라인 뷰에서 SELECT한 칼럼만 메인쿼리에서 사용할 수 있다.

-- 문제1. 부서번호가 1인 사원을 조회하시오. 이름순으로 정렬하시오.

-- 1) 일반적인 풀이 (조건 >>> 정렬) 
select depart  
     , name
  from employee
 where depart = 1
 order by name;
 
-- 2) 인라인 뷰 (정렬 >>> 조건) : 과정; 실행 순서가 달라진것. [정렬 먼저 실행.]
select depart
     , name
  from (select depart 
             , name 
          from employee 
          order by name) e
 where e.depart = 1;


-- CRAETE문과 서브쿼리
-- 1. 서브쿼리의 결과를 이용해서 새로운 테이블을 생성할 수 있다.
-- 2. 데이터를 포함할  수도 있고, 제외할 수도 다.

desc employee;

-- 문제1. employee테이블의 구조와 데이터를 모두 복사해서 새로운 employee2 테이블을 생성하시오.
create table employee2
    as (select emp_no
             , name
             , depart
             , position
             , gender
             , hire_date
             , salary
          from employee );

          
-- 문제2. employee테이블의 데이터를 제외하고 구조만 복사해서 employee3테이블을 생성하시오
create table employee3
    as (select emp_no
             , name
             , depart
             , position
             , gender
             , hire_date
             , salary 
          from employee 
         where 1 =2 );  -- 1=2는 만족하지 않으므로 어떤 데이터도 조회되지 않는다.








