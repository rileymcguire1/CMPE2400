--ICA09RileyMcGuire

--q1
declare @country as nvarchar(3) = 'USA'
select 
	S.CompanyName as 'Company Name',
	p.ProductName as 'Product Name',
	p.UnitPrice as 'Unit Price'
from 
	Suppliers as S inner join Products as P
	on S.SupplierID = P.SupplierID
where s.Country like @country
order by [Company Name], [Product Name]
go

--q2
select
	EMP.LastName + ', ' + EMP.FirstName as 'Name',
	TER.TerritoryDescription as 'Territory Desciption'
from
	Employees as EMP inner join EmployeeTerritories as ETR
	on EMP.EmployeeID = ETR.EmployeeID
	inner join Territories as TER
	on ETR.TerritoryID = TER.TerritoryID
where
	EMP.LastName like '%ul%'
order by ter.TerritoryDescription
go
--q3
declare @country as varchar(6) = 'Sweden'
select distinct
	ORD.CustomerID as 'Customer ID',
	PRO.ProductName as 'Product Name'
from
	Orders as ORD inner join [Order Details] as ODE
	on ORD.OrderID = ODE.OrderID
	inner join Products as PRO
	on ODE.ProductID = PRO.ProductID
where ORD.CustomerID in
	(
		select  CustomerID
		from Customers
		where 
			country like @country
	) and
	pro.ProductName like '[U-Z]%'
order by pro.ProductName
go

--q4
declare @SellingPrice as money = 69
select distinct
	Cat.CategoryName as 'Category Name',
	PRO.UnitPrice as 'Product Price',
	ODE.UnitPrice as 'Selling Price'
from 
	Categories as CAT inner join Products as PRO
	on CAT.CategoryID = PRO.CategoryID
	inner join [Order Details] as ODE
	on PRO.ProductID = ode.ProductID
where
	ode.UnitPrice > @SellingPrice and
	not ode.UnitPrice = PRO.UnitPrice
order by ode.UnitPrice
go
--q5
declare @days as int = 8
select
	ShipName as 'Ship Name',
	ProductName as 'Product Name'
from
	Orders as ORD inner join [Order Details] as ODE
	on ORD.OrderID = ODE.OrderID
	inner join Products as PRO
	on pro.ProductID = ode.ProductID
where 
	Discontinued = 1 and
	DATEDIFF(day, requireddate, shippeddate) > @days
order by ShipName
go
