--对表中的数据的操作
delete from FC
where 罚款分类号='2';
commit;
 
insert into FC values('2','损坏',20);
commit;

update FC SET 罚金=50 where 罚款名称='损坏';
commit;
