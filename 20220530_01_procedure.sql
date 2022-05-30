--���ν��� (procedure)
DROP TABLE test;
CREATE TABLE test(
code VARCHAR2(10) PRIMARY KEY,
username VARCHAR2(20),
age NUMBER(3)
);
select * from test;

--------------------------------------------------------------------
--���ν��� ����
--test���̺� insert
--DROP PROCEDURE test_insert;
CREATE OR REPLACE PROCEDURE test_insert(
--�Ű�����
    pCode IN VARCHAR2,
    pUserName IN VARCHAR2,
    pAge IN NUMBER
)
IS
BEGIN
    --���๮
    INSERT INTO test(code, username, age) VALUES (pCode, pUserName,pAge);
END;
--���ν��� ����
EXEC test_insert('kim', '��ö��', 35);

--------------------------------------------------------------------
--test ���̺� update ���ν���
create or replace procedure test_update(
    --�Ű�����: ���̺��� type������
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
EXEC test_update('java', '���ڹ�', 30);

--------------------------------------------------------------------
--test���̺� ����
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
--test���̺��� �Ѱ���ȸ : code�� hong�� username, age��ȯ
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

--������ �͸� ���ν��� 
declare 
--����� �ʱ�ȭ 
-- :=  ���Կ�����
    code test.code%type :=  'hong';
    username test.username%type;
    age test.age%type;
begin
    --���๮
    test_select(code, username, age);
    --���
    dbms_output.put_line('�ڵ�:' || code);
    dbms_output.put_line('�̸�:' || username);
    dbms_output.put_line('����:' || age);
end;
--�ܼ�â�� ��� ���� ���� =>ON
set serveroutput on;

--------------------------------------------------------------------
--��ü �Ǽ� ��ȸ
create or replace procedure test_count(
    cnt out number --�Ǽ��� ��ȯ
)
is 
begin
    select count(*) into cnt 
    from test;
end;

--���ν��� ����
declare
     cnt number;
begin
    test_count(cnt);
    dbms_output.put_line('�Ǽ�:' || cnt);
end;

-----------------------------------------------------------
--����Ÿ�� ������ update, ������ insert
create or replace procedure test_insert_update(
    pCode in test.code%type,
    pUserName in test.username%type,
    pAge in test.age%type
)
is 
--����
    cnt number;
begin
    --�Ѱ���ȸ
    select count(*) into cnt
    from test
    where code = pCode;
    if cnt =0 then --�����Ͱ� �������� �ʴ´ٸ�
        INSERT INTO test(code, username, age) VALUES (pCode, pUserName,pAge);
    else  --�����Ͱ� �����Ѵٸ�
        update test
        set username = pUsername,
             age = pAge
        where code = pCode;
    end if;
end;

exec test_insert_update('park','������', 40);

----------------------------------------------------------------
--Ŀ��(cursor)�����
--�Ͻ���Ŀ��(insert,update, delete, onerow)
begin
    delete from test 
    where code = 'hong';
    --sql%found : ������ �Ǿ���
    --sql%notfound : ������ ���� �ʾҴ�
    if sql%found then
        dbms_output.put_line('�����Ͱ� �����Ǿ���');
    else
        dbms_output.put_line('�����Ͱ� ������');
    end if;
end;

--sql%rowcount : ��ȸ�Ǽ�
--onerow üũ , �����Ͱ� �Ѱ��� �ƴҰ�� ����
declare
    rUserName test.username%type;
begin
    select username into rUserName
    from test
    where code = 'java';
    dbms_output.put_line('��ȸ�Ǽ�:' || sql%rowcount);
    exception
        when no_data_found then
            dbms_output.put_line('�����Ͱ� �������� �ʽ��ϴ�');
        when others then
            dbms_output.put_line('����ó��');
end;

--����� Ŀ��
--for Ű���带 �̿��ؼ� Ŀ�� ����
begin
    for test_cur in (
        select * from test
    )
    loop
        dbms_output.put_line(test_cur.code || ' ' || test_cur.username || ' ' || test_cur.age);
    end loop;
end;

--Ŀ���� ��ȯ
create or replace procedure test_selectlist(
    test_cur out sys_refcursor
)
is 
begin
    open test_cur for
    select * from test;
end;

--��ȯ�Ǵ� Ŀ�� �׽�Ʈ
--exec���� ������ ���ε� =>  :������
var test_cur refcursor; 
exec test_selectlist(:test_cur) ;
print test_cur;





