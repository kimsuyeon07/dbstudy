-- << employees 테이블 >> --

DESC employees;

-- 1. 전체 사원의 모든 칼럼을 조회한다.

select employee_id, first_name, last_name, email, phone_number
  from employees;

select *
  from employees;

select employess.employees_id, employess.first_name, employess.last_name, employess.email, employess.phone_number --OWNER(칼럼의 테이블)
  from employees;
  
select e.employees_id, e.first_name, e.last_name, e.email, e.phone_number
  from employees e;  -- employees 테이블의 별명(alias)를 e로 지정한다.


-- 2. 전체 사원의 first_name, last_name, job_id 를 조회한다.
select first_name, last_name, job_id
  form employees;
  
select emp.first_name, emp.last_name, emp.job_id
  form employees emp; -- 별명은 마음대로 지정한다.


-- 3. 연봉(salary)이 12000 이상되는 사원들의 last_name, salary 를 조회한다.
select last_name, salary
  from employees;
where salary >= 12000;

select e.last_name, e.salary
  from employees e ;
where e.salary >= 12000;

--                 실행순서
-- SELECT 칼럼     3
--  FROM 테이블    1
-- where 조건식    2

-- 4. 사원번호(employee_id)가 150 인 사원의 last_name, department_id 를 조회한다.
-- 사원번호의 타입이 NUMBER : employees_id = 150;
-- 사원번호의 타입이 VARCHAR2 : employees_id = '150';

-- 1) 사원번호의 타입이 NUMBER
select last_name, departnemt_id
  from employees
where employtees_id = 150;  -- WHERE절에서 사용되는 =는 '같다'

select last_name, departnemt_id
  from employees
where employtees_id = '150';  -- 실무에서는 전혀 문제 없는 쿼리문(자동으로 WHERE employees_id = TO_NUMBER('150');

-- 2) 사원번호의 타입이 VARCHAR2
select last_name, departnemt_id
  from employees
where employtees_id = 150;  -- 성능이 떨어지는 쿼리문 (자동으로 WHERE TO_NUMBER (employees_id) = 150; )

select last_name, departnemt_id
  from employees
where employtees_id = '150';



-- 5. 커미션(commission_pct)을 받는 모든 사원들의 last_name, salary, commission_pct 를 조회한다.
--     NULL 조건 : IS NULL
-- NOT NULL 조건 : IS NOT NULL (커미션;commission을 받는다는 것.)
select last_name, salary, commission_pct
  from employees
where commission_pct IS NOT NULL;

select last_name, salary, commission_pct
  from employees
where NVL (commission_pct, 0) != 0; -- NVL (commission_pct, 0) : commision_pct가 null인 경우, 0 처리한다.



-- 6. 모든 사원들의 last_name, commission_pct 를 조회하되 커미션(commission_pct)이 없는 사원은 0으로 처리하여 조회한다.
      -- select last_name, NVL(commission_pct, 0) : 출력하고자 하는 상황에서 변경조건을 달아둔다.
select last_name, NVL (commission_pct, 0) as commission_pct  
  from employees;  



-- 7. 커미션(commission_pct)이 없는 사원들은 0으로 처리하고, 커미션이 있는 사원들은 기존 커미션보다 10% 인상된 상태로 조회한다.
-- 1) WHERE절
select last_name, commission_pct*1.1 as new_commission_pct
  from employees
where commission_pct IS NOT NULL;
-- 2) NVL2(표현식, NOT NULL, NULL) 함수 : 함수 처리 : null일때도 not null일 때로 처리하겠다.
      -- select last_name, NVL2(commission_pct, commission_pct*1.1, 0) : 출력하고자 하는 상황에서 변경조건을 달아둔다.
select last_name, NVL2(commission_pct, commission_pct*1.1, 0) as new_commission_pct
  from employees;



-- 8. 연봉(salary)이 5000 에서 12000 인 범위의 사원들의 first_name, last_name, salary 를 조회한다.
-- 1) 비교식
select first_name, last_name, salary 
  from employees
where salary >= 5000 and salary <= 12000;
-- 2) between 사용
select first_name, last_name, salary 
  from employees
where salary between 5000 and 12000;



-- 9. 연봉(salary)이 5000 에서 12000 사이의 범위가 아닌 사원들의 first_name, last_name, salary 를 조회한다.
-- 1) 비교식
select first_name, last_name, salary 
  from employees
where salary < 5000 or salary > 12000;
-- 2) between 사용
select first_name, last_name, salary
  from employees
where salary not between 5000 and 12000;




-- 10. 직업(job_id)이 SA_REP 이나 ST_CLERK 인 사원들의 전체 칼럼을 조회한다.
-- 1) 동등비교식
select *
  from employees
where job_id = 'SA_REP' or job_id = 'ST_CLERK';
-- 2) in 연산자 : in('--', '--')
select *
  from employees
where job_id IN ('SA_REP','ST_CLERK');



-- 11. 연봉(salary)이 2500, 3500, 7000 이 아니며 직업(job_id) 이 SA_REP 이나 ST_CLERK 인 사람들을 조회한다.
select *
  from employees
where salary not in(2500, 3500, 7000) 
  and job_id in('SA_REP', 'ST_CLERK');



-- 12. 상사(manager_id)가 없는 사람들의 last_name, job_id 를 조회한다.
select last_name, job_id
  from employees
where manager_id IS NULL;

--연습
-- emp 테이블 emp_id(pk), manager_id(fk)
create table emp
( 
    emp_id number(3),
    manager_id number(3)
);
alter table emp add constraint emp_pk primary key(emp_id);
alter table emp add constraint emp_emp_fk foreign key(manager_id) references emp(emp_id);
drop table emp;


/*
    와일드 카드(wild card)
    1. 모든 문자를 대체할 수 있는 만능문자
    2. 종료
       1) 글자 수 상관없는 만능문자 : %
       2) 한 글자를 대체하는 만능문자 : _
    3. 와일드 카드 연산자 : LIKE(등호(=) 대신 사용!)
    4. 예시
       1) 마동석, 마요네즈 : ak%
       2) 백설공주, 평강공주, 칠공주 : %공주
       3) 아이언맨, 맨드라미, 슈퍼맨대배트맨 : %맨%
*/
-- 13. 성(last_name)에 u 가 포함되는 사원들의 employee_id, last_name 을 조회한다.
-- 1) u (소문자)만 조회
select employee_id, last_name
  from employees
where last_name like '%u%';
-- 2) u (대문자/소문자) 모두 조회
select employee_id, last_name
  from employees 
where last_name like '%u%' or last_name like '%U%';
   -- last_name like in ('%u%', '%U%') : 안되는 쿼리 (wild card와 in())
   
-- // upper // lower
select employee_id, last_name
  from employees 
where UPPER(last_name) like '%U%';

select employee_id, last_name
  from employees 
where lower(last_name) like '%u%';


-- 14. 전화번호(phone_number)가 650 으로 시작하는 사원들의 last_name, phone_number 를 조회한다.
-- 1) like함수
select last_name, phone_number
  from employees
where phone_number like '650%';
-- 2) substr함수 : phone_number에서 앞의 3글자만 일부출력
select last_name, phone_number
  from employees
where substr(phone_number, 1, 3) = '650';  -- substring의 결과값은 '언제나' "문자열"타입!


-- 15. 성(last_name)의 네 번째 글자가 a 인 사원들의 last_name 을 조회한다.
-- 1) like 함수
select last_name
  from employees
where last_name like '___a%';  --  '-'하나 당 문자 한개를 의미
-- 2) substr 함수
select last_name
  from employees
where substr(last_name, 4, 1) = 'a';


-- 16. 성(last_name) 에 a 또는 e 가 포함된 사원들의 last_name 을 조회한다.
-- 1) like 함수
select last_name
  from employees
where last_name like '%a%' or last_name like '%e%';



-- 17. 성(last_name) 에 a 와 e 가 모두 포함된 사원들의 last_name 을 조회한다.
-- 1) like 함수
select last_name
  from employees
where last_name like '%a%' and last_name like '%e%';



-- 18. 2008/02/20 ~ 2008/05/01 사이에 고용된(hire_date) 사원들의 last_name, employee_id, hire_date 를 조회한다.
-- 1) between 함수
select last_name, employee_id, hire_date
  from employees
where hire_date between '2008/02/20' and '2008/05/01';



-- 19. 2004년도에 고용된(hire_date) 모든 사원들의 last_name, employee_id, hire_date 를 조회한다.
-- 1) like 함수 : hire_date가 문자열로 출력되기 때문에 가능
select last_name, employee_id, hire_date
  from employees
where hire_date like '04%';
-- 2) between 함수
select last_name, employee_id, hire_date
  from employees
where hire_date between '2004/01/01' and '2004/12/31';
-- 3) extract 함수
select last_name, employee_id, hire_date
  from employees
where extract(year from hire_date) = 2004;



-- 20. 부서(department_id)를 조회하되 중복을 제거하여 조회한다.
-- DISTINCT : 중복 제거 (칼럼 앞에 사용)
select distinct department_id
  from employees;



-- 21. 직업(job_id)이 ST_CLERK 가 아닌 사원들의 부서번호(department_id)를 조회한다.
-- 단, 부서번호가 NULL인 값은 제외하고 부서번호의 중복을 제거한다.
select distinct department_id
  from employees
where job_id != 'ST_CLERK'       --  job_id NOT IN ('ST_CLERK') : 하나의 조건도 가능하다!
  and department_id IS NOT NULL;



-- 22. 커미션(commission_pct)을 받는 사원들의 실제 커미션(commission = salary * commission_pct)을 구하고,
-- employee_id, first_name, job_id 와 함께 조회한다.
select employee_id, first_name, job_id, salary*commission_pct as commission
  from employees
where commission_pc IS NOT NULL;


/*
    오름차순/내림차순 정렬
    1. 오름차순 : ORDER BY 칼럼 ASC  -- Ascending 
                  ORDER BY 칼럼 (ASC -> 생략가능)
    2. 내림차순 : ORDER BY 칼럼 DESC -- Descending
*/
-- 23. 가장 오래 전에 입사(hire_date)한 직원부터 최근에 입사한 직원 순으로 last_name, hire_date 를 조회한다.
-- 날짜는 오래된 날짜가 작은 값이고, 최근 날짜가 큰 값이다.
-- 오래된 직원부터 보겠다 => 오름차순
select last_name, hire_date
  from employees
order by hire_date; -- ORDER BY hire_date ASC;



-- 24. 부서번호(department_id)가 20, 50 인 부서에서 근무하는 모든 사원들의 부서번호의 오름차순으로 조회하되,
-- 같은 부서번호 내에서는 last_name 의 알파벳순으로 조회한다.
select *
  from employees
where department_id in (20, 50)
order by department_id, last_name ;  -- department_id를 먼저 확인, 동일한 넘버(department_id) 안에서 last_name으로 정렬.



-- 25. 커미션(commission_pct)을 받는 모든 사원들의 last_name, salary, commission_pct 을 조회한다.
-- 연봉이 높은 사원을 먼저 조회하고 같은 연봉의 사원들은 커미션이 높은 사원을 먼저 조회한다.
select last_name, salary, commission_pct
  from employees
where commission_pct IS NOT NULL
order by salary desc , commission_pct desc;


