-- 메인 쿼리로 전달되는 행이 단 하나인 경우
-- 단일행 연산자를 사용한다.
-- 예제:  현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요. 
 SELECT  a.emp_no,       
	     concat( a.first_name, ' ', a.last_name) AS name, 	                 
		 b.dept_name  
   FROM  employees a,  departments b,  dept_emp c 
  WHERE  a.emp_no = c.emp_no  
	AND c.dept_no = b.dept_no  
	AND c.to_date = '9999-01-01'    
	AND c.dept_no = ( SELECT c.dept_no 
						FROM employees a, dept_emp c 
						WHERE a.emp_no = c.emp_no   
						AND c.to_date = '9999-01-01'    
						AND concat( a.first_name, ' ', a.last_name) = 'Fai Bale');
                     
                     
					
                    
-- 실습문제 1:   현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름, 급여를 나타내세요.
select concat( emp.first_name, ' ', emp.last_name) as '이름'
     , sal.salary                                  as '급여'
  from employees emp, salaries sal
 where emp.emp_no = sal.emp_no
   and sal.to_date = '9999-01-01'
   and sal.salary < (select avg(sal2.salary)
                       from salaries sal2
					  where sal2.to_date = '9999-01-01');
                      

-- 실습문제 2:   현재 가장적은 평균 급여를 받고 있는 직책에해서  평균 급여를 구하세요   

select ttl.title
     , round(avg(sal.salary)) as '현재 가장적은 평균 급여를 받고 있는 직책에해서  평균 급여'
  from salaries sal, titles ttl
 where 1 = 1
   and sal.emp_no  = ttl.emp_no
   and sal.to_date = '9999-01-01'
   and ttl.to_date = sal.to_date
 group by ttl.title
having round(avg(sal.salary)) = (select round(avg(sal.salary))
								   from salaries sal, titles ttl
								  where 1 = 1
								    and sal.emp_no  = ttl.emp_no
							 	   and sal.to_date = '9999-01-01'
							 	   and ttl.to_date = sal.to_date
								 group by ttl.title
								 order by avg(sal.salary)
								 limit 0, 1);


select min(sal.avg_salary)
  from(select round(avg(sal.salary))
		 from salaries sal, titles ttl
		where 1 = 1
		  and sal.emp_no  = ttl.emp_no
		  and sal.to_date = '9999-01-01'
		  and ttl.to_date = sal.to_date
		group by ttl.title) as avg_salary;
        

-- where 절인 경우
-- in, any, all, not in

-- any 사용법
-- 1. =any         : in과 완전동일
-- 2. >any, >=any  : 최소값
-- 3. <any, <=any  : 최대값
-- 4. <>any, !=any : != all과 동일

-- all 사용법
-- 1. =all         : in과 완전동일
-- 2. >all, >=all  : 최대값
-- 3. <all, <=all  : 최소값
-- 4. <>all, !=all : !=all과 동일

-- 현재 급여가 50000 이상인 직원 이름 출력

-- 방법1 : join으로 해결
select *
  from salaries sal, employees emp
 where emp.emp_no = sal.emp_no
   and sal.to_date = '9999-01-01'
   and sal.salary >= 50000;


-- 방법2 : in
select *
  from employees emp2 
 where emp2.emp_no in (select sal.emp_no
					    from salaries sal
					   where sal.to_date = '9999-01-01'
					     and sal.salary > 50000);
  
-- 방법3 : =any


-- 2) 각 부서별로 최고의 월급을 받는 지원의 이름과 월급 출력

select concat( emp.first_name, ' ', emp.last_name)
     , max(sal.salary)
  from dept_emp demp, employees emp, salaries sal
 where 1 = 1
   and emp.emp_no  = sal.emp_no
   and demp.emp_no = emp.emp_no
   and sal.to_date  = '9999-01-01'
   and demp.to_date = '9999-01-01'
   and (demp.dept_no, sal.salary) in (select dept2.dept_no , max(sal2.salary)
										  from departments dept2, dept_emp demp2, salaries sal2
										 where 1 = 1
										   and sal2.emp_no   = demp2.emp_no
										   and dept2.dept_no = demp2.dept_no
										   and sal2.to_date  = '9999-01-01'
                                           and demp2.to_date = '9999-01-01'
										 group by dept2.dept_name)
group by demp.dept_no
order by max(sal.salary) desc;
 

select dept.dept_no , max(sal.salary)
  from departments dept, dept_emp demp, salaries sal
 where 1 = 1
   and sal.emp_no   = demp.emp_no
   and dept.dept_no = demp.dept_no
   and sal.to_date  = '9999-01-01'
 group by dept.dept_name;
 
    
    select *
     from dept_emp
     where to_date = '9999-01-01';
  
    select *
     from salaries
     where to_date = '9999-01-01';
-- Bezalel Simmel



