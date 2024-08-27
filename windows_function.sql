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



