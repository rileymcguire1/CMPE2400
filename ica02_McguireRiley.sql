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
set @Rcvd = cast(@@PACK_RECEIVED as real) / cast(@@PACK_SENT as real)

select 
		cast(@Server as nVarchar(20)) as 'Server',
		cast(@Version as nvarchar(35)) as 'Version',
		@Errors as 'Errors',
		@Connections as 'Connections',
		@Rcvd as 'Rcvd%'
go

--q2
declare @start as nvarchar(max)
declare @back as smalldatetime

set @start = 'October 31 2000'
--set @back = DATEADD (minute, -123456789, convert(smalldatetime, GETDATE(),9)

select
		cast(@start as nvarchar(20)) as 'Start',
		@back as 'Wayback'
go

--q3

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
