--1 ��ѯ����¥�Ρ�Ŀǰ�ɽ�ĸ�ͼ���ţ��������汾��Ϣ--
select ͼ����,���浥λ,BIB.ISBN 
from BOOK,BIB 
where BOOK.ISBN=BIB.ISBN and 
      �Ƿ���='��' and 
      BIB.����='��¥��';

--2 ���ҸߵȽ����������������Ŀ�����ۣ���������۽�������--
select ����,���� 
from BIB 
where ���浥λ='�ߵȽ���������' 
order by ���� desc;

--3 ͳ�ơ���¥�Ρ�����Ĳ�������--
select ISBN,count(*) �������� 
from BIB 
where ����='��¥��' 
group by ISBN;

--4 ��ѯѧ�š�20061234���Ž���֤����δ����ͼ�����Ϣ--
select * 
from BIB 
where ISBN in 
(select ISBN 
from BOOK,BORROW 
where BOOK.ͼ����=BORROW.ͼ���� and 
      ����֤��='20061234' and 
      �黹���� is null);

--5 ��ѯ�����������ͼ����ߵ��ۡ�ƽ������--
select ���浥λ,max(����) ��ߵ���,avg(����) ƽ������ 
from BIB 
group by ���浥λ;

--6 Ҫ��ѯ��������������������ͼ��Ķ��ߵĸ�����Ϣ--
select * 
from READER 
where ����֤�� in 
(select ����֤�� 
from BORROW 
group by ����֤�� 
having count(*)>1);

--7 ��ѯ�����ơ��ĵ�λ������ͼ��������ͽ�������--
select ��λ,����,�������� 
from READER,BORROW,BOOK,BIB 
where READER.����֤��=BORROW.����֤�� and 
      READER.����='����' and 
      BORROW.ͼ����=BOOK.ͼ���� and 
      BOOK.ISBN=BIB.ISBN;

--8 ��ѯÿ��ͼ��Ĳ�����ƽ������--
select count(*) ����,avg(����) ƽ������ 
from BIB 
group by ͼ������;

--9 ͳ�ƴ�δ����Ķ�������--
select count(����֤��) ��δ�������� 
from READER 
where not exists 
(select ����֤�� 
from BORROW 
where READER.����֤��=BORROW.����֤��);

--10 ͳ�Ʋ�����������--
select count(����֤��) ����������� 
from READER 
where exists 
(select ����֤�� 
from BORROW 
where READER.����֤��=BORROW.����֤��);

--11 �ҳ����н���δ���Ķ��ߵ���Ϣ������ͼ���ż�����--
select READER.*,BOOK.ͼ����,BIB.���� 
from READER,BORROW,BOOK,BIB 
where READER.����֤��=BORROW.����֤�� and 
      BORROW.ͼ����=BOOK.ͼ���� and 
      BOOK.ISBN=BIB.ISBN and 
      BORROW.�黹���� is null;

--12 �����������ԡ�Internet����ͷ������ͼ�������������--
select ����,���� 
from BIB 
where ����='Internet%';

--13 ��ѯ��ͼ��ķ�������--
select ͼ����,sum(FC.����) 
from FC,BORROW 
where FC.��������=BORROW.��������
group by ͼ����;

--14 ��ѯ���ļ����������Ϣ������з�������ʾ������Ϣ���������ơ��������û�з����򷣿����ơ�������ʾ�գ��������ӣ�--
select BORROW.*,��������,���� 
from BORROW left outer join FC on(BORROW.��������=FC.��������);

--15 ��ѯ���������С���ѧ������Ŀ�Ķ��ߵ���������λ--
select ����,��λ 
from READER 
where not exists 
(select * 
from BIB,BC 
where BIB.ͼ������=BC.ͼ������ and 
      ����='��ѧ' and not exists 
                      (select * 
                       from BORROW,BOOK 
                       where BORROW.ͼ����=BOOK.ͼ���� and 
                       BORROW.����֤��=READER.����֤�� and 
                       BOOK.ISBN=BIB.ISBN));
