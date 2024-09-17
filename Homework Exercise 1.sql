Create database CompanyDB;

Use CompanyDB;

Create table Employees (
EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
FirstName Varchar(50) NOT NULL,
LastName Varchar(50) NOT NULL,
BirthDate date not null,
HireDate date not null,
DepartmentID INT,
Salary decimal(10, 2) default 3000.00 check (salary >=0),
constraint UC_CompanyDB Unique (FirstName, LastName),
foreign key (DepartmentID) references Departments(DepartmentID)
);

Create table Departments (
DepartmentID INT primary key auto_increment,
DepartmentName Varchar(100) not null,
UNIQUE (DepartmentName)
);

Insert into Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID, Salary) value
(1, 'Anna', 'Kowalska', '1991-10-10', '2020-01-10', 11, 3100.00),
(2, 'Jan', 'Kowalski', '1995-06-06', '2022-05-12', 12, 3000.00),
(3, 'Adam', 'Asnyk', '1990-07-13', '2019-12-17', 13, 4000.00),
(4, 'Katarzyna', 'Nowak', '1975-02-26', '2023-10-01', 14, 3000.00),
(5, 'Ewelina', 'Adamska', '1980-01-11', '2020-01-01', 15,  4500.00);

Insert into Departments (DepartmentID, DepartmentName) value
(11, 'Marketing'),
(12, 'HR'),
(13, 'IT'),
(14, 'Accouting'),
(15, 'Finance');

Select *
from employees;

Select FirstName, LastName
from employees
where salary > 4000.00;

Select FirstName, LastName
from employees
where DepartmentID = 15;


Use CompanyDB;

UPDATE employees
SET Salary= Salary * 1.10
Where HireDate < '2020-01-01';

DELETE FROM Employees
WHERE Salary > '3000.00';



