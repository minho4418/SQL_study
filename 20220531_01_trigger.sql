--Ʈ����(trigger)
DROP TABLE test;
CREATE TABLE test(
code VARCHAR2(10) PRIMARY KEY,
username VARCHAR2(20),
age NUMBER(3)
);


select * from test;
--�α׻������̺�(test���̺��� �߰�, ����, ���� �� �ɶ����� ���)
create table test_log(
code varchar2(10),
jobgubun char(1), --1:�߰�, 2.����, 3.����
chgdate date default sysdate
);

insert into test(code, username, age) values ('002', '���ڹ�',30);
update test
set username = 'ȫ���',
age = 45
where code = '001';
delete from test 
where code = '002';

select * from test;
select * from test_log;
--Ʈ���Ż���
--test���̺� insert�� �Ͼ �Ŀ� �ڵ�����
create or replace trigger tg_test_insert_after
after insert on test for each row
begin
    --test_log�� insert
    -- :new => ���� ���ϵ� Ʃ���� ���� ����Ű�� ������
    insert into test_log(code, jobgubun)
    values(:new.code, '1' ); --�߰�
end;

--test���̺� update�� �Ͼ �Ŀ� �ڵ�����
create or replace trigger tg_test_update_after
after update on test for each row
begin
    insert into test_log(code ,jobgubun)
    values(:new.code, '2'); --����
end;

--test���̺� delete�� �Ͼ �Ŀ� �ڵ�����
create or  replace trigger tg_test_delete_after
after delete on test for each row
begin
    --:old => �������� Ʃ���� ����Ű�� ������
    insert into test_log(code ,jobgubun)
    values(:old.code, '3'); --����
end;






