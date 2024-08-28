use employees;
SELECT
  emp_no,
  salary,
  ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary) AS ROW_NUM
FROM
  salaries;
-- Exercise #1 :

-- Write a query that upon execution, assigns a row number to all managers we have information for in the "employees" database 
-- (regardless of their department).

-- Let the numbering disregard the department the managers have worked in. Also, let it start from the value of 
-- 1. Assign that value to the manager with the lowest employee number.

-- Exercise #2:
-- Write a query that upon execution, assigns a sequential number for each employee number registered in the "employees" table.
--  Partition the data by the employee's first name and order it by their last name in ascending order (for each partition).
SELECT

    emp_no,

    dept_no,

    ROW_NUMBER() OVER (ORDER BY emp_no) AS row_num

FROM

dept_manager;
-- Solution #2:

SELECT

emp_no,

first_name,

last_name,

ROW_NUMBER() OVER (PARTITION BY first_name ORDER BY last_name) AS row_num

FROM

employees;

-- Retrieve everything stored in the employee number (emp_no) and department number (dept_no) columns from the department manager (dept_manager) 
-- table. Add a third column named row_num containing a row number, starting from 1 and incrementing for each row in the obtained output, 
-- ordered by emp_no in descending order.
SELECT 
    emp_no, 
    dept_no,
    ROW_NUMBER() OVER (ORDER BY emp_no DESC) AS row_num
FROM
	dept_manager
ORDER BY dept_no DESC;
-- Retrieve everything stored in the employee number (emp_no), first name (first_name), and last name (last_name) columns from the employees table.
--  Add a fourth column named row_num, which partitions the data by last name, sorts it by employee number in ascending order, and assigns a
--  row number starting from 1 and incrementing for each row in every partition.
SELECT 
	emp_no, 
	first_name, 
	last_name,
	ROW_NUMBER() OVER (PARTITION BY last_name ORDER BY emp_no) AS row_num
FROM
	employees;

-- Obtain a result set containing the salary values each manager has signed a contract for. To obtain the data, refer to the "employees" database.

-- Use window functions to add the following two columns to the final output:

-- - a column containing the row number of each row from the obtained dataset, starting from 1.

-- - a column containing the sequential row numbers associated to the rows for each manager, where their highest salary has been given a number 
-- equal to the number of rows in the given partition, and their lowest - the number 1.

-- Finally, while presenting the output, make sure that the data has been ordered by the values in the first of the row number columns, 
-- and then by the salary values for each partition in ascending order.



-- Exercise #2:

-- Obtain a result set containing the salary values each manager has signed a contract for. To obtain the data, refer to the "employees" database.

-- Use window functions to add the following two columns to the final output:

-- - a column containing the row numbers associated to each manager, where their highest salary has been given a number equal to the 
-- number of rows in the given partition, and their lowest - the number 1.

-- - a column containing the row numbers associated to each manager, where their highest salary has been given the number of 1, 
-- and the lowest - a value equal to the number of rows in the given partition.

-- Let your output be ordered by the salary values associated to each manager in descending order.

-- Hint: Please note that you don't need to use an ORDER BY clause in your SELECT statement to retrieve the desired output.
select* from salaries;
select* from dept_manager;
-- Solution #1:
SELECT
dm.emp_no,

    salary,

    ROW_NUMBER() OVER () AS row_num1,

    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary ASC) AS row_num2

FROM

dept_manager dm

    JOIN 

    salaries s ON dm.emp_no = s.emp_no

ORDER BY row_num1, emp_no, salary ASC;
-- Solution #2:
SELECT

dm.emp_no,

    salary,

    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary ASC) AS row_num1,

    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num2   

FROM

dept_manager dm

    JOIN 
    salaries s ON dm.emp_no = s.emp_no;
   select * from salaries; 
-- Retrieve the employee number (emp_no) and job title (title) from the titles table, and the salary (salary) from the salaries table. 
-- Add a column to the left, named row_num1, starting from 1 incrementing by 1 for each row from the obtained result. 
-- Also, add a fifth column, named row_num2, which provides a row position for each record per employee, starting from the total 
-- number of records obtained for that employee and continuing down to 1.


-- Include only data about 'Staff' members and employees with a number no greater than 10006. Order the result by 
-- employee number (emp_no), salary, and row_num1 in ascending order.   

SELECT 
	ROW_NUMBER() OVER () AS row_num1,
	t.emp_no, 
	t.title,
    s.salary, 
    ROW_NUMBER() OVER (PARTITION BY t.emp_no ORDER BY salary DESC) AS row_num2
FROM
	titles t
    JOIN  
    salaries s ON t.emp_no = s.emp_no
WHERE t.title = 'Staff' AND t.emp_no < 10007
ORDER BY t.emp_no, salary, row_num1 ASC;

-- Retrieve the employee number (emp_no) and job title (title) from the titles table, and the salary (salary) from the salaries table. 
-- Add a fourth column, named row_num1, containing starting from 1 incrementing by 1 for each row for every employee from the obtained result. 
-- Also, add a fifth column, named row_num2, which provides the opposite values - starting from the total number of 
-- records obtained for a given employee and continuing down to 1.
-- Include only data about 'Staff' members and employees with a number no greater than 10006. Order the result by 
-- employee number (emp_no), salary, and row_num1 in ascending order.

SELECT 
	t.emp_no, 
	t.title,
    s.salary, 
    ROW_NUMBER() OVER (PARTITION BY t.emp_no ORDER BY salary ASC) AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY t.emp_no ORDER BY salary DESC) AS row_num2
FROM
	titles t
    JOIN  
    salaries s ON t.emp_no = s.emp_no
WHERE t.title = 'Staff' AND t.emp_no < 10007
ORDER BY t.emp_no ASC, s.salary ASC, row_num1 ASC;

-- Window function by using alias

SELECT
  emp_no,
  salary,
  ROW_NUMBER() OVER w AS ROW_NUM
FROM
  salaries
  window w AS (PARTITION BY emp_no ORDER BY salary);
-- Exercise #1:

-- Write a query that provides row numbers for all workers from the "employees" table, partitioning 
-- the data by their first names and ordering each partition by their employee number in ascending order.

-- NB! While writing the desired query, do *not* use an ORDER BY clause in the relevant SELECT statement. 
-- At the same time, do use a WINDOW clause to provide the required window specification.
-- Solution #1:

SELECT

emp_no,

first_name,

ROW_NUMBER() OVER w AS row_num

FROM

employees

WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);

-- Similar to "The ROW_NUMBER() Ranking Window Function - Exercise #2", retrieve everything stored in the 
-- employee number (emp_no), first name (first_name), and last name (last_name) columns from the employees table. 
-- Add a fourth column named row_num, which partitions the data by first name, sorts it by employee number in ascending
--  order, and assigns a row number starting from 1 and incrementing for each row in every partition.

-- Use the WINDOW keyword to solve the exercise.
SELECT
	emp_no,
	first_name,
	last_name,
	ROW_NUMBER() OVER w AS row_num
FROM
	employees 
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);

-- 	Partion Vs Groupby function

select 
      emp_no,
      salary,
      row_number() OVER (partition by emp_no order by salary desc) AS row_num
 FROM
  salaries;

  
 select a.emp_no,
       MAX(salary) AS max_salary FROM (
 
     select 
      emp_no,
      salary,
      row_number() OVER w AS row_num
   FROM
   salaries
  window w AS (partition by emp_no order by salary desc)) a
  group by emp_no;
  
  select a.emp_no,
       MAX(salary) AS max_salary FROM (
     select 
        emp_no,
         salary
      FROM
        salaries) a
 group by emp_no;
 
 
 select a.emp_no,
       a.salary AS max_salary FROM (
 
     select 
      emp_no,
      salary,
      row_number() OVER w AS row_num
   FROM
   salaries
  window w AS (partition by emp_no order by salary desc)) a
  where a.row_num=1;
 
 -- Exercise #1:

-- Find out the lowest salary value each employee has ever signed a contract for. To obtain the desired output, 
-- use a subquery containing a window function, as well as a window specification introduced with the help of 
-- the WINDOW keyword.

-- Also, to obtain the desired result set, refer only to data from the “salaries” table.
select * from salaries;
SELECT a.emp_no,

       MIN(salary) AS min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

GROUP BY emp_no;

-- Exercise #2:

-- Again, find out the lowest salary value each employee has ever signed a contract for. Once again, to obtain the desired output, 
-- use a subquery containing a window function. This time, however, introduce the window specification in the field list of 
-- the given subquery.

-- To obtain the desired result set, refer only to data from the “salaries” table.

SELECT a.emp_no,

       MIN(salary) AS min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary) AS row_num

FROM

salaries) a

GROUP BY emp_no;

-- Exercise #3:

-- Once again, find out the lowest salary value each employee has ever signed a contract for. This time, 
-- to obtain the desired output, avoid using a window function. Just use an aggregate function and a subquery.

-- To obtain the desired result set, refer only to data from the “salaries” table.
SELECT 
    a.emp_no, MIN(salary) AS min_salary
FROM
    (SELECT 
        emp_no, salary
    FROM
        salaries) a
GROUP BY emp_no;

-- Exercise #4:

-- Once more, find out the lowest salary value each employee has ever signed a contract for. 
-- To obtain the desired output, use a subquery containing a window function, as well as a window specification introduced 
-- with the help of the WINDOW keyword. Moreover, obtain the output without using a GROUP BY clause in the outer query.

-- To obtain the desired result set, refer only to data from the “salaries” table.
SELECT a.emp_no,

a.salary as min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

WHERE a.row_num=1;

-- Exercise #5:

-- Find out the second-lowest salary value each employee has ever signed a contract for. To obtain the desired output,
--  use a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword. 
--  Moreover, obtain the desired result set without using a GROUP BY clause in the outer query.

-- To obtain the desired result set, refer only to data from the “salaries” table.

SELECT a.emp_no,

a.salary as min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

WHERE a.row_num=2;

-- Retrieve the employee number (emp_no) and the lowest contract salary value (salary, using the alias min_salary) for all managers. 
-- To obtain the desired output, you need to refer to the dept_manager and salaries tables.

-- PARTITION BY and GROUP BY are two clauses whose funcionality people sometimes confuse at the beginning. 
-- To explore the difference between these two SQL tools, try to include both in your query.

SELECT a.emp_no, 
       MIN(salary) AS min_salary FROM (
	SELECT 
		s.emp_no, salary, ROW_NUMBER() OVER w AS row_num
	FROM
		dept_manager dm
	JOIN 
	    salaries s ON dm.emp_no = s.emp_no 
	WINDOW w AS (PARTITION BY s.emp_no ORDER BY salary)) a
GROUP BY a.emp_no;

-- method-2
SELECT a.emp_no, 
       MIN(salary) AS min_salary FROM (
	SELECT 
		s.emp_no, salary, ROW_NUMBER() OVER (PARTITION BY s.emp_no ORDER BY salary) AS row_num
	FROM
		dept_manager dm
	JOIN 
	    salaries s ON dm.emp_no = s.emp_no) a
GROUP BY a.emp_no;

-- method-3
SELECT a.emp_no, 
	a.salary AS min_salary FROM (
	SELECT 
		s.emp_no, salary, ROW_NUMBER() OVER w AS row_num
	FROM
		dept_manager dm
	JOIN 
	    salaries s ON s.emp_no = dm.emp_no
	WINDOW w AS (PARTITION BY s.emp_no ORDER BY salary)) a
WHERE a.row_num=1;
-- method-4

SELECT 
    dm.emp_no, MIN(s.salary) AS min_salary
FROM
    dept_manager dm
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY dm.emp_no;

-- method-5
SELECT 
    a.emp_no, MIN(salary) AS min_salary
FROM
    (SELECT 
        dm.emp_no, s.salary
    FROM
        dept_manager dm
	JOIN 
	    salaries s ON dm.emp_no = s.emp_no) a
GROUP BY emp_no;
-- Retrieve the employee number (emp_no) and the highest contract salary value (salary, using the alias max_salary) for all managers.

-- To obtain the desired output, modify the following query, which finds the department managers' lowest salaries.
SELECT a.emp_no, 
	a.salary AS max_salary FROM (
	SELECT 
		s.emp_no, salary, ROW_NUMBER() OVER w AS row_num
	FROM
		dept_manager dm
	JOIN 
	    salaries s ON s.emp_no = dm.emp_no
	WINDOW w AS (PARTITION BY s.emp_no ORDER BY salary DESC)) a
WHERE a.row_num=1;

-- The PARTITION BY Clause vs the GROUP BY Clause - Exercise #3
-- Retrieve the employee number (emp_no) and the third-highest contract salary value (salary, using the alias third_max_salary)
--  for all managers.

-- To solve the exercise, you need to refer to the dept_manager and salaries tables.
SELECT a.emp_no, 
	a.salary as third_max_salary FROM (
	SELECT 
		s.emp_no, salary, ROW_NUMBER() OVER w AS row_num
	FROM
		dept_manager dm 
	JOIN 
	    salaries s ON s.emp_no = dm.emp_no 
	WINDOW w AS (PARTITION BY s.emp_no ORDER BY salary DESC)) a
WHERE a.row_num = 3;
               
          --      Rank and dense rank
          
SELECT distinct
emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries
   WHERE emp_no=10001
WINDOW w AS (PARTITION BY emp_no ORDER BY salary desc) ;


SELECT emp_no, diff
FROM (
    SELECT emp_no, 
           (COUNT(salary) - COUNT(DISTINCT salary)) AS diff
    FROM salaries
    GROUP BY emp_no
) AS subquery
WHERE diff > 0
ORDER BY emp_no;
-- Explanation:
-- Subquery (subquery):

-- The inner query calculates diff as the difference between the total count of salary and the count of distinct salary.
-- The result is aliased as subquery.
-- Outer Query:

-- The outer query selects emp_no and diff from the subquery.
-- The WHERE clause filters the results to only include rows where diff > 0.
select * from salaries where emp_no='11839';

-- Rank function

  
SELECT 
emp_no, salary, rank() OVER w AS rank_num

FROM

salaries
   WHERE emp_no=11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary desc) ;

-- Dense Rank()
SELECT 
emp_no, salary, dense_rank() OVER w AS rank_num
FROM
salaries
   WHERE emp_no=11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary desc) ;

-- Exercise #1:
-- Write a query containing a window function to obtain all salary values that employee number 10560 has ever signed a contract for.

-- Order and display the obtained salary values from highest to lowest.

SELECT

emp_no,

salary,

ROW_NUMBER() OVER w AS row_num

FROM

salaries

WHERE emp_no = 10560

WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC)

-- Exercise #2:
-- Write a query that upon execution, displays the number of salary contracts that each manager has ever signed 
-- while working in the company.

SELECT
    dm.emp_no,
    COUNT(s.salary) AS no_of_salary_contracts
FROM
    dept_manager dm
JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY
    dm.emp_no
ORDER BY
    dm.emp_no;

SELECT VERSION();

-- query with window function
-- Assuming you are using MySQL 8.0 or later
SELECT
    emp_no,
    salary,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM
    salaries
WHERE
    emp_no = 10560;

-- 2. Query for Counting Salary Contracts:
SELECT
    dm.emp_no,
    COUNT(s.salary) AS no_of_salary_contracts
FROM
    dept_manager dm
JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY
    dm.emp_no
ORDER BY
    dm.emp_no;

-- Exercise #3:
-- Write a query that upon execution retrieves a result set containing all salary values that employee 10560 has ever signed 
-- a contract for. Use a window function to rank all salary values from highest to lowest in a way that equal salary values bear 
-- the same rank and that gaps in the obtained ranks for subsequent rows are allowed.

SELECT

emp_no,

salary,

RANK() OVER w AS rank_num

FROM

salaries

WHERE emp_no = 10560

WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- Exercise #4:
-- Write a query that upon execution retrieves a result set containing all salary values that employee 10560 
-- has ever signed a contract for. Use a window function to rank all salary values from highest to lowest in a way that equal
--  salary values bear the same rank and that gaps in the obtained ranks for subsequent rows are not allowed.
SELECT

emp_no,

salary,

DENSE_RANK() OVER w AS rank_num

FROM

salaries

WHERE emp_no = 10560

WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- The MySQL RANK() and DENSE_RANK() Window Functions - Exercise #1
-- Order and number all contract salary values of employee 10002 from highest to lowest. Store the row numbers in a third 
-- column named order_num which assigns different row numbers to identical salary values.

-- To obtain the desired values, refer to the employee number (emp_no) and salary (salary) columns from the salaries table.
SELECT 
	emp_no, 
	salary,
	ROW_NUMBER() OVER w AS order_num
FROM
	salaries
	WHERE emp_no = 10002
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

-- Exercise #2
-- Order and rank all contract salary values of employee 10002 from highest to lowest. 
-- Store the row numbers in a third column named order_num. Assign the same rank to identical salary values allowing gaps in 
-- the obtained ranks for subsequent rows.

-- To obtain the desired values, refer to the employee number (emp_no) and salary (salary) columns from the salaries table.
SELECT
    emp_no,
    salary,
    RANK() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS order_num
FROM
    salaries
WHERE
    emp_no = 10002;

-- Exercise #3
-- Order and rank all contract salary values of employee 10002 from highest to lowest. Store the row numbers in a third column 
-- named order_num. Assign the same rank to identical salary values without allowing gaps in the obtained ranks for subsequent rows.

-- To obtain the desired values, refer to the employee number (emp_no) and salary (salary) columns from the salaries table.
select
emp_no,
salary,
dense_rank() over (partition by emp_no order by salary desc) AS order_num
FROM
    salaries
WHERE
    emp_no = 10002;
    
          -- Ranking window function and Joins Together