use exercise_3;

-- Task 3
SELECT e.fist_name, e.last_name, p.project_name
FROM employees e
JOIN assignments a ON e.employee_id = a.employee_id
JOIN projects p ON a.project_id = p.project_id;

-- Task 4
SELECT e.first_name, e.last_name
FROM employees e
LEFT JOIN assignments a ON e.employee_id = a.employee_id
WHERE a.employee_id IS NULL;

-- Task 5
SELECT p.project_name, e.first_name, e.last_name
FROM projects p
LEFT JOIN assignments a ON p.project_id = a.project_id
LEFT JOIN employees e ON a.employee_id = e.employee_id;

-- Task 6
SELECT COUNT(*) AS total_employees FROM employees;

SELECT p.project_name, 
       COUNT(a.employee_id) / (SELECT COUNT(*) FROM employees) * 100 AS percentage_assigned
FROM projects p
LEFT JOIN assignments a ON p.project_id = a.project_id
GROUP BY p.project_id;

-- Task 7
SELECT p.project_id, 
       COUNT(a.employee_id) AS total_assigned, 
       COUNT(a.employee_id) / (SELECT COUNT(*) FROM employees) * 100 AS percentage_assigned
FROM projects p
LEFT JOIN assignments a ON p.project_id = a.project_id
GROUP BY p.project_id;
