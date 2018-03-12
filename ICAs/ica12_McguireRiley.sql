--ica12 McGuire Riley

--q1
declare @classNumber as int = 88
select
	at.ass_type_desc as 'Type',
	AVG(rs.score) as 'Raw Avg',
	AVG(rs.score/rq.max_score*100) as 'Avg',
	COUNT(score) as 'Num'
from 
	Assignment_type as at inner join Requirements as rq
	on at.ass_type_id = rq.ass_type_id
	inner join Results as rs
	on rq.req_id = rs.req_id
where 
	rs.class_id = @classNumber
group by 
	at.ass_type_desc
order by ass_type_desc
go

--q2
declare @classNumber as int = 88
select
	cast(rq.ass_desc + '(' + at.ass_type_desc + ')' as varchar(35)) as 'Desc(Type)',
	Round(AVG(rs.score/rq.max_score*100),2) as 'Avg',
	Count(rs.score) as 'Num Score'
from 
	Assignment_type as at inner join Requirements as rq
	on at.ass_type_id = rq.ass_type_id
	inner join Results as rs
	on rq.req_id = rs.req_id
where
	rs.class_id = @classNumber
group by rq.ass_desc, at.ass_type_desc
having 
	AVG(rs.score/rq.max_score*100) > 57
order by at.ass_type_desc, rq.ass_desc
go

--q3
declare @classNumber as int = 123
select 
	st.last_name as 'Last',
	at.ass_type_desc,
	Round(min(rs.score/rq.max_score*100), 1) as 'Low',
	Round(max(rs.score/rq.max_score*100),1) as 'High',
	Round(AVG(rs.score/rq.max_score*100),1) as 'Avg'
from 
	Students as st inner join Results as rs
	on st.student_id = rs.student_id
	inner join Requirements as rq
	on rs.req_id = rq.req_id
	inner join Assignment_type as at
	on rq.ass_type_id = at.ass_type_id
where rq.class_id = @classNumber
group by st.last_name, at.ass_type_desc
having AVG(rs.score/rq.max_score*100)>70
order by at.ass_type_desc, Avg
go

--q4
select
	it.last_name as 'Instructor',
	convert(varchar(12), cl.start_date,106) as 'Start',
	Count(cs.student_id) as 'Num Registered',
	Sum(Cast(cs.active as int)) as 'Num Active'
from
	Instructors as it inner join Classes as cl
	on it.instructor_id = cl.instructor_id
	inner join class_to_student as cs
	on cl.class_id = cs.class_id
group by 
	it.last_name, cl.start_date
having 
	count(cs.student_id) - Sum(Cast(cs.active as int)) > 3
order by it.last_name, cl.start_date
go

--q5
declare @scoreAvg as int = 40
declare @startYear as int = 2011
select 
	st.last_name + ', ' + st.first_name as 'Student',
	cl.class_desc as 'Class',
	at.ass_type_desc as 'Type',
	Count(rs.score) as 'Submitted',
	Round(AVG(rs.score/rq.max_score*100),1) as 'Avg'
from 
	Students as st inner join Results as rs
	on st.student_id = rs.student_id
	inner join Requirements as rq
	on rs.req_id = rq.req_id
	inner join Assignment_type as at
	on rq.ass_type_id = at.ass_type_id
	inner join Classes as cl
	on rs.class_id = cl.class_id
where
	DATEPART(year, cl.start_date) = @startYear
	and rs.score is not null
group by 
	st.last_name, st.first_name, cl.class_desc, at.ass_type_desc
having
	Count(rs.score) > 10
	and AVG(rs.score/rq.max_score*100) < @scoreAvg
order by Count(rs.score), AVG(rs.score/rq.max_score*100)
go
