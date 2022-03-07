--도서판매관리
--고객마스터
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
VALUES('c001', '이선희', '7011117777777', '','');

--책마스터
DROP TABLE book;
CREATE TABLE book(
book_no VARCHAR2(10) NOT NULL,
book_name VARCHAR2(30) NOT NULL,
book_company VARCHAR2(50) NOT NULL,
book_price NUMBER(10) NOT NULL,
PRIMARY KEY(book_no)
);
INSERT INTO book (book_no,book_name,book_company,book_price)
VALUES('b001', '자바프로그래밍', '이젠출판사', 15000);

--판매테이블
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
--조인 조회
SELECT s.*, c.cust_name, b.book_name
FROM sales s LEFT JOIN customer c ON (s.cust_no = c.cust_no)
INNER JOIN book b ON(s.book_no = b.book_no);

--뷰(view):가상테이블
--장점 : 간결한 코드의 작성 
--         일부컬럼에 대한 권한 삭제(보안)
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

--만약에 customer의 정보를 조회 불가하려면 권한 삭제
SELECT * FROM customer;

create view cust_view
as
select cust_no, cust_name, cust_jumin
from customer;

insert into cust_view values('c002', '현빈', '1111111111111');

--고객을 조회시 속도향상을 위해서 index생성
CREATE INDEX cust_cust_name_ix
ON customer(cust_name);

--book테이블에 index를 생성한다면

SELECT *
FROM customer
WHERE cust_name = '이선희';


