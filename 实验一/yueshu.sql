--������Լ������
alter table READER add constraint ch_��ϵ�绰 check(length(��ϵ�绰)=11);

alter table READER add constraint ch_���֤�� check(regexp_like(���֤���,'[0-9]{17}[0-9,X,x]'));

alter table BOOK add constraint ch_�Ƿ��� check(�Ƿ���='��' or �Ƿ���='��');

alter table BORROW modify (�������� NOT NULL);
