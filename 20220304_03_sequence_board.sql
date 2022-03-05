--게시물테이블(board)
--컬럼: seq(pk,순번), writer(not null, 작성자),subject(not null, 제목),content(내용), 
--        regidate(default:sysdate,작성일시)

--테이블삭제
DROP TABLE board;
--테이블생성
CREATE TABLE board(
seq NUMBER(5),
writer VARCHAR2(20) NOT NULL,
subject VARCHAR2(100) NOT NULL,
content VARCHAR2(1000),
regidate DATE DEFAULT sysdate,
PRIMARY KEY(seq)
);

--전체조회
SELECT * FROM board;
--한건조회
SELECT * FROM board WHERE seq=1;

--가장큰 seq구하기
SELECT MAX(seq)+1 seq FROM board;
--추가
INSERT INTO board (seq, writer, subject, content)
VALUES (1, 'java', '가입인사', '만나서 반갑습니다.');

INSERT INTO board (seq, writer, subject, content)
VALUES ((SELECT MAX(seq)+1 FROM board), '이선희', '인사', '방가방가');
--시퀀스이용 추천
INSERT INTO board (seq, writer, subject, content)
VALUES (s_seq.nextval, '이문세', '아침인사', '방가방가');
--시퀀스 생성
DROP SEQUENCE s_seq;
CREATE SEQUENCE s_seq; --게시물의 seq를 관리하기위해
SELECT s_seq.nextval FROM dual; --다음번호
SELECT s_seq.currval FROM dual; --현재번호

--한건수정
UPDATE board
SET  writer = '현빈',
       subject = '인사',
       content = '방가'
WHERE seq = 1;

--한건삭제
DELETE FROM board
WHERE seq = 1;

ROLLBACK; --취소
COMMIT; --확정