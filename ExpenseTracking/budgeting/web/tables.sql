create user budgeting identified by budgeting;

grant connect, resource to budgeting;

connect budgeting/budgeting;

create table users 
( userid  number(5) primary key,
  username varchar2(10) not null unique,
  password varchar2(10) not null,
  email    varchar2(50) not null unique
);

create sequence  userid_sequence nocache;

insert into users values( userid_sequence.nextval, 'abc','abc','abc@classroom.com');

create table categories
( catcode  number(2) primary key,
  catname  varchar2(20) not null
);

insert into categories values(1,'Health');
insert into categories values(2,'Education');
insert into categories values(3,'Sports');
insert into categories values(4,'Food');
insert into categories values(5,'Entertainment');
insert into categories values(6,'Transport');


create table budgets
( budgetid  number(5)  primary key,
  userid    number(5)  references users (userid),
  month     number(2)  check ( month between 1 and 12),
  year      number(4),
  catcode   number(2)  references categories (catcode),
  amount    number(5),
  unique(userid,month,year,catcode)
);

create sequence budgetid_sequence nocache;

insert into budgets values ( budgetid_sequence.nextval, 1,12,2011,2,5000);
insert into budgets values ( budgetid_sequence.nextval, 1,12,2011,6,1000);
insert into budgets values ( budgetid_sequence.nextval, 1,12,2011,3,500);

create table expenditures 
( expid       number(5) primary key,
  userid      number(5)  references users (userid),
  exp_date    date,
  exp_details varchar2(100),
  exp_amount  number(5),
  catcode     number(2)  references categories (catcode)
);

create sequence expid_sequence nocache;

insert into expenditures values ( expid_sequence.nextval,
   1,'1-dec-2011','Course Fee For Java',2000,2);

insert into expenditures values ( expid_sequence.nextval,
   1,'3-dec-2011','Auto Charge',50,6);

