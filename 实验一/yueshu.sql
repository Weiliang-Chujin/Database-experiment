--完整性约束定义
alter table READER add constraint ch_联系电话 check(length(联系电话)=11);

alter table READER add constraint ch_身份证号 check(regexp_like(身份证编号,'[0-9]{17}[0-9,X,x]'));

alter table BOOK add constraint ch_是否借出 check(是否借出='是' or 是否借出='否');

alter table BORROW modify (借书日期 NOT NULL);
