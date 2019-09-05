-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(*) as '평균 연봉보다 많은 월급 받는 직원 수'
  from employees emp, salaries sal
 where emp.emp_no  = sal.emp_no
   and sal.to_date = '9999-01-01'
   and sal.salary > (select avg(sal2.salary)
                       from salaries sal2
					  where sal2.to_date = '9999-01-01');

-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select emp.emp_no                                  as '사번'
     , concat( emp.first_name, ' ', emp.last_name) as '이름'
     , max(sal.salary)                             as '연봉'
     , dept.dept_name                              as '부서명'
  from dept_emp demp, employees emp, salaries sal, departments dept
 where 1 = 1
   and emp.emp_no  = sal.emp_no
   and demp.emp_no = emp.emp_no
   and sal.to_date  = '9999-01-01'
   and demp.to_date = '9999-01-01'
   and dept.dept_no = demp.dept_no
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

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select emp.emp_no                                 as '사번'
     , demp.dept_no                               as '사번'
     , concat(emp.first_name, ' ', emp.last_name) as '이름'
     , sal.salary                                 as '연봉'
  from employees emp, salaries sal, dept_emp demp, (select dept2.dept_no    as fromno
														 , avg(sal2.salary) as avgs
													  from departments dept2, dept_emp demp2, salaries sal2
												     where 1 = 1
													   and sal2.emp_no   = demp2.emp_no
													   and dept2.dept_no = demp2.dept_no
													   and sal2.to_date  = '9999-01-01'
													   and demp2.to_date = '9999-01-01'
													 group by dept2.dept_name) as avg_t
 where 1 = 1
   and emp.emp_no   = sal.emp_no
   and demp.emp_no  = emp.emp_no
   and sal.to_date  = '9999-01-01'
   and demp.to_date = '9999-01-01'
   and sal.salary   > avg_t.avgs
   and demp.dept_no = avg_t.fromno;
		
		
-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select emp.emp_no as '사번'
     , concat(emp.first_name, ' ', emp.last_name) as '이름'
     , dept.dept_name as '부서'
     , mgr_t.mgrn as '매니저'
 from employees emp, dept_emp demp, departments dept ,(select dept2.dept_no as mgrdno
                                                            , concat(emp2.first_name, ' ', emp2.last_name) as mgrn
														 from employees emp2, dept_manager dmgr2, departments dept2
														where emp2.emp_no   = dmgr2.emp_no
														  and dmgr2.dept_no = dept2.dept_no
														  and dmgr2.to_date = '9999-01-01'
														group by dept2.dept_no) as mgr_t
 where emp.emp_no   = demp.emp_no
   and demp.dept_no = dept.dept_no
   and dept.dept_no = mgr_t.mgrdno
   and demp.to_date = '9999-01-01'
 order by emp.emp_no;
 
-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select emp.emp_no                                   as '사번'
     , concat(emp.first_name, ' ', emp.last_name)   as '이름'
     , ttl.title                                    as '직책'
     , sal.salary                                   as '연봉'
  from employees emp, titles ttl, salaries sal, dept_emp demp
 where 1 = 1
   and emp.emp_no   = ttl.emp_no 
   and sal.emp_no   = emp.emp_no
   and demp.emp_no  = emp.emp_no
   and sal.to_date  = '9999-01-01'
   and ttl.to_date  = '9999-01-01'
   and demp.to_date = '9999-01-01'
   and demp.dept_no = (select dept2.dept_no    as fromno
						 from departments dept2, dept_emp demp2, salaries sal2
						where 1 = 1
						  and sal2.emp_no   = demp2.emp_no
						  and dept2.dept_no = demp2.dept_no
						  and sal2.to_date  = '9999-01-01'
						  and demp2.to_date = '9999-01-01'
						group by dept2.dept_name
						order by avg(sal2.salary) desc
						limit 0, 1)
order by sal.salary desc;
   
-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
select dept.dept_name
  from departments dept
  where dept.dept_no = (select dept2.dept_no    as fromno
						  from departments dept2, dept_emp demp2, salaries sal2
						 where 1 = 1
						   and sal2.emp_no   = demp2.emp_no
						   and dept2.dept_no = demp2.dept_no
						   and sal2.to_date  = '9999-01-01'
						   and demp2.to_date = '9999-01-01'
						 group by dept2.dept_no
						 order by avg(sal2.salary) desc
						 limit 0, 1);


-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select distinct(ttl.title)
  from titles ttl
 where title =  (select ttl2.title
				   from employees emp2, salaries sal2, titles ttl2
				  where 1 = 1
				    and emp2.emp_no = sal2.emp_no
				    and ttl2.emp_no = emp2.emp_no 
				    and sal2.to_date = '9999-01-01'
				    and ttl2.to_date = '9999-01-01'
				  group by ttl2.title
				  order by avg(sal2.salary) desc
				  limit 0, 1);
  
-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select dept.dept_name                               as '부서이름'
     , concat(emp.first_name, ' ', emp.last_name)   as '이름'
     , sal.salary                                   as '연봉'
     , mgrs_t.mgrnm                                 as '매니저이름' 
  from departments dept, dept_emp demp, employees emp, salaries sal, (select dmgr2.dept_no as 'mgrdno'
                                                                           , concat(emp2.first_name, ' ', emp2.last_name)   as 'mgrnm' 
																		   , sal2.salary   as 'mgrs'
																	   from employees emp2, salaries sal2, dept_manager dmgr2
																	  where 1 = 1
																		and emp2.emp_no   = sal2.emp_no
																		and dmgr2.emp_no  = emp2.emp_no
																		and sal2.to_date  = '9999-01-01'
																		and dmgr2.to_date = '9999-01-01'
																	  group by emp2.emp_no) as mgrs_t
 where 1 = 1
   and emp.emp_no   = sal.emp_no
   and demp.emp_no  = emp.emp_no
   and dept.dept_no = demp.dept_no
   and sal.to_date  = '9999-01-01'
   and demp.to_date = '9999-01-01'
   and sal.salary   > mgrs_t.mgrs
   and dept.dept_no = mgrs_t.mgrdno
   order by emp.emp_no;

   