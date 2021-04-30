drop table ATMENT;

select * from ATMENT;

ALTER TABLE READER ENABLE ROW MOVEMENT;

insert into READER(����֤��,����) values('20191208','����');
insert into READER(����֤��,����) values('20191209','����');
commit;

FLASHBACK TABLE READER TO TIMESTAMP TO_TIMESTAMP('2019-12-07 00:00:00','YYYY-MM-DD:HH24:MI:SS');

create view view_reader as select ISBN,����,����,���浥λ,���� ͼ��������� from BIB,BC where BIB.ͼ������=BC.ͼ������; 

create user s5120176114_user3 identified by orcl;
grant select on view_reader to s5120176114_user3;

create profile profile_user3 limit
failed_login_attempts 3
password_lock_time 10;

alter user s5120176114_user3 profile profile_user3;
