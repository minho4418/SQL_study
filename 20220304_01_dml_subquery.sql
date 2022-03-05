--��������(subquery)
--1)where���� subquery
--employees���̺��� ��տ��޺��� ���� ����� ��ȸ
SELECT AVG(salary)
FROM employees;
--6461���� salary�� ���� ���
SELECT *
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(salary)
                            FROM employees );

--jobs���̺��� min_salary�� ��պ��� ���� ������ ����÷� ��ȸ
SELECT AVG(min_salary)
FROM jobs;

SELECT *
FROM jobs
WHERE min_salary < (SELECT AVG(min_salary)
                                    FROM jobs);

--2)select���� subquery
--����� employee_id, salary, ����ū����, ������������
SELECT MAX(salary)
FROM employees;
SELECT MIN(salary)
FROM employees;

SELECT employee_id, salary, 
    (SELECT MAX(salary) FROM employees),
    (SELECT MIN(salary) FROM employees)
FROM employees;

--3)from���� subquery
SELECT e.employee_id, e.salary, m.msalary
FROM employees e ,  (SELECT MAX(salary) msalary FROM employees) m;






