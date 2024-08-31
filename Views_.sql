use employees;
select * from dept_emp;
-- How many emp_no having  same from_date and to_date in dept_empTable
SELECT 
    emp_no,
    MIN(from_date) AS from_date,
    MAX(to_date) AS to_date,
    COUNT(emp_no) as NUM 
FROM 
    dept_emp 
GROUP BY 
    emp_no 
HAVING 
    NUM > 1 
LIMIT 0, 50;

-- Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent.

-- If you have worked correctly, after executing the view from the 
-- “Schemas” section in Workbench, you should obtain the value of 66924.27.

CREATE OR REPLACE VIEW v_manager_avg_salary AS

    SELECT

        ROUND(AVG(salary), 2)

    FROM

        salaries s

            JOIN

        dept_manager m ON s.emp_no = m.emp_no;
        
 

-- You won't be able to access the view you create as you could if you were using Workbench.

-- Although it is considered best practice to create a view by using CREATE OR REPLACE VIEW, please only use CREATE VIEW in this exercise. The former command is only applicable to more complete tools such as MySQL Workbench.

-- That said, focus on the code required to create a view rather than its usage after creation. To explore its application, please recreate the view locally using Workbench.

-- Retrieve the average contract salary values of employees 10002, 10005, and 10007, rounded to the nearest cent. Ensure that this query only includes contracts that started between the years 1991 and 1996, inclusive. Name the resulting column avg_salary.

-- Next, insert this query into a view. To do that, following best practices, 
-- drop the view named v_manager_avg_salary if it currently exists in the 
-- databse. Finally, create a view named v_manager_avg_salary containing the 
-- SELECT statement you just created.       


SELECT 
    ROUND(AVG(salary), 2) AS avg_salary
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
WHERE e.emp_no IN (10002, 10005, 10007)
AND from_date BETWEEN '1991-01-01' AND '1996-12-31';
    
DROP VIEW IF EXISTS v_manager_avg_salary;
CREATE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(salary), 2) AS avg_salary
    FROM
        salaries s
            JOIN
        employees e ON s.emp_no = e.emp_no
    WHERE e.emp_no IN (10002, 10005, 10007)
    AND from_date BETWEEN '1991-01-01' AND '1996-12-31';        