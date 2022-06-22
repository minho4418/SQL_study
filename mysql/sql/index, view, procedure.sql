select * from member where member_name = '아이유';

#인덱스 생성
create index idx_member_name on member(member_name);

#뷰 생성
create view member_view
as
select * from member;

select * from member_view;

#프로시저
delimiter //
create procedure myProc()
begin
	select * from member where member_name = '나훈아';
	select * from prodect where prodect_name = '삼각김밥';
end //
delimiter ;

call myProc();