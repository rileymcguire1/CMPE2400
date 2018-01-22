--ICA05 RileyMcGuire

--Q1
select *
from Genre
go

--Q2
select 
	CustomerId as'Customer ID',
	LastName as 'Last Name',
	FirstName as 'First Name',
	Company as 'Company Name'
from 
	Customer
go

--Q3
select
	CustomerId as 'Customer ID',
	cast(FirstName as varchar(18)) as 'First Name',
	cast(Country as varchar(18)) as 'Country',
	cast(State as varchar (18)) as 'Region'
from 
	Customer
where 
	Fax is null and State is not null
go

--Q4
declare @max as int = 480000
select
	TrackId as 'Track ID',
	left(Name, 24) as 'Name',
	left(Composer, 64) as 'Written by'
from 
	Track
where
	GenreId = 2 and Milliseconds > 420000 and Milliseconds < @max
	
go

--Q5
select
	left(Company, 48) as 'Company Name',
	LastName as 'Name',
	left(Address, 36) as 'Street Address'
from 
	Customer
where
	Country in ('argentina', 'brazil') and Company is not null
go

--Q6
select 
	TrackId as 'Track ID',
	left(Name, 50) as 'Title',
	Composer
from 
	Track
where
	(name like 'black%' or Composer like '%verd%') and 
	GenreId not in ('1', '3', '5', '7', '9')
go

--Q7
declare 
	@time as time = dateadd(ms, Milliseconds, 0),
	@cost as float
select
	TrackId as 'Track ID',
	@time as 'Time',
	@cost as 'Cost/Minute'
from 
	Track
go