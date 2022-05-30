--프로시저 (procedure)
DROP TABLE test;
CREATE TABLE test(
code VARCHAR2(10) PRIMARY KEY,
username VARCHAR2(20),
age NUMBER(3)
);
select * from test;

--------------------------------------------------------------------
--프로시저 생성
--test테이블에 insert
--DROP PROCEDURE test_insert;
CREATE OR REPLACE PROCEDURE test_insert(
--매개변수
    pCode IN VARCHAR2,
    pUserName IN VARCHAR2,
    pAge IN NUMBER
)
IS
BEGIN
    --실행문
    INSERT INTO test(code, username, age) VALUES (pCode, pUserName,pAge);
END;
--프로시저 실행
EXEC test_insert('kim', '김철수', 35);

--------------------------------------------------------------------
--test 테이블에 update 프로시저
create or replace procedure test_update(
    --매개변수: 테이블의 type을적용
    pCode in test.code%type ,
    pUsername in test.username%type,
    pAge in test.age%type
)
is
begin
    update test
    set username = pUsername,
         age = pAge
    where code = pCode;
end;
EXEC test_update('java', '박자바', 30);

--------------------------------------------------------------------
--test테이블 삭제
create or replace procedure test_delete(
    pCode in test.code%type
)
is 
begin
    delete from test 
    where code = pCode;
end;
EXEC test_delete('hong');

--------------------------------------------------------------------
--test테이블의 한건조회 : code가 hong인 username, age반환
create or replace procedure test_select(
    pCode in test.code%type,
    rUserName out test.username%type,
    rAge out test.age%type
)
is
begin
    select username, age into rUserName, rAge
    from test
    where code = pCode;
end;

--실행할 익명 프로시저 
declare 
--선언과 초기화 
-- :=  대입연산자
    code test.code%type :=  'hong';
    username test.username%type;
    age test.age%type;
begin
    --실행문
    test_select(code, username, age);
    --출력
    dbms_output.put_line('코드:' || code);
    dbms_output.put_line('이름:' || username);
    dbms_output.put_line('나이:' || age);
end;
--콘솔창에 출력 설정 변경 =>ON
set serveroutput on;

--------------------------------------------------------------------
--전체 건수 조회
create or replace procedure test_count(
    cnt out number --건수를 반환
)
is 
begin
    select count(*) into cnt 
    from test;
end;

--프로시저 실행
declare
     cnt number;
begin
    test_count(cnt);
    dbms_output.put_line('건수:' || cnt);
end;

-----------------------------------------------------------
--데이타가 있으면 update, 없으면 insert
create or replace procedure test_insert_update(
    pCode in test.code%type,
    pUserName in test.username%type,
    pAge in test.age%type
)
is 
--변수
    cnt number;
begin
    --한건조회
    select count(*) into cnt
    from test
    where code = pCode;
    if cnt =0 then --데이터가 존재하지 않는다면
        INSERT INTO test(code, username, age) VALUES (pCode, pUserName,pAge);
    else  --데이터가 존재한다면
        update test
        set username = pUsername,
             age = pAge
        where code = pCode;
    end if;
end;

exec test_insert_update('park','박제비', 40);

----------------------------------------------------------------
--커서(cursor)만들기
--암시적커서(insert,update, delete, onerow)
begin
    delete from test 
    where code = 'hong';
    --sql%found : 삭제가 되었다
    --sql%notfound : 삭제가 되지 않았다
    if sql%found then
        dbms_output.put_line('데이터가 삭제되었다');
    else
        dbms_output.put_line('데이터가 미존재');
    end if;
end;

--sql%rowcount : 조회건수
--onerow 체크 , 데이터가 한건이 아닐경우 예외
declare
    rUserName test.username%type;
begin
    select username into rUserName
    from test
    where code = 'java';
    dbms_output.put_line('조회건수:' || sql%rowcount);
    exception
        when no_data_found then
            dbms_output.put_line('데이터가 존재하지 않습니다');
        when others then
            dbms_output.put_line('예외처리');
end;

--명시적 커서
--for 키워드를 이용해서 커서 생성
begin
    for test_cur in (
        select * from test
    )
    loop
        dbms_output.put_line(test_cur.code || ' ' || test_cur.username || ' ' || test_cur.age);
    end loop;
end;

--커서를 반환
create or replace procedure test_selectlist(
    test_cur out sys_refcursor
)
is 
begin
    open test_cur for
    select * from test;
end;

--반환되는 커서 테스트
--exec에서 변수명 바인딩 =>  :변수명
var test_cur refcursor; 
exec test_selectlist(:test_cur) ;
print test_cur;





