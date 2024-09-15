use employees_mod;
use employees;
-- Find the average salary of male and female employees in each department. 
-- The desired result set should contain three columns: department name (dept_name), gender (gender), and average salary (avg_salary).
--  Apply only to average salary values higher than $70,000. Order your output by department number, starting with the highest value.
SELECT
    d.dept_name, e.gender, AVG(salary) AS avg_salary
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
GROUP BY de.dept_no , e.gender
HAVING AVG(salary) > 70000
ORDER BY de.dept_no;


-- Practice - Exercise #2
-- Assign 10006 as manager to all employees with a number between 10001 and 10005, inclusive. Assign 10007 to all others.
--  Apply only to employees with a number not higher than 10008.

-- To obtain the desired result, organize your output into three columns:

-- 1. The first column (emp_no) containing the employee number.
-- 2. The second column (dept_no) containing the lowest department number they have ever signed a contract for,
--  as recorded in the (dept_emp) table.
-- 3. The last column (manager_no) containing the number of the manager assigned to the given employee.

SELECT
    emp_no,
    (SELECT
            MIN(dept_no)
        FROM
            dept_emp de
        WHERE
            e.emp_no = de.emp_no) dept_no,
    CASE
        WHEN emp_no <= 10005 THEN '10006'
        ELSE '10007'
    END AS manager_no
FROM
    employees e
WHERE
    emp_no <= 10008;
    
-- Practice - Exercise #3
-- Retrieve all records from the employees table for employees hired between January 1, 1988, and December 31, 1992, inclusive.    

SELECT
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1988-01-01' AND '1993-01-01';

-- Practice - Exercise #4
-- Retrieve a list of all employees from the titles table who are staff members. Organize your output into emp_no, title, from_date, 
-- and to_date columns.
SELECT
    *
FROM
    titles
WHERE
    title LIKE ('%staff%');

-- Practice - Exercise #5
-- How many open-ended contracts with a value higher than $74,057 have been registered in the salaries table? 
-- Store your output in a column named num_open_ended_contracts.
-- Please note that open-ended contracts have all been assigned January 1, 9999 as a to_date.
SELECT
    COUNT(*) AS num_open_ended_contracts
FROM
    salaries
WHERE
    to_date = '9999-01-01'
    AND salary > 74057;

-- --Another method

SELECT 
    COUNT(*) AS num_open_ended_contracts
FROM
    salaries
WHERE
    salary > 74057
        AND to_date = '9999-01-01';




