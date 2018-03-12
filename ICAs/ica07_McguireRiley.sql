--ica07 McGuire Riley

--q1
declare @weight as int = 800;
select 
	LastName as 'Last Name',
	Title as 'Title'
from Employees
where EmployeeID in (
	select EmployeeID
	from Orders
	where Freight > @weight
)
order by [Last Name]
go

--q2
declare @weight as int = 800
select 
	LastName as 'Last Name',
	Title as 'Title'
from Employees as outty
where exists (
	select *
	from Orders as inny
	where Freight > @weight and inny.EmployeeID = outty.EmployeeID
)
order by [Last Name]
go
--q3
select 
	ProductName as 'Product Name',
	UnitPrice as 'Unit Price'
from products
where supplierId in
(
	select SupplierID
	from Suppliers
	where Country in ('Sweden','Italy')
)
order by UnitPrice
go
--q4
select 
	ProductName as 'Product Name',
	UnitPrice as 'Unit Price'
from products
where exists
(
	select *
	from Suppliers
	where Country in ('Sweden','Italy') and products.SupplierID = Suppliers.SupplierID
)
order by UnitPrice
go

--q5
declare @price as int = 20
select 
	ProductName as 'ProductName'
from Products
where UnitPrice> @price and CategoryID in
(
	select CategoryID
	from Categories
	where CategoryName in ('confections', 'seafood')
)
order by CategoryID, ProductName
go

--q6
declare @price as int = 20
select 
	ProductName as 'ProductName'
from Products
where UnitPrice> @price and exists
(
	select *
	from Categories
	where CategoryName in ('confections', 'seafood') and Products.CategoryID = Categories.CategoryID
)
order by CategoryID, ProductName
go

--q7
declare @details as int = 15
select
	CompanyName as 'Company Name',
	Country as 'Country'
from Customers
where 
	CustomerID in
		(
			select CustomerID
			from Orders
			where 
				OrderID in
					(
						select OrderID
						from [Order Details]
						where UnitPrice * Quantity < @details
					)
		)
order by Country
go

--q8
declare @details as int = 15
select
	CompanyName as 'Company Name',
	Country as 'Country'
from Customers
where 
	exists
		(
			select *
			from Orders
			where customers.CustomerID = orders.CustomerID and
				exists
					(
						select *
						from [Order Details]
						where UnitPrice * Quantity < @details and [Order Details].OrderID = orders.OrderID
					)
		)
order by Country
go

--q9
declare @days as int = 7
select 
	ProductName as 'ProductName'
from Products
where 
	ProductID in
	(
		select ProductID
		from [Order Details]
		where 
			orderID in
			(
				select orderID
				from Orders
				where DATEDIFF(day, RequiredDate,shippedDate) > @days and
					CustomerID in
					(
						select CustomerID
						from Customers
						where Country in ('UK', 'USA')
					)
			)
	)
order by ProductName
go

--q10
select
	OrderID as 'OrderID',
	ShipCity as 'ShipCity'
from Orders as outty
where 
	OrderID in 
	(
		select OrderID
		from [Order Details]
		where 
			ProductID in 
			(
				select ProductID
				from Products
				where 
					SupplierID in
					(
						select 
							SupplierID
						from Suppliers as inny
						where inny.City = outty.ShipCity
					)
			)
	)
order by ShipCity
go