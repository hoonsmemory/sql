-- select 기본
-- employees 테이블에서 직원의 이름,  성별, 입사일을 출력
select first_name
     , last_name
     , gender
     , hire_date
  from employees;

-- concat
-- employees 테이블에서 직원의 전체이름,  성별, 입사일을 출력
select concat (first_name, ' ', last_name) 
     , gender
     , hire_date
  from employees;

-- alias -> as
-- 생략 가능
-- employees 테이블에서 직원의 이름,  성별, 입사일을 출력
select concat (first_name, ' ', last_name) as 이름
     , gender as 성별
     ,  hire_date as '입사 날짜'
  from employees;

-- 중복 제거 distinct()
-- select title from titles;
select distinct(title) from titles;
  
-- order by
-- employees 테이블에서 직원의 전체이름,  성별, 입사일을  입사일 순으로 출력
select concat (first_name, ' ', last_name) as 이름
     , gender as 성별
     ,  hire_date as '입사 날짜'
  from employees
 order by hire_date desc;
 
 -- salaries 테이블에서 2001년 월급을 가장 높은순으로 사번,  월급순으로 출력
  SELECT emp_no,salary
	FROM salaries
   WHERE from_date like '2001-%' 
ORDER BY salary DESC;

-- employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력

  SELECT concat( first_name, ' ', last_name ) AS 이름
       , gender AS 성별
       , hire_date AS 입사일
    FROM employees
   WHERE hire_date < '1991-01-01'     
   order by hire_date desc;

-- employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일을 출력
  SELECT concat( first_name, ' ', last_name ) AS 이름
       , gender AS 성별
       , hire_date AS 입사일
    FROM employees
   WHERE gender='f'
     AND hire_date < '1989-01-01'
   order by hire_date desc;

-- dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의 사번, 부서번호 출력
 SELECT emp_no, dept_no    
   FROM dept_emp
  WHERE dept_no in( 'd005', 'd009' );
  
-- like 검색
-- employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력
 SELECT concat( first_name, ' ', last_name ) AS 이름,
         hire_date AS 입사일
    FROM employees
   WHERE hire_date <= '1989-12-31'
	 and hire_date >= '1989-01-01'
   order by hire_date desc;

   -- upper
-- 1.자바 upperCase보다 DB의 uppper() 함수가 훨씬 빠르다.
-- 2.웬만한 DB에서 문자열 처리뿐만 아니라 포맷팅 처리등을 다 해주고 
-- 자바에서는 화면 출력만 해결한다.
-- 3. 자바 코드가 간결해서 좋다.

select upper('Seoul'), lcase('seoul');
select upper(first_name) from employees;

-- lower
select lower('Seoul'), lower('SEOUL');

-- substring
select substring('Happy Day',3,2) as substr;

select first_name, substring(hire_date,1, 4) as '입사년도'
  from employees;

-- lpad, rpad
select lpad('1234', 10, '-'), rpad('1234', 10, '-');

-- salaries 테이블에서 2001년 급여가 70000불 이하의 직원만 사번, 급여로 출력하되 급여는 10자리로 부족한 자리수는 *로 표시
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


 