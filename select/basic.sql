-- select �⺻
-- employees ���̺��� ������ �̸�,  ����, �Ի����� ���
select first_name
     , last_name
     , gender
     , hire_date
  from employees;

-- concat
-- employees ���̺��� ������ ��ü�̸�,  ����, �Ի����� ���
select concat (first_name, ' ', last_name) 
     , gender
     , hire_date
  from employees;

-- alias -> as
-- ���� ����
-- employees ���̺��� ������ �̸�,  ����, �Ի����� ���
select concat (first_name, ' ', last_name) as �̸�
     , gender as ����
     ,  hire_date as '�Ի� ��¥'
  from employees;

-- �ߺ� ���� distinct()
-- select title from titles;
select distinct(title) from titles;
  
-- order by
-- employees ���̺��� ������ ��ü�̸�,  ����, �Ի�����  �Ի��� ������ ���
select concat (first_name, ' ', last_name) as �̸�
     , gender as ����
     ,  hire_date as '�Ի� ��¥'
  from employees
 order by hire_date desc;
 
 -- salaries ���̺��� 2001�� ������ ���� ���������� ���,  ���޼����� ���
  SELECT emp_no,salary
	FROM salaries
   WHERE from_date like '2001-%' 
ORDER BY salary DESC;

-- employees ���̺��� 1991�� ������ �Ի��� ������ �̸�, ����, �Ի����� ���

  SELECT concat( first_name, ' ', last_name ) AS �̸�
       , gender AS ����
       , hire_date AS �Ի���
    FROM employees
   WHERE hire_date < '1991-01-01'     
   order by hire_date desc;

-- employees ���̺��� 1989�� ������ �Ի��� �������� �̸�, �Ի����� ���
  SELECT concat( first_name, ' ', last_name ) AS �̸�
       , gender AS ����
       , hire_date AS �Ի���
    FROM employees
   WHERE gender='f'
     AND hire_date < '1989-01-01'
   order by hire_date desc;

-- dept_emp ���̺��� �μ� ��ȣ�� d005�� d009�� ���� ����� ���, �μ���ȣ ���
 SELECT emp_no, dept_no    
   FROM dept_emp
  WHERE dept_no in( 'd005', 'd009' );
  
-- like �˻�
-- employees ���̺��� 1989�⿡ �Ի��� ������ �̸�, �Ի����� ���
 SELECT concat( first_name, ' ', last_name ) AS �̸�,
         hire_date AS �Ի���
    FROM employees
   WHERE hire_date <= '1989-12-31'
	 and hire_date >= '1989-01-01'
   order by hire_date desc;

   -- upper
-- 1.�ڹ� upperCase���� DB�� uppper() �Լ��� �ξ� ������.
-- 2.������ DB���� ���ڿ� ó���Ӹ� �ƴ϶� ������ ó������ �� ���ְ� 
-- �ڹٿ����� ȭ�� ��¸� �ذ��Ѵ�.
-- 3. �ڹ� �ڵ尡 �����ؼ� ����.

select upper('Seoul'), lcase('seoul');
select upper(first_name) from employees;

-- lower
select lower('Seoul'), lower('SEOUL');

-- substring
select substring('Happy Day',3,2) as substr;

select first_name, substring(hire_date,1, 4) as '�Ի�⵵'
  from employees;

-- lpad, rpad
select lpad('1234', 10, '-'), rpad('1234', 10, '-');

-- salaries ���̺��� 2001�� �޿��� 70000�� ������ ������ ���, �޿��� ����ϵ� �޿��� 10�ڸ��� ������ �ڸ����� *�� ǥ��
select emp_no 
     , lpad(salary, 10, '*') as salary
  from salaries
 where from_date like '2001%'
   and salary < 70000;   

-- ltrim, rtrim, trim
select concat('--------',ltrim('     h e l l o    '), '---') as ltrim
     , concat('--------',rtrim('     h e l l o    '), '---') as rtrim
     , concat('--------',trim('     h e l l o     '), '---') as trim
     , concat('--------',trim(both 'x' from 'xxxxxxh e l l oxxxxxx'), '---') as trim2
     , concat('--------',trim(leading 'x' from 'xxxxxxh e l l oxxxxxx'), '---') as trim3
     , concat('--------',trim(trailing 'x' from 'xxxxxxh e l l oxxxxxx'), '---') as trim4;


 