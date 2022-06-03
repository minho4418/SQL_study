#현재 접속된 user
#root@localhost : root계정이 localhost에서만 접근
select user();
#null : 선택된 데이터 베이스가 없다
select database();
#사용할 db변경
use mysql;
#user에게 db(테이블 등의 권한 부여) 의 사용 허용

#db의 목록
show databases;
#선택된 db의 table목록
show tables;

#user의 정보
select * from user;

#1)db를 생성(root의 권한)
drop database boarddb;
create database boarddb;

#2)user생성(root의 권한)
# user명 : coding , % : 모든 ip에서 접근 가능
drop user 'board'@'%';
create user 'board'@'%' identified by '1111';

#3)user에게 db접속 할수있는 권한 부여(root의 권한)
grant all privileges on boarddb.* to 'board'@'%';
show grants for 'board'@'%';

