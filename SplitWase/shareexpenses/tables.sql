create table Members
( MemberId  int  identity primary key,
  Fullname  varchar(50) not null,
  Password  varchar(10) not null,
  Email     varchar(50) unique not null,
  Mobile    varchar(10)
)

insert into members values('Mickey','m','mickey@disney.com','9898989898');
insert into members values('Donald','d','donald@disney.com','8989898989');

create table Programmes
( ProgId  int  identity primary key,
  Title  varchar(100) not null,
  Description  varchar(500),
  StartDate    DateTime,
  MemberId     int  references Members(MemberId)
)

insert into programmes values('Kashmir Trip', 
              'Visit Kashmir, India. Places to visit - Srinagar etc.', '7/1/2012',1);   

create table Programmes_Members
( ProgId       int  references Programmes(ProgId),
  MemberId     int  references Members(MemberId),
  Primary Key (progid,memberid)
)

insert into programmes_members values(1,1);
insert into programmes_members values(1,2);


create table Expenses
( ExpId  int  identity primary key,
  ExpDesc  varchar(100) not null,
  ExpAmount money,
  ExpDate    DateTime,
  ExpType    char(1),
  ProgId      int,
  MemberId     int,
  Foreign key(progid,memberid) references Programmes_Members(progid,memberid)
)

insert into expenses values('Contribution',5000,'6/1/2012','c',1,1);
insert into expenses values('Contribution',5000,'6/1/2012','c',1,2);
insert into expenses values('Train Tickets',2000,'6/6/2012','e',1,2);

create table Expenses_Members
( ExpId       int  references Expenses(ExpId),
  MemberId    int   references Members(MemberId),
  Amount      money,
  Primary Key (ExpId,MemberId)
)

insert into expenses_members values(3,1,1000);
insert into expenses_members values(3,2,1000);




