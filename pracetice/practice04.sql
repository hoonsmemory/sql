-- ����1.
-- ���� ��� �������� ���� ������ �޴� ������ �� ���̳� �ֽ��ϱ�?
select count(*) as '��� �������� ���� ���� �޴� ���� ��'
  from employees emp, salaries sal
 where emp.emp_no  = sal.emp_no
   and sal.to_date = '9999-01-01'
   and sal.salary > (select avg(sal2.salary)
                       from salaries sal2
					  where sal2.to_date = '9999-01-01');

-- ����2. 
-- ����, �� �μ����� �ְ��� �޿��� �޴� ����� ���, �̸�, �μ�, ������ ��ȸ�ϼ���. �� ��ȸ����� ������ ������������ ���ĵǾ� ��Ÿ���� �մϴ�. 
select emp.emp_no                                  as '���'
     , concat( emp.first_name, ' ', emp.last_name) as '�̸�'
     , max(sal.salary)                             as '����'
     , dept.dept_name                              as '�μ���'
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

-- ����3.
-- ����, �ڽ��� �μ� ��� �޿����� ����(salary)�� ���� ����� ���, �̸��� ������ ��ȸ�ϼ��� 
select emp.emp_no                                 as '���'
     , demp.dept_no                               as '���'
     , concat(emp.first_name, ' ', emp.last_name) as '�̸�'
     , sal.salary                                 as '����'
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
		
		
-- ����4.
-- ����, ������� ���, �̸�, �Ŵ��� �̸�, �μ� �̸����� ����� ������.
select emp.emp_no as '���'
     , concat(emp.first_name, ' ', emp.last_name) as '�̸�'
     , dept.dept_name as '�μ�'
     , mgr_t.mgrn as '�Ŵ���'
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
 
-- ����5.
-- ����, ��տ����� ���� ���� �μ��� ������� ���, �̸�, ��å, ������ ��ȸ�ϰ� ���� ������ ����ϼ���.
select emp.emp_no                                   as '���'
     , concat(emp.first_name, ' ', emp.last_name)   as '�̸�'
     , ttl.title                                    as '��å'
     , sal.salary                                   as '����'
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
   
-- ����6.
-- ��� ������ ���� ���� �μ���? 
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


-- ����7.
-- ��� ������ ���� ���� ��å?
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
  
-- ����8.
-- ���� �ڽ��� �Ŵ������� ���� ������ �ް� �ִ� ������?
-- �μ��̸�, ����̸�, ����, �Ŵ��� �̸�, �޴��� ���� ������ ����մϴ�.
select dept.dept_name                               as '�μ��̸�'
     , concat(emp.first_name, ' ', emp.last_name)   as '�̸�'
     , sal.salary                                   as '����'
     , mgrs_t.mgrnm                                 as '�Ŵ����̸�' 
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

   