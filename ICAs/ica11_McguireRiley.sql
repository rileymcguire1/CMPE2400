--ica10 McGuire Riley

--q1
select 
	e.LastName + ', ' + e.FirstName as 'Name',
	count(*) as 'Num Orders'
from 
	Employees as e inner join Orders as o
	on e.EmployeeID = o.EmployeeID
group by 
	e.LastName, 
	e.FirstName
order by [Num Orders] desc
go

--q2
select 
	e.LastName + ', ' + e.FirstName as 'Name',
	AVG(freight) as 'Average Freight',
	convert(varchar, MAX(OrderDate),106) as 'Newest Order Date'
from 
	Employees as e inner join Orders as o
	on e.EmployeeID = o.EmployeeID
group by 
	e.LastName, 
	e.FirstName
order by MAX(OrderDate), LastName
go

--q3
select
	s.CompanyName as 'Supplier',
	s.Country as 'Country',
	count(p.productid) as 'Num Products',
	AVG(p.UnitPrice) as 'Avg Price'
from
	Suppliers as s left outer join Products as p
	on s.SupplierID = p.SupplierID
where CompanyName like '[HURT]%'
group by CompanyName, Country
order by count(p.productid)
go

--q4
declare @countrySelect as nvarchar(20) = 'USA'
select 
	s.CompanyName as 'Supplier',
	s.Country as 'Country',
	MIN(COALESCE( p.unitprice, 0)) as 'Min Price',
	MAX(COALESCE( p.unitprice, 0)) as 'Max Price'
from 
	Suppliers as s left outer join Products as p
	on s.SupplierID = p.SupplierID
where 
	Country = @countrySelect
group by 
	companyname, country
order by 
	[Min Price]
go

--q5
select
	c.CompanyName as 'Customer',
	c.City as 'City',
	convert(varchar, o.OrderDate,106) as 'Order Date',
	COUNT(od.Quantity) as 'Products in Order'
from
	Customers as c left outer join Orders as o
	on c.CustomerID = o.CustomerID
	left outer join [Order Details] as od
	on o.OrderID = od.orderid
where 
	city like 'Walla Walla' or
	country like 'Poland'
group by CompanyName, city, OrderDate
order by [Products in Order]
go

--q6
select
	e.LastName + ', ' + e.FirstName as 'Name',
	SUM(od.unitprice*od.quantity) as 'Sales Total',
	COUNT(od.OrderID) as 'Detail Items'
from 
	Employees as e left outer join orders as o
	on e.EmployeeID = o.EmployeeID
	left outer join [Order Details] as od
	on o.OrderID = od.OrderID
group by e.LastName, e.FirstName
order by [Sales Total] desc
go
