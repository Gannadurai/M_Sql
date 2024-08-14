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



