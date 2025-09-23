-- Cesar Castro

use Chinook

--------------1

select top 10 with ties
	Ar.Name ArtistName,
	SUM (IL.Quantity * IL.UnitPrice) Total
from Invoice I
join InvoiceLine IL
	on IL.InvoiceId = I.InvoiceId
join Track T
	on T.TrackId = IL.TrackId
join Album A
	on A.AlbumId = T.AlbumId
join Artist Ar
	on Ar.ArtistId = A.ArtistId
where
	I.InvoiceDate between '07-01-2011' and '06-30-2012' and
	T.MediaTypeId != 3
group by
	Ar.Name
order by
	Total desc

--------------2

select
	concat (E.FirstName, ' ', E.LastName) [Employee Name],
	year (I.InvoiceDate) [Calendar Year],
	case
		when datename (quarter, I.InvoiceDate) = '1' then 'First'
		when datename (quarter, I.InvoiceDate) = '2' then 'Second'
		when datename (quarter, I.InvoiceDate) = '3' then 'Third'
		when datename (quarter, I.InvoiceDate) = '4' then 'Fourth'
	end [Sales Quarter],
	max (I.total) [Highest Sale],
	count (I.total) [Number of Sales],
	sum (I.total) [Total Sales]
from Invoice I
join Customer C
	on C.CustomerId = I.CustomerId
join Employee E
	on E.EmployeeId = C.SupportRepId
where
	I.InvoiceDate between '01-01-2010' and '06-30-2012'
group by
	concat (E.FirstName, ' ', E.LastName),
	year (I.InvoiceDate),
	datename (quarter, I.InvoiceDate)

--------------3

select 
	PL2.Name,
	PL2.PlaylistId,
	PLT.TrackId
from Playlist PL1
join Playlist PL2
	on PL2.Name = PL1.Name
left join PlaylistTrack PLT
	on PLT.PlaylistId = PL2.PlaylistId
where
	PL1.PlaylistId < PL2.PlaylistId
order by PL1.Name

--------------4

select
	C.Country,
	Ar.Name,
	count (T.TrackID) [Track Count],
	count (distinct T.TrackID) [Unique Track Count],
	count (T.TrackID) - count (distinct T.TrackID) [Count Difference],
	sum (IL.UnitPrice * IL.Quantity) [Total Revenue],
	iif (T.MediaTypeId = 3, 'Video', 'Audio') [Media Type]
from Invoice I
join InvoiceLine IL
	on IL.InvoiceId = I.InvoiceId
join Track T
	on T.TrackId = IL.TrackId
join Album A
	on A.AlbumId = T.AlbumId
join Artist Ar
	on Ar.ArtistId = A.ArtistId
join Customer C
	on C.CustomerId = I.CustomerId
where
	I.InvoiceDate between '07-01-2009' and '06-30-2013'
group by
	C.Country, Ar.Name,
	iif (T.MediaTypeId = 3, 'Video', 'Audio')
order by
	C.Country, [Track Count] desc, Ar.Name

--------------5

drop table if exists ##BdayTemp

select 
	concat (E.FirstName, ' ', E.LastName) [Full Name],
	datefromparts (year (E.BirthDate), month (E.BirthDate), day (E.BirthDate)) [Birth Date],
	datefromparts (2016, month (E.BirthDate), day (E.BirthDate)) [Birth Day 2016]
	into ##BdayTemp
from Employee E

select
	[Full Name],
	concat (month ([Birth Date]), '/', day ([Birth Date]), '/', year ([Birth Date])) [Birth Date], 
	concat (month ([Birth Day 2016]), '/', day ([Birth Day 2016]), '/', year ([Birth Day 2016])) [Birth Day 2016],
	datename (weekday, [Birth Day 2016]) [Birth Day of Week],	
	case
		when datepart (weekday, [Birth Day 2016]) = 1 then
			concat (
				month (dateadd (day, 1, [Birth Day 2016])), '/',
				day (dateadd (day, 1, [Birth Day 2016])), '/2016')
		when datepart (weekday, [Birth Day 2016]) = 7 then
			concat (
				month (dateadd (day, 2, [Birth Day 2016])), '/',
				day (dateadd (day, 2, [Birth Day 2016])), '/2016')
		else concat (month ([Birth Day 2016]), '/', day ([Birth Day 2016]), '/', year ([Birth Day 2016]))
	end [Celebration Date],
	iif (datepart (weekday, [Birth Day 2016]) in (1, 7), 'Monday', datename (weekday, [Birth Day 2016])) [Celebration Day of Week]
from ##BdayTemp
