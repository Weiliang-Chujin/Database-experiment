--1 查询“红楼梦”目前可借的各图书编号，及所属版本信息--
select 图书编号,出版单位,BIB.ISBN 
from BOOK,BIB 
where BOOK.ISBN=BIB.ISBN and 
      是否借出='否' and 
      BIB.书名='红楼梦';

--2 查找高等教育出版社的所有书目及单价，结果按单价降序排序--
select 书名,单价 
from BIB 
where 出版单位='高等教育出版社' 
order by 单价 desc;

--3 统计“红楼梦”各版的藏书数量--
select ISBN,count(*) 藏书数量 
from BIB 
where 书名='红楼梦' 
group by ISBN;

--4 查询学号“20061234”号借书证借阅未还的图书的信息--
select * 
from BIB 
where ISBN in 
(select ISBN 
from BOOK,BORROW 
where BOOK.图书编号=BORROW.图书编号 and 
      借书证号='20061234' and 
      归还日期 is null);

--5 查询各个出版社的图书最高单价、平均单价--
select 出版单位,max(单价) 最高单价,avg(单价) 平均单价 
from BIB 
group by 出版单位;

--6 要查询借阅了两本和两本以上图书的读者的个人信息--
select * 
from READER 
where 借书证号 in 
(select 借书证号 
from BORROW 
group by 借书证号 
having count(*)>1);

--7 查询“王菲”的单位、所借图书的书名和借阅日期--
select 单位,书名,借书日期 
from READER,BORROW,BOOK,BIB 
where READER.借书证号=BORROW.借书证号 and 
      READER.姓名='王菲' and 
      BORROW.图书编号=BOOK.图书编号 and 
      BOOK.ISBN=BIB.ISBN;

--8 查询每类图书的册数和平均单价--
select count(*) 册数,avg(单价) 平均单价 
from BIB 
group by 图书分类号;

--9 统计从未借书的读者人数--
select count(借书证号) 从未借书人数 
from READER 
where not exists 
(select 借书证号 
from BORROW 
where READER.借书证号=BORROW.借书证号);

--10 统计参与借书的人数--
select count(借书证号) 参与借书人数 
from READER 
where exists 
(select 借书证号 
from BORROW 
where READER.借书证号=BORROW.借书证号);

--11 找出所有借书未还的读者的信息及所借图书编号及名称--
select READER.*,BOOK.图书编号,BIB.书名 
from READER,BORROW,BOOK,BIB 
where READER.借书证号=BORROW.借书证号 and 
      BORROW.图书编号=BOOK.图书编号 and 
      BOOK.ISBN=BIB.ISBN and 
      BORROW.归还日期 is null;

--12 检索书名是以“Internet”开头的所有图书的书名和作者--
select 书名,作者 
from BIB 
where 书名='Internet%';

--13 查询各图书的罚款总数--
select 图书编号,sum(FC.罚金) 
from FC,BORROW 
where FC.罚款分类号=BORROW.罚款分类号
group by 图书编号;

--14 查询借阅及罚款分类信息，如果有罚款则显示借阅信息及罚款名称、罚金，如果没有罚款则罚款名称、罚金显示空（左外连接）--
select BORROW.*,罚款名称,罚金 
from BORROW left outer join FC on(BORROW.罚款分类号=FC.罚款分类号);

--15 查询借阅了所有“文学”类书目的读者的姓名、单位--
select 姓名,单位 
from READER 
where not exists 
(select * 
from BIB,BC 
where BIB.图书分类号=BC.图书分类号 and 
      类名='文学' and not exists 
                      (select * 
                       from BORROW,BOOK 
                       where BORROW.图书编号=BOOK.图书编号 and 
                       BORROW.借书证号=READER.借书证号 and 
                       BOOK.ISBN=BIB.ISBN));
