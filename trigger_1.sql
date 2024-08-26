use employees;
-- Create a trigger that checks if the hire date of an employee is higher than the 
-- current date. If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
Delimiter //
create trigger trig_hire_date
BEFORE insert ON employees
for each row
Begin
if new.hire_date > date_format(sysdate(), '%Y-%m-%d') 
THEN 
SET NEW.hire_date = date_format(sysdate(), '%Y-%m-%d');     

                END IF;  
END // 

DELIMITER ;  

-- INDEX
select * from employees where hire_date >'2000-01-01';    
Create INDEX i_hire_date ON employees( hire_date);           
show INDEX FROM employees FROM employees;

-- Drop the ‘i_hire_date’ index.
ALTER TABLE employees
DROP INDEX i_hire_date;

-- Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.

-- Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.
SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;

create INDEX i_salary ON salaries(salary);
   SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;
-- Create an index named i_from_date on the from_date column of the department employees table dept_emp.
create index i_from_date on dept_emp(from_date);
-- Create a composite index named i_composite_salary on the emp_no and salary columns of the salaries table.
create  INDEX i_composite_salary ON salaries(emp_no,salary);

-- CASE statement
select emp_no,first_name,last_name,
CASE
   When gender= 'M' Then 'Male'
   Else 'Female'
END AS gender
from employees;
-- Alternate statement

select emp_no,first_name,last_name,
IF
   ( gender= 'M' , 'Male','Female') AS Gender
from employees;
-- Alternate statement
SELECT
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than $20,000 but less than $30,000'
        ELSE 'Salary was raised by less than $20,000'
    END AS salary_increase
FROM
    dept_manager dm
JOIN
    employees e ON e.emp_no = dm.emp_no
JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY
    e.emp_no
LIMIT 50;
-- Similar to the exercises done in the lecture, obtain a result set containing the employee number, first name, and last name of all 
-- employees with a number higher than 109990. Create a fourth column in the query, indicating whether this employee is also a manager, 
-- according to the data provided in the dept_manager table, or a regular employee. 

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;
    
-- Extract a dataset containing the following information about the managers: employee number, first name, and last name.
--  Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, 
--  and another one saying whether this salary raise was higher than $30,000 or NOT.

-- If possible, provide more than one solution. 
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'
        ELSE 'Salary was NOT raised by more then $30,000'
    END AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;  

   

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(s.salary) > 30000,
        'Salary was raised by more then $30,000',
        'Salary was NOT raised by more then $30,000') AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

-- Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, called “current_employee” 
-- saying “Is still employed” if the employee is still working in the company, or “Not an employee anymore” if they aren’t.

-- Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. 
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;

-- Retrieve the employee number (emp_no), first name (first_name), and last name (last_name) of all employees from the employees 
-- table whose employee number is greater than 10005. Join this information with the data from the department manager dept_manager 
-- table to add a fourth column named is_manager, containing the string 'Manager' if the employee number of the given employee 
-- is not a null value, and 'Employee' otherwise.
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 10005;

-- Your analytics task is to decide if the salary raises of all managers whose employee numbers over 10005 have been significant. 
-- To do this, you need to retrieve the following table containing eight columns:

-- emp_no from the dept_manager table.

-- first_name, last_name, and hire_date from the employees table.

-- min_salary, max_salary, and salary_difference from the salaries table.

-- salary_raise to indicate whether the raise is "insignificant" (positive but no more than $10,000), "significant" (more than $10,000), 
-- or a "salary decrease" (if it decreased).

-- To solve the exercise, you'll also need to:
-- - join the three tables ON their employees numbers (emp_no)
-- - use a full GROUP BY statement (i.e. GROUP BY s.emp_no, e.first_name, e.last_name, e.hire_date)
-- - sort the results by department managers' employee number in ascending order.

SELECT     
    dm.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date,
    MIN(s.salary) AS min_salary,
    MAX(s.salary) AS max_salary,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) <= 10000 AND MAX(s.salary) - MIN(s.salary) > 0 
    THEN 'insignificant'
        WHEN MAX(s.salary) - MIN(s.salary) > 10000 THEN 'significant'
        ELSE 'salary decrease'
	END as salary_raise
FROM 
dept_manager dm
JOIN
employees e ON dm.emp_no = e.emp_no
JOIN
salaries s ON s.emp_no = dm.emp_no
WHERE dm.emp_no > 10005
GROUP BY s.emp_no, e.first_name, e.last_name, e.hire_date 
ORDER BY dm.emp_no;

-- Retrieve the employee number (emp_no), first name (first_name), and last name (last_name) of all employees from the employees 
-- table who also have records in the department employees table dept_emp. Add a fourth column named current_status displaying 
-- "Currently working" if their contract in the dept_emp table ends on or after January 1, 2025, or later. Otherwise, display 
-- "No longer with the company". Use GROUP BY on the employee number, first name, and last name to obtain the desired result.

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) >= '2025-01-01' THEN 'Currently working'
        ELSE 'No longer with the company'
    END AS current_status
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name;

