drop table ATMENT;

select * from ATMENT;

ALTER TABLE READER ENABLE ROW MOVEMENT;

insert into READER(借书证号,姓名) values('20191208','张三');
insert into READER(借书证号,姓名) values('20191209','李四');
commit;

FLASHBACK TABLE READER TO TIMESTAMP TO_TIMESTAMP('2019-12-07 00:00:00','YYYY-MM-DD:HH24:MI:SS');

create view view_reader as select ISBN,书名,作者,出版单位,类名 图书分类名称 from BIB,BC where BIB.图书分类号=BC.图书分类号; 

create user s5120176114_user3 identified by orcl;
grant select on view_reader to s5120176114_user3;

create profile profile_user3 limit
failed_login_attempts 3
password_lock_time 10;

alter user s5120176114_user3 profile profile_user3;
