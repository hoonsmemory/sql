-- ANSI JOIN 1999
-- 1. join ~ on
select a.emp_no, a.first_name, b.dept_name
  from employees a
  join dept_emp b
    on a.emp_no = b.emp_no
  join departments c
    on b.dept_no = c.dept_no;
    
-- 1. join ~ on
select a.first_name, b.title
  from employees a
  join titles b
    on a.emp_no = b.emp_no;

-- 2. natural join (테이블끼리 같은 이름이 있는 경우)
 select a.first_name, b.title
   from employees a
natural join titles b;

-- 2-1. natural join의 문제점
  select count(*)
    from salaries a
 natural join titles b;

-- 2-1. natural join의 문제점 => join ~ using 사용
  select *
    from salaries a
    join titles b using(emp_no);

-- ------------------------------------------------------------------------------------

select avg(salary), sum(salary)
  from salaries
 where emp_no='10060';

select emp_no, avg(salary) as avg_salary, sum(salary)
from salaries
where to_date='9999-01-01'
group by emp_no
having avg_salary > 40000
order by avg_salary  asc;

select avg(salary), sum(salary)
  from salaries
 where emp_no='10060';
 
-- ex1) 각 사원별로 평균 연봉 출력
select emp_no, avg(salary) as '평균 연봉'
from salaries
group by emp_no
order by avg(salary) desc;

-- [과제] 각 현재 Manager 직책 사원에 대한 평균 연봉은?
select b.title, avg(a.salary)
  from salaries a, titles b
 where 1 = 1  
   and a.emp_no  = b.emp_no
   and a.to_date = '9999-01-01'
   and b.to_date = a.to_date 
   and b.title   = 'Manager';
   
-- ex2) 사원별 몇 번의 직책 변경이 있었는지 조회
select emp_no, count(*)
from titles
group by emp_no
order by count(*) desc;

-- ex3) 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
select emp_no, avg(salary)
from salaries
group by emp_no
having avg(salary)>=50000;

-- [과제] 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.
select b.title, avg(a.salary)
  from salaries a, titles b
 where 1 = 1  
   and a.emp_no  = b.emp_no
   and a.to_date = '9999-01-01'
   and b.to_date = a.to_date
 group by b.title
having count(*) > 100
 order by avg(a.salary) desc;
   
-- [과제] 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요.
-- 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에 대해서 내림차순(DESC)로 정렬하세요.
select a.title, sum(b.salary)
  from titles a, salaries b
where 1 = 1
  and a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
  and a.title  != 'Engineer'
group by a.title
having sum(b.salary) > '2000000000'
order by sum(b.salary) desc;

-- 실습문제 1:  현재 회사 상황을 반영한 직원별 근무부서를  사번, 직원 전체이름, 근무부서 형태로 출력해 보세요.
select a.emp_no as '사번'
     , concat(a.first_name, ' ', a.last_name) as '전체이름'
     , c.dept_name as '근무부서'
  from employees a, dept_emp b, departments c
 where a.emp_no  = b.emp_no
   and b.dept_no = c.dept_no;

--  실습문제 2:  현재 회사에서 지급되고 있는 급여체계를 반영한 결과를 출력하세요. 사번,  전체이름, 연봉  이런 형태로 출력하세요.
select a.emp_no as '사번'
     , concat(a.first_name, ' ', a.last_name) as '전체이름'
     , b.salary as '연봉'
  from employees a, salaries b
 where a.emp_no  = b.emp_no
   and b.to_date = '9999-01-01'
 order by salary desc;






