create table BC(
ͼ������ CHAR(4) PRIMARY KEY,
���� CHAR(10) NOT NULL
);
create table BIB(
ISBN CHAR(15) PRIMARY KEY,
���� CHAR(30) NOT NULL,
���� CHAR(15),
���浥λ CHAR(30),
���� REAL,
ͼ������ CHAR(4) NOT NULL,
foreign key(ͼ������) REFERENCES BC(ͼ������)
);
create table BOOK(
ͼ���� CHAR(10) PRIMARY KEY,
ISBN CHAR(15)  NOT NULL,
�Ƿ��� CHAR(2) NOT NULL,
��ע CHAR(20),
foreign key(ISBN) REFERENCES BIB(ISBN)
);
create table READER(
����֤�� CHAR(8) PRIMARY KEY,
���� CHAR(15) NOT NULL,
��λ CHAR(50),
�Ա� CHAR(2),
��ַ CHAR(50),
��ϵ�绰 CHAR(15),
���֤��� CHAR(18)
);
create table BORROW(
������ˮ�� CHAR(4) PRIMARY KEY,
����֤�� CHAR(8) NOT NULL,
ͼ���� CHAR(10) NOT NULL,
�������� date NOT NULL,
�黹���� date,
�������� CHAR(4),
��ע CHAR(20),
foreign key(����֤��) REFERENCES READER(����֤��),
foreign key(ͼ����) REFERENCES BOOK(ͼ����),
foreign key(��������) REFERENCES FC(��������)
);
create table FC(
�������� CHAR(4) PRIMARY KEY,
�������� CHAR(10) NOT NULL,
���� REAL
);
create table ATMENT(
ԤԼ��ˮ�� CHAR(4) PRIMARY KEY,
����֤�� CHAR(8) NOT NULL,
ISBN CHAR(15) NOT NULL,
ԤԼʱ�� date NOT NULL,
foreign key(����֤��) REFERENCES READER(����֤��),
foreign key(ISBN) REFERENCES BIB(ISBN)
);
