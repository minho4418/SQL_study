select user();
use boarddb;
show tables;

#테이블삭제(자식부터)
DROP TABLE boardfile;
DROP TABLE reply;
DROP TABLE board;
DROP TABLE member;
#테이블생성(부모부터)
CREATE TABLE member(
email VARCHAR(50), #이메일
passwd VARCHAR(60), #패스워드암호화(bcrypt)
username VARCHAR(20), #이름
zipcode CHAR(5), #우편번호
addrload VARCHAR(100), #도로명주소
addrdetail VARCHAR(100), #상세주소
filename VARCHAR(100), #프로필사진
emailauth CHAR(1) DEFAULT '0', #0:미인증, 1:인증
simplejoin CHAR(1) DEFAULT '0', #0:일반가입, 1:네이버, 2:카카오,3:구글
regidate datetime DEFAULT now(), #등록일자
modidate datetime DEFAULT now(), #수정일자
PRIMARY KEY (email)
);
CREATE TABLE board(
bnum int,
email VARCHAR(50),
subject VARCHAR(100),
content VARCHAR(1000),
readcnt int DEFAULT 0, #조회수
likecnt int DEFAULT 0, #좋아요
dislikecnt int DEFAULT 0, #싫어요
ip VARCHAR(50), #작성자의ip
regidate datetime DEFAULT now(), #작성일자
modidate datetime DEFAULT now(), #수정일자,
removeyn CHAR(1) DEFAULT 'n', #삭제여부(y/n) 
PRIMARY KEY (bnum)
);
CREATE TABLE boardfile(
bfnum int,
bnum int,
filename VARCHAR(50),
PRIMARY KEY(bfnum),
FOREIGN KEY (bnum) REFERENCES board(bnum)
);
CREATE TABLE reply(
rnum int, #댓글번호
bnum int, #게시물번호
email VARCHAR(50), #작성자
content VARCHAR(1000), #댓글의내용
ip VARCHAR(50), #작성자의ip
restep int, #글순서
relevel int, #글레벨
regidate datetime DEFAULT now(),
modidate datetime DEFAULT now(),
PRIMARY KEY(rnum),
FOREIGN KEY(bnum) REFERENCES board(bnum)
);

#fk생성
ALTER TABLE reply ADD FOREIGN KEY (email) REFERENCES MEMBER(email); #테이블의 구조 바꾸기
ALTER TABLE board ADD FOREIGN KEY (email) REFERENCES MEMBER(email); #테이블의 구조 바꾸기

select * from reply;
