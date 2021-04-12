-- 1. 부서의 위치(location_id)가 1700 인 사원들의 employee_id, last_name, department_id, salary 를 조회한다.
-- 사용할 테이블 (departments, employees)
select 
       e.employee_id
     , e.last_name
     , e.department_id
     , e.salary
  from employees e inner join departments d  -- employees테이블이 driving테이블, departments테이블이 driven테이블.
    on e.department_id = d.department_id -- 조인조건
 where d.location_id = 1700;  -- 일반조건
 
 
 select 
       e.employee_id
     , e.last_name
     , e.department_id
     , e.salary
  from employees e, departments d
 where e.deparment_id = d.department_id  -- 조인조건
   and d.location_id = 1700;  -- 일반조건
    


-- 2. 부서명(department_name)이 'Executive' 인 부서에 근무하는 모든 사원들의 department_id, last_name, job_id 를 조회한다.
-- 사용할 테이블 (departments, employees)
select
       e.department_id
     , e.last_name
     , e.job_id
  from employees e inner join departments d   -- employees테이블이 driving테이블, departments테이블이 driven테이블.
    on e.department_id = d.department_id      -- 조인 조건 (!인덱스가 없는 e.department_id를 기준으로 검색하므로 좋지 않다!)
 where d.department_name = 'Executive';


/* ↓ 이 방법이 더 좋음. 성능 면에서 [FROM절에서 작성 순서 주의!] */
select
       e.department_id
     , e.last_name
     , e.job_id
  from departments d inner join employees e   -- departments테이블이 driving테이블(먼저 실행하는 테이블.), employees테이블이 dirven테이블. 
    on e.department_id = d.department_id      -- 조건절의 등호(=)왼쪽은 PK 또는 인덱스를 가진 칼럼이 좋다.
 where d.department_name = 'Executive';       -- 여기서는 departments테이블을 먼저 실행해주는 것이 용이.
 -- driving테이블 => 성능에 영향을 끼칠 수 있다.
 
 
 
 select
       e.department_id
     , e.last_name
     , e.job_id
  from departments d, employees e
 where d.department_id = e.department_id
   and d.department_name = 'Executive';





-- 3. 기존의 직업(job_id)을 여전히 가지고 있는 사원들의 employee_id, job_id 를 조회한다.
-- 사용할 테이블 (employees, job_history)
select
       e.employee_id
     , e.job_id
  from employees e inner join job_history j
    on e.employee_id = j.employee_id  -- 조인 조건 
 where e.job_id = j.job_id;
 -- 일반 조건 : 기존의 직업을 여전히 가지고 있다. (employees테이블의 job_id(현재 job)와 job_history테이블의 job_id(과거 job)이 동일하다.)

select
       e.employee_id
     , e.job_id
  from employees e, job_history j
 where e.employee_id = j.employee_id  -- 조인 조건 
   and e.job_id = j.job_id;
   -- 일반 조건 : 기존의 직업을 여전히 가지고 있다. (employees테이블의 job_id(현재 job)와 job_history테이블의 job_id(과거 job)이 동일하다.)



-- 4. 각 부서별 사원수와 평균연봉을 department_name, location_id 와 함께 조회한다.
-- 평균연봉은 소수점 2 자리까지 반올림하여 표현하고, 각 부서별 사원수의 오름차순으로 조회한다.
-- 사용할 테이블 (departments, employees)
select 
       d.department_name
     , d.location_id                            -- [실행순서]
     , count(*) as 사원수                       -- 4
     , round(avg(salary), 2) as 평균연봉
      from departments d inner join employees e -- 1
    on d.department_id = e.department_id        -- 2
 group by d.department_name, d.location_id      -- 3
 order by 사원수;                               -- 5 (ORDER BY절은 SELECT절 이후에 처리되므로 별명을 사용할 수 있다.)



-- 5. 도시이름(city)이 T 로 시작하는 지역에서 근무하는 사원들의 employee_id, last_name, department_id, city 를 조회한다.
-- 사용할 테이블 (employees, departments, locations)
select
       e.employee_id
     , e.last_name
     , e.department_id
     , l.city
  from locations l , departments d, employees e
 where l.location_id = d.location_id 
   and d.department_id = e.department_id
   and l.city like 'T%';
   

select
       e.employee_id
     , e.last_name
     , e.department_id
     , l.city
  from locations l inner join departments d
    on l.location_id = d.location_id inner join employees e
    on d.department_id = e.department_id
 where l.city like 'T%';




-- 6. 자신의 상사(manager_id)의 고용일(hire_date)보다 빨리 입사한 사원을 찾아서 last_name, hire_date, manager_id 를 조회한다. 
-- 사용할 테이블 (employees)
-- manager_id 담당 테이블 : m
-- employee_id 담당 테이블 : e
-- 상사(manamer_id)의 고용일
-- 내 (employee_id)의 고용일
-- 조인 조건 : e.manager_id = d.employee_id
-- 일반 조건 : e.hire_date > m.hire_date
select
       e.last_name as 내이름
     , e.hire_date as 내입사일
     , m.last_name as 상사이름
     , m.hire_date as 상사입사일
     , e.manager_id
  from employees e join employees m
    on e.manager_id =  m.employee_id
 where e.hire_date < m.hire_date;




-- 7. 같은 소속부서(department_id)에서 나보다 늦게 입사(hire_date)하였으나 나보다 높은 연봉(salary)을 받는 사원이 존재하는 사원들의
-- department_id, full_name(first_name 과 last_name 사이에 공백을 포함하여 연결), salary, hire_date 를 full_name 순으로 정렬하여 조회한다.
-- 사용할 테이블 (employees)
-- 나 : me
-- 남 : you
select 
       me.department_id as 부서번호
     , me.first_name ||  ' ' || me.last_name as 내이름
     , me.salary as 내급여
     , you.first_name || ' ' || you.last_name as 너이름
     , you.salary as 너급여
  from employees me join employees you
    on me.department_id = you.department_id
 where me.hire_date < you.hire_date
   and me.salary < you.salary
 order by 부서번호, 내이름;
 
 
 select 
       me.department_id as 부서번호
     , me.first_name ||  ' ' || me.last_name as 내이름
     , me.salary as 내급여
     , you.first_name || ' ' || you.last_name as 너이름
     , you.salary as 너급여
  from employees me join employees you
    on me.department_id = you.department_id
 where me.hire_date < you.hire_date
   and me.salary < you.salary
 order by 부서번호, 내이름;




-- 8. 같은 소속부서(department_id)의 다른 사원보다 늦게 입사(hire_date)하였으나 현재 더 높은 연봉(salary)을 받는 사원들의
-- department_id, full_name(first_name 과 last_name 사이에 공백을 포함하여 연결), salary, hire_date 를 full_name 순으로 정렬하여 조회한다.
-- 사용할 테이블 (employees)
-- 나 : me
-- 남 : you
select
       me.department_id as 부서번호
     , me.first_name || ' ' || me.last_name as 내이름
     , me.salary as 내연봉
     , you.first_name || ' ' || you.last_name as 당신이름
     , you.salary as 당신연봉
  from employees me join employees you
    on me.department_id = me.department_id
 where me.hire_date > you.hire_date
   and me.salary > you.salary
 order by 부서번호, 내이름;



