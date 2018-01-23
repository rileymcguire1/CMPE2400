--ICA03 McGuire Riley

--Q1
declare @var as int = rand() *100 +1
declare @div as nvarchar(3)
if @var%3 = 0
	set @div = 'yes'
else 
	set @div = 'no'
select
	@var as 'Random Number',
	@div as 'Factor of 3'
go

--Q2
declare @var as int = rand() *60 +1
declare @ballpark as nvarchar(15)
set @ballpark = case
	when @var<15 then 'on the hour'
	when @var<30 then 'quarter past'
	when @var<45 then 'half past'
	else 'quarter to'
end
select 
	@var as 'Minutes',
	@ballpark as 'Ballpark'
	
go

--Q3
declare @day as tinyint = datepart(weekday, dateadd(day, rand() *7, getdate()))
declare @status as nvarchar(10)
set @status = case @day
	when 1 then 'Yahoo'
	when 7 then 'Yahoo'
	else 'Got Class'
end
select
	@day as 'Day Number',
	@status as 'Status'
go

--Q4
declare @LoopCount as int = rand()*10000+1
declare @Loop as int = @loopcount
declare @var as int
declare @Factor2 as int = 0
declare @Factor3 as int = 0
declare @Factor5 as int = 0
while @LoopCount >0
	begin
		set @var = rand() * 10+1
		if @var%2=0
			set @Factor2 +=1
		if @var%3=0
			set @Factor3 +=1
		if @var%5=0
			set @Factor5 +=1
		set @LoopCount -= 1
	end
select
	@Loop as 'Number of Iterations',
	@Factor2 as 'Factor of 2',
	@Factor3 as 'Factor of 3',
	@Factor5 as 'Factor of 5'
go

--Q5
declare @X as float
declare @Y as float
declare @inside as int = 0
declare @Guess as int = 0
declare @approx as decimal(10, 9)
declare @PI as decimal(15,14) = PI()
while @Guess < 1000
	begin
		set @x = rand()*101
		set @y = rand()*101
		if (SQRT(@X*@X + @Y*@Y)) < 101
			set @inside +=1
		set @Guess +=1
		set @approx = 4.0 * @inside / @Guess
		if ABS(@approx - @PI) < 0.0002
			 break
	end
select
	@approx as 'Estimate',
	@PI as 'PI',
	@inside as 'In',
	@Guess as 'Tries'
go