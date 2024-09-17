-- Task 1 Create a view that displays all students along with their dates of birth.
Create view StudentsBirthDate AS
select student_id, first_name, last_name, date_of_birth
from students;

-- Task 2 Create a view that shows all courses along with the number of students enrolled in each course.
Create view NumberOfStudentsPerCourse AS
Select c.course_name, count(e.student_id) as number_of_students
from courses as c 
join enrollments as e on c.course_id=e.course_id
group by c.course_name;

-- Task 3 Update an existing view to show only active students (those born after the year 2000).
CREATE OR REPLACE VIEW NumberOfStudentsPerCourse as
Select c.course_name, count(e.student_id) as number_of_students
from courses as c 
join enrollments as e on c.course_id=e.course_id
join students as s on e.student_id=s.student_id
where s.date_of_birth >= '2000-01-01'
group by c.course_name;

-- Task 4 Drop a view that is no longer needed.
Drop view NumberOfStudentsPerCourse;