-- Cesar Castro

USE master
IF DB_ID('MyDB_CesarC') IS NOT NULL
BEGIN
	ALTER DATABASE MyDB_CesarC SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE MyDB_CesarC SET ONLINE;
	DROP DATABASE MyDB_CesarC;
END

--------------1

CREATE DATABASE MyDB_CesarC
GO

--------------2

USE MyDB_CesarC

SELECT * INTO 
Users
FROM Chinook.dbo.Customer

--------------3
DELETE FROM Users
WHERE Users.CustomerId % 2 = 1

--------------4

UPDATE Users
SET 
	Company = CASE
				WHEN Email LIKE '%GMAIL%' THEN 'Google'
				WHEN Email LIKE '%YAHOO%' THEN 'Yahoo!'
				ELSE Company
END;

--------------5

EXEC sp_rename 'Users.CustomerID', 'UserId', 'column'

--------------6

ALTER TABLE Users
ADD CONSTRAINT pk_Users PRIMARY KEY (UserID)

--------------7

CREATE TABLE Address (
	AddresId int IDENTITY (1, 1) PRIMARY KEY,
	AddressType varchar(10), 
	AddressLine1 varchar(50), 
	City varchar(30), 
	State varchar(2), 
	UserId int, 
	CreateDate datetime DEFAULT GETDATE())

--------------8

ALTER TABLE Address
ADD CONSTRAINT uc_AddressType UNIQUE (UserId, AddressType)

--------------9

ALTER TABLE Address
ADD CONSTRAINT fk_UserAddress FOREIGN KEY (UserId) REFERENCES Users(UserId)

--------------10

INSERT INTO Address (AddressType, AddressLine1, City, State, UserId)
VALUES 
('home', '111 Elm St.', 'Los Angeles', 'CA', 2),
('home', '222 Palm Ave.', 'San Diego', 'CA', 4),
('work', '333 Oak Ln.', 'La Jolla', 'CA', 4)

--------------11

SELECT * FROM Users
SELECT * FROM Address

