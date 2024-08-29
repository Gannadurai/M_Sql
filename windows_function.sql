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

 -- Create a query that will complete all subtask at once.
--  1.Obtain data only about the managers from the 'employee' database.
--  2.Partition the relevant information by the departments where the managers have worked in.
--  3.Arrange the partition by manager's salary contract values in descending order.
--  4.Rank the manager according to their salaries in a certain department(where you prefer not to lose track of the no:of salary 
--    contract signed within each department).
--  5.Display the start and end dates of each salary contract(call the relevant fields salary_from_date and salary_to_date respectively)
--  6.Display the first and last date in which an employee has been a manager according to the data provided dept_manager table 
--    (call the relevant fields dept_manager_from_date and dept_manager_to_date,respectively)
   select * from dept_manager;
 select 
      d.dept_no,
      d.dept_name,
      dm.emp_no,
      RANK() over w AS department_salary_ranking,
      s.salary,
      s.from_date as salary_from_date,
      s.to_date as salary_to_date,
      dm.from_date as dept_manager_from_date,
      dm.to_date as dept_manager_to_date
    from
     dept_manager dm
       JOIN
      departments d on d.dept_no=dm.dept_no
       JOIN
      salaries s on s.emp_no=dm.emp_no
      And s.from_date between dm.from_date AND dm.to_date
      And s.to_date between dm.from_date AND dm.to_date
	Window w as (partition by dm.dept_no order by s.salary DESC);  
 --   Exercise #1:

-- Write a query that ranks the salary values in descending order of all contracts signed by employees numbered between 
-- 10500 and 10600 inclusive. Let equal salary values for one and the same employee bear the same rank. 
-- Also, allow gaps in the ranks obtained for their subsequent rows.

-- Use a join on the “employees” and “salaries” tables to obtain the desired result.       
SELECT

    e.emp_no,

    RANK() OVER w as employee_salary_ranking,

    s.salary

FROM

employees e

JOIN

    salaries s ON s.emp_no = e.emp_no

WHERE e.emp_no BETWEEN 10500 AND 10600

WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);
-- Exercise #2:

-- Write a query that ranks the salary values in descending order of the following contracts from the "employees" database:

-- - contracts that have been signed by employees numbered between 10500 and 10600 inclusive.

-- - contracts that have been signed at least 4 full-years after the date when the given employee was hired in the 
-- company for the first time.

-- In addition, let equal salary values of a certain employee bear the same rank. Do not allow gaps in the ranks obtained 
-- for their subsequent rows.

-- Use a join on the “employees” and “salaries” tables to obtain the desired result.   

SELECT

    e.emp_no,

    DENSE_RANK() OVER w as employee_salary_ranking,

    s.salary,

    e.hire_date,

    s.from_date,

    (YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start

FROM

employees e

JOIN

    salaries s ON s.emp_no = e.emp_no

    AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5

WHERE e.emp_no BETWEEN 10500 AND 10600

WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC); 

-- MySQL Ranking Window Functions and JOINs - Exercise #1
-- Allowing gaps in the obtained ranks for subsequent rows, rank the contract salary values from highest to 
-- lowest for employees 10001, 10002, 10003, 10004, 10005, and 10006.

-- Every row in the desired output should contain an employee number (emp_no) obtained from the employees table, 

-- and a salary value obtained from the salaries table. Additionally, include the salary ranking values between 
-- the two columns in a field named employee_salary_ranking.      
select * from employees;
select * from salaries;

SELECT 
    e.emp_no,
    RANK() OVER w as employee_salary_ranking,
    s.salary
FROM
	employees e 
		JOIN 
    salaries s ON s.emp_no = e.emp_no
WHERE e.emp_no BETWEEN 10001 AND 10006
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary DESC);

-- MySQL Ranking Window Functions and JOINs - Exercise #2
-- Without allowing gaps in the obtained ranks for subsequent rows, rank the contract salary values from highest to lowest 
-- for employees 10001, 10002, and 10003.

-- Every row in the desired output should contain the relevant employee number (emp_no) and the hire date (hire_date) 
-- from the employees table, as well as the relevant salary value and the start date (from_date) from the salaries table. 
-- Additionally, include the salary ranking values in a field named employee_salary_ranking.

-- Retrieve only data for contracts that have started prior to 2000. Sort your data by the  emp_no in ascending order, 
-- referring to the employees table.

SELECT 
    e.emp_no,
    DENSE_RANK() OVER w as employee_salary_ranking,
    s.salary,
    e.hire_date,
    s.from_date
FROM
	employees e 
		JOIN 
    salaries s ON s.emp_no = e.emp_no
    AND s.from_date < '2000-01-01'
WHERE e.emp_no BETWEEN 10001 AND 10003
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC)
ORDER BY e.emp_no ASC;

-- The LAG and LEAD function.

-- The salary values from all contracts that employee 10001 had ever signed while working for the company(in ascending order)
-- 1.A coloum showing the previous salary value from our ordered list(in ascending order).
-- 2.A coloum showing the previous salary value from our ordered list.
-- 3.A coloum displaying the diff bw the current and previous salary of a given record from the list.
-- 4.A coloum displaying the diff bw the next and current salary of a given record from the list.

select
   emp_no,
   salary,
   lag(salary) over w as prevoius_salary,
   lead(salary) over w as next_salary,
   salary -  lag(salary) over w as diff_salary_current_previous,
   lead(salary) over w - salary AS diff_salary_next_current
  FROM
     salaries
  where emp_no=10001
  window w AS (order by salary);

--   Exercise #1:

-- Write a query that can extract the following information from the "employees" database:

-- - the salary values (in ascending order) of the contracts signed by all employees numbered between 
-- 10500 and 10600 inclusive

-- - a column showing the previous salary from the given ordered list

-- - a column showing the subsequent salary from the given ordered list

-- - a column displaying the difference between the current salary of a certain employee 
-- and their previous salary

-- - a column displaying the difference between the next salary of a certain employee and their current salary

-- Limit the output to salary values higher than $80,000 only.

-- Also, to obtain a meaningful result, partition the data by employee number.
  SELECT

emp_no,

    salary,

    LAG(salary) OVER w AS previous_salary,

    LEAD(salary) OVER w AS next_salary,

    salary - LAG(salary) OVER w AS diff_salary_current_previous,

LEAD(salary) OVER w - salary AS diff_salary_next_current

FROM

salaries

    WHERE salary > 80000 AND emp_no BETWEEN 10500 AND 10600

WINDOW w AS (PARTITION BY emp_no ORDER BY salary);

-- Exercise #2:

-- The MySQL LAG() and LEAD() value window functions can have a second argument, designating how many 
-- rows/steps back (for LAG()) or forth (for LEAD()) we'd like to refer to with respect to a given record.

-- With that in mind, create a query whose result set contains data arranged by the salary values 
-- associated to each employee number (in ascending order). Let the output contain the following six columns:

-- - the employee number

-- - the salary value of an employee's contract (i.e. which we’ll consider as the employee's current salary)

-- - the employee's previous salary

-- - the employee's contract salary value preceding their previous salary

-- - the employee's next salary

-- - the employee's contract salary value subsequent to their next salary

-- Restrict the output to the first 1000 records you can obtain.

SELECT

emp_no,

    salary,

    LAG(salary) OVER w AS previous_salary,

LAG(salary, 2) OVER w AS 1_before_previous_salary,

LEAD(salary) OVER w AS next_salary,

    LEAD(salary, 2) OVER w AS 1_after_next_salary

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)

LIMIT 1000;


-- For employees with employee numbers between 10003 and 10008, inclusive, and their salary contracts 
-- with values less than $70,000, retrieve the following data from the salaries table:

-- - employee number (emp_no)
-- - salary (salary)
-- - previous salary (previous_salary)
-- - next salary (next_salary)
-- - the difference between the current salary of a certain employee and their previous salary (diff_salary_current_previous)
-- - the difference between the next salary of a certain employee and their current salary (diff_salary_next_current).

-- Observe the following excerpt from the desired output to see how to organize the field list in your SELECT statement:

SELECT 
	emp_no,
    salary, 
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_salary_current_previous,
	LEAD(salary) OVER w - salary AS diff_salary_next_current
FROM
	salaries
    WHERE salary < 70000 AND emp_no BETWEEN 10003 AND 10008
WINDOW w AS (PARTITION BY emp_no ORDER BY salary);

-- The LAG() and LEAD() Value Window Functions - Exercise #2
-- Retrieve the following data from the salaries table:

-- - employee number (emp_no)
-- - salary (salary)
-- - use a window function to obtain the salary value of three contracts prior to the given employee contract 
-- salary value, if applicable. Name the column _before_previous_salary
-- - use a window function to obtain the salary value of three contracts after the given employee contract 
-- salary value, if applicable. Name the column _after_next_salary.

-- To obtain the desired output, partition the data by employee number (emp_no) and order by salary 
-- (salary) in ascending order. Retrieve only the first one hundred rows of data.

SELECT 
	emp_no,
    salary, 
	LAG(salary, 3) OVER w AS _before_previous_salary,
    LEAD(salary, 3) OVER w AS _after_next_salary
FROM
	salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary)
LIMIT 100;


-- Aggregate windows function
select emp_no,salary,from_date,to_date
    From 
    salaries
    where 
    to_date > sysdate();
    
    
select
   s1.emp_no,s.salary,s.from_date,s.to_date
 from
    salaries s
    join
    (select 
        emp_no,MAX(from_date) AS from_date
        FROM
        salaries
        group by emp_no) s1 on s.emp_no=s1.emp_no
  where
       s.to_date > sysdate()
       AND s.from_date=s1.from_date;

-- MySQL Aggregate Functions in the Context of Window Functions - Part I-Exercise
-- Exercise #1:

-- Create a query that upon execution returns a result set containing the employee numbers, 
-- contract salary values, start, and end dates of the first ever contracts that each employee signed for 
-- the company.

-- To obtain the desired output, refer to the data stored in the "salaries" table.

SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MIN(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date;
    
-- ---------

SELECT 
    de.emp_no, de.dept_no, de.from_date, de.to_date
FROM
    dept_emp de
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS from_date
    FROM
        dept_emp
    GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
WHERE
    de.to_date = sysdate()
    AND
    de.from_date=de1.from_date;
    -- ---------
-- MySQL Aggregate Functions in the Context of Window Functions - Part II-Exercise
-- Exercise #1:

-- Consider the employees' contracts that have been signed after the 1st of January 2000 and terminated before the 1st of January 2002 (as registered in the "dept_emp" table).

-- Create a MySQL query that will extract the following information about these employees:

-- - Their employee number

-- - The salary values of the latest contracts they have signed during the suggested time period

-- - The department they have been working in (as specified in the latest contract they've signed during the suggested time period)

-- - Use a window function to create a fourth field containing the average salary paid in the department the employee was last working in during the suggested time period. Name that field "average_salary_per_department".



-- Note1: This exercise is not related neither to the query you created nor to the output you obtained while solving the exercises after the previous lecture.

-- Note2: Now we are asking you to practically create the same query as the one we worked on during the video lecture; the only difference being to refer to contracts that have been valid within the period between the 1st of January 2000 and the 1st of January 2002.

-- Note3: We invite you solve this task after assuming that the "to_date" values stored in the "salaries" and "dept_emp" tables are greater than the "from_date" values stored in these same tables. If you doubt that, you could include a couple of lines in your code to ensure that this is the case anyway!

-- Hint: If you've worked correctly, you should obtain an output containing 200 rows.
SELECT

    de2.emp_no, d.dept_name, s2.salary, AVG(s2.salary) OVER w AS average_salary_per_department

FROM

    (SELECT

    de.emp_no, de.dept_no, de.from_date, de.to_date

FROM

    dept_emp de

        JOIN

(SELECT

emp_no, MAX(from_date) AS from_date

FROM

dept_emp

GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no

WHERE

    de.to_date < '2002-01-01'

AND de.from_date > '2000-01-01'

AND de.from_date = de1.from_date) de2

JOIN

    (SELECT

    s1.emp_no, s.salary, s.from_date, s.to_date

FROM

    salaries s

    JOIN

    (SELECT

emp_no, MAX(from_date) AS from_date

FROM

salaries

    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no

WHERE

    s.to_date < '2002-01-01'

AND s.from_date > '2000-01-01'

AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no

JOIN

    departments d ON d.dept_no = de2.dept_no

GROUP BY de2.emp_no, d.dept_name

WINDOW w AS (PARTITION BY de2.dept_no)

ORDER BY de2.emp_no, salary;




