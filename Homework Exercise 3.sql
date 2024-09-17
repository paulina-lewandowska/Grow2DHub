-- Zadanie 1

Create database exercise_3;

Create table projects (
project_id int primary key auto_increment, 
project_name VARCHAR(100) not null,
department_id int not null);

use exercise_3;

Create table employees (
employee_id int primary key auto_increment, 
first_name VARCHAR(50), 
last_name VARCHAR(50),
department_id int not null,
department_name VARCHAR(100),
salary int not null,
foreign key (department_id) references projects(department_id));

Create table assignments (
assignment_id INT primary key auto_increment,
employee_id int not null,
project_id int not null,
assignment_date date not null,
foreign key (employee_id) references employee(employee_id),
foreign key (project_id) references projects(project_id));

-- Zadanie 2
insert into projects (project_id, project_name, department_id) value
(10, 'project_one_a', '03'),
(20, 'project_two_b', '01'),
(30, 'project_three-c', '02');

insert into employees (employee_id, first_name, last_name, department_id, department_name, salary) value
(1, 'Anna', 'Kowalska', '01', 'Marketing', 4000.00),
(2, 'Jan', 'Kowalski', '02', 'Finance', 5000.00),
(3, 'Adam', 'Asnyk', '03', 'HR', 3500.00),
(4, 'Katarzyna', 'Nowak', '02', 'Finance', 3800.00),
(5, 'Ewelina', 'Adamska', '01', 'Marketing', 4600.00);

insert into assignments (assignment_id, employee_id, project_id, assignment_date) value
(11, 1, 20, '2024-01-01'),
(22, 2, 30, '2023-09-27'),
(33, 3, 10, '2024-06-15'),
(44, 4, 30, '2022-12-24'),
(55, 5, 20, '2023-10-18');

-- Zadanie 3
Select e.first_name, e.last_name, p.project_name
from employees as e
join assignments as a on e.employee_id=a.employee_id
join projects as p on a.project_id=p.project_id;

-- Zadanie 4
Select p.project_name, count(a.employee_id) as number_of_employee
from projects as p
join assignments as a on p.project_id=a.project_id
group by p.project_name;

-- Zadanie 5
Select p.project_name, avg(e.salary) as avg_salary
from projects as p
join assignments as a on p.project_id=a.project_id
join employees as e on a.employee_id=e.employee_id
group by p.project_name;

-- Zadanie 6
Select p.project_name, a.assignment_id, a.assignment_date
from projects as p
join assignments as a on p.project_id=a.project_id
join employees as e on a.employee_id=e.employee_id;

-- Zadanie 7
select p.project_name, count(a.assignment_id) as number_of_assignment
from projects as p
join assignments as a on p.project_id=a.project_id
group by p.project_name
having count(a.assignment_id) >= 2;
