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
	select 
		@name = e.LastName + ', ' + e.FirstName,
		@freight = AVG(freight)
	from 
		NorthwindTraders.dbo.Employees as e inner join NorthwindTraders.dbo.Orders as o
		on e.EmployeeID = o.EmployeeID
	where datepart(year,OrderDate) = @year
	group by 
		e.LastName, 
		e.FirstName
	order by MAX(OrderDate), LastName
	go	

declare @year as int
declare @name as varchar(64)
declare @freight as money 

exec ica14_02 @year, @name = @name out, @freight = @freight out
select
	@year as 'Year',
	@name as 'Name',
	@freight as 'Biggest Avg Freight'
go

--q3

go

--q4

go

--q5

go