--1、建立存储过程完成图书管理系统中的借书功能，并调用该存储过程实现借书功能
create or replace procedure p_borrow(
p_jylsh in BORROW.借阅流水号%type,
p_jszh in BORROW.借书证号%type,
p_tsbh in BORROW.图书编号%type)
as 
  v_sfjc BOOK.是否借出%type;
begin 
  select 是否借出 into v_sfjc from BOOK where 图书编号=p_tsbh;
  if v_sfjc='否' then
    insert into BORROW(借阅流水号,借书证号,图书编号,借书日期) values
    (p_jylsh,p_jszh,p_tsbh,to_date(to_char(sysdate,'YYYY/MM/DD'),'YYYY/MM/DD'));
    update BOOK set 是否借出='是' where 图书编号=p_tsbh;
    commit;
  else 
    dbms_output.put_line('该图书已借出！');
  end if;
end;
--1、借书功能的调用
call p_borrow('7','20051001','1005050');
select * from BORROW;
select * from BOOK;

--2、建立存储过程完成图书管理系统中的预约功能
create or replace procedure p_ATMENT(
p_yylsh in ATMENT.预约流水号%type,
p_jszh in ATMENT.借书证号%type,
p_isbn in ATMENT.ISBN%type)
as v_sfjc BOOK.是否借出%type;
begin
  select 是否借出 into v_sfjc from BOOK where ISBN=p_isbn;
  if v_sfjc='是' then
    insert into ATMENT(预约流水号,借书证号,ISBN,预约时间) values
    (p_yylsh,p_jszh,p_isbn,to_date(to_char(sysdate,'YYYY/MM/DD'),'YYYY/MM/DD'));
    commit;
  else 
    dbms_output.put_line('该书目有可借图书，请查找');
  end if;
end;
--2、预约功能的调用
call p_ATMENT('2','20081237','9787508040110');
select * from ATMENT;

--3、建立存储过程完成图书管理系统中的还书功能
create or replace procedure p_return(
p_jszh in BORROW.借书证号%type,
p_tsbh in BORROW.图书编号%type,
p_fkflh in BORROW.罚款分类号%type)
as v_sfjc BOOK.是否借出%type;
begin
  select 是否借出 into v_sfjc from BOOK where 图书编号=p_tsbh;
  if v_sfjc='是' then
    update BORROW set 罚款分类号=p_fkflh,归还日期=to_date(to_char(sysdate,'YYYY/MM/DD'),'YYYY/MM/DD')
    where BORROW.借书证号=p_jszh and BORROW.图书编号=p_tsbh;
    update BOOK set 是否借出='否' where 图书编号=p_tsbh;
    commit;
  else 
    dbms_output.put_line('图书编号输入错误');
  end if;
end;
--3、还书功能调用
call p_return('20051001','1005050','');
select * from BORROW;
select * from BOOK;

--4、通过序列和触发器实现借阅表中借阅流水号字段的自动递增
create sequence seq_jylsh
minvalue 1
maxvalue 1.0E28
start with 8
increment by 1
cache 20;

create or replace trigger tri_borrow_jylsh
     before insert on BORROW for each row
   begin select seq_jylsh.nextval into :new.借阅流水号   
   from DUAL; 
end;
 
insert into BORROW(借阅流水号,借书证号,图书编号,借书日期) values
    ('100','20061234','2001231',to_date(to_char(sysdate,'YYYY/MM/DD'),'YYYY/MM/DD'));
select * from BORROW;

--5、修改借书功能的存储过程
create or replace procedure pro_new_borrow(
p_new_jszh in BORROW.借书证号%type,
p_new_tsbh in BORROW.图书编号%type
)as begin
    insert into BORROW(借书证号,图书编号,借书日期) values
    (p_new_jszh,p_new_tsbh,to_date(to_char(sysdate,'YYYY/MM/DD'),'YYYY/MM/DD'));
    commit;
end;

--6、建立与借书存储过程相对应的触发器
create or replace trigger tri_borrow_jieshu
       after insert on BORROW for each row
     begin update BOOK set 是否借出='是' where BOOK.图书编号=:new.图书编号;
     end;
call pro_new_borrow('20081237','2001231');
select * from BORROW;
select * from BOOK;
