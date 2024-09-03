use employees;
-- How many salary contracts signed by female employees have valued above all-time  average contarct salary of 
-- the company?.
SELECT 
    AVG(salary) AS average_salary
FROM
    salaries;
    
WITH CTE AS (
    SELECT AVG(salary) AS avg_salary
    FROM salaries
)
SELECT
    SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_of_salaries_above_avg,
    COUNT(s.salary) AS total_no_of_salary_contracts
FROM
    salaries s
JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
CROSS JOIN
    CTE c;

-- --2
SELECT 
    AVG(salary) AS average_salary
FROM
    salaries;
    
WITH CTE AS (
    SELECT AVG(salary) AS avg_salary
    FROM salaries
)
SELECT
    SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_of_salaries_above_avg_w_sum,
    SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS total_no_of_salaries_above_avg_w_count,
    COUNT(s.salary) AS total_no_of_salary_contracts
FROM
    salaries s
JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
CROSS JOIN
    CTE c;


    






-- Exercise #1:

-- Use a CTE (a Common Table Expression) and a SUM() function in the SELECT statement in a query to find out how many male employees have
--  never signed a contract with a salary value higher than or equal to the all-time company salary average.

WITH cte AS (

SELECT AVG(salary) AS avg_salary FROM salaries

)

SELECT

SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg,

COUNT(s.salary) AS no_of_salary_contracts

FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;


-- Exercise #2:

-- Use a CTE (a Common Table Expression) and (at least one) COUNT() function in the SELECT statement of a query to find out how many
--  male employees have never signed a contract with a salary value higher than or equal to the all-time company salary average.

WITH cte AS (

SELECT AVG(salary) AS avg_salary FROM salaries

)

SELECT

COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,

COUNT(s.salary) AS no_of_salary_contracts

FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;


-- Exercise #3:

-- Use MySQL joins (and don’t use a Common Table Expression) in a query to find out how many male employees have never signed a contract
--  with a salary value higher than or equal to the all-time company salary average (i.e. to obtain the same result as in the previous exercise).
SELECT 
    SUM(CASE
        WHEN s.salary < a.avg_salary THEN 1
        ELSE 0
    END) AS no_salaries_below_avg,
    COUNT(s.salary) AS no_of_salary_contracts
FROM
    (SELECT 
        AVG(salary) AS avg_salary
    FROM
        salaries s) a
        JOIN
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'M';
-- Exercise #4:

-- Use a cross join in a query to find out how many male employees have never signed a contract with a salary value higher than or 
-- equal to the all-time company salary average (i.e. to obtain the same result as in the previous exercise).

WITH cte AS (

SELECT AVG(salary) AS avg_salary FROM salaries

)

SELECT

SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg_w_sum,

# COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,

COUNT(s.salary) AS no_of_salary_contracts

FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' CROSS JOIN cte c;

-- An Alternative Solution to the Same Task - Exercise #1
-- Considering the salary contracts signed by female employees in the company, how many have been signed for a value below the average? 
-- Store the output in a column named no_f_salaries_below_avg. In a second column named no_of_f_salary_contracts, provide the total
--  number of contracts signed by women.

-- Use the salary column from the salaries table and the gender column from the employees table. 
-- Match the two tables on the employee number column (emp_no).

-- Feel free to explore different aggregate functions in your SELECT statement to solve the given task.

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_f_salaries_below_avg,
COUNT(s.salary) AS no_of_f_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F' JOIN cte c;

-- OR

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_f_salaries_below_avg,
COUNT(s.salary) AS no_of_f_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F' JOIN cte c;
-- OR

SELECT 
    SUM(CASE
        WHEN s.salary < a.avg_salary THEN 1
        ELSE 0
    END) AS no_f_salaries_below_avg,
    COUNT(s.salary) AS no_of_f_salary_contracts
FROM
    (SELECT 
        AVG(salary) AS avg_salary
    FROM
        salaries s) a
        JOIN
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'F';
-- OR

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_f_salaries_below_avg,
COUNT(s.salary) AS no_of_f_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F' CROSS JOIN cte c;
-- OR

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_f_salaries_below_avg,
COUNT(s.salary) AS no_of_f_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F' CROSS JOIN cte c;

-- An Alternative Solution to the Same Task - Exercise #2
-- Considering the salary contracts signed by male employees in the company, how many have been signed for a value above the average? 
-- Store the output in a column named no_m_salaries_above_avg. In a second column named no_of_m_salary_contracts, provide the total 
-- number of contracts signed by men.

-- Use the salary column from the salaries table and the gender column from the employees table. Match the two tables on the
--  employee number column (emp_no).

-- Feel free to explore different aggregate functions in your SELECT statement to solve the given task.
WITH MaleSalaries AS (
    SELECT s.salary
    FROM salaries s
    JOIN employees e ON s.emp_no = e.emp_no
    WHERE e.gender = 'M'
),
AverageSalary AS (
    SELECT AVG(salary) AS avg_salary
    FROM MaleSalaries
),
MaleContracts AS (
    SELECT s.salary
    FROM salaries s
    JOIN employees e ON s.emp_no = e.emp_no
    WHERE e.gender = 'M'
),
Counts AS (
    SELECT 
        SUM(CASE WHEN m.salary > a.avg_salary THEN 1 ELSE 0 END) AS no_m_salaries_above_avg,
        COUNT(*) AS no_of_m_salary_contracts
    FROM MaleContracts m, AverageSalary a
)
SELECT no_m_salaries_above_avg, no_of_m_salary_contracts
FROM Counts;

-- OR

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_m_salaries_above_avg,
COUNT(s.salary) AS no_of_m_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;
-- OR

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
COUNT(CASE WHEN s.salary > c.avg_salary THEN s.salary ELSE NULL END) AS no_m_salaries_above_avg,
COUNT(s.salary) AS no_of_m_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' JOIN cte c;
-- OR

SELECT 
    SUM(CASE
        WHEN s.salary > a.avg_salary THEN 1
        ELSE 0
    END) AS no_m_salaries_above_avg,
    COUNT(s.salary) AS no_of_m_salary_contracts
FROM
    (SELECT 
        AVG(salary) AS avg_salary
    FROM
        salaries s) a
        JOIN
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'M';
-- OR

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_m_salaries_above_avg,
COUNT(s.salary) AS no_of_m_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' CROSS JOIN cte c;
-- OR

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
COUNT(CASE WHEN s.salary > c.avg_salary THEN s.salary ELSE NULL END) AS no_m_salaries_above_avg,
COUNT(s.salary) AS no_of_m_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' CROSS JOIN cte c;


