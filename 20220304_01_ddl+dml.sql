--ddl
--테이블삭제
DROP TABLE sample;
--테이블 생성
CREATE TABLE sample(
name VARCHAR2(20), --최대 20자리의 문자열
age NUMBER(3), --정수3자리
regidate DATE DEFAULT sysdate--현재시스템의 날짜를 자동 추가
);
DESC sample; --테이블의 구조 확인

--dml
--조회(select)
SELECT name, age, TO_CHAR(regidate, 'YYYY-MM-DD HH24:MI:SS') regidate
FROM sample;
--추가(insert문)
INSERT INTO sample(name, age, regidate) VALUES('홍길동',20,'2022-03-04');
INSERT INTO sample VALUES('현빈',39,'2022-03-03'); --테이블과 데이터가 일치할경우 필드 생략
INSERT INTO sample(name, age) VALUES('BTS',25);
INSERT INTO sample(name, age, regidate) VALUES('이선희',53, sysdate);

--수정(update문)
UPDATE sample
SET age = 40,
      regidate = sysdate
WHERE NAME ='홍길동';

--삭제(delete문)
DELETE FROM sample
WHERE NAME='BTS';

--실습)멤버테이블(member)
--컬럼: userid(아이디), passwd(비밀번호), email(이메일), birthyear(출생년도), 
--regidate(등록일:sysdate), modidate(수정일:sysdate)

--테이블삭제
DROP TABLE member;
--테이블생성
CREATE TABLE member(
userid VARCHAR2(20),
passwd VARCHAR2(30),
email VARCHAR2(50),
birthyear NUMBER(4),
regidate DATE DEFAULT sysdate,
modidate DATE DEFAULT sysdate
);
--전체조회
SELECT * FROM member;
--한건조회
SELECT * FROM member
WHERE userid = 'java';
--추가
INSERT INTO member(userid, passwd, email, birthyear)
VALUES('java', '1111', 'java@gmail.com', 2000);
--수정
UPDATE member 
SET passwd = '1234',
      email = 'java@naver.com',
      birthyear = 2001,
      modidate = sysdate
WHERE userid = 'java';
--삭제
DELETE FROM member
WHERE userid = 'java';

--트랜잭션을 관리하기 위한 DCL
ROLLBACK;--undo취소
COMMIT; --redo확정