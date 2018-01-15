--ica02 McGuire Riley

--q1
declare @Server as nVarchar(max)
declare @Version as nVarchar(max)
declare @Errors as int
declare @Connections as int
declare @Rcvd as decimal(5,2)

set @Server = @@SERVERNAME
set @Version = @@VERSION
set @Errors = @@ERROR
set @Connections = @@CONNECTIONS
set @Rcvd = cast(@@PACK_RECEIVED as real) / cast(@@PACK_SENT as real) *100

select 
		cast(@Server as nVarchar(20)) as 'Server',
		cast(@Version as nvarchar(35)) as 'Version',
		@Errors as 'Errors',
		@Connections as 'Connections',
		cast(@Rcvd as varchar(5)) + '%' as 'Rcvd%'
go

--q2
declare @month as nvarchar(max)
declare @day as int
declare @year as int
declare @back as datetime

set @month = DATENAME(month, GETDATE())
set @day = DATEPART(day, GetDate())
set @year = DATEPART(year, Getdate())
set @back = DATEADD (minute, -123456789, GETDATE())

select
		cast(@month as nvarchar(12)) +' '+ cast(@day as nvarchar(2)) + ' ' + cast(@year as nvarchar(4)) as 'Start',
		convert(varchar(20) ,@back , 120)  as 'Wayback'
go

--q3
declare @Christmas as date
declare @Days as smallint
declare @CurrentYear as int

set @CurrentYear = DATEPART(year, getdate())
set @Christmas = DATEFROMPARTS(@CurrentYear, 12, 25)
set @days = datediff(day, GETDATE(), @christmas)

select
	@days as 'Days',
	convert(nvarchar(15), @Christmas, 102) as 'XMas'
go

--q4
declare @MonthName as nvarchar(24)
declare @MonthNumber as int
declare @season as varchar(max)
declare @GotP as varchar(max)

set @MonthName = DATEName(month, getdate())
set @MonthNumber = datepart(m, getdate())

if @MonthNumber < 5
		set @season = 'Winter'
else
if @MonthNumber < 10
		set @season = 'Summer'
else
		set @season = 'Winter'

if @MonthName like '%p%'
		set @GotP = 'Yup'
else
		set @GotP = 'Nope'

select
		cast(@MonthName as nvarchar(24)) + '(' + cast(@MonthNumber as nvarchar(2)) + ')' as 'Name(#)',
		cast(@season as varchar(8)) as 'Season',
		cast(@GotP as varchar(8)) as 'Gotta p'
go
