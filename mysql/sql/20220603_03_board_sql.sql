select database();
use boarddb;
show tables;

#회원------------------------------------------------------------------------------
#추가(일반회원)
insert into member(email,passwd,username,zipcode,addrload,addrdetail,filename)
values('park@gmail.com', '1111', '박자바', '11111', '신림로','6층', 'a.png');

#추가(네이버간편가입)
INSERT INTO MEMBER(email,username,simplejoin)
VALUES('java@gmail.com', '박자바', '1');

#수정
update member
set 
passwd ='2222',
username='박보검',
zipcode='22222',
addrload='신림로',
addrdetail='르네상스 7층',
filename='b.png',
modidate=now()
where email = 'java@gmail.com';

#삭제
delete from member
where email = 'hong@gmail.com';

#한건조회--네이버 간편가입 여부 조회
select *  from member
where email = 'codingtreeksy@gmail.com';



#전체조회
select * from member
where username like concat('%', '성', '%');


#이메일 인증 수정
UPDATE member
SET emailauth = 1
WHERE email = 'park@gmail.com';

UPDATE member
SET simplejoin = 0
WHERE email = 'sysilove1014@naver.com';


SELECT * FROM member    WHERE email ='';


#게시물---------------------------------------------------------------------------------
#게시물 추가
INSERT INTO board(email,subject,content,ip)
VALUES ('codingtreeksy@gmail.com', '제목1', '내용1', '192.168.0.10');

#게시물 수정
UPDATE board
SET email ='',
subject = '',
content ='',
ip = '',
modidate = sysdate
WHERE bnum = 1;

#게시물 삭제
DELETE FROM board
WHERE bnum = 1;

#게시물 삭제필드 변경(y)
UPDATE board
SET removeyn = 'y'
WHERE bnum = 172;

#게시물 한건조회
SELECT  * FROM board
WHERE bnum = 80;

#게시물 리스트
SELECT  * FROM board
WHERE subject LIKE '%' || '게' ||'%'
OR content LIKE '%' || '게' ||'%';

#게시물 조회수+1
UPDATE board
SET readcnt = readcnt +1
WHERE bnum = 6;

#게시물 좋아요+1
UPDATE board
SET likecnt = likecnt +1
WHERE bnum = 1;


desc  board;
SELECT  * FROM board order by bnum desc;

#게시물 리스트
select * from board
WHERE removeyn = 'n'
and email like concat('%', 'coding', '%')
order by bnum desc
limit 0 , 2; #시작번호, 갯수

#전체게시물수
SELECT COUNT(*) totalCnt FROM board
WHERE email LIKE '%' || 'java' || '%';

-----------------------------------------------------------------------------------
#게시물 파일
#게시물 파일 추가
INSERT INTO boardfile(bfnum, bnum, filename)
VALUES(bf_seq.nextval, 1, 'a.png');
#게시물 파일 수정
UPDATE boardfile
SET filename = 'b.png'
WHERE bfnum = 1;

#게시물 파일 한건삭제
DELETE FROM boardfile
WHERE bfnum = 1;

#bnum의 파일들 삭제
DELETE FROM boardfile
WHERE bnum = 1;

--게시물 파일 한건조회
SELECT * FROM boardfile
WHERE bfnum = 1;
#게시물 파일 리스트
SELECT * FROM boardfile
WHERE bnum = 3;
---------------------------------------------------------------------------------------
#댓글추가
INSERT INTO reply(rnum, bnum ,email, content, ip, restep, relevel)
VALUES(r_seq.nextval,8, 'java@gmail.com', '댓글1','192.168.0.1', 1,1);

#댓글수정
UPDATE reply
SET content='댓글수정',
ip = '192.168.0.100',
modidate = sysdate
WHERE rnum = 2;

#글순서를 재수정(restep+1)
UPDATE reply
SET restep= restep+1
WHERE bnum = 169
AND restep >= 1;

#댓글삭제
DELETE FROM reply
WHERE rnum = 1;

#게시물한건의 모든 댓글 삭제
DELETE FROM reply
WHERE bnum = 1;

#댓글 한건 조회
SELECT * FROM reply
WHERE rnum = 1;

#댓글리스트(게시물의 댓글, restep: 순서)
SELECT * FROM reply
WHERE bnum = 10
ORDER BY restep;






