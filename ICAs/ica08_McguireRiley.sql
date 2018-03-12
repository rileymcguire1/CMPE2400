--ica07 McGuire Riley

--Q1
select top 1
	CompanyName as 'Supplier Company Name',
	Country as 'Country'
from Suppliers
order by Country
go

--Q2
select top 1 with ties
	CompanyName as 'Supplier Company Name',
	Country as 'Country'
from Suppliers
order by Country
go

--Q3
select top 10 percent
	ProductName as 'Product Name',
	UnitsInStock as 'Units in Stock'
from Products
order by UnitsInStock desc
go

--Q4
select 
	CompanyName as 'Customer Company Name',
	Country as 'Country'
from Customers
where
	CustomerID in
	(
		select top 8
			CustomerID
		from Orders
		order by Freight desc
	)
go

--Q5
select 
	CustomerID as 'Customer ID',
	OrderID as 'Order ID',
	convert(varchar(12),OrderDate,106) as 'Order Date'
from Orders
where
	OrderID in
	(
		select top 3
			OrderID
		from [Order Details]
		order by Quantity desc
	)
order by [Customer ID]
go

--Q6
select 
	CustomerID as 'Customer ID',
	OrderID as 'Order ID',
	convert(varchar(12),OrderDate,106) as 'Order Date'
from Orders
where
	OrderID in
	(
		select top 3 with ties
			OrderID
		from [Order Details]
		order by Quantity desc
	)
order by [Customer ID]
go

--Q7
select	
	CompanyName as 'Supplier Company Name',
	Country as 'Country'
from Suppliers
where
	SupplierID in
	(
		select SupplierID
		from Products
		where
			ProductID in 
				(
					select top 1 percent 
						ProductID
					from [Order Details]
					order by UnitPrice*Quantity desc
				)
	)
order by Country, CompanyName
go
