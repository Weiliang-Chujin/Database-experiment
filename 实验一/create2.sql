--对表的操作
create table A(
a char(4) primary key,
b char(4)
);

alter table A add c char(10); 
alter table A drop column a;
alter table A modify (b smallint);

drop table A cascade constraints;
