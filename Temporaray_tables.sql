use employees;
-- Obtain a list containing the highest contract salary values signed by 
-- all female employees in who have worked for the company.
create temporary table f_highest_salaryies
SELECT 
    s.emp_no, MAX(s.salary) AS f_highest_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
GROUP BY s.emp_no;

SELECT 
    *
FROM
    f_highest_salaryies;
DROP table if exists f_highest_salaryies;
    
SELECT 
    *
FROM
    departments;    
    
-- MySQL Temporary Tables in Action-Exercise
-- Exercise #1:
-- Store the highest contract salary values of all male employees in a temporary table called male_max_salaries.
CREATE TEMPORARY TABLE male_max_salaries

SELECT

    s.emp_no, MAX(s.salary)

FROM

    salaries s

        JOIN

    employees e ON e.emp_no = s.emp_no AND e.gender = 'M'

GROUP BY s.emp_no;

-- Exercise #2:
-- Write a query that, upon execution, allows you to check the result set contained in 
-- the male_max_salaries temporary table you created in the previous exercise.    
SELECT 
    *
FROM
    male_max_salaries;
    
-- MySQL Temporary Tables - Exercise #1
-- Create a temporary table named male_min_salaries containing the employee number (emp_no) and 
-- the lowest salary (salary, with an alias min_salary) for each male employee (gender = 'M') in the company.

-- To solve the given task, refer to the salaries and employees tables.    
CREATE TEMPORARY TABLE male_min_salaries AS
SELECT
	s.emp_no,
	MIN(s.salary) AS max_salary
FROM
	salaries s
	JOIN employees e ON e.emp_no = s.emp_no
WHERE
	e.gender = 'M'
GROUP BY
	s.emp_no;

-- MySQL Temporary Tables - Exercise #2
-- Retrieve all the information stored in the male_min_salaries temporary table about employees whose 
-- employee numbers are less than 10007, .
CREATE TEMPORARY TABLE male_min_salaries AS
SELECT
	s.emp_no,
	MIN(s.salary) AS max_salary
FROM
	salaries s
	JOIN employees e ON e.emp_no = s.emp_no
WHERE
	e.gender = 'M'
GROUP BY
	s.emp_no;
--
SELECT
	*
FROM
	male_min_salaries
WHERE
	emp_no < 10007;


create temporary table dates
select
     now() AS current_date_time,
     date_sub(now(),interval 1 month) as a_month_earlier,
     date_sub(now(),interval -1 year) as a_year_later;
     
select * from dates;     

with CTE as (select
     now() AS current_date_time,
     date_sub(now(),interval 1 month) as a_month_earlier,
     date_sub(now(),interval -1 year) as a_year_later)
select * from dates d1 JOIN cte c;     

-- union all

with CTE as (select
     now() AS current_date_time,
     date_sub(now(),interval 1 month) as a_month_earlier,
     date_sub(now(),interval -1 year) as a_year_later)
select * from dates d1 union all select * from cte c;    

drop temporary table if exists dates;
     
-- Other Features of MySQL Temporary Tables-Exercise
-- Exercise #1:
-- Create a temporary table called dates containing the following three columns:

-- - one displaying the current date and time,

-- - another one displaying two months earlier than the current date and time, and a

-- - third column displaying two years later than the current date and time.     
CREATE TEMPORARY TABLE dates

SELECT

    NOW(),

    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,

    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later;


-- Exercise #2:

-- Write a query that, upon execution, allows you to check the result set contained in the dates 
-- temporary table you created in the previous exercise.

SELECT 
    *
FROM
    dates;
-- Exercise #3:

-- Create a query joining the result sets from the dates temporary table you created during the previous lecture with a new Common Table Expression (CTE) containing the same columns.
--  Let all columns in the result set appear on the same row.
WITH cte AS (SELECT

    NOW(),

    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS cte_a_month_earlier,

    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS cte_a_year_later)

SELECT * FROM dates d1 JOIN cte c;

-- Exercise #4:
-- Again, create a query joining the result sets from the dates temporary table you created during the 
-- previous lecture with a new Common Table Expression (CTE) containing the same columns. 
-- This time, combine the two sets vertically.
WITH cte AS (SELECT

    NOW(),

    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS cte_a_month_earlier,

    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS cte_a_year_later)

SELECT * FROM dates UNION SELECT * FROM cte;


-- Exercise #5:
-- Drop the male_max_salaries and dates temporary tables you recently created.
DROP TABLE IF EXISTS male_max_salaries;

DROP TABLE IF EXISTS dates;

-- MySQL Temporary Tables - Other Features - Exercise #1
-- Execute the following two queries.

-- 1. Create a temporary table called salaries_adjusted_for_inflation based on the data in the salaries table.
--  It should contain the following five fields for all employees:

--    1.1   Employee number (emp_no)
--    1.2  Salary value (salary)
--    1.3  A field named inflation_adjusted_salary containing the salary value (salary) 
--                rounded to the nearest cent, which should be:
--               - Multiplied by 6.5 if the contract start date (from_date) was between January 1, 1970, 
--                          and December 31, 1989, inclusive;
--               - Multiplied by 2.8 if the contract start date (from_date) was between January 1, 1990,
--                   and December 31, 1999, inclusive;
--               - Multiplied by 3 for the rest of the contracts.
--    1.4   The contract start date (from_date)
--    1.5   The contract end date (to_date).

-- 2. Select all the data from the temporary table just created.

CREATE TEMPORARY TABLE salaries_adjusted_for_inflation AS
SELECT  emp_no,
        salary,
        CASE
            WHEN from_date BETWEEN '1970-01-01' AND '1989-12-31' THEN ROUND(salary * 6.5, 2)
            WHEN from_date BETWEEN '1990-01-01' AND '1999-12-31' THEN ROUND(salary * 2.8, 2)
            ELSE ROUND(salary * 3, 2)
        END AS inflation_adjusted_salary,
        from_date,
        to_date
    FROM 
        salaries;
        
SELECT * FROM salaries_adjusted_for_inflation;

-- MySQL Temporary Tables - Other Features - Exercise #2

-- Copy and paste the SELECT statement creating the salaries_adjusted_for_inflation 
-- temporary table in the WITH clause of a common table expression whose top-level SELECT statement joins the 
-- common table expression data with the data from the salaries_adjusted_for_inflation table on 
-- the employee number (emp_no).
CREATE TEMPORARY TABLE salaries_adjusted_for_inflation AS
SELECT  emp_no,
        salary,
        CASE
            WHEN from_date BETWEEN '1970-01-01' AND '1989-12-31' THEN ROUND(salary * 6.5, 2)
            WHEN from_date BETWEEN '1990-01-01' AND '1999-12-31' THEN ROUND(salary * 2.8, 2)
            ELSE ROUND(salary * 3, 2)
        END AS inflation_adjusted_salary,
        from_date,
        to_date
    FROM 
        salaries;
 
WITH cte AS (SELECT  emp_no,
        salary,
        CASE
            WHEN from_date BETWEEN '1970-01-01' AND '1989-12-31' THEN ROUND(salary * 6.5, 2)
            WHEN from_date BETWEEN '1990-01-01' AND '1999-12-31' THEN ROUND(salary * 2.8, 2)
            ELSE ROUND(salary * 3, 2)
        END AS inflation_adjusted_salary,
        from_date,
        to_date FROM salaries)
SELECT * FROM salaries_adjusted_for_inflation s JOIN cte c ON s.emp_no = c.emp_no;

-- MySQL Temporary Tables - Other Features - Exercise #3
-- Copy and paste the SELECT statement creating the salaries_adjusted_for_inflation temporary table in 
-- the WITH clause of a common table expression whose top-level SELECT statement should combine
--  all the data from the salaries_adjusted_for_inflation table with the common table expression data 
--  vertically, excluding duplicate rows from both tables.

CREATE TEMPORARY TABLE salaries_adjusted_for_inflation AS
SELECT  emp_no,
        salary,
        CASE
            WHEN from_date BETWEEN '1970-01-01' AND '1989-12-31' THEN ROUND(salary * 6.5, 2)
            WHEN from_date BETWEEN '1990-01-01' AND '1999-12-31' THEN ROUND(salary * 2.8, 2)
            ELSE ROUND(salary * 3, 2)
        END AS inflation_adjusted_salary,
        from_date,
        to_date
    FROM 
        salaries;
        
WITH cte AS (SELECT  emp_no,
        salary,
        CASE
            WHEN from_date BETWEEN '1970-01-01' AND '1989-12-31' THEN ROUND(salary * 6.5, 2)
            WHEN from_date BETWEEN '1990-01-01' AND '1999-12-31' THEN ROUND(salary * 2.8, 2)
            ELSE ROUND(salary * 3, 2)
        END AS inflation_adjusted_salary,
        from_date,
        to_date FROM salaries)
SELECT * FROM salaries_adjusted_for_inflation s UNION SELECT * FROM cte;

-- MySQL Temporary Tables - Other Features - Exercise #4
-- Drop the salaries_adjusted_for_inflation temporary table.
DROP TABLE IF EXISTS salaries_adjusted_for_inflation;
