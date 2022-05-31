select regidate, simplejoin from member;

drop table joininfo;
create table joininfo(
joindate varchar2(10) primary key,
join0 number(10) default 0, --�Ϲݰ��� ������
join1 number(10) default 0, --���̹����� ������
join2 number(10) default 0 --īī������ ������
);

insert into member(email,passwd,username,zipcode,addrload,addrdetail,filename, simplejoin)
values('fdsffsd@gmail.com', '1111', '���ڹ�', '11111', '�Ÿ���','6��', 'a.png','1');
insert into member(email,passwd,username,zipcode,addrload,addrdetail,filename, simplejoin)
values('park1@gmail.com', '2222', '���ڹ�', '22222', '�븲��','3��', 'b.png','2');


--��¥�� ��ȸ�ؼ� �����Ͱ� ���ٸ�
select count(*) from joininfo 
where joindate like '%'||'2022-05-31'||'%';
insert into joininfo(joindate) values ('2022-05-31'); 

--�Ϲݰ����̾�����
update joininfo 
set join0= join0+1
where joindate = '2022-05-31';

select * from joininfo;

--�ý����� ��¥�� ���ڿ��� �ٲٱ�
select to_char(sysdate, 'yyyy-MM-dd')  from dual;

--�ܼ�â�� ��� ���� ���� =>ON
set serveroutput on;

--ȸ������ ��Ȳ trigger
create or replace trigger tg_after_insert_join
after insert on member for each row
declare
    --����
    v_joindate joininfo.joindate%type; --��������
    cnt number; --��¥ �Ǽ�
begin
    --1)���ڿ� ��¥�� ���ϱ�
    select to_char(:new.regidate, 'yyyy-MM-dd' )  into v_joindate from dual;
    dbms_output.put_line(v_joindate);
    dbms_output.put_line(:new.simplejoin);
    --2)���Գ�¥�� Row�� ����(insert)=>�ش� ��¥�� ���� ����				
    select count(*) into cnt from joininfo where joindate = v_joindate;
    insert into joininfo(joindate)values (sysdate); 
    --3)���Ա��п����� update	
    --���� :new.simplejoin �� '0'=>join0 �� ����
    --���� :new.simplejoin �� '1'=>join1 �� ����
    --���� :new.simplejoin �� '2'=>join2 �� ����    
    if :new.simplejoin = '0' then
        update joininfo
        set join0 = join0+1
        where joindate = '2022-05-31';
    elsif :new.simplejoin = '1' then
        update joininfo
        set join1 = join1+1
        where joindate = '2022-05-31';
    elsif :new.simplejoin = '2' then
        update joininfo
        set join2 = join2+1
        where joindate = '2022-05-31';
    end if;
end;





