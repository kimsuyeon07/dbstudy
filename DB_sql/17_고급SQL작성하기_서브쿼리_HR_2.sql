-- 1. 모든 사원의 LAST_NAME, SALARY, 본인이 근무하는 부서의 평균연봉(SALARY)을 조회하시오.
select t.LAST_NAME
     , t.SALARY
     , (select round(avg(salary), 2) 
          from employees d 
         where d.department_id = t.department_id) as 부서별평균연봉
  from employees t;

    
-- 2. 부서(DEPARTMENT_ID)별로 DEPARTMENT_ID, DEPARTMENT_NAME, 평균연봉을 조회하시오.
select d.department_id
     , d.department_name
     , (select round(avg(salary), 2)
          from employees e
         where e.department_id = d.department_id) as 평균연봉
  from departments d;


-- 3. 모든 사원들의 EMPLOYEE_ID, LAST_NAME, DEPARTMENT_NAME 을 조회하시오.
select e.EMPLOYEE_ID
     , e.LAST_NAME
     , d.DEPARTMENT_NAME
  from employees e inner join departments d
    on e.department_id = d.department_id;


-- 4. 평균연봉 이상의 연봉을 받는 사원들의 정보를 조회하시오.
select LAST_NAME
     , EMPLOYEE_ID
     , salary
  from employees
 where salary > (select avg(salary)
                   from employees);


-- 5. Patrick Sully 와 같은 부서에 근무하는 모든 사원정보를 조회하시오.
select e.department_id
     , d.department_name
     , e.last_name
     , e.salary
  from departments d inner join employees e
    on d.department_id = e.department_id
 where e.department_id = (select department_id
                          from employees 
                         where first_name = 'Patrick'
                           and last_name = 'Sully' );
    



-- 6. 부서번호가 20인 사원들 중에서 평균연봉 이상의 연봉을 받는 사원정보를 조회하시오.
select e.department_id
     , d.department_name
     , e.employee_id
     , e.last_name
     , e.salary
  from departments d inner join employees e
    on d.department_id = e.department_id
 where e.department_id = 20
   and e.salary > (select avg(salary)
                   from employees);


-- 7. 'PU_MAN'의 최대연봉보다 더 많은 연봉을 받은 사원들의 정보를 조회하시오.
select employee_id
     , last_name
     , department_id
     , job_id
     , salary
  from employees
 where salary > (select max(salary)
                   from employees
                  where job_id = 'PU_MAN');


-- 8. 사원번호가 131인 사원의 JOB_ID와 SALARY가 모두 일치하는 사원들의 정보를 조회하시오.
select employee_id
     , last_name
     , salary
     , JOB_ID
  from employees
 where (JOB_ID, SALARY) = (select JOB_ID
                                , SALARY
                             from employees
                            where employee_id = 131);


-- 9. LOCATION_ID가 1000~1900인 국가들의 COUNTRY_ID와 COUNTRY_NAME을 조회하시오.
select l.COUNTRY_ID
     , c.COUNTRY_NAME
     , l.LOCATION_ID
  from locations l inner join countries c
    on l.country_id = c.country_id
 where l.location_id between 1000 and 1900;
 
select COUNTRY_ID
     , COUNTRY_NAME
  from countries 
 where country_id in (select DISTINCT country_id
                        from locations
                       where location_id between 1000 and 1900);



-- 10. 부서가 'Executive'인 모든 사원들의 정보를 조회하시오.
-- 서브쿼리의 WHERE 절에서 사용한 DEPARTMENT_NAME은 PK, UQ가 아니므로 서브쿼리의 결과는 여러 개이다.
select department_id
     , employee_id
     , last_name
  from employees
 where department_id in (select department_id
                           from departments
                          where department_name = 'Executive');


-- 11. 부서번호가 30인 사원들 중에서 부서번호가 50인 사원들의 최대연봉보다 더 많은 연봉을 받는 사원들을 조회하시오.
select employee_id
     , last_name
     , salary
  from employees
 where department_id = 30
   and salary > (select max(salary)
                   from employees
                  where department_id = 50); 

              
-- 12. MANAGER가 아닌 사원들의 정보를 조회하시오.
-- MANAGER는 MANAGER_ID를 가지고 있다.
select manager_id
     , employee_id
     , last_name
  from employees
 where employee_id NOT IN (select distinct manager_id
                             from employees
                            where manager_id IS NOT NULL);

-- 13. 근무지가 'Southlake'인 사원들의 정보를 조회하시오.
select l.city
     , e.employee_id
     , e.last_name
  from locations l, departments d, employees e
 where l.location_id = d.location_id
   and d.department_id = e.department_id
   and l.city = 'Southlake';



-- 14. 부서명의 가나다순으로 모든 사원의 정보를 조회하시오.
select e.employee_id
     , e.last_name
     , e.salary
  from employees e
 order by (select department_name
             from departments d
            where d.department_id = e.department_id);

-- 15. 가장 많은 사원들이 근무하고 있는 부서의 번호와 근무하는 인원수를 조회하시오.
select count(*) as 사원수
     , department_id
  from employees
 group by department_id
having count(*) = (select max(count(*))
                     from employees
                    group by department_id);
