-- 1. 모든 사원의 LAST_NAME, SALARY, 본인이 근무하는 부서의 평균연봉(SALARY)을 조회하시오
-- 스칼라 서브쿼리
-- t : 전체 테이블의 데이터
-- d : 같은   부서의 데이터

/* 1) 본인이 근무하는 부서의 평균연봉(SALARY)
select avg(me.salary)
  from employees me inner join employees you
    on me.department_id = you.department_id ) */
    
/* 2) 모든 사원의 LAST_NAME, SALARY, 본인이 근무하는 부서의 평균연봉(SALARY)을 조회 */
select t.last_name
     , t.salary
     , (select round(avg(d.salary))  -- 1) 과정.
          from employees d                                      -- [실행순서]
         where d.department_id = t.department_id) as 평균연봉   --         2.
  from employees t;                                              --        1.


    
-- 2. 부서(DEPARTMENT_ID)별로 DEPARTMENT_ID (dept), DEPARTMENT_NAME (dept), 평균연봉 (emp)을 조회하시오.
-- ** 서브쿼리 / 일반쿼리 중 => 성능 상으로 일반쿼리로 작성하는 것이 좋다.

/* 부서별 평균연봉
select round(avg(e.salary))
  from employees e inner join departments d
    on e.department_id = d.department_id
*/
select d.department_id
     , d.department_name
     , (select round(avg(e.salary))
          from employees e
         where e.department_id = d.department_id ) as 평균연봉
  from departments d;




-- 3. 모든 사원들의 EMPLOYEE_ID, LAST_NAME, DEPARTMENT_NAME 을 조회하시오.
-- 스칼라 서브쿼리
-- employees테이블에서 departments테이블의 department_name을 가져온다.
select e.employee_id
     , e.last_name
     , (select d.department_name  -- DEPARTMENT_NAME 을 조회
          from departments d
         where d.department_id = e.department_id) as 부서명
  from employees e;

-- 2)내부 조인 : 정렬 순서에만 차이가 있음. [ (1), (2) 모두 동일한 데이터값 출력. ]
select e.employee_id
     , e.last_name
     , d.department_name
  from employees e inner join departments d
    on e.department_id = d.department_id;
    
    

-- 4. 평균연봉 이상의 연봉을 받는 사원들의 정보를 조회하시오.
-- where절에서 사용하는 서브쿼리.
select e.first_name
     , e.salary
  from employees e
 where salary > (select avg(salary)
                   from employees);



-- 5. Patrick Sully 와 같은 부서에 근무하는 모든 사원정보를 조회하시오.
-- first_name : Patrick
-- last_name : Sully
-- 이름은 유일한 값으로 칠 수 없음. => 다중 행 서브쿼리.
-- 서브쿼리 : Patrick Sully의 부서, 다중 행 서브쿼리
select department_id
     , first_name 
     , last_name
  from employees
 where department_id in(select department_id
                          from employees
                         where first_name = 'Patrick'
                           and last_name = 'Sully');


-- 6. 부서번호가 20인 사원들 중에서 평균연봉 이상의 연봉을 받는 사원정보를 조회하시오.
select first_name
     , last_name
     , salary
     , department_id
  from employees
 where department_id = 20
   and salary > (select avg(salary)
                   from employees);




-- 7. 'PU_MAN'의 최대연봉보다 더 많은 연봉을 받은 사원들의 정보를 조회하시오.
-- job_id ('PU_MAN')
-- 다중 행 서브쿼리 OR  단일 행 서브쿼리(최대연봉) 

-- 1) 단일 행 서브쿼리
select last_name
     , salary
     , job_id
  from employees
 where salary > (select max(salary) 
                   from employees 
                  where job_id = 'PU_MAN');
 
-- 2) 다중 행 서브쿼리
select last_name
     , salary
     , job_id
  from employees
 where salary > all (select salary
                       from employees 
                      where job_id = 'PU_MAN');





-- 8. 사원번호가 131인 사원의 JOB_ID와 SALARY가 모두 일치하는 사원들의 정보를 조회하시오.
select last_name
     , employee_id
     , job_id
     , salary
  from employees
 where (job_id, salary) = (select job_id, salary   
                             from employees
                            where employee_id = 131); -- [단일 행 서브쿼리] : 사원번호가 131인 사원의 JOB_ID와 SALARY는 값이 유일(하나).
                  




-- 9. LOCATION_ID가 1000~1900인 국가들의 COUNTRY_ID와 COUNTRY_NAME을 조회하시오.
-- country_id 
-- LOCATION_ID  => countrys테이블의 country_id를 FK 받음.

-- 다중 행 서브쿼리
select DISTINCT country_id  -- 중복 제거
  from locations
 where location_id between 1000 and 1900;


select country_id
     , country_name
  from countries
 where country_id in (select DISTINCT country_id  -- 중복 제거
                        from locations
                       where location_id between 1000 and 1900);
                       
                       



-- 10. 부서가 'Executive'인 모든 사원들의 정보를 조회하시오.
-- 서브쿼리 : 부서이름이 'Executive'인 부서들의 department_id
-- 서브쿼리의 WHERE 절에서 사용한 DEPARTMENT_NAME은 PK, UQ가 아니므로 서브쿼리의 결과는 여러 개이다.

select last_name
     , department_id
  from employees
 where department_id in (select department_id 
                           from departments 
                          where department_name = 'Executive');






-- 11. 부서번호가 30인 사원들 중에서 부서번호가 50인 사원들의 최대연봉보다 더 많은 연봉을 받는 사원들을 조회하시오.
-- 서브쿼리 : 부서번호가 50인 사원들의 최대연봉

-- 1) 다중 행 서브쿼리
select last_name
     , salary
  from employees
 where department_id = 30
   and salary > all (select salary
                       from employees
                      where department_id = 50);
                      
-- 2) 단일 행 서브쿼리                      
select last_name
     , salary
  from employees
 where department_id = 30
   and salary > (select max(salary)
                   from employees
                  where department_id = 50);





              
-- 12. MANAGER가 아닌 사원들의 정보를 조회하시오.
-- MANAGER는 MANAGER_ID를 가지고 있다.


-- 13. 근무지가 'Southlake'인 사원들의 정보를 조회하시오.


-- 14. 부서명의 가나다순으로 모든 사원의 정보를 조회하시오.


-- 15. 가장 많은 사원들이 근무하고 있는 부서의 번호와 근무하는 인원수를 조회하시오.
