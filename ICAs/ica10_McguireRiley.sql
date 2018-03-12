--ica10 McGuire Riley

--q1
select
	CompanyName as 'Company Name',
	ProductName as 'Product Name',
	UnitPrice as 'Unit Price'
from 
	Products right outer join Suppliers
	on Products.SupplierID = Suppliers.SupplierID
order by CompanyName, [Product Name]
go
--q2
select
	CompanyName as 'Company Name',
	ProductName as 'Product Name',
	UnitPrice as 'Unit Price'
from 
	Products right outer join Suppliers
	on Products.SupplierID = Suppliers.SupplierID
where
	ProductName is null
order by CompanyName, [Product Name]
go
--q3
select
	Employees.LastName + ', ' + Employees.FirstName as 'Name',
	OrderDate as 'Order Date'
from 
	Employees left outer join Orders
	on Employees.EmployeeID = Orders.EmployeeID
where
	OrderDate is null
go
--q4
select top 5
	Products.ProductName as 'Product Name',
	[Order Details].Quantity as 'Quantity'
from
	Products left outer join [Order Details]
	on Products.ProductID = [Order Details].ProductID
order by Quantity
go
--q5
select top 10
	Suppliers.CompanyName as 'Company',
	Products.ProductName as 'Product',
	[Order Details].Quantity as 'Quantity'
from
	Suppliers left outer join Products
	on Suppliers.SupplierID = Products.SupplierID
	left outer join [Order Details]
	on Products.ProductID = [Order Details].ProductID
order by Quantity, Company desc
go
--q6
select 
	CompanyName as 'Customer/Supplier with Nothing'
from 
	Customers left outer join Orders
	on Customers.CustomerID = Orders.CustomerID
	where Orders.CustomerID is null
union
select 
	CompanyName as 'Customer/Supplier with Nothing'
from
	Suppliers left outer join Products
	on Suppliers.SupplierID = Products.SupplierID
	where Products.SupplierID is null
order by CompanyName
go
--q7
select
	'Customer' as 'Type', 
	CompanyName as 'Customer/Supplier with Nothing'
from 
	Customers left outer join Orders
	on Customers.CustomerID = Orders.CustomerID
	where Orders.CustomerID is null
union
select 
	'Supplier' as 'Type',
	CompanyName as 'Customer/Supplier with Nothing'
from
	Suppliers left outer join Products
	on Suppliers.SupplierID = Products.SupplierID
	where Products.SupplierID is null
order by Type, CompanyName desc
go
