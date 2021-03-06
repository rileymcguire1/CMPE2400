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
declare @min as int = 420000
select
	TrackId as 'Track ID',
	left(Name, 24) as 'Name',
	left(Composer, 64) as 'Written by'
from 
	Track
where
	GenreId = 2 and Milliseconds > @min and Milliseconds < @max
	
go

--Q5
select
	left(Company, 48) as 'Company Name',
	LastName as 'Contact',
	left(Address, 36) as 'Street Address'
from 
	Customer
where
	Country in ('argentina', 'brazil', 'Ecuador', 'Suriname', 'Bolivia', 'Guyana', 'Uruguay', 'Chile', 'Colombia', 'Paraguay', 'Peru', 'Venezuela') and Company is not null
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
select
	TrackId as 'Track ID',
	convert(time(3),DATEADD(ms, milliseconds, 0), 114) as 'Time',
	cast(UnitPrice/(Milliseconds/1000.0/60.0) as money) as 'Cost/Minute',
	cast(Bytes*1000.0/Milliseconds as decimal(8,3)) as 'Bytes/Second'
from 
	Track
where
	milliseconds>60000 and (UnitPrice/(Milliseconds/1000.0/60.0))>2.75
go