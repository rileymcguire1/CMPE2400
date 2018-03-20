--ica14 McGuire Riley

--q1
if exists ( select * from sysobjects where name = 'ica14_01' )
drop procedure ica14_01
go

create procedure ica14_01
@category as nvarchar(30) = null
as
	select top 5
		Products.ProductName as 'Product Name',
		[Order Details].Quantity as 'Quantity'
	from
		NorthwindTraders.dbo.Products left outer join NorthwindTraders.dbo.[Order Details]
		on Products.ProductID = [Order Details].ProductID
	order by Quantity
	go
exec ica14_01
go

--q2

go

--q3

go

--q4

go

--q5

go