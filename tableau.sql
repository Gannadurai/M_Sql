use employees;
show tables;
select * from t_dept_emp;
select * from t_salaries
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




