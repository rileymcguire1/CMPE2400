--ica06 McGuire Riley

--q1
declare @max as money = 1.89
declare @min as money = 1.69
select
	left(Name, 24) as 'Name',
	UnitPrice as 'Unit Price'
from
	Track
where
	GenreId in (13, 25) and UnitPrice <= @max and UnitPrice >= @min
order by Name
go

--q2
declare @min as money = 16
declare @max as money = 18
select
	InvoiceId as 'Invoice Id',
	TrackId as 'Track Id',
	UnitPrice*Quantity as 'Value'
from 
	InvoiceLine
where UnitPrice*Quantity >= @min and UnitPrice*Quantity <=@max
order by 'Value' desc
go


--q3
declare @word1 as varchar(5) = 'white'
declare @word2 as varchar(5) = 'black'
select
	left(Name, 48) as 'Name',
	left(Composer, 12) as 'Composer',
	UnitPrice as 'Unit Price'
from 
	Track
where 
	Name like '%'+@word1+'%' or Name like '% '+@word2+' %'
order by Name	
go

--q4
declare @target as money = 13
declare @InvoiceStart as int = 200
select
	cast(InvoiceId as varchar(6))+':'+cast(TrackId as varchar(6)) as 'Inv:Track',
	UnitPrice as 'Unit Price',
	Quantity as 'Quantity',
	UnitPrice*Quantity as 'Cost'
from 
	InvoiceLine
where 
	UnitPrice*Quantity + 1 >= @target 
	and UnitPrice*Quantity - 1 <= @target
	and InvoiceId >= @InvoiceStart
	and InvoiceId <= @InvoiceStart +100
order by InvoiceId, TrackId desc
go

--q5
select 
	left(FirstName,24) as 'First Name',
	PostalCode as 'PC',
	Phone as 'Phone',
	left(Email, 24) as 'Email'
from 
	Customer
where
	PostalCode like '[A-Z][0-9][A-Z] [0-9][A-Z][0-9]'
	or Phone like '%[0-2][0-2][0-2][0-2]%'
order by [First Name]
go

--q6
select 
	LastName as 'LastName',
	Datediff(year,birthdate, GetDate())+DATEDIFF(year, hiredate, getdate()) as 'Magic Number',
	case
		when Datediff(year,birthdate, GetDate())+DATEDIFF(year, hiredate, getdate()) < 85 then cast(85-(Datediff(year,birthdate, GetDate())+DATEDIFF(year, hiredate, getdate())) as varchar)
		else 'Yup'
	end as 'Yet?'

from 
	Employee
order by 'Magic Number'
go

--q7
select 
	LastName as 'Last Name',
	City as 'City',
	Country as 'Country'
from Customer
where
	Country not like '%[aemy]'
	and Company is not null
order by country, city
go

--q8
select distinct
	Country as 'Country'
from Customer
where
	country like '[A-F]%'
order by country desc
go

--q9
declare @NameLength as int = 3
select distinct
	substring(name,1,CHARINDEX(' ', name)) as 'First Word'
from Track
where
	GenreId like 1
	and len(substring(name,1,CHARINDEX(' ', name))) > @NameLength
	and name like '[aeoui]%'
order by substring(name,1,CHARINDEX(' ', name))
go

