use chinook

--------------1

select
	FirstName,
	LastName
from Employee
where ReportsTo is not null

--------------2

select *
from Customer
where state != 'ca'
or state is null

--------------3

select *
from Invoice
where InvoiceDate between '04-02-2010' and '05-01-2010'

--------------4

select
	Title,
	AlbumId
from Album
where Title like 'The%'

--------------5

select
	Title,
	AlbumId
from Album
where Title like '[^a-z]%'

--------------6

select
	CustomerId, BillingCity, BillingCountry, InvoiceDate
from invoice
where BillingCountry in ('canada', 'germany', 'france', 'spain', 'india')
order by InvoiceDate desc

--------------7

select *
from Album
where exists (
	select *
	from Artist
	where
		artist.ArtistId = Album.ArtistId and
		artist.Name like '%black%'
		)

--------------8

select * from track
where not exists (
	select * from InvoiceLine
	where InvoiceLine.TrackId = track.TrackId
	)

--------------9

select * from track
where 
	(MediaTypeId = 5 and
	GenreId != 1) or 
	composer = 'Gene Simmons'

-------------10

select * from track
where 
	AlbumId = 237 and
	(Composer like '%Dylan%' or
	 Composer like '%Hendrix%')

