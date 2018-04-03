-- ica15
-- This ICA is comprised of 2 parts, but should be tackled as described by your instructor.
-- To ensure end-to-end running, you will have to complete the ica in pairs where possible :
--  q1A + q2A, then q1B + q2B
-- You will need to install a personal version of the ClassTrak database
-- The Full and Refresh scripts are on the Moodle site.
-- Once installed, you can run the refresh script to restore data that may be modified or 
--  deleted in the process of completing this ica.

use  rmcguire2_ClassTrak
go

-- q1
-- All in one batch, to retain your variable contexts/values
declare @instructor as int
declare @course as int
declare @class as int
-- A
-- Insert a new Instructor : Donald Trump
--  Check column types, supply necessary values, it may require a column list
--  Save your identity into a variable
insert into Instructors(last_name, first_name)
values ('Trump','Donald')
set @instructor = @@IDENTITY

-- B
-- Insert a new Course : cmpe2442 "Fast and Furious - SQL Edition"
--  Check column types, supply necessary values, it may require a column list
--  Save your identity into a variable
insert into Courses (course_abbrev, course_desc)
values ('cmpe2442','Fast and Furious - SQL Edition')
set @course = @@IDENTITY
-- C
-- Insert a record indicating your new instructor is teaching the new course
--  description : "Beware the optimizer"
--  start_date : use 01 Sep 2016
--  Save the identity into a variable
insert into Classes(class_desc, course_id, instructor_id, start_date)
values('Beware the optimizer', @course, @instructor, '01 sep 2016')
set @class = @@IDENTITY
-- D Insert a bunch in one insert
-- Generate the insert statement to Add all the students with a last name that
--  starts with a vowel to the new class
insert into class_to_student
(class_id, student_id)
select 
	@class,
	student_id
from Students
where last_name like '[aeiou]%'
-- E
--  Prove it all, generate a select to show :
--   All instructors - see your new entry
--   All courses that have SQL in description
--   All classes that have a start_date after 1 Aug 2016
--   All students in the new class - filter by description having "Beware"
--       sort by first name in last name
select *
from Instructors

select	*
from courses
where course_desc like '%SQL%'

select *
from classes
where start_date > '1 aug 2016'

select 
	s.first_name,
	s.last_name
from 
	Students as s inner join class_to_student as cs
	on s.student_id = cs.student_id
	inner join classes as cl
	on cl.class_id = cs.class_id
where
	cl.class_desc like '%Beware%'
order by last_name, first_name
go
-- end q1



-- q2 - Undo all your changes to reset the database, you must do this in reverse order to
--      ensure you do not attempt to corrupt Referencial Integrity.
--     As such, work backwards from D to A, deleting what we added, but you must query the DB
--      to find and save the relevant keys.


-- D - Delete all students that have been assigned to your new class, do this without a 
--     variable, rather perform a join with proper filtering for this delete
delete class_to_student
where class_to_student_id in (
			select 
				class_to_student_id
			from class_to_student as cts inner join Classes as c
			on c.class_id = cts.class_id
			where c.class_desc like '%Beware%')
-- C - declare, query and set class id to your new class based on above filter.
--     declare, query and save the linked course and instructor ( use in B and A )
--     Delete the new class
declare @class_id as int
declare @course_id as int
declare @instructor_id as int
set @class_id = (
	select
		class_id
	from Classes
	where class_desc like '%beware%')
set @course_id = (
	select	
		course_id
	from Courses
	where course_abbrev like 'cmpe2442')
set @instructor_id = (
	select 
		i.instructor_id
	from Instructors as i
	where i.first_name + ' ' + i.last_name = 'Donald Trump')
delete Classes
where class_id = @class_id
-- B - Delete the new course as saved in C
delete Courses
where course_id = @course_id
-- A - Delete the new instructor as saved in C
delete Instructors
where instructor_id = @instructor_id
-- E - Repeat q1 part E to verify the removal of all the data.

select *
from Instructors

select	*
from courses
where course_desc like '%SQL%'

select *
from classes
where start_date > '1 aug 2016'

select 
	s.first_name,
	s.last_name
from 
	Students as s inner join class_to_student as cs
	on s.student_id = cs.student_id
	inner join classes as cl
	on cl.class_id = cs.class_id
where
	cl.class_desc like '%Beware%'
order by last_name, first_name

go