--상품테이블(item)
--컬럼:itemcode(상품코드),itemname(상품명), price(단가), regidate(등록일),modidate(수정일)
--테이블삭제
DROP TABLE item;
--테이블생성
--PRIMARY KEY(기본키): 무결성을 위해서
--            데이터의 중복을 허용하지 않는다
--            null을 허용하지 않는다
CREATE TABLE item(
itemcode CHAR(4), --고정길이4
itemname VARCHAR2(50) NOT NULL , --가변길이50
price NUMBER(7) NOT NULL,
regidate DATE DEFAULT sysdate,
modidate DATE DEFAULT sysdate,
PRIMARY KEY(itemcode) --기본키(유일키)
);
--전체조회
SELECT * FROM item;
--한건조회(조건에 pk를 이용)
SELECT * FROM item WHERE itemcode = '8801';
--추가
INSERT INTO item (itemcode, itemname, price) VALUES('8801', '새우깡', 1000);
INSERT INTO item (itemcode, itemname, price) VALUES('8802', '감자깡', 1300);
INSERT INTO item (itemcode, itemname, price) VALUES('8803', '라면', 800);
--한건수정
UPDATE item
SET itemname = '삼양라면',
      price = 900,
      modidate = sysdate
WHERE itemcode = '8803'; --pk를 조건으로

--한건삭제
DELETE FROM item
WHERE itemcode = '8803'; --pk를 조건으로
