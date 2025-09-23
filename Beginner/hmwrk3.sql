-- Cesar Castro

use chinook

--------------1

select 
	Name,
	replace (name, ' & ', ' And ') [NewName]	
from genre

--------------2

select
	concat (firstname, ' ', LastName) [FullName]
   ,day (birthdate) [Day]
   ,datename (month, BirthDate) [Month]
   ,year (birthdate) [Year]
from Employee 

--------------3

select
	replace (Title, ' ', '') [TitleNoSpaces]
   ,upper (Title) [TitleUpperCase]
   ,reverse (Title) [TitleReverse]
   ,len (Title) [TitleLength]
   ,charindex (' ', Title) [SpaceLocation]
from Album

--------------4

select
	firstname
   ,LastName
   ,birthdate
   ,DATEDIFF (day, BirthDate, getdate()) / 365 [Age]
from Employee 

--------------5

select
	title 
   ,substring (title, charindex (' ', title) + 1, LEN (title)) [ShortTitle]
from Employee

--------------6

select
	FirstName,
	LastName,
	concat (substring (firstname, 1, 1), substring (lastname, 1, 1)) as [Initials]
from Customer
order by Initials

--------------7

select
	FirstName,
	LastName,
	replace (replace (phone, '-', ' '), '+1', '') [Phone],
	iif (fax is null, 'Unknown', replace (replace (fax, '-', ' '), '+1', '')) [Fax]
from Customer
where Country = 'usa'
order by LastName

--------------8

select
	upper (concat (LastName, ', ', FirstName)) as [CustomerName]
   ,iif (company is null, 'N/A', company) [Company]
from Customer
where LastName like '[A-M]%'

--------------9

select 
	InvoiceId,
	CustomerId,
	Total,
	convert (varchar, InvoiceDate, 101) [InvoiceDate],
	concat ('Y', datePart (year, DateAdd (month, 6, GETDATE()))) [FiscalYear]
from Invoice
order by InvoiceDate desc

-------------10

select 
	iif (Country = 'usa' or country = 'Canada', 'Domestic', 'International') [CustomerType],
	FirstName,
	LastName,
	Country
from Customer
order by CustomerType, LastName