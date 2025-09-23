use chinook

--------------1

select * from Employee

--------------2

select 
	 FirstName 
	,LastName
	,Email
from Employee

--------------3

select
	 Name
	,Composer
	,AlbumId
from Track
where AlbumId= 19

--------------4

select
	 Name as 'Track Title'
	,Composer
	,AlbumId
from Track
where AlbumId= 19
order by Composer, Name

--------------5

select top 5
	 BillingCountry
	,BillingCity
	,Total
from Invoice
where BillingCountry!= 'usa'
order by Total desc

--------------6

select distinct
	 state
	,country
from Customer
where Country= 'usa'

--------------7

select 
	 CustomerId
	,BillingCity
	,BillingPostalCode
	,Total
from Invoice
where 
	BillingCountry= 'germany'
	and Total> 5
order by CustomerId, total desc

--------------8

select distinct top 20 
	 Country as 'Country Name'
	,State as 'State or Region'
from Customer
order by Country, State

--------------9

select
	 AlbumId
	,MediaTypeId
	,Name
from Track
where 
	AlbumId<= 5 or
	MediaTypeId= 2
order by AlbumId

--------------10

select
	 AlbumId
	,Name
	,Milliseconds
	,UnitPrice
from Track
where 
	(AlbumId= 5 and
	 Milliseconds> 300000) or
	 UnitPrice> 0.99
order by AlbumId, Milliseconds