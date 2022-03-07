--�Ǹ����̺�(sales)
--�÷�: seq(����(pk)), saledate(��¥), itemcode(��ǰ�ڵ�), qty(�Ǹż���), saleprice(�Ǹűݾ�)
DROP TABLE sales;
CREATE TABLE sales(
seq NUMBER(5),
saledate CHAR(10) NOT NULL , --2022-03-04
itemcode CHAR(4) NOT NULL,
qty NUMBER(3) NOT NULL,
saleprice NUMBER(10) NOT NULL,
PRIMARY KEY (seq),
--sales�� itemcode�÷��� item���̺��� itemcode�� ����
--item���̺��� itemcode�� �ݵ�� ����ũ�ؾ��Ѵ�
FOREIGN KEY(itemcode) REFERENCES item(itemcode) --����Ű -> ���������̺��� itemcode�κп� �ִ� ���� ��밡��
);
-- ���鶧�� �θ�(item) -> �ڽ�(sales)
-- ���ﶧ�� �ڽ� -> �θ�
-- �θ����̺� ���� �� �ڽ����̺��� �����ϸ� �ȵȴ�.
--NOT NULL: �ش� Į���� NULL ���� �Ǹ� �ȵȴ�.
--DEFAULT "person": ����ϰ� ���� �Էµ��� ������ "person"�� ������ �����ش�.

drop table item cascade constraints; -- �������� �����ϰ� ����

drop sequence s_seq;
CREATE SEQUENCE s_seq; --�Խù��� seq�� �����ϱ�����
SELECT s_seq.nextval FROM dual; --������ȣ
SELECT s_seq.currval FROM dual; --�����ȣ

SELECT * FROM sales;
--�߰�
INSERT INTO sales (seq, saledate, itemcode, qty, saleprice)
VALUES(s_seq.nextval, '2022-03-04', '8801', 3, 3000 );

--��ȸ
--INNER JOIN : ��������
SELECT s.saledate, s.itemcode, i.itemname, i.price, s.qty, s.saleprice
FROM sales s INNER JOIN item i on (s.itemcode = i.itemcode);

--����
update sales
set itemcode = '8802',
    saledate = '2022-03-05',
    qty = 5,
    saleprice = 5000
where seq = 1;

--����
DELETE FROM sales;
WHERE seq = 1;

rollback; --���
commit; -- Ȯ��
SAVEPOINT save1; --�ѹ��� ����Ʈ ����
rollback to savepoint save1;

--�ָ��� �غ���
 --board���̺�(�ڽ�)�� writer�� member���̺�(�θ�) userid ����
 --board���̺��� writer�� fk�����

--��ȸ
--userid, email, ����, ����

select * from board;
select * from member;
select * from board b join member m on (b.writer = m.userid);
select * from member m join board b on (b.writer = m.userid);

SELECT m.userid, m.email, b.subject, b.content
FROM board b INNER JOIN member m on (b.writer = m.userid)
where b.writer = 'java';

FROM board b INNER JOIN member m on (b.writer = m.userid)
where b.subject like '%�λ�%'
order by b.seq desc;

--���� �ǽ�)
--1)COUNTRIES, REGIONS
--�����ڵ�, �����, ����ڵ�, �����
select * from countries;
select * from regions;
select c.country_id,c.country_name,c.region_id,r.region_name 
from countries c join regions r on (c.region_id = r.region_id);

--2)COUNTRIES, LOCATIONS
--�����ڵ�, �����, ��ġ���̵�, ����, �ּ�
select * from countries;
select * from locations;
select c.country_id,c.country_name,l.location_id,l.city,l.street_address 
from countries c join locations l on (c.country_id = l.country_id);
 
--3)������ ���̺� ����
--REGIONS, COUNTRIES, LOCATIONS
--����ڵ�, �����, �����ڵ�, �����, ��ġ���̵�, ����, �ּ�
select * from regions;
select * from countries;
select * from locations;
select r.region_id, r.region_name,c.country_id,c.country_name,l.location_id,l.city,l.street_address 
from regions r join countries c on (r.region_id = c.region_id)
join locations l on (c.country_id = l.country_id)
where r.region_name = 'Asia';

--4)EMPLOYEES, JOBS
--������̵�, �̸���, �������̵�, ����Ÿ��Ʋ, ����
--����: ������ 15000���� ū ���
select * from employees;
select * from jobs;
SELECT E.EMPLOYEE_ID, E.EMAIL,J.JOB_ID,J.JOB_TITLE,E.SALARY
FROM EMPLOYEES E JOIN JOBS J ON (E.JOB_ID = J.JOB_ID);

--5)EMPLOYEES
--������̵�, �̸�, �����ھ��̵�, �����ڸ�
--LEFT JOIN : �������̺��� �������� ��ȸ\
select employee_id, first_name, manager_id from employees;
select e.employee_id, e.first_name, e.manager_id, m.first_name
from employees e left join employees m on (e.manager_id = m.employee_id)
order by e.employee_id;
-- nvl(e.manger_id,0) -> null�̸� 0���� ǥ���ض��� ��


select * from item;
select * from sales;
select * from item i left join sales s on (i.itemcode = s.itemcode);
--��ǰ���� �Ǹż���, �Ǹ��հ�
select i.itemname,s.qty, s.qty*S.SALEPRICE sum
from item i left join sales s on (i.itemcode = s.itemcode)
order by i.itemcode;
--��¥���� �Ǹż���, �Ǹ��հ�
select i.itemname,s.saledate, nvl(s.qty,0), s.qty*S.SALEPRICE sum
from item i left join sales s on (i.itemcode = s.itemcode)
order by s.saledate;
--��¥��, ��ǰ���� �Ǹż���, �Ǹ��հ�