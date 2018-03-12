--ica13 McGuire Riley

--q1
if exists ( select * from sysobjects where name = 'ica13_01' )
drop procedure ica13_01
go
create procedure ica13_01
as
	select 
		e.LastName + ', ' + e.FirstName as 'Name',
		count(*) as 'Num Orders'
	from 
		NorthwindTraders.dbo.Employees as e inner join NorthwindTraders.dbo.Orders as o
		on e.EmployeeID = o.EmployeeID
	group by 
		e.LastName, 
		e.FirstName
	order by [Num Orders] desc
go

exec ica13_01
go

--q2
if exists ( select * from sysobjects where name = 'ica13_02' )
drop procedure ica13_02
go
create procedure ica13_02
as
select
	e.LastName + ', ' + e.FirstName as 'Name',
	SUM(od.unitprice*od.quantity) as 'Sales Total',
	COUNT(od.OrderID) as 'Detail Items'
from 
	NorthwindTraders.dbo.Employees as e left outer join NorthwindTraders.dbo.orders as o
	on e.EmployeeID = o.EmployeeID
	left outer join NorthwindTraders.dbo.[Order Details] as od
	on o.OrderID = od.OrderID
group by e.LastName, e.FirstName
order by [Sales Total] desc
go
exec ica13_02
go

--q3
if exists ( select * from sysobjects where name = 'ica13_03' )
drop procedure ica13_03
go
create procedure ica13_03
@maxPrice as int = null
as
select
	CompanyName as 'Company Name',
	Country as 'Country'
from NorthwindTraders.dbo.Customers
where 
	CustomerID in
		(
			select CustomerID
			from NorthwindTraders.dbo.Orders
			where 
				OrderID in
					(
						select OrderID
						from NorthwindTraders.dbo.[Order Details]
						where UnitPrice * Quantity < @details
					)
		)
order by Country
go

exec ica13_03 15
go

exec ica13_03 @maxPrice = 15
go

--q4
if exists ( select * from sysobjects where name = 'ica13_04' )
drop procedure ica13_04
go
create procedure ica13_04
@minPrice as money = null,
@categoryName as nvarchar(24) = ''
as
select 
	ProductName as 'ProductName'
from NorthwindTraders.dbo.Products
where UnitPrice> @minPrice and exists
(
	select *
	from NorthwindTraders.dbo.Categories
	where CategoryName like @categoryName and Products.CategoryID = Categories.CategoryID
)
order by CategoryID, ProductName
go

exec ica13_04 20, 'confections'
go

exec ica13_04 @categoryName = 'confections', @minPrice = 20
go

--q5
if exists (select * from sysobjects where name = 'ica13_05')
drop procedure ica13_05
go
create procedure ica13_05
@minPrice as money = null,
@country as nvarchar(24) = 'USA'
as
	select 
		s.CompanyName as 'Supplier',
		s.Country as 'Country',
		MIN(COALESCE( p.unitprice, 0)) as 'Min Price',
		MAX(COALESCE( p.unitprice, 0)) as 'Max Price'
	from 
		NorthwindTraders.dbo.Suppliers as s left outer join NorthwindTraders.dbo.Products as p
		on s.SupplierID = p.SupplierID
	where 
		Country = @country
	group by 
		companyname, country
	having 
		MIN(COALESCE( p.unitprice, 0)) > @minPrice
	order by 
		[Min Price]
go

exec ica13_05 15
go
exec ica13_05 @minPrice = 15
go
exec ica13_05 @minPrice = 5, @country = 'UK'
go

--q6
if exists (select * from sysobjects where name= 'ica13_06')
drop procedure ica13_06
go
create procedure ica13_06
@class_id as int = 0
as
select
	at.ass_type_desc as 'Type',
	Round(AVG(rs.score), 2) as 'Raw Avg',
	Round(AVG(rs.score/rq.max_score*100), 2) as 'Avg',
	COUNT(score) as 'Num'
from 
 	ClassTrak.dbo.Assignment_type as at inner join ClassTrak.dbo.Requirements as rq
	on at.ass_type_id = rq.ass_type_id
	inner join ClassTrak.dbo.Results as rs
	on rq.req_id = rs.req_id
where 
	rs.class_id = @class_id
group by 
	at.ass_type_desc
order by ass_type_desc
go

exec ica13_06 88
go
exec ica13_06 @class_id = 89
go

--q7
if exists (select * from sysobjects where name= 'ica13_07')
drop procedure ica13_07
go
create procedure ica13_07
@year as int,
@minAvg as int = 50,
@minSize as int = 10
as
select 
	st.last_name + ', ' + st.first_name as 'Student',
	cl.class_desc as 'Class',
	at.ass_type_desc as 'Type',
	Count(rs.score) as 'Submitted',
	Round(AVG(rs.score/rq.max_score*100),1) as 'Avg'
from 
	ClassTrak.dbo.Students as st inner join ClassTrak.dbo.Results as rs
	on st.student_id = rs.student_id
	inner join ClassTrak.dbo.Requirements as rq
	on rs.req_id = rq.req_id
	inner join ClassTrak.dbo.Assignment_type as at
	on rq.ass_type_id = at.ass_type_id
	inner join ClassTrak.dbo.Classes as cl
	on rs.class_id = cl.class_id
where
	DATEPART(year, cl.start_date) = @year
	and rs.score is not null
group by 
	st.last_name, st.first_name, cl.class_desc, at.ass_type_desc
having
	Count(rs.score) > @minSize
	and AVG(rs.score/rq.max_score*100) < @minAvg
order by Count(rs.score), AVG(rs.score/rq.max_score*100)
go
exec ica13_07 @year=2011
go
exec ica13_07 @year=2011, @minAvg=40, @minSize=15
go