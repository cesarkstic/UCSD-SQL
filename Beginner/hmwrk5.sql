-- Cesar Castro

use Chinook

--------------1

select
	T.Name TrackName,
	MT.Name MediaName,
	case
		when MT.Name like '%video%' then 'Video'
		when MT.Name like '%audio%' then 'Audio'
	end MediaType,
	case
		when MT.Name like '%aac%' then 'AAC'
		when MT.Name like '%mpeg%' then 'MPEG'
		else 'Unknown'
	end EncodingFormat
from
	Track T
join MediaType MT
	on MT.MediaTypeId = T.MediaTypeId

--------------2

select
	MT.Name MediaTypeName,
	count (MT.Name) TotalTracks
from
	Track T
join MediaType MT
	on MT.MediaTypeId = T.MediaTypeId
group by MT.Name

--------------3

select
	E.FirstName,
	E.LastName,
	sum (I.Total) Total,
	year (I.InvoiceDate) Year
from
	Employee E
join Customer C
	on C.SupportRepId = E.EmployeeId
join Invoice I
	on I.CustomerId = C.CustomerId
group by 
	E.FirstName,
	E.LastName,
	year (I.InvoiceDate)

--------------4

select
	C.LastName,
	C.FirstName,
	MAX (I.Total) MaxInvoice
from Customer C
join Invoice I
	on I.CustomerId = C.CustomerId
group by 
	C.LastName,
	C.FirstName

--------------5

select
	C.Country,
	C.PostalCode,
	case
		when isnumeric (C.PostalCode) = 1 then 'Yes'
		when C.PostalCode is null then 'Unknown'
		else 'No'
	end NumericPostalCode 
from Customer C
order by
	NumericPostalCode, C.Country

--------------6

select
	C.LastName,
	C.FirstName,
	sum (I.Total) TotalSales
from Customer C
join Invoice I
	on I.CustomerId = C.CustomerId
group by 
	C.LastName,
	C.FirstName
having  
	sum (I.Total)> 42 

--------------7

select top 1
	A.Name TopArtist,
	count (T.TrackId) TrackNumber
from
	Artist A
join Album Alb
	on Alb.ArtistId = A.ArtistId
join Track T
	on T.AlbumId = Alb.AlbumId
group by A.Name
order by count (T.TrackId) desc

--------------8

select
	C.FirstName,
	C.LastName,
	case
		when C.LastName like '[a-g]%' then 'Group1'
		when C.LastName like '[h-m]%' then 'Group2'
		when C.LastName like '[n-s]%' then 'Group3'
		when C.LastName like '[t-z]%' then 'Group4'
	end CustomerGrouping		
from Customer C

--------------9

select
	A.Name ArtistName,
	count (Alb.ArtistId) AlbumCount
from
	Artist A
left join Album Alb
	on Alb.ArtistId = A.ArtistId
group by A.Name 

-------------10

select
	E.FirstName,
	E.LastName,
	E.Title,
	case
		when E.Title like '%sales%' then 'Sales'
		when E.Title like '%it%' then 'Technology'
		when E.Title like '%manager%' then 'Management'
	end Department
from Employee E
order by Department