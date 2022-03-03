--����Ű : 
--�ּ� : ctrl+/
--��ҹ��� ���� : alt + '
--SQL���� ��ҹ��� ���� ���� �ʴ´� (Ű����, ���̺��, �÷�..)
--�����ʹ� ��ҹ��� ������ �Ѵ�.
--SELECT ��ȸ��... FROM ���̺��;
SELECT job_id,job_title,min_salary, max_salary FROM jobs;

SELECT * FROM jobs;

--WHERE ���� ���� 
SELECT * FROM jobs WHERE min_salary >= 10000;

SELECT * FROM jobs WHERE min_salary >5000 AND min_salary <10000;

--JOBS���̺��� MAX_SALARY�� 10000�̻� 17000���� �������� 
--JOB_ID�� MAX_SALARY�� ��ȸ
SELECT job_id, max_salary 
FROM jobs 
WHERE max_salary 
BETWEEN 10000  AND 17000;

--EMPLOYEES���̺��� SALARY�� 12000�̻��� ������ employee_id, first_name, salary �÷�
--Sql���� ��ҹ��ڸ� �������� �ʴ´�
SELECT employee_id, first_name, salary  -- �÷�
FROM employees  --���̺�
WHERE salary >= 12000 --��ȸ ����
ORDER BY salary desc; --����(asc(��������default), desc(��������))

--employees���̺��� job_id�� IT_PROG �� employee_id, hire_date, job_id
SELECT EMPLOYEE_ID, HIRE_DATE, JOB_ID 
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
ORDER BY EMPLOYEE_ID;

--employees���̺��� employee_id, email, hire_date, salary
--2008�� 1��1�� ���� �Ի� salary�� 8000������ �����ȸ
--salary�� ������������ ����
SELECT EMPLOYEE_ID, EMAIL, to_char(hire_date, 'YYYY-MM-DD') HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE >= '08/01/01' AND SALARY <= 8000
ORDER BY SALARY;

--��¥�����Լ� : ��¥�� ���ϴ� ���� ���ڿ��� ����
--cdate : �÷��� �̸�
SELECT to_char(sysdate, 'YYYY-MM-DD') cdate FROM dual;
--dual�� ����, ���÷��� ��� �մ� dummy ���̺�� �Լ� ���Ӿ˰� ������ ���̺� ���� ���ϰ� �� ���� ���� �� �ִ�

--locations���̺��� city�� southlake�� ����ʵ�
select * from LOCATIONS
where city like '%South%'; --like �����Ѱ� �̱� -> %�ڿ����̸� ���� ���ʿ� ���̸� ����

--departments���̺��� department_name�� IT�� ���Ե� ����
--department_id, department_name �ʵ� ��ȸ
select * from departments;
select department_id, department_name from departments
where department_name like '%IT%';

--�����Լ�
--count:�������� �Ǽ�
select * from departments;
select COUNT(*) totcnt from DEPARTMENTS;

--sum:�հ�
select * from employees;
select count(*) totCnt, SUM(salary) totsalary, AVG(salary) savg,
        MAX(SALARY) smax, MIN(SALARY) sMIN
from employees
where job_id  = 'ST_CLERK';

--jobs���̺��� min_salary�� 9000�̸��� ������ ��
select COUNT(*) tot from jobs
where MIN_SALARY < 9000;

--employees���̺��� department_id�� 60�̸��� ����� ���� ū ���ް� �������� ������ ��ȸ
select * from employees;
select MIN(SALARY), max(salary) from employees
where department_id < 60;

--employees���̺��� job_id�� IT�� ���Ե� ����� ������� �Ի��� ����
SELECT * FROM employees;
SELECT MIN(hire_date) FROM employees
WHERE job_id LIKE '%IT%';

--group by, having
SELECT job_id,SUM(salary) "Total" FROM employees
GROUP BY job_id
HAVING SUM(salary) > 20000; --�׷����� ���� ��ȸ����(�˸��ƽ��� ���Ұ�)

--from -> where -> select -> having -> group by -> order by

--�ǽ�1)
--EMPLOYEES���̺��� EMPLOYEE_ID�� 200 �̻��� ����� ��� �ʵ�
--EMPLOYEE_ID �� ������������ ����

select * from employees
where EMPLOYEE_ID >= 200
order by EMPLOYEE_ID;

--�ǽ�2)
--EMPLOYEES���̺��� EMPLOYEE_ID, MANAGER_ID ��ȸ
--MANAGER_ID�� 147 �̸��� ���

select employee_id, manager_id from EMPLOYEES
where MANAGER_ID < 147;

--�ǽ�3)
--EMPLOYEES���̺��� MANAGER_ID�� 147�� �� ����� ��

select COUNT(*) from employees
where manager_id = 147;

--�ǽ�4)
--EMPLOYEES���̺��� SALARY�� 10000 �̻� �̰ų� 5000������ ����� ��

select COUNT(*) from EMPLOYEES
where salary >= 10000 or salary <= 5000;

--�ǽ�5)
--EMPLOYEES���̺���  JOB_ID ���� ����� �� ��ȸ
--����� ���� ������������ ����
select * from EMPLOYEES;
select job_id, COUNT(*) from EMPLOYEES
group by job_id;

--�ǽ�6)
--jobs���̺��� �յα����� �׷����� min_salary�� ���� ���� ����
select * from jobs;

select substr(JOB_ID,1,2) , min(min_salary) from jobs
group by substr(JOB_ID,1,2);