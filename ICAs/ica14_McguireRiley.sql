--ica14 McGuire Riley

--q1
if exists ( select * from sysobjects where name = 'ica14_01' )
drop procedure ica14_01
go

create procedure ica14_01
@category as nvarchar(30) = null,
@ProductName as nvarchar(30) out,
@Quantity as int out
as
	select top 1
		@ProductName = p.ProductName,
		@Quantity = max(od.Quantity)
	from
		NorthwindTraders.dbo.Products as p inner join NorthwindTraders.dbo.[Order Details] as od
		on p.ProductID = od.ProductID
		inner join NorthwindTraders.dbo.Categories as c
		on c.CategoryID = p.CategoryID
		where c.CategoryName = @category
		group by p.ProductName
		order by max(od.Quantity) desc
	go

declare @Category as varchar(24) = 'Beverages'
declare @product as varchar(30)
declare @quantity as int

exec ica14_01 @Category, @ProductName = @product output, @Quantity = @quantity output
select 
	@Category as 'Category', 
	@product as 'ProductName',
	@quantity as 'Highest Qty'

set @Category = 'Confections'
exec ica14_01 @category = @Category, @ProductName = @product output, @Quantity = @quantity output
select 
	@Category as 'Category', 
	@product as 'ProductName',
	@quantity as 'Highest Qty'
go

--q2
if exists ( select * from sysobjects where name = 'ica14_02' )
drop procedure ica14_02
go

create procedure ica14_02
@year as int,
@name as varchar(64) out,
@freight as money out
as
	select top 1
		@name = e.LastName + ', ' + e.FirstName,
		@freight = AVG(freight)
	from 
		NorthwindTraders.dbo.Employees as e inner join NorthwindTraders.dbo.Orders as o
		on e.EmployeeID = o.EmployeeID
	where datepart(year,OrderDate) = @year
	group by 
		e.LastName, 
		e.FirstName
	order by AVG(freight) desc
	go	

declare @year as int = 1996
declare @name as varchar(64)
declare @freight as money 

exec ica14_02 @year, @name = @name out, @freight = @freight out
select
	@year as 'Year',
	@name as 'Name',
	@freight as 'Biggest Avg Freight'

set @year = 1997
exec ica14_02 @year = @year, @name = @name out, @freight = @freight out
select
	@year as 'Year',
	@name as 'Name',
	@freight as 'Biggest Avg Freight'
go

--q3
if exists ( select * from sysobjects where name = 'ica14_03' )
drop procedure ica14_03
go

create procedure ica14_03
@cid as int,
@ass_desc as varchar(50) = 'all'
as
select
	s.last_name as 'Last',
	a.ass_type_desc,
	Min(Round(r.score/req.max_score * 100, 1)) as 'Low',
	Max(Round(r.score/req.max_score * 100, 1)) as 'High',
	Avg(Round(r.score/req.max_score * 100, 1)) as 'Avg'
into #ClassInfo
from 
	ClassTrak.dbo.Students as S inner join ClassTrak.dbo.Results as R
	on S.student_id = r.student_id
	inner join ClassTrak.dbo.Requirements as Req
	on req.req_id = r.req_id and Req.class_id = R.class_id
	inner join ClassTrak.dbo.Assignment_type as A
	on a.ass_type_id = req.ass_type_id
where r.class_id = @cid
group by s.last_name, a.ass_type_desc
order by Avg(Round(r.score/req.max_score * 100, 1)) desc

if @ass_desc = 'ica'
	set	@ass_desc = 'Assignment'
else if @ass_desc = 'lab'
	set @ass_desc = 

select
	ci.Low
from
	#ClassInfo as ci

--q4

go

--q5

go