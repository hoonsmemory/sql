-- join
select * from employee;
select * from department;

-- 1. 데이터 넣기
insert into department values(null, '총무팀');
insert into department values(null, '인사팀');
insert into department values(null, '영업팀');
insert into department values(null, '개발팀');

insert into employee values(null, '둘리', '1');
insert into employee values(null, '마이콜', '2');
insert into employee values(null, '또치', '3');
insert into employee values(null, '진국', null);


-- 1. 조심 : cartesian product( M X N)
select *
  from employee, department;
  
-- 2. equijoin
select emp.no, emp.name, dept.name
  from employee emp, department dept
 where emp.department_no = dept.no;
  
-- 3. join ~ on(ANSI sql 1999)
select emp.no, emp.name, ifnull(dept.name, '사장님')
  from employee emp
  left join department dept
    on emp.department_no = dept.no;
    
-- 4. right join
select emp.no, ifnull(emp.name, '채용요망'), dept.name
  from employee emp
 right join department dept
    on emp.department_no = dept.no; 
  
-- 5.full join  
-- mysql / mariadb 지원안함
-- select emp.no, ifnull(emp.name, '채용요망'), dept.name
--   from employee emp
--   full join department dept
--     on emp.department_no = dept.no;  

-- 6. natual join
select *
  from employee;


  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  