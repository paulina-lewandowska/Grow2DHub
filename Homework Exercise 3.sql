-- Zadanie 1

Create database exercise_3;

use exercise_3;
Create table projects (
project_id INT PRIMARY KEY AUTO_INCREMENT,
project_name VARCHAR(100) NOT NULL,
start_date DATE NOT NULL);

use exercise_3;

Create table employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    salary DECIMAL(10, 2) NOT NULL);

Create table assignments (
assignment_id INT PRIMARY KEY AUTO_INCREMENT,
employee_id INT,
project_id INT,
start_date DATE NOT NULL,
FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
FOREIGN KEY (project_id) REFERENCES projects(project_id));

-- Zadanie 2
insert into projects (project_name, start_date) value
('project_one_a', '2024-01-01'),
('project_two_b', '2024-02-02'),
('project_three_c', '2024-03-03');

insert into employees (first_name, last_name, department_id, salary) value
('Anna', 'Kowalska', '101', 4000.00),
('Jan', 'Kowalski', '102', 5000.00),
('Adam', 'Asnyk', '103', 3500.00),
('Katarzyna', 'Nowak', '104', 3800.00);

insert into assignments (employee_id, project_id, start_date) value
(1, 1, '2024-01-10'),
(1, 2, '2024-04-05'),
(2, 1, '2024-01-01'),
(2, 3, '2024-06-25'),
(3, 2, '2024-04-19'),
(4, 3, '2024-06-01');

-- Zadanie 3
Select e.first_name, e.last_name, p.project_name
from employees as e
join assignments as a on e.employee_id=a.employee_id
join projects as p on a.project_id=p.project_id
order by e.last_name;

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
Select p.project_name, e.first_name, e.last_name, a.assignment_id, a.start_date
from projects as p
join assignments as a on p.project_id=a.project_id
join employees as e on a.employee_id=e.employee_id;

-- Zadanie 7
select p.project_name, count(a.assignment_id) as number_of_assignments
from projects as p
join assignments as a on p.project_id=a.project_id
group by p.project_name
having count(a.assignment_id) >= 2;
