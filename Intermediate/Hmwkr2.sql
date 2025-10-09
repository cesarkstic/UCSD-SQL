-- Cesar Castro

USE Chinook
IF OBJECT_ID('Track_v_cc') IS NOT NULL DROP VIEW Track_v_cc
IF OBJECT_ID('ArtistAlbum_fn_cc') IS NOT NULL DROP FUNCTION ArtistAlbum_fn_cc
IF OBJECT_ID('TracksByArtist_p_cc') IS NOT NULL DROP PROC TracksByArtist_p_cc

go

--------------1

create view Track_v_cc as
select
	T.AlbumId,
	T.Bytes,
	T.Composer,
	G.Name as GenreName,
	M.Name as MediTypeName,
	T.Milliseconds,
	T.Name,
	T.TrackId,
	T.UnitPrice
from Track T
join Genre G
	on G.GenreId = T.GenreId
join MediaType M
	on M.MediaTypeId = T.MediaTypeId

go

--------------2

create function ArtistAlbum_fn_cc (@TrackId as int) returns varchar (100)
as begin
	declare @ArtistAlbum varchar (100)

	select 
		@ArtistAlbum = CONCAT (Ar.Name, ',', Al.Title)
	from Track T
	left join Album Al
		on Al.AlbumId = T.AlbumId
	left join Artist Ar
		on Ar.ArtistId = Al.ArtistId
	where T.TrackId = @TrackId

	return @ArtistAlbum
end

go

--------------3

create proc TracksByArtist_p_cc @ArtistName as varchar (100) AS

	select
		Ar.Name as ArtistName,
		Al.Title as AlbumTitle,
		T.Name as TrackName
	from Artist Ar
	left join Album Al
		on Al.ArtistId = Ar.ArtistId
	left join Track T
		on T.AlbumId = Al.AlbumId
	where Ar.Name like concat ('%', @ArtistName, '%')
go

--------------4

select
	Tv.Name as Title,
	Tv.GenreName,
	Tv.MediTypeName
from Track_v_cc Tv
where Tv.Name = 'babylon'

--------------5

select
	dbo.ArtistAlbum_fn_cc(Tv.TrackId) as 'Artist and Album',
	Tv.Name as TrackName
from Track_v_cc Tv
where Tv.GenreName = 'opera'

--------------6

execute TracksByArtist_p_cc 'black'
execute TracksByArtist_p_cc 'white'

go

--------------7

alter proc TracksByArtist_p_cc @ArtistName as varchar (100) = 'scorpions' AS

	select
		Ar.Name as ArtistName,
		Al.Title as AlbumTitle,
		T.Name as TrackName
	from Artist Ar
	left join Album Al
		on Al.ArtistId = Ar.ArtistId
	left join Track T
		on T.AlbumId = Al.AlbumId
	where Ar.Name like concat ('%', @ArtistName, '%')
go

--------------8

execute TracksByArtist_p_cc 

--------------9

begin transaction

update Employee
set LastName = 'Castro'
where Employee.EmployeeId = 1

--------------10

select
	EmployeeId,
	LastName
from Employee
where Employee.EmployeeId = 1

rollback transaction

select
	EmployeeId,
	LastName
from Employee
where Employee.EmployeeId = 1