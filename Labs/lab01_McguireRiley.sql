--lab 01 Riley McGuire

/*
--create database
USE [master]
GO
if exists 
(	
	select *
	from sysdatabases
	where [name] = 'rmcguire2_lab01'
)
drop database rmcguire2_lab01

create database rmcguire2_lab01
go
*/

use rmcguire2_lab01

-- drop tables if exists
if exists ( select * from sysobjects where name = 'Sessions' )
	drop table [Sessions]
if exists ( select * from sysobjects where name = 'Bikes' )
	drop table Bikes
if exists ( select * from sysobjects where name = 'Riders' )
	drop table Riders
if exists ( select * from sysobjects where name = 'Class' )
	drop table Class
go

--create all tables
create table Class
(
	ClassID varchar(6)
		constraint PK_Class_ClassID primary key,
	ClassDescription varchar(45)
)

create table Riders
(
	RiderID smallint identity (10, 1)
		constraint PK_Riders_RiderID primary key,
	Name varchar(64)
		constraint CHK_Riders_Name check (len (Name) > 4),
	ClassID varchar(6)
		constraint FK_Riders_ClassID foreign key
		references Class (ClassID) 
)

create table Bikes
(
	BikeID varchar(6) not null
		constraint CHK_Bikes_BikeID check (BikeID like '[0-9][0-9][0-9][HYS]-[AP]'),
	StableDate date
)

create table [Sessions]
(
	RiderID smallint,
	BikeID varchar(6),
	SessionDate datetime
		constraint CHK_Sessions_SessionDate check (SessionDate > 'Sep 1 2017'),
	Laps int

	constraint PK_Sessions_RiderID_BikeID_SessionDate primary key (RiderID, BikeID, SessionDate)
)
create nonclustered index NCI_RiderSession on Sessions (RiderID, BikeId)
go

--after table creation alter constraints
alter table Sessions add constraint CHK_Sessions_Laps check (Laps >=0)
alter table Bikes add constraint PK_Bikes_BikeID primary key (BikeID)
alter table Sessions add
	constraint FK_Sessions_RiderID foreign key (RiderID) references Riders (RiderID),
	constraint FK_Sessions_BikeID foreign key (BikeID) references Bikes (BikeID)

go

 