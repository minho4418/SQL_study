select regidate, simplejoin from member;

drop table joininfo;
create table joininfo(
joindate varchar2(10) primary key,
join0 number(10) default 0, --일반가입 누적수
join1 number(10) default 0, --네이버가입 누적수
join2 number(10) default 0 --카카오가입 누적수
);

insert into member(email,passwd,username,zipcode,addrload,addrdetail,filename, simplejoin)
values('fdsffsd@gmail.com', '1111', '박자바', '11111', '신림로','6층', 'a.png','1');
insert into member(email,passwd,username,zipcode,addrload,addrdetail,filename, simplejoin)
values('park1@gmail.com', '2222', '김자바', '22222', '대림로','3층', 'b.png','2');


--날짜를 조회해서 데이터가 없다면
select count(*) from joininfo 
where joindate like '%'||'2022-05-31'||'%';
insert into joininfo(joindate) values ('2022-05-31'); 

--일반가입이었을때
update joininfo 
set join0= join0+1
where joindate = '2022-05-31';

select * from joininfo;

--시스템의 날짜를 문자열로 바꾸기
select to_char(sysdate, 'yyyy-MM-dd')  from dual;

--콘솔창에 출력 설정 변경 =>ON
set serveroutput on;

--회원가입 현황 trigger
create or replace trigger tg_after_insert_join
after insert on member for each row
declare
    --변수
    v_joindate joininfo.joindate%type; --가입일자
    cnt number; --날짜 건수
begin
    --1)문자열 날짜를 구하기
    select to_char(:new.regidate, 'yyyy-MM-dd' )  into v_joindate from dual;
    dbms_output.put_line(v_joindate);
    dbms_output.put_line(:new.simplejoin);
    --2)가입날짜의 Row를 생성(insert)=>해당 날짜가 없을 때만				
    select count(*) into cnt from joininfo where joindate = v_joindate;
    insert into joininfo(joindate)values (sysdate); 
    --3)가입구분에따라서 update	
    --만약 :new.simplejoin 이 '0'=>join0 이 증가
    --만약 :new.simplejoin 이 '1'=>join1 이 증가
    --만약 :new.simplejoin 이 '2'=>join2 이 증가    
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





