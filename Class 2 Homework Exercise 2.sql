-- Task 1 .Create a transaction that attempts to add a new course but fails due to a primary key violation 
-- (a course with the same name already exists). 
-- Apply rollback transaction in case of error.

start transaction;
insert into courses (course_id, course_name, course_description) values
(22, 'Polish', 'Learning polish language');

Commit;

Rollback;

-- Task 2 Create a stored procedure that returns all courses a given student is enrolled in.

use kurs_sql;
DELIMITER // 
Create procedure CoursesStudentIsEnrolledIn(in student_id INT)
BEGIN
Select c.course_name, e.student_id
from courses as c 
join enrollments as e on e.course_id=c.course_id
where e.student_id=student_id
order by e.student_id;
END //
DELIMITER ;

-- Task 3 Create a stored procedure that updates the enrollment date for a specific student in a specified course.
DELIMITER // 
Create procedure UpdateEnrollmentDate(in student_id INT, course_id INT, in new_enrollment_date Date)
BEGIN
update enrollments as e
set enrollment_date = new_enrollment_date
where e.student_id = student_id and e.course_id = course_id;
END //
DELIMITER ;

-- Task 4 Create a stored procedure that removes a student from all courses they are enrolled in.
DELIMITER // 
Create procedure RemoveStudent(in student_id INT)
BEGIN
delete from enrollments as e
where e.student_id = student_id;
END //
DELIMITER ;

-- Task 5 Create a transaction that adds a new course and updates the description of an existing course. 
-- Commit the transaction only if both operations are successful.

start transaction; 

insert into courses (course_id, course_name, course_description) values
(23, 'German', 'Learning german language');

update courses 
set course_description = 'Advanced statistical methods and analysis.'
where course_id = 15;

commit;

