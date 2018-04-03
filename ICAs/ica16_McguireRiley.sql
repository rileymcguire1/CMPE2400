--ica 16 riley mcguire

-- You will need to install a personal version of the ClassTrak database
-- The Full and Refresh scripts are on the Moodle site.
-- Once installed, you can run the refresh script to restore data that may be modified or 
--  deleted in the process of completing this ica.

use  rmcguire2_ClassTrak
go

-- q1
-- Complete an update to change all classes to have their descriptions be lower case
-- select all classes to verify your update
update classes
set class_desc = lower(class_desc)
select *
from Classes
go

-- q2
-- Complete an update to change all classes have 'Web' in their 
-- respective course description to be upper case
-- select all classes to verify your selective update
update Classes
set class_desc = UPPER(class_desc)
from 
	classes as cl inner join Courses as co
	on cl.course_id = co.course_id
where co.course_desc like '%web%'
select *
from Classes
go

-- q3
-- For class_id = 123
-- Update the score of all results which have a real percentage of less than 50
-- The score should be increased by 10% of the max score value, maybe more pass ?
-- Use ica13_06 select statement to verify pre and post update values,
--  put one select before and after your update call.
declare @class_id as int = 123
select
	at.ass_type_desc as 'Type',
	Round(AVG(rs.score), 2) as 'Raw Avg',
	Round(AVG(rs.score/rq.max_score*100), 2) as 'Avg',
	COUNT(score) as 'Num'
from 
 	Assignment_type as at inner join Requirements as rq
	on at.ass_type_id = rq.ass_type_id
	inner join Results as rs
	on rq.req_id = rs.req_id
where 
	rs.class_id = @class_id
group by 
	at.ass_type_desc
order by ass_type_desc


update Results
set score = score + (max_score / 10)
from 
	results as res inner join Requirements as req
	on res.req_id = req.req_id and res.class_id = req.class_id
where score/max_score *100 < 50

select
	at.ass_type_desc as 'Type',
	Round(AVG(rs.score), 2) as 'Raw Avg',
	Round(AVG(rs.score/rq.max_score*100), 2) as 'Avg',
	COUNT(score) as 'Num'
from 
 	Assignment_type as at inner join Requirements as rq
	on at.ass_type_id = rq.ass_type_id
	inner join Results as rs
	on rq.req_id = rs.req_id
where 
	rs.class_id = @class_id
group by 
	at.ass_type_desc
order by ass_type_desc
go