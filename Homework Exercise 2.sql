USE kurs_sql;

-- Zadanie 1
SELECT distinct s.first_name, s.last_name
from students as s
join enrollments as e on s.student_id=e.student_id
where s.student_id IN (
select e.student_id
from enrollments
where e.enrollment_date < '2024-01-01')
and s.student_id not in (
select e.student_id
from enrollments
where e.enrollment_date >= '2024-01-01');

-- Zadanie 2
SELECT c.course_id, c.course_name, s.first_name, s.last_name, year(enrollment_date) as enrollment_year, month(enrollment_date) as enrollment_month
from courses as c
join enrollments as e on c.course_id=e.course_id
join students as s on e.student_id=s.student_id
group by c.course_id, c.course_name, s.first_name, s.last_name, year(enrollment_date), month(enrollment_date);

-- Zadanie 3
SELECT s.first_name, s.last_name
from students as s
join enrollments as e on s.student_id=e.student_id
group by s.student_id, s.last_name
Having count(e.enrollment_id) = 1;

-- Zadanie 4
SELECT c.course_name, s.first_name, s.last_name, timestampdiff(year, date_of_birth, now()) as age
from courses as c
join enrollments as e on c.course_id=e.course_id
join students as s on e.student_id=s.student_id
where timestampdiff(year, date_of_birth, now()) < 25 and timestampdiff(year, date_of_birth, now()) > 30;

-- Zadanie 5
Select s.first_name, s. last_name, count(c.course_id) as number_of_courses, year(e.enrollment_date) as enrollment_year
from courses as c
join enrollments as e on c.course_id=e.course_id
join students as s on e.student_id = s.student_id
where enrollment_date is not null
group by s.first_name, s. last_name, year(e.enrollment_date);
