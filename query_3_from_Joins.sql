use employees;
select * from departments_dup;
 ALTER table departments_dup DROP COLUMN dept_manager ;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

# if you don’t currently have ‘departments_dup’ set up

DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup (
    dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

 INSERT INTO departments_dup

(

    dept_no,

    dept_name

)

SELECT * FROM  departments;

 

INSERT INTO departments_dup (dept_name)

VALUES                ('Public Relations');

 

DELETE FROM departments_dup
WHERE
dept_no = 'd002'; 

   

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

select * from departments_dup;

-- Intro to JOINs - exercise 2
-- Create and fill in the ‘dept_manager_dup’ table, using the following code:

DROP TABLE IF EXISTS dept_manager_dup;
show tables;
CREATE TABLE dept_manager_dup (

  emp_no int(11) NOT NULL,

  dept_no char(4) NULL,

  from_date date NOT NULL,

  to_date date NULL

  );

INSERT INTO dept_manager_dup (emp_no, dept_no, from_date, to_date)
SELECT emp_no, dept_no, from_date, to_date
FROM dept_manager;
 
INSERT INTO dept_manager_dup

select * from dept_manager_dup;

INSERT INTO dept_manager_dup (emp_no, from_date)

VALUES                (999904, '2017-01-01'),

                                (999905, '2017-01-01'),

                               (999906, '2017-01-01'),

                               (999907, '2017-01-01');
select * from dept_manager_dup order by dept_no;
 select * from departments_dup;
DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';
    
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

select * from dept_manager;
select * from dept_emp;
select * from departments;
select * from employees;
-- Extract a list containing information about all managers’ employee number, first and last name, 
-- department number, and hire date.     
SELECT
    e.emp_no,

    e.first_name,

    e.last_name,

    dm.dept_no,

    e.hire_date
FROM
    employees e
        JOIN
dept_manager dm ON e.emp_no = dm.emp_no;
-- INNER JOIN - Exercise #1
-- Retrieve all employee numbers (emp_no) and contract start dates (from_date) from the department employees 
-- table (dept_emp). Add a third column, displaying the name of the department they have signed for 
-- (dept_name from the departments table).

SELECT 
    e.emp_no, 
    e.from_date, 
    d.dept_name
FROM 
    dept_emp e
INNER JOIN 
    departments d
ON 
    e.dept_no = d.dept_no;
-- Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last 
  --   name is Markovitch. See if the output contains a manager with that name.  

-- -- Hint: Create an output containing information corresponding to the following fields: ‘emp_no’, 
--    ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no' descending, and then by 'emp_no'.
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC , e.emp_no;

-- Use a LEFT JOIN to retrieve the employee number (emp_no), first name (first_name),
--  and last names (last_name) of all individuals whose last name is 'Bamford'. 
--  Join the data from the employees table with the data from dept_manager to add two more columns: 
--  the number of the department these people are working in (dept_no) and the start date of their contracts 
--  (from_date). Sort your ouptut by department number in descending order.

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Bamford'
ORDER BY dm.dept_no DESC , e.emp_no;
-- Right Join
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM
    dept_manager dm
        RIGHT JOIN
    employees e ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Bamford'
ORDER BY dm.dept_no DESC , e.emp_no; 

-- The new and the old join syntax - exercise
-- Extract a list containing information about all managers’ employee number, first and last name,
--  department number, and hire date. Use the old type of join syntax to obtain the result.
SELECT
    e.emp_no,

    e.first_name,

    e.last_name,

    dm.dept_no,

    e.hire_date
FROM
    employees e,

    dept_manager dm
WHERE
    e.emp_no = dm.emp_no;

-- New Join Syntax:
SELECT
    e.emp_no,

    e.first_name,

    e.last_name,

    dm.dept_no,

    e.hire_date
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no; 
    -- The new and the old join syntax - Exercise #1
-- Retrieve a table containing three columns:

-- 1. The employee number (emp_no) as recorded in the departments manager table (dept_manager).

-- 2. Their contract salary value (salary), obtained from the salaries table.
-- 3. The start date of their contracts (from_date).

-- Aim to write your query using the old join syntax.
    SELECT 
    dm.emp_no, s.salary, s.from_date
FROM
    dept_manager dm,
    salaries s
WHERE
    dm.emp_no = s.emp_no;

select e.emp_no,e.last_name,e.first_name,s.salary    
from
employees e
JOIN
salaries s ON e.emp_no=s.emp_no
where
s.salary > 145000;
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
select @@global.sql_mode;
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
set @@global.sql_mode := concat('ONLY_FULL_GROUP_BY,', @@global.sql_mode);

-- Select the first and last name, the hire date, and the job title of all employees whose 
-- first name is “Margareta” and have the last name “Markovitch”.

select * from titles;
select  e.first_name, e.last_name, e.hire_date, t.title
FROM 
employees e
JOIN
titles t ON t.emp_no=e.emp_no
WHERE 
first_name='Margareta' AND last_name='Markovitch'
ORDER BY e.emp_no;  
-- Retrieve the employee number (emp_no), first name (first_name), last name (last_name), and hire date (hire_date)
--  of all employees whose last name is 'Bamford'. Add a fifth column displaying their job title (title), 
--  as recorded in the titles table. Sort your output by employee number in ascending order.
select e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
FROM 
employees e
JOIN
titles t ON t.emp_no=e.emp_no
WHERE 
last_name='Bamford'
ORDER BY e.emp_no asc; 

-- --CROSS JOIN
select dm.*,d.*
FROM
dept_manager dm
CROSS JOIN
departments d
order by
dm.emp_no,d.dept_no;

select dm.*,d.*
FROM
dept_manager dm
CROSS JOIN
departments d
where d.dept_no <> dm.dept_no
order by
dm.emp_no,d.dept_no;

select e.*,d.*
FROM
departments d
CROSS JOIN
dept_manager dm
JOIN
employees e ON dm.emp_no = e.emp_no
where d.dept_no <> dm.dept_no
order by
dm.emp_no,d.dept_no;

 -- Use a CROSS JOIN to return a list with all possible combinations between managers 
--  from the dept_manager table and department number 9.
SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;
select * from departments;
select * from dept_emp;
-- Return a list with the first 10 employees with all the departments they can be assigned to.
-- Hint: Don’t use LIMIT; use a WHERE clause.
SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;

-- Use a CROSS JOIN to return a list with all possible combinations between managers from the 
-- dept_manager table and department number 6 (dept_no) from the departments table.
SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no = 'd006'; 
-- Return a list with the first two employees (i.e. employees 10001 and 10002) 
-- with all the departments they can be assigned to. To obtain the desired output, refer to all column from 
-- the departments and department employees tables (departments, dept_emp). Order your output by employee number 
-- (emp_no) and department name (dept_name).

-- Hint: Don't use LIMIT; use a WHERE clause.
SELECT 
    e.*, d.*
FROM
    dept_emp e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10003
ORDER BY e.emp_no , d.dept_name; 
