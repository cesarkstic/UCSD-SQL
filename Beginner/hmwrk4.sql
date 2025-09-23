-- Cesar Castro

use Chinook

--------------1

select
	Artist.Name ArtistName,
	Album.Title AlbumTitle
from Artist
join Album
	on Album.ArtistId = Artist.ArtistId
where Artist.Name like '[A-D]%'
order by ArtistName, AlbumTitle

--------------2

select
	Artist.Name ArtistName,
	Album.Title AlbumTitle
from Artist
left join Album
	on Album.ArtistId = Artist.ArtistId
where Artist.Name like '[A-D]%'
order by ArtistName, AlbumTitle

--------------3

select 
	Artist.Name ArtistName,
	Track.Name TrackTitle
from Genre
join Track
	on Track.GenreID = Genre.GenreId
join Album
	on Album.AlbumId = Track.AlbumId
join Artist
	on Artist.ArtistId = Album.ArtistId
where
	Genre.Name = 'alternative'
order by ArtistName, TrackTitle

--------------4

select
	Employee.FirstName,
	Employee.LastName
from Employee
cross join Employee XE
order by Employee.FirstName

--------------5

select
	Playlist.Name PlaylistName,
	Artist.Name ArtistName,
	Album.Title AlbumName,
	Track.Name TrackName,
	Genre.Name GenreName
from Playlist
join PlaylistTrack
	on PlaylistTrack.PlaylistId = Playlist.PlaylistId
join Track
	on Track.TrackId = PlaylistTrack.TrackId
join Album
	on Album.AlbumId = Track.AlbumId
join Artist
	on Artist.ArtistId = Album.ArtistId
join Genre
	on Genre.GenreId = Track.GenreId
where Playlist.Name = 'Grunge'

--------------6

select
	Album.Title AlbumName,
	Track.Name TrackName,
	Track.Milliseconds / 1000 Seconds
from Album
join Track
	on Track.AlbumId = Album.AlbumId
where Album.Title = 'Let There Be Rock'

--------------7

select
	CONCAT (Employee.firstname, ' ', Employee.LastName) CustomerRep,
	CONCAT (customer.firstname, ' ', Customer.LastName) CustomerName,
	Customer.Country
from Customer
join Employee
	on Employee.EmployeeId = Customer.SupportRepId
order by CustomerRep, customer.Country

--------------8

select
	Album.Title AlbumName,
	Track.Name TrackName,
	InvoiceLine.InvoiceId
from Album
join Track
	on Track.AlbumId = Album.AlbumId
left join InvoiceLine
	on InvoiceLine.TrackId = Track.TrackId
order by Track.Name desc, InvoiceLine.InvoiceId desc

--------------9

select
	Employee.EmployeeId,
	Employee.LastName,
	Employee.FirstName,
	iif (Employee.ReportsTo is null, 'N/A', concat (Manager.FirstName, ' ', Manager.LastName)) ManagerName
from Employee
left join Employee Manager
	on Manager.EmployeeId= Employee.ReportsTo

-------------10

select
	Customer.LastName,
	Album.Title,
	Track.Name,
	Invoice.InvoiceDate
from Customer
join Invoice
	on Invoice.CustomerId = Customer.CustomerId
join InvoiceLine
	on InvoiceLine.InvoiceId = Invoice.InvoiceId
join Track 
	on Track.TrackId = InvoiceLine.TrackId
join Album
	on Album.AlbumId = Track.AlbumId
where Customer.FirstName = 'julia' and
	  Customer.LastName = 'barnett'
order by Invoice.InvoiceDate, Album.Title, Track.Name