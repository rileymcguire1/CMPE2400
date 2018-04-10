-- ica15 - master
-- This ICA is comprised of 2 parts, but should be tackled as described by your instructor.
-- To ensure end-to-end running, you will have to complete the ica in pairs :
--  q1A + q2A, then q1B + q2B
-- You will need to install a personal version of the ClassTrak database
-- The Full and Refresh scripts are on the Moodle site.
-- Once installed, you can run the refresh script to restore data that may be modified or 
--  deleted in the process of completing this ica.

use herbv_test_ClassTrak -- YOUR_COPY_CLASSTRAK
go

-- q1
-- All in one batch, to retain your variable contexts/values
declare @inst as int

-- A
-- Insert a new Instructor : Donald Trump
--  Check column types, supply necessary values, it may require a column list
--  Save your identity into a variable
insert Instructors( last_name, first_name )
values( 'Trump', 'Donald' )
set @inst = @@IDENTITY

-- B
-- Insert a new Course : cmpe2442 "Fast and Furious - SQL Edition"
--  Check column types, supply necessary values, it may require a column list
--  Save your identity into a variable
declare @course_id as int
insert courses( course_abbrev, course_desc )
values( 'cmpe2442', 'Fast and Furious - SQL Edition' )
set @course_id = @@IDENTITY

-- C
-- Insert a record indicating your new instructor is teaching the new course
--  description : "Beware the optimizer"
--  start_date : use 01 Sep 2016
--  Save the identity into a variable
declare @class_id as int
insert Classes( class_desc, instructor_id, course_id, start_date, days )
values( 'Beware the optimizer', @inst, @course_id, '01 Sep 2016', null )
set @class_id = @@IDENTITY

-- D Insert a bunch in one insert
-- Generate the insert statement to Add all the students with a last name that
--  starts with a vowel to the new class
insert class_to_student( class_id, student_id, active )
select @class_id, student_id, 1
from students where last_name like '[AEIOU]%'

-- E
--  Prove it all, generate a select to show :
--   All instructors - see your new entry
--   All courses that have SQL in description
--   All classes that have a start_date after 1 Aug 2016
--   All students in the new class - filter by description having "Beware"
--       sort by first name in last name

select * from instructors
select * from courses
select * from classes where start_date > '1 Aug 2016'
select last_name, first_name
from 
	students as s inner join class_to_student as cs on s.student_id = cs.student_id
	inner join classes as c on cs.class_id = c.class_id
where
	c.class_desc like 'Beware%'
order by last_name, first_name

go
-- end q1

-- q2 - Undo all your changes to reset the database, you must do this in reverse order to
--      ensure you do not attempt to corrupt Referencial Integrity.
--     As such, work backwards from D to A.

-- D - Delete all students that have been assigned to your new class, do this without a 
--     variable, rather perform a join with proper filtering for this delete
delete class_to_student
from class_to_student as cs inner join classes as c on cs.class_id = c.class_id
where c.class_desc like 'Beware%'

-- C - declare, query and set class id to your new class based on above filter.
--     declare, query and save the linked course and instructor ( use in B and A )
--     Delete the new class

declare @course_id as int
declare @instructor_id as int
declare @class_id as int
select @course_id = course_id, @instructor_id = instructor_id, @class_id = class_id
from classes as c
where class_desc like 'Beware%'

delete Classes
where class_desc = @class_id

-- B - Delete the new course as saved in C

delete Courses
where course_id = @course_id

-- A - Delete the new instructor as saved in C

delete instructors
where instructor_id = @instructor_id

-- E - Repeat q1 part E to verify the removal of all the data.
select * from instructors
select * from courses
select * from classes where start_date > '1 Aug 2016'
select last_name, first_name
from 
	students as s inner join class_to_student as cs on s.student_id = cs.student_id
	inner join classes as c on cs.class_id = c.class_id
where
	c.class_desc like 'Beware%'

go
