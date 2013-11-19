create table Users
(  Email  varchar(50) primary key,
   Password  varchar(20)  not null,
   Address   varchar(300),
   Mobileno  varchar(30),
   Registeredon  datetime
)

create table Books
(  Bookid  int  identity  primary key,
   Title  varchar(100) not null,
   Description varchar(200),
   Author varchar(100),
   Price  money,
   Discount float,
   Nopages int
)

insert into books values('C# 4.0 Complete Reference','Teaches how to build .NET applications using C#',
 'Herbert Schildt',550,20,898);
insert into books values('ASP.NET 4.0 Unleashed','Explains how to build web applications using ASP.NET 4.0',
 'Stephen Walther',890,20,1898);
insert into books values('ASP.NET MVC Unleashed','Teaches how to use ASP.NET MVC',
 'Stephen Walther',555,15,789);
insert into books values('Linq In Action','Teaches linq by giving numerous examples',
 'La Ben',560,25,989);
insert into books values('Asp.net AJAX','Explains how to use ASP.NET AJAX',
 'Tim Burton',450,15,770);

 
create table Orders
(  Orderid  int  identity  primary key,
   Email      varchar(50) references users(email),
   OrderDate  datetime,
   Status     char(1)  check( status in ('n','p','d','c')),
   Dispatchedon  datetime,
   Deliveredon   datetime,
   ShippingAddress varchar(300),
   TotalAmount   money
);

create table OrderBooks
(  Orderid  int  references orders(orderid),
   Bookid   int references books(bookid),
   Nocopies int,
   NetPrice  money,
   primary key (orderid, bookid)
);




