--index
--속도의 향상을 위해서
--pk는 자동 index생성
--너무 많은 index는 속도 저하(insert, update, delete)
--고객을 조회시 속도향상을 위해서 index생성
CREATE INDEX cust_cust_name_ix
ON customer(cust_name);
--book테이블에 index를 생성한다면


SELECT *
FROM customer
WHERE cust_name = '이선희';
