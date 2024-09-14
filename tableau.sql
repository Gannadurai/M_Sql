USE employees_mod;  -- Make sure this is the correct database

show tables;
select * from t_dept_emp;
select * from t_salaries;
-- ---Task1
-- Create a visualization that provides a breakdown between the male and female 
-- employees working in the company each year, starting from 1990. 
-- Important clarification!
-- Hi everyone!

-- We’d like to note two things that you may otherwise worry about as you proceed with the next video.

-- First, remember that you will obtain an output that contains slightly and insignificantly different numbers
--  from the ones shown in the video. This discrepancy was caused by the fact that we updated the content
--  of the employees_mod database after the creation of the video. 
--  However, the focus is on using the correct logic and code, and they are correct. 
--  So, you needn’t worry about the difference in the numbers.

-- Here’s the output you should obtain after executing the code provided.

-- Second, we have received feedback from students suggesting alternative ways to calculate the number
--  of employees working in the company each year. We agree there is a better way to do that,
--  and we’ve applied it in Task 2. In other words, we’d like to ask you to consider that 
--  we’ve tried to gradually increase the difficulty of solving Tasks 1 to 4 in this section.

-- So, for Task 1, please assume that you’ll need to use the from_date column from the dept_emp table 
-- to count the number of employees working in the company each year. You will discover the alternative as you move.
-- .

select distinct emp_no,from_date,to_date from t_dept_emp;
-- Solution for problem1-Task1
select
     year(d.from_date) as Calendar_year,
     e.gender,
     count(e.emp_no) as num_of_employees
 from
	t_employees e
    join
    t_dept_emp d on d.emp_no=e.emp_no
group by   Calendar_year, e.gender
having  Calendar_year >='1990';

-- Task 1: SQL Solution - Code
SELECT 

    YEAR(d.from_date) AS calendar_year,
    e.gender,    
    COUNT(e.emp_no) AS num_of_employees

FROM     
     t_employees e         
          JOIN    
     t_dept_emp d ON d.emp_no = e.emp_no

GROUP BY calendar_year , e.gender 

HAVING calendar_year >= 1990;

-- MySQL and Tableau - Task/Exercise #1
-- How many female employees have signed their contracts before January 1, 1998 according to the data in 
-- the dept_emp table? Also, determine the relevant number for male employees. 
-- Assign the column names as provided in the following screenshot containing the output
--  you should obtain if you correctly solve the given task:
-- Assign 'before' to all employees who have started before the suggested date; otherwise assign 'on or after'.

SELECT 
    CASE 
        WHEN de.from_date < '1998-01-01' THEN 'before'
        ELSE 'on or after'
    END AS jan_1_1998,
    e.gender,
    COUNT(e.emp_no) AS num_of_employees
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY jan_1_1998, e.gender;

-- MySQL and Tableau - Task/Exercise #2
-- Compare the no:of male managers to the no:of female managers from diff departments for each year,starting from 1990.
SELECT 
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calendar_year,
    CASE
        WHEN YEAR(dm.to_date) >= e.calendar_year AND YEAR(dm.from_date) <= e.calendar_year THEN 1
        ELSE 0
    END AS active
FROM
    (SELECT 
        YEAR(hire_date) AS calendar_year
    FROM
        t_employees
    GROUP BY calendar_year) e
        CROSS JOIN
    t_dept_manager dm
        JOIN
    t_departments d ON dm.dept_no = d.dept_no
        JOIN 
    t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no, calendar_year;

-- MySQL and Tableau - Task/Exercise #2
-- Use a subquery that cross-joins the employees table (with an alias e) with the dept_manager, departments, 
-- and employees tables (with aliases dm, d, and ee, respectively). 
-- This subquery should be part of an outer query that retrieves data from the following five subquery columns: 
-- department name (dept_name)
-- gender (gender)
-- employee number (emp_no)
-- start date (from_date)
-- and end date (to_date).

-- Additionally, the outer query should include a sixth column 
-- named currently_active which displays the value of 1 if the employee is currently working in the company, and 0 if they are not. 
-- For this task, assume 'currently active' means an employee whose contract end date is in 2024 or later.
-- Sort the results by employee number in descending order.
SELECT 
    a.dept_name,
    a.gender,
    a.emp_no,
    a.from_date,
    a.to_date,
    CASE
        WHEN a.to_date > '2024-01-01' THEN 1
        ELSE 0
    END AS currently_active
FROM
    (SELECT 
    d.dept_name, e.gender, e.emp_no, dm.from_date, dm.to_date
    FROM
        employees e
        CROSS JOIN
    dept_manager dm
        JOIN
    departments d ON dm.dept_no = d.dept_no
        JOIN 
    employees ee ON dm.emp_no = ee.emp_no) a
ORDER BY emp_no DESC;

-- Output:
-- dept_name	gender	emp_no	from_date	to_date	currently_active
-- Marketing	F	10012	1990-08-05	9999-01-01	1
-- Finance	F	10012	1986-10-30	9999-01-01	1
-- Human Resources	F	10012	1999-03-20	2001-10-20	0
-- Marketing	M	10011	1990-08-05	9999-01-01	1
-- Finance	M	10011	1986-10-30	9999-01-01	1
-- Human Resources	M	10011	1999-03-20	2001-10-20	0
-- Marketing	F	10010	1990-08-05	9999-01-01	1
-- Finance	F	10010	1986-10-30	9999-01-01	1
-- Human Resources	F	10010	1999-03-20	2001-10-20	0
-- Marketing	F	10009	1990-08-05	9999-01-01	1
-- Finance	F	10009	1986-10-30	9999-01-01	1
-- Human Resources	F	10009	1999-03-20	2001-10-20	0
-- Marketing	M	10008	1990-08-05	9999-01-01	1
-- Finance	M	10008	1986-10-30	9999-01-01	1
-- Human Resources	M	10008	1999-03-20	2001-10-20	0
-- Marketing	F	10007	1990-08-05	9999-01-01	1
-- Finance	F	10007	1986-10-30	9999-01-01	1
-- Human Resources	F	10007	1999-03-20	2001-10-20	0
-- Marketing	F	10006	1990-08-05	9999-01-01	1
-- Finance	F	10006	1986-10-30	9999-01-01	1
-- Human Resources	F	10006	1999-03-20	2001-10-20	0
-- Marketing	M	10005	1990-08-05	9999-01-01	1
-- Finance	M	10005	1986-10-30	9999-01-01	1
-- Human Resources	M	10005	1999-03-20	2001-10-20	0
-- Marketing	M	10004	1990-08-05	9999-01-01	1
-- Finance	M	10004	1986-10-30	9999-01-01	1
-- Human Resources	M	10004	1999-03-20	2001-10-20	0
-- Marketing	M	10003	1990-08-05	9999-01-01	1
-- Finance	M	10003	1986-10-30	9999-01-01	1
-- Human Resources	M	10003	1999-03-20	2001-10-20	0
-- Marketing	F	10002	1990-08-05	9999-01-01	1
-- Finance	F	10002	1986-10-30	9999-01-01	1
-- Human Resources	F	10002	1999-03-20	2001-10-20	0
-- Marketing	M	10001	1990-08-05	9999-01-01	1
-- Finance	M	10001	1986-10-30	9999-01-01	1
-- Human Resources	M	10001	1999-03-20	2001-10-20	0








SELECT
    d.dept_name AS dept_name,
    ee.gender AS gender,
    e.emp_no AS emp_no,
    dm.from_date AS from_date,
    dm.to_date AS to_date,
    CASE
        WHEN dm.to_date >= '2024-01-01' OR dm.to_date IS NULL THEN 1
        ELSE 0
    END AS currently_active
FROM
    employees e
    CROSS JOIN dept_manager dm
    CROSS JOIN departments d
    CROSS JOIN employees ee
WHERE
    e.emp_no = dm.emp_no
    AND d.dept_no = dm.dept_no
    AND ee.emp_no = e.emp_no
ORDER BY
    e.emp_no DESC;

-- Task=3
-- Compare the average salary of female versus male employees in the entire company until year 2002,
--  and add a filter allowing you to see that per each department.
SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS salary,
    YEAR(s.from_date) AS calendar_year
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no , e.gender , calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;

-- Here's an excerpt of the output you are supposed to obtain:

-- Apply the column names suggested. In order from left to right, they refer to the employees, departments, salaries, and dept_emp tables, 
-- respectively. Please note that the third column contains only average salary values rounded to the nearest cent. 
-- The last column should contain 'before' or 'on or after' depending on whether the 
-- employee's start date (stored in the dept_emp's from_date column) is before or on or after January 1, 1998.

-- Group by the department number dept_no, employee's gender, and jan_1_1998 columns. 
-- Retrieve only data about contracts signed in 1990 or later. Sort the obtained results by department number in ascending order.
SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS avg_salary,
    CASE 
        WHEN de.from_date < '1998-01-01' THEN 'before'
        ELSE 'on or after'
    END AS jan_1_1998
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no, e.gender, jan_1_1998
HAVING de.from_date >= '1990-01-01'
ORDER BY d.dept_no;
-- --another

SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS avg_salary,
    CASE 
        WHEN de.from_date < '1998-01-01' THEN 'before'
        ELSE 'on or after'
    END AS jan_1_1998
FROM
    salaries s
    JOIN employees e ON s.emp_no = e.emp_no
    JOIN dept_emp de ON de.emp_no = e.emp_no
    JOIN departments d ON d.dept_no = de.dept_no
WHERE
    de.from_date >= '1990-01-01'
GROUP BY 
    d.dept_name, 
    e.gender, 
    jan_1_1998
ORDER BY 
    d.dept_name;
 
-- Expected result

-- gender	dept_name	avg_salary	jan_1_1998
-- F	Production	76723	before
-- M	Production	52409.04	before
-- F	Development	50514.92	before
-- M	Development	49307.67	on or after
-- F	Quality Management	76723	on or after
-- F	Sales	68549.17	before

-- Task 4 - Text
-- Create an SQL stored procedure that will allow you to obtain the average male and female salary per department within a certain salary range.
--  Let this range be defined by two values the user can insert when calling the procedure.

-- Finally, visualize the obtained result-set in Tableau as a double bar chart. 

DROP PROCEDURE IF EXISTS filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT 
    e.gender, d.dept_name, AVG(s.salary) as avg_salary
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender;
END$$

DELIMITER ;

CALL filter_salary(50000, 90000);


