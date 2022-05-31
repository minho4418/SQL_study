--트리거(trigger)
DROP TABLE test;
CREATE TABLE test(
code VARCHAR2(10) PRIMARY KEY,
username VARCHAR2(20),
age NUMBER(3)
);


select * from test;
--로그생성테이블(test테이블이 추가, 수정, 삭제 가 될때마다 기록)
create table test_log(
code varchar2(10),
jobgubun char(1), --1:추가, 2.수정, 3.삭제
chgdate date default sysdate
);

insert into test(code, username, age) values ('002', '박자바',30);
update test
set username = '홍사범',
age = 45
where code = '001';
delete from test 
where code = '002';

select * from test;
select * from test_log;
--트리거생성
--test테이블에 insert가 일어난 후에 자동실행
create or replace trigger tg_test_insert_after
after insert on test for each row
begin
    --test_log에 insert
    -- :new => 새로 삽일될 튜플의 값을 가리키는 지정자
    insert into test_log(code, jobgubun)
    values(:new.code, '1' ); --추가
end;

--test테이블에 update가 일어난 후에 자동실행
create or replace trigger tg_test_update_after
after update on test for each row
begin
    insert into test_log(code ,jobgubun)
    values(:new.code, '2'); --수정
end;

--test테이블에 delete가 일어난 후에 자동실행
create or  replace trigger tg_test_delete_after
after delete on test for each row
begin
    --:old => 기존값의 튜플을 가리키는 지정자
    insert into test_log(code ,jobgubun)
    values(:old.code, '3'); --삭제
end;






