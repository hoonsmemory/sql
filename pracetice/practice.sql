-- practice01

-- ����1
-- ����� 10944�� ����� �̸���(��ü �̸�)
select concat( first_name, ' ', last_name ) AS '��ü �̸�'
  from employees 
 where emp_no = 10944;

-- ����2
-- ��ü������ ���� ������ ��ȸ�ϼ���. ���� ���Ӻ��� ����� �ǵ��� �ϼ���. 
-- ����� �̸�, ����,  �Ի��� �����̰� ���̸���, ��������, ���Ի��Ϸ� �÷� �̸��� ��ü�� ������.
 select concat( emp.first_name, ' ', emp.last_name ) AS '��ü �̸�'
	  , emp.gender                                   AS '����'
      , emp.hire_date                                AS '�Ի���'
   from employees emp
      , titles    ttl
  where emp.emp_no  = ttl.emp_no
    and ttl.to_date = '9999-01-01' 
  order by emp.hire_date asc;

-- ����3
-- �������� �������� �� �� �� ���̳� �ֳ���?
-- select (select count(emp1.gender)
--           from employees emp1
--		  where gender = 'F'
--            and emp1.gender = emp3.gender) as '���� ��'
--	  , (select count(emp2.gender)
--           from employees emp2
--		  where gender = 'M'
--           and emp2.gender = emp3.gender) as '���� ��'
--   from employees emp3
--  group by gender;

 select emp2.gender as '����'
	  , (select count(*)
           from employees emp1
		  where emp1.gender = emp2.gender)as '���ο�'
   from employees emp2 
  group by gender;
  
-- ����4
-- ���� �ٹ��ϰ� �ִ� ���� ���� �� ���Դϱ�? (salaries ���̺��� ����մϴ�.) 
select count(distinct(emp_no)) as '���� �ٹ��ϰ� �ִ� ���� ��'
  from salaries;

-- ����5
-- �μ��� �� �� ���� �ֳ���?
select count(dept_no) as '�μ� �� ����'
  from departments;

-- ����6
-- ���� �μ� �Ŵ����� �� ���̳� �ֳ���?(���� �ų����� ����)
select count(distinct(emp_no)) as '���� �μ� �Ŵ���'
  from dept_manager
 where to_date = '9999-01-01';
  
-- ����7
-- ��ü �μ��� ����Ϸ��� �մϴ�. ������ �μ��̸��� �� ������� ����� ������.
select *
  from departments
 order by length(dept_name) desc;
  
-- ����8
-- ���� �޿��� 120,000�̻� �޴� ����� �� ���̳� �ֽ��ϱ�?
select count(sal.emp_no) as '���� �޿��� 120,000�̻� �޴� ����� ��'
  from salaries sal
 where sal.emp_no
   and sal.salary >= 120000
   and sal.to_date = '9999-01-01';

-- ����9
-- � ��å���� �ֳ���? �ߺ� ���� �̸��� �� ������� ����� ������.
select distinct(title) as '��å'
  from titles
 order by length(title) desc;

-- ����10
-- ���� Engineer ��å�� ����� �� �� ���Դϱ�?
select count(emp_no) as '��å�� �����'
  from titles
 where title = 'Engineer'
   and to_date = '9999-01-01';

-- ����11
-- ����� 13250(Zeydy)�� ������ ��å ���� ��Ȳ�� �ð������� ����غ�����.
select *
  from titles
 where emp_no = 13250
 order by from_date;

