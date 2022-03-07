--�����ǸŰ���
--��������
DROP TABLE customer;
CREATE TABLE customer(
cust_no VARCHAR2(10) NOT NULL,
cust_name VARCHAR2(20) NOT NULL,
cust_jumin CHAR(13) NOT NULL,
cust_addr VARCHAR2(50),
cust_telno VARCHAR2(11),
PRIMARY KEY(cust_no)
);
INSERT INTO customer (cust_no,cust_name,cust_jumin,cust_addr,cust_telno)
VALUES('c001', '�̼���', '7011117777777', '','');

--å������
DROP TABLE book;
CREATE TABLE book(
book_no VARCHAR2(10) NOT NULL,
book_name VARCHAR2(30) NOT NULL,
book_company VARCHAR2(50) NOT NULL,
book_price NUMBER(10) NOT NULL,
PRIMARY KEY(book_no)
);
INSERT INTO book (book_no,book_name,book_company,book_price)
VALUES('b001', '�ڹ����α׷���', '�������ǻ�', 15000);

--�Ǹ����̺�
DROP TABLE sales;
CREATE TABLE sales(
sale_no VARCHAR2(10) NOT NULL,
sale_date DATE NOT NULL,
cust_no VARCHAR2(10),
book_no VARCHAR2(10) NOT NULL,
sale_qty NUMBER(5) NOT NULL,
sale_amount NUMBER(10) NOT NULL,
PRIMARY KEY(sale_no),
FOREIGN KEY(cust_no) REFERENCES customer(cust_no),
FOREIGN KEY(book_no) REFERENCES book(book_no)
);
CREATE SEQUENCE s_sale_no;
INSERT INTO sales(sale_no,sale_date,cust_no,book_no,sale_qty,sale_amount)
VALUES(s_sale_no.nextval,sysdate, '', 'b001', 1, 15000);
INSERT INTO sales(sale_no,sale_date,cust_no,book_no,sale_qty,sale_amount)
VALUES(s_sale_no.nextval,sysdate, 'c001', 'b001', 1, 13500);
SELECT * FROM sales;
--���� ��ȸ
SELECT s.*, c.cust_name, b.book_name
FROM sales s LEFT JOIN customer c ON (s.cust_no = c.cust_no)
INNER JOIN book b ON(s.book_no = b.book_no);

--��(view):�������̺�
--���� : ������ �ڵ��� �ۼ� 
--         �Ϻ��÷��� ���� ���� ����(����)
CREATE OR REPLACE VIEW book_sales_view
AS
SELECT s.*, c.cust_name, b.book_name
FROM sales s LEFT JOIN customer c ON (s.cust_no = c.cust_no)
INNER JOIN book b ON(s.book_no = b.book_no);

SELECT * FROM book_sales_view
WHERE cust_no = 'c001';

SELECT * FROM book_sales_view
WHERE book_no = 'b001'
ORDER BY sale_date;

--���࿡ customer�� ������ ��ȸ �Ұ��Ϸ��� ���� ����
SELECT * FROM customer;

create view cust_view
as
select cust_no, cust_name, cust_jumin
from customer;

insert into cust_view values('c002', '����', '1111111111111');

--���� ��ȸ�� �ӵ������ ���ؼ� index����
CREATE INDEX cust_cust_name_ix
ON customer(cust_name);

--book���̺� index�� �����Ѵٸ�

SELECT *
FROM customer
WHERE cust_name = '�̼���';


