-- Cesar Castro

USE master
IF DB_ID('MyDB_CC') IS NOT NULL
BEGIN
ALTER DATABASE MyDB_CC SET OFFLINE WITH ROLLBACK IMMEDIATE;
ALTER DATABASE MyDB_CC SET ONLINE;
DROP DATABASE MyDB_CC;
END

--------------1

create database MyDB_CC
go
use MyDB_CC

--------------2

select *
into Users
from Chinook.dbo.Customer

--------------3

delete Users
where Users.CustomerId % 2 = 1

--------------4

update Users
set
	Users.Company= 
		case
			when Users.Email like '%gmail%' then 'Google'
			when Users.Email like '%yahoo%' then 'Yahoo!'
			else Users.Company
		end

--------------5

exec sp_rename 'Users.CustomerId', 'UserId', 'COLUMN'

--------------6

alter table Users
add constraint
	pk_Users primary key (UserId)

--------------7

create table Address
	(AddresId int identity (1, 1) primary key,
	 AddressType varchar(10), 
	 AddressLine1 varchar(50), 
	 City varchar(30), 
	 State varchar(2), 
	 UserId int, 
	 CreateDate datetime default getdate())

--------------8

alter table Address
add constraint
	uc_addressType unique (UserID, AddressType)

--------------9

alter table Address
add constraint
	fk_UserAddress foreign key (UserID) references Users(UserId)

--------------10

insert into Address (AddressType, AddressLine1, City, State, UserID)
values 
	('home', '111 Elm St.', 'Los Angeles', 'CA', 2),
	('home', '222 Palm Ave.', 'San Diego', 'CA', 4),
	('work', '333 Oak Ln.', 'La Jolla', 'CA', 4)

select * from users
select * from Address
