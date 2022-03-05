--단축키 : 
--주석 : ctrl+/
--대소문자 변경 : alt + '
--SQL문은 대소문자 구별 하지 않는다 (키워드, 테이블명, 컬럼..)
--데이터는 대소문자 구별을 한다.
--SELECT 조회열... FROM 테이블명;
SELECT job_id,job_title,min_salary, max_salary FROM jobs;

SELECT * FROM jobs;

--WHERE 행의 조건 
SELECT * FROM jobs WHERE min_salary >= 10000;

SELECT * FROM jobs WHERE min_salary >5000 AND min_salary <10000;

--JOBS테이블에서 MAX_SALARY가 10000이상 17000이하 데이터의 
--JOB_ID와 MAX_SALARY를 조회
SELECT job_id, max_salary 
FROM jobs 
WHERE max_salary 
BETWEEN 10000  AND 17000;

--EMPLOYEES테이블에서 SALARY가 12000이상인 직원의 employee_id, first_name, salary 컬럼
--Sql문은 대소문자를 구별하지 않는다
SELECT employee_id, first_name, salary  -- 컬럼
FROM employees  --테이블
WHERE salary >= 12000 --조회 조건
ORDER BY salary desc; --정렬(asc(오름차순default), desc(내림차순))

--employees테이블에서 job_id가 IT_PROG 인 employee_id, hire_date, job_id
SELECT EMPLOYEE_ID, HIRE_DATE, JOB_ID 
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
ORDER BY EMPLOYEE_ID;

--employees테이블에서 employee_id, email, hire_date, salary
--2008년 1월1일 이후 입사 salary가 8000이하인 사원조회
--salary의 오름차순으로 정렬
SELECT EMPLOYEE_ID, EMAIL, to_char(hire_date, 'YYYY-MM-DD') HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE >= '08/01/01' AND SALARY <= 8000
ORDER BY SALARY;

--날짜포맷함수 : 날짜를 원하는 포맷 문자열로 변경
--cdate : 컬럼의 이름
SELECT to_char(sysdate, 'YYYY-MM-DD') cdate FROM dual;
--dual은 한행, 한컬럼을 담고 잇는 dummy 테이블로 함수 쓰임알고 싶을때 테이블 생성 안하고 값 리턴 받을 수 있다
 
--locations테이블에서 city가 southlake인 모든필드
select * from LOCATIONS
where city like '%South%'; --like 유사한거 뽑기 -> %뒤에붙이면 시작 양쪽에 붙이면 포함

--departments테이블에서 department_name에 IT가 포함된 행의
--department_id, department_name 필드 조회
select * from departments;
select department_id, department_name from departments
where department_name like '%IT%';

--집계함수
--count:데이터의 건수
select * from departments;
select COUNT(*) totcnt from DEPARTMENTS;

--sum:합계
select * from employees;
select count(*) totCnt, SUM(salary) totsalary, AVG(salary) savg,
        MAX(SALARY) smax, MIN(SALARY) sMIN
from employees
where job_id  = 'ST_CLERK';

--jobs테이블에서 min_salary가 9000미만인 직업의 수
select COUNT(*) tot from jobs
where MIN_SALARY < 9000;

--employees테이블에서 department_id가 60미만인 사원의 가장 큰 월급과 가장작은 월급을 조회
select * from employees;
select MIN(SALARY), max(salary) from employees
where department_id < 60;

--employees테이블에서 job_id가 IT가 포함된 사원중 가장먼저 입사한 일자
SELECT * FROM employees;
SELECT MIN(hire_date) FROM employees
WHERE job_id LIKE '%IT%';

--group by, having
SELECT job_id,SUM(salary) "Total" FROM employees
GROUP BY job_id
HAVING SUM(salary) > 20000; --그룹결과에 대한 조회조건(알리아스명 사용불가)

--from -> where -> select -> having -> group by -> order by

--실습1)
--EMPLOYEES테이블의 EMPLOYEE_ID의 200 이상인 사원의 모든 필드
--EMPLOYEE_ID 의 오름차순으로 정렬

select * from employees
where EMPLOYEE_ID >= 200
order by EMPLOYEE_ID;

--실습2)
--EMPLOYEES테이블의 EMPLOYEE_ID, MANAGER_ID 조회
--MANAGER_ID가 147 미만인 사원

select employee_id, manager_id from EMPLOYEES
where MANAGER_ID < 147;

--실습3)
--EMPLOYEES테이블의 MANAGER_ID가 147번 인 사원의 수

select COUNT(*) from employees
where manager_id = 147;

--실습4)
--EMPLOYEES테이블의 SALARY가 10000 이상 이거나 5000이하인 사원의 수

select COUNT(*) from EMPLOYEES
where salary >= 10000 or salary <= 5000;

--실습5)
--EMPLOYEES테이블에서  JOB_ID 별로 사원의 수 조회
--사원의 수의 내림차순으로 정력
select * from EMPLOYEES;
select job_id, COUNT(*) from EMPLOYEES
group by job_id;

--실습6)
--jobs테이블에서 앞두글자의 그룹으로 min_salary의 가장 작은 월급
select * from jobs;

select substr(JOB_ID,1,2) , min(min_salary) from jobs
group by substr(JOB_ID,1,2);
