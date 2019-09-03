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

















