create table BC(
图书分类号 CHAR(4) PRIMARY KEY,
类名 CHAR(10) NOT NULL
);
create table BIB(
ISBN CHAR(15) PRIMARY KEY,
书名 CHAR(30) NOT NULL,
作者 CHAR(15),
出版单位 CHAR(30),
单价 REAL,
图书分类号 CHAR(4) NOT NULL,
foreign key(图书分类号) REFERENCES BC(图书分类号)
);
create table BOOK(
图书编号 CHAR(10) PRIMARY KEY,
ISBN CHAR(15)  NOT NULL,
是否借出 CHAR(2) NOT NULL,
备注 CHAR(20),
foreign key(ISBN) REFERENCES BIB(ISBN)
);
create table READER(
借书证号 CHAR(8) PRIMARY KEY,
姓名 CHAR(15) NOT NULL,
单位 CHAR(50),
性别 CHAR(2),
地址 CHAR(50),
联系电话 CHAR(15),
身份证编号 CHAR(18)
);
create table BORROW(
借阅流水号 CHAR(4) PRIMARY KEY,
借书证号 CHAR(8) NOT NULL,
图书编号 CHAR(10) NOT NULL,
借书日期 date NOT NULL,
归还日期 date,
罚款分类号 CHAR(4),
备注 CHAR(20),
foreign key(借书证号) REFERENCES READER(借书证号),
foreign key(图书编号) REFERENCES BOOK(图书编号),
foreign key(罚款分类号) REFERENCES FC(罚款分类号)
);
create table FC(
罚款分类号 CHAR(4) PRIMARY KEY,
罚款名称 CHAR(10) NOT NULL,
罚金 REAL
);
create table ATMENT(
预约流水号 CHAR(4) PRIMARY KEY,
借书证号 CHAR(8) NOT NULL,
ISBN CHAR(15) NOT NULL,
预约时间 date NOT NULL,
foreign key(借书证号) REFERENCES READER(借书证号),
foreign key(ISBN) REFERENCES BIB(ISBN)
);
