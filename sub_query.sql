use employees;
-- Extract the information about all department managers who were hired between the 1st of January 
-- 1990 and the 1st of January 1995.
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            
-- Use a subquery with an IN operator inside a WHERE clause to obtain the employee number (emp_no), 
-- department number (dept_no), and contract start date (from_date) from the dept_manager table. 
-- Retrieve only data about managers born in or after 1955.   
SELECT emp_no, dept_no, from_date
FROM dept_manager
WHERE emp_no IN (
    SELECT emp_no
    FROM employees
    WHERE birth_date >= '1955-01-01'
);
-- Select the entire information for all employees whose job title is “Assistant Engineer”. 

-- Hint: To solve this exercise, use the 'employees' table.    
SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');
                
-- Use a subquery with EXISTS inside a WHERE clause of an outer query to retrieve all data from the salaries table.
--  Specify in the subquery that you are only interested in individuals whose job title is 'Engineer'.
select 
*
from salaries s
where
exists(select * 
       from
       titles t
       where s.emp_no=t.emp_no
       and title='Engineer')
       order by emp_no;

select 
   emp_no
   from
   dept_manager
   
                










-- Starting your code with “DROP TABLE”, create a table called “emp_manager” 
-- (emp_no – integer of 11, not null; dept_no – CHAR of 4, null; manager_no – integer of 11, not null). 
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (

   emp_no INT(11) NOT NULL,

   dept_no CHAR(4) NULL,

   manager_no INT(11) NOT NULL

);

-- Fill emp_manager with data about employees, the number of the department they are working in, and their managers.

-- Your query skeleton must be:

-- Insert INTO emp_manager SELECT

-- U.*

-- FROM

--                  (A)

-- UNION (B) UNION (C) UNION (D) AS U;

-- A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM). In other words, assign employee number 110022 as a manager to all employees from 10001 to 10020 (this must be subset A), and employee number 110039 as a manager to all employees from 10021 to 10040 (this must be subset B).

-- Use the structure of subset A to create subset C, where you must assign employee number 110039 as a manager to employee 110022.

-- Following the same logic, create subset D. Here you must do the opposite - assign employee 110022 as a manager to employee 110039.

-- Your output must contain 42 rows.
select * from employees;
DELETE FROM emp_manager;
select * from dept_manager;
select * from dept_emp;
INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;
    select * from emp_manager;
   
   --  Retrieve a table containing three columns:

-- 1. The employee number (emp_no) from the titles table
-- 2. The job title from the titles table
-- 3. A column named avg_salary containing the average salary from the employees' records stored in the salaries table, rounded to the nearest cent. To obtain this column, use a subquery in the outer SELECT statement.

-- To obtain the desired output, use a second subquery, embedded in the FROM clause of the outer query. In its field list, specify that you are only interested in the employee number (emp_no) and title (title) from the records stored in the titles table. In this subquery, you should also indicate that you are focusing on employees whose job title is 'Staff' or 'Engineer'.

-- Sort your output by the average salary in descending order.

SELECT 
    t.emp_no,
    t.title,
    (SELECT 
            ROUND(AVG(s.salary), 2)
        FROM
            salaries s
        WHERE
            s.emp_no = t.emp_no) AS avg_salary
FROM
    (SELECT 
        emp_no, title
    FROM
        titles t
    WHERE
        title = 'Staff' OR title = 'Engineer') as t
ORDER BY avg_salary DESC;

select e.emp_no AS employee_ID,
    min(de.dept_no) As department_code,
    (select emp_no from dept_manager where emp_no='110022') AS manager_ID
    from employees e
    join
    dept_emp de on de.emp_no=e.emp_no
     WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    
    
//