-- 테이블간 조인(JOIN) SQL 문제입니다.

-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.

select emp.emp_no                                 as '사번'
     , concat(emp.first_name, ' ', emp.last_name) as '전체이름'
     , sal.salary                                 as '연봉'
  from employees emp, salaries sal
 where emp.emp_no  = sal.emp_no
   and sal.to_date = '9999-01-01'
 order by sal.salary desc;


-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.

select emp.emp_no                                 as '사번'
     , concat(emp.first_name, ' ', emp.last_name) as '전체이름'
     , ttl.title                                  as '직책'
  from employees emp, titles ttl
 where 1 = 1
   and ttl.emp_no   = emp.emp_no
   and ttl.to_date  = '9999-01-01';
   
-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..

select emp.emp_no                                 as '사번'
     , concat(emp.first_name, ' ', emp.last_name) as '전체이름'
     , dept.dept_name                             as '부서'
  from employees emp, departments dept, dept_emp demp
 where 1 = 1
   and emp.emp_no   = demp.emp_no
   and dept.dept_no = demp.dept_no
   and demp.to_date  = '9999-01-01';

   
-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.

select emp.emp_no                                 as '사번'
     , concat(emp.first_name, ' ', emp.last_name) as '전체이름'
     , sal.salary                                 as '연봉'
     , ttl.title                                  as '직책'
     , dept.dept_name                             as '부서'
  from employees emp, salaries sal, titles ttl, departments dept, dept_emp demp
 where 1 = 1
   and emp.emp_no   = sal.emp_no
   and ttl.emp_no   = emp.emp_no
   and demp.emp_no  = emp.emp_no
   and dept.dept_no = demp.dept_no
   and ttl.to_date  = '9999-01-01'
   and demp.to_date = ttl.to_date
   and sal.to_date  = ttl.to_date;
-- order by emp.emp_no;
   
   
-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. 
-- (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.

select emp.emp_no                                 as '사번'
     , concat(emp.first_name, ' ', emp.last_name) as '전체이름'
     , ttl.to_date
  from titles ttl, employees emp
 where 1 = 1
   and ttl.emp_no = emp.emp_no
   and ttl.title  = 'Technique Leader'
   and ttl.to_date != '9999-01-01';

-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.

select concat(emp.first_name, ' ', emp.last_name) as '전체이름'
     , dept.dept_name                             as '부서명'
     , ttl.title                                  as '직책'
  from employees emp, departments dept, titles ttl, dept_emp demp
 where 1 = 1
   and emp.emp_no   = ttl.emp_no
   and demp.emp_no  = emp.emp_no
   and dept.dept_no = demp.dept_no
   and ttl.to_date  = '9999-01-01'
   and demp.to_date = ttl.to_date
   and emp.last_name like 'S%';
   
-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.

select ttl.emp_no as '사번'
     , sal.salary as '급여'
  from titles ttl, salaries sal
 where 1 = 1
   and ttl.emp_no  = sal.emp_no 
   and ttl.title   = 'Engineer'
   and sal.salary >= '40000'
   and sal.to_date = '9999-01-01'
   and ttl.to_date = sal.to_date
 order by sal.salary desc;
 
 select *
   from employees
   where first_name = 'Zvonko'
     and last_name  = 'Yoshizawa';
 
-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
-- 급여 50000 넘는 사람의 직책, 급여..
select ttl.title  as '직책'
	 , sal.salary as '급여'
  from salaries sal, titles ttl
 where 1 = 1
   and sal.emp_no = ttl.emp_no
   and sal.salary > '50000'
   and sal.to_date = '9999-01-01'
   and ttl.to_date = sal.to_date
   order by sal.salary desc;
 
-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.

select dept.dept_name   as '부서명'
     , avg(sal.salary) as '평균연봉' 
  from salaries sal, departments dept, employees emp, dept_emp demp
 where 1 = 1  
   and emp.emp_no   = sal.emp_no
   and emp.emp_no   = demp.emp_no
   and demp.dept_no = dept.dept_no
   and sal.to_date  = '9999-01-01'
   and demp.to_date = sal.to_date
 group by dept.dept_name
 order by avg(sal.salary) desc;
 
-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.

select ttl.title       as '직책'
     , avg(sal.salary) as '연봉'
  from salaries sal, titles ttl
 where 1 = 1  
   and sal.emp_no  = ttl.emp_no
   and sal.to_date = '9999-01-01'
   and ttl.to_date = sal.to_date
 group by ttl.title
 order by avg(sal.salary) desc; 
