-- Task 1 
use kurs_sql;

WITH Highest_Enrollment AS (
Select 
s.first_name, s.last_name, count(e.enrollment_id) as number_of_enrollments
from students as s
join enrollments as e on s.student_id=e.student_id
group by s.first_name, s.last_name
order by number_of_enrollments desc
limit 3
)

Select * from Highest_Enrollment

-- Task 2 Use a Common Table Expression (CTE) to calculate the percentage of enrollments for each course compared to the total enrollments.

with Percentage_Enrollments as (
Select c.course_name, 
count(e.enrollment_id) as total_number_of_enrollments,
count(e.enrollment_id) * 100.0 / (Select count(enrollment_id) as total_enrollments from enrollments) as percentage_of_enrollments
from courses as c
join enrollments as e on c.course_id=e.course_id
group by c.course_name)

Select * from Percentage_Enrollments;

-- Task 3 Use a Common Table Expression (CTE) to identify the courses with the highest number of enrollments.
WITH Courses_Highest_Enrollment AS (
Select 
c.course_name, count(e.enrollment_id) as number_of_enrollments
from courses as c
join enrollments as e on c.course_id=e.course_id
group by c.course_name
order by number_of_enrollments desc
limit 3)

Select* from Courses_Highest_Enrollment;

-- Task 4 Use a Common Table Expression (CTE) to calculate the total scores for students in each course.
WITH Courses_Total_Scores AS (
Select s.first_name, s.last_name, c.course_name, SUM(g.grade) as total_score
from students as s
join enrollments as e on s.student_id=e.student_id
join courses as c on e.course_id=c.course_id
join grades as g on c.course_id=g.course_id
group by s.first_name, s.last_name, c.course_name)

Select * from Courses_Total_Scores;

-- Task 5 ????

