use employees;

SELECT 
    first_name, last_name
FROM
    employees;
    SELECT 
    *
FROM
    employees where first_name='georgi';
    
     SELECT 
    *
FROM
    employees where hire_date BETWEEN '1990-01-01' and '2000-01-01';

select * from departments;

SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01'
        AND gender = 'F';
select * from  salaries where salary >='100000';  
select count(*) from  salaries where salary >='100000';   
SELECT DISTINCT
    hire_date
FROM
    employees;   
select * from titles;	

SELECT COUNT(dept_no) AS total_departments
FROM departments;
 SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name;

SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;
select * from titles;
SELECT title, COUNT(title) AS emps_with_same_job_title
FROM titles
WHERE to_date = '9999-01-01'
GROUP BY title;

-- SELECT 
--     *, AVG(salary)
-- FROM
--     salaries
-- GROUP BY emp_no
-- HAVING AVG(salary) > 120000;
SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;
select * from salaries;
-- --Having

select first_name, count(first_name) as names_count
FROM employees
WHERE hire_date >'1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name desc;
select* from employees;
select * from dept_emp;
select * from titles;
select * from dept_manager;
select * from departments;
-- Group by and Having 

SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no ASC;

select * from salaries
order by salary desc
limit 10;
SELECT * FROM
dept_emp
LIMIT 100;
INSERT INTO departments VALUES ('d010', 'Business Analysis');
select * from  departments;
-- Step 1: Create the new table

Drop departments_dup;
CREATE TABLE departments_dup (
    dept_no INT,
    dept_name VARCHAR(255)
);

-- Step 2: Copy the data from the original table to the new table
INSERT INTO departments_dup (dept_no, dept_name)
SELECT dept_no, dept_name
FROM departments_dup;
DESCRIBE departments_dup;
select * from  departments_dup;

update departments set dept_name='Data analytics'where dept_no='d010';

select * from departments;
DELETE FROM departments 
WHERE
    dept_no = 'd010';
    rollback
   select * from dept_emp;
   SELECT * FROM dept_emp ORDER BY dept_no ASC;
 
DELETE FROM 
dept_emp WHERE dept_no = 'd005';
 
SELECT 
    *
FROM
    dept_emp
ORDER BY dept_no ASC;

-- What is the average contract salary value for contracts starting on or before November 29, 1994 or earlier? Round your answer to the nearest dollar, with no cents, and name the resulting column average_salary.
SELECT 
    ROUND(AVG(salary), 0) AS average_salary
FROM
    salaries
WHERE
    from_date <= '1994-11-29'; 
select * from departments; 
CREATE TABLE departments_dup (
    dept_no CHAR(4) ,
    dept_name VARCHAR(40) 
);
drop table departments_dup;
INSERT INTO departments_dup (dept_no, dept_name) VALUES ('D001', 'Human Resources');
INSERT INTO departments_dup (dept_no, dept_name)
SELECT dept_no, dept_name
FROM departments;

select * from departments_dup


ORDER BY dept_no ASC; 
ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL; 
INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

ALTER TABLE employees.departments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;
commit;

select 
dept_no,
IFNULL (dept_name,'Department name not provided') AS dept_name
FROM departments_dup;

-- Coalesce function
select dept_no,dept_name,
coalesce(dept_manager,dept_name,'N/A') AS dept_manager
FROM departments_dup;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;

select * from employees;

-- Retrieve the employee number, date of birth, and first name for all individuals from the 
-- employees table. Use a function to ensure that their last name is displayed in place of the 
-- first name if a null value is encountered in the first name for a given record.

SELECT 
    emp_no,
    birth_date,
    COALESCE(first_name, last_name) AS name
FROM
    employees; 
-- OR

SELECT 
    emp_no,
    birth_date,
    IFNULL(first_name, last_name) AS name
FROM
    employees; 
    
-- Modify the code obtained from the previous exercise in the following way. 
-- Apply the IFNULL() function to the values from the first and second column, so that ‘N/A’ is 
-- displayed whenever a department number has no value, and ‘Department name not provided’ is shown if there 
-- is no value for ‘dept_name’.    
SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;

-- Retrieve the employee number, date of birth, and first and last names for all individuals from the
--  employees table. Use a function to ensure that "Not provided" is displayed in place of the first name
--  if a null value is encountered for a given record.
SELECT 
    emp_no,
    birth_date,
    IFNULL(first_name, "Not provided") AS first_name,
    last_name
FROM
    employees; 
-- OR

SELECT 
    emp_no,
    birth_date,
    COALESCE(first_name, "Not provided") AS first_name,
    last_name
FROM
    employees; 

--     --NVL function
-- The NVL and COALESCE functions are both used to handle NULL values in SQL, but they have some differences in terms of functionality and compatibility across SQL dialects. Here’s a comparison of the two:

-- NVL Function
-- Usage: Primarily used in Oracle SQL.
-- Syntax: NVL(expression, replacement_value)
-- expression: The value or column to check for NULL.
-- replacement_value: The value to return if expression is NULL.
-- Behavior: NVL takes exactly two arguments. If the first argument is NULL, the second argument is returned. Otherwise, the first argument is returned.
-- Example:

-- sql
-- Copy code
-- SELECT NVL(commission, 0) AS commission
-- FROM employees;
-- Characteristics:

-- Limited to Two Arguments: You can only specify one value to replace NULL.
-- Oracle-Specific: Primarily used in Oracle databases.
-- COALESCE Function
-- Usage: Available in most SQL databases, including Oracle, SQL Server, PostgreSQL, MySQL, and others.
-- Syntax: COALESCE(expression1, expression2, ..., expressionN)
-- expression1, expression2, ..., expressionN: A list of expressions to check for NULL.
-- Behavior: COALESCE evaluates the list of expressions from left to right and returns the first non-NULL value. If all expressions are NULL, it returns NULL.
-- Example:

-- sql
-- Copy code
-- SELECT COALESCE(commission, bonus, 0) AS compensation
-- FROM employees;
-- Characteristics:

-- Multiple Arguments: You can specify multiple arguments. The function returns the first non-NULL value from the list.
-- Standard SQL: COALESCE is part of the SQL standard and is supported by most SQL databases.
-- Summary of Differences
-- Number of Arguments:

-- NVL: Only two arguments.
-- COALESCE: Multiple arguments.
-- SQL Dialect Compatibility:

-- NVL: Specific to Oracle.
-- COALESCE: Supported by most SQL databases and part of the SQL standard.
-- Usage Flexibility:

-- NVL: Best suited for simple cases with a single alternative value.
-- COALESCE: More flexible for scenarios where multiple potential non-NULL values are possible.
-- In general, if you need to support multiple potential values or want a more portable solution across different SQL databases, COALESCE is often preferred. For Oracle-specific queries, NVL can be a straightforward option.




    
