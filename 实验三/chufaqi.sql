--1�������洢�������ͼ�����ϵͳ�еĽ��鹦�ܣ������øô洢����ʵ�ֽ��鹦��
create or replace procedure p_borrow(
p_jylsh in BORROW.������ˮ��%type,
p_jszh in BORROW.����֤��%type,
p_tsbh in BORROW.ͼ����%type)
as 
  v_sfjc BOOK.�Ƿ���%type;
begin 
  select �Ƿ��� into v_sfjc from BOOK where ͼ����=p_tsbh;
  if v_sfjc='��' then
    insert into BORROW(������ˮ��,����֤��,ͼ����,��������) values
    (p_jylsh,p_jszh,p_tsbh,to_date(to_char(sysdate,'YYYY/MM/DD'),'YYYY/MM/DD'));
    update BOOK set �Ƿ���='��' where ͼ����=p_tsbh;
    commit;
  else 
    dbms_output.put_line('��ͼ���ѽ����');
  end if;
end;
--1�����鹦�ܵĵ���
call p_borrow('7','20051001','1005050');
select * from BORROW;
select * from BOOK;

--2�������洢�������ͼ�����ϵͳ�е�ԤԼ����
create or replace procedure p_ATMENT(
p_yylsh in ATMENT.ԤԼ��ˮ��%type,
p_jszh in ATMENT.����֤��%type,
p_isbn in ATMENT.ISBN%type)
as v_sfjc BOOK.�Ƿ���%type;
begin
  select �Ƿ��� into v_sfjc from BOOK where ISBN=p_isbn;
  if v_sfjc='��' then
    insert into ATMENT(ԤԼ��ˮ��,����֤��,ISBN,ԤԼʱ��) values
    (p_yylsh,p_jszh,p_isbn,to_date(to_char(sysdate,'YYYY/MM/DD'),'YYYY/MM/DD'));
    commit;
  else 
    dbms_output.put_line('����Ŀ�пɽ�ͼ�飬�����');
  end if;
end;
--2��ԤԼ���ܵĵ���
call p_ATMENT('2','20081237','9787508040110');
select * from ATMENT;

--3�������洢�������ͼ�����ϵͳ�еĻ��鹦��
create or replace procedure p_return(
p_jszh in BORROW.����֤��%type,
p_tsbh in BORROW.ͼ����%type,
p_fkflh in BORROW.��������%type)
as v_sfjc BOOK.�Ƿ���%type;
begin
  select �Ƿ��� into v_sfjc from BOOK where ͼ����=p_tsbh;
  if v_sfjc='��' then
    update BORROW set ��������=p_fkflh,�黹����=to_date(to_char(sysdate,'YYYY/MM/DD'),'YYYY/MM/DD')
    where BORROW.����֤��=p_jszh and BORROW.ͼ����=p_tsbh;
    update BOOK set �Ƿ���='��' where ͼ����=p_tsbh;
    commit;
  else 
    dbms_output.put_line('ͼ�����������');
  end if;
end;
--3�����鹦�ܵ���
call p_return('20051001','1005050','');
select * from BORROW;
select * from BOOK;

--4��ͨ�����кʹ�����ʵ�ֽ��ı��н�����ˮ���ֶε��Զ�����
create sequence seq_jylsh
minvalue 1
maxvalue 1.0E28
start with 8
increment by 1
cache 20;

create or replace trigger tri_borrow_jylsh
     before insert on BORROW for each row
   begin select seq_jylsh.nextval into :new.������ˮ��   
   from DUAL; 
end;
 
insert into BORROW(������ˮ��,����֤��,ͼ����,��������) values
    ('100','20061234','2001231',to_date(to_char(sysdate,'YYYY/MM/DD'),'YYYY/MM/DD'));
select * from BORROW;

--5���޸Ľ��鹦�ܵĴ洢����
create or replace procedure pro_new_borrow(
p_new_jszh in BORROW.����֤��%type,
p_new_tsbh in BORROW.ͼ����%type
)as begin
    insert into BORROW(����֤��,ͼ����,��������) values
    (p_new_jszh,p_new_tsbh,to_date(to_char(sysdate,'YYYY/MM/DD'),'YYYY/MM/DD'));
    commit;
end;

--6�����������洢�������Ӧ�Ĵ�����
create or replace trigger tri_borrow_jieshu
       after insert on BORROW for each row
     begin update BOOK set �Ƿ���='��' where BOOK.ͼ����=:new.ͼ����;
     end;
call pro_new_borrow('20081237','2001231');
select * from BORROW;
select * from BOOK;
