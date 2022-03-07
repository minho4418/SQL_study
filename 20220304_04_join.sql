--판매테이블(sales)
--컬럼: seq(순번(pk)), saledate(날짜), itemcode(상품코드), qty(판매수량), saleprice(판매금액)
DROP TABLE sales;
CREATE TABLE sales(
seq NUMBER(5),
saledate CHAR(10) NOT NULL , --2022-03-04
itemcode CHAR(4) NOT NULL,
qty NUMBER(3) NOT NULL,
saleprice NUMBER(10) NOT NULL,
PRIMARY KEY (seq),
--sales의 itemcode컬럼은 item테이블의 itemcode를 참조
--item테이블의 itemcode는 반드시 유니크해야한다
FOREIGN KEY(itemcode) REFERENCES item(itemcode) --참조키 -> 아이템테이블의 itemcode부분에 있는 값만 사용가능
);
-- 만들때는 부모(item) -> 자식(sales)
-- 지울때는 자식 -> 부모
-- 부모테이블 삭제 시 자식테이블이 존재하면 안된다.
--NOT NULL: 해당 칼럼이 NULL 값이 되면 안된다.
--DEFAULT "person": 명백하게 값이 입력되지 않으면 "person"을 값으로 정해준다.

drop table item cascade constraints; -- 제약조건 무시하고 삭제

drop sequence s_seq;
CREATE SEQUENCE s_seq; --게시물의 seq를 관리하기위해
SELECT s_seq.nextval FROM dual; --다음번호
SELECT s_seq.currval FROM dual; --현재번호

SELECT * FROM sales;
--추가
INSERT INTO sales (seq, saledate, itemcode, qty, saleprice)
VALUES(s_seq.nextval, '2022-03-04', '8801', 3, 3000 );

--조회
--INNER JOIN : 동등조인
SELECT s.saledate, s.itemcode, i.itemname, i.price, s.qty, s.saleprice
FROM sales s INNER JOIN item i on (s.itemcode = i.itemcode);

--수정
update sales
set itemcode = '8802',
    saledate = '2022-03-05',
    qty = 5,
    saleprice = 5000
where seq = 1;

--삭제
DELETE FROM sales;
WHERE seq = 1;

rollback; --취소
commit; -- 확정
SAVEPOINT save1; --롤백할 포인트 지정
rollback to savepoint save1;

--주말에 해보기
 --board테이블(자식)의 writer와 member테이블(부모) userid 관계
 --board테이블의 writer에 fk만들기

--조회
--userid, email, 제목, 내용

select * from board;
select * from member;
select * from board b join member m on (b.writer = m.userid);
select * from member m join board b on (b.writer = m.userid);

SELECT m.userid, m.email, b.subject, b.content
FROM board b INNER JOIN member m on (b.writer = m.userid)
where b.writer = 'java';

FROM board b INNER JOIN member m on (b.writer = m.userid)
where b.subject like '%인사%'
order by b.seq desc;

--조인 실습)
--1)COUNTRIES, REGIONS
--나라코드, 나라명, 대륙코드, 대륙명
select * from countries;
select * from regions;
select c.country_id,c.country_name,c.region_id,r.region_name 
from countries c join regions r on (c.region_id = r.region_id);

--2)COUNTRIES, LOCATIONS
--나라코드, 나라명, 위치아이디, 도시, 주소
select * from countries;
select * from locations;
select c.country_id,c.country_name,l.location_id,l.city,l.street_address 
from countries c join locations l on (c.country_id = l.country_id);
 
--3)세개의 테이블 조인
--REGIONS, COUNTRIES, LOCATIONS
--대륙코드, 대륙명, 나라코드, 나라명, 위치아이디, 도시, 주소
select * from regions;
select * from countries;
select * from locations;
select r.region_id, r.region_name,c.country_id,c.country_name,l.location_id,l.city,l.street_address 
from regions r join countries c on (r.region_id = c.region_id)
join locations l on (c.country_id = l.country_id)
where r.region_name = 'Asia';

--4)EMPLOYEES, JOBS
--사원아이디, 이메일, 직업아이디, 직업타이틀, 연봉
--조건: 연봉이 15000보다 큰 사원
select * from employees;
select * from jobs;
SELECT E.EMPLOYEE_ID, E.EMAIL,J.JOB_ID,J.JOB_TITLE,E.SALARY
FROM EMPLOYEES E JOIN JOBS J ON (E.JOB_ID = J.JOB_ID);

--5)EMPLOYEES
--사원아이디, 이름, 관리자아이디, 관리자명
--LEFT JOIN : 왼쪽테이블을 기준으로 조회\
select employee_id, first_name, manager_id from employees;
select e.employee_id, e.first_name, e.manager_id, m.first_name
from employees e left join employees m on (e.manager_id = m.employee_id)
order by e.employee_id;
-- nvl(e.manger_id,0) -> null이면 0으로 표시해라라는 뜻


select * from item;
select * from sales;
select * from item i left join sales s on (i.itemcode = s.itemcode);
--상품별로 판매수량, 판매합계
select i.itemname,s.qty, s.qty*S.SALEPRICE sum
from item i left join sales s on (i.itemcode = s.itemcode)
order by i.itemcode;
--날짜별로 판매수량, 판매합계
select i.itemname,s.saledate, nvl(s.qty,0), s.qty*S.SALEPRICE sum
from item i left join sales s on (i.itemcode = s.itemcode)
order by s.saledate;
--날짜별, 상품별로 판매수량, 판매합계