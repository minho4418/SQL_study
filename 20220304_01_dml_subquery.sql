--서브쿼리(subquery)
--1)where절에 subquery
--employees테이블에서 평균월급보다 작은 사원을 조회
SELECT AVG(salary)
FROM employees;
--6461보다 salary가 작은 사원
SELECT *
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(salary)
                            FROM employees );

--jobs테이블에서 min_salary의 평균보다 작은 직업의 모든컬럼 조회
SELECT AVG(min_salary)
FROM jobs;

SELECT *
FROM jobs
WHERE min_salary < (SELECT AVG(min_salary)
                                    FROM jobs);

--2)select절에 subquery
--사원의 employee_id, salary, 가장큰월급, 가장작은월급
SELECT MAX(salary)
FROM employees;
SELECT MIN(salary)
FROM employees;

SELECT employee_id, salary, 
    (SELECT MAX(salary) FROM employees),
    (SELECT MIN(salary) FROM employees)
FROM employees;

--3)from절에 subquery
SELECT e.employee_id, e.salary, m.msalary
FROM employees e ,  (SELECT MAX(salary) msalary FROM employees) m;






