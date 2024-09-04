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


-- ----Sub query with clause
WITH CTE1 AS (
    SELECT AVG(salary) AS avg_salary
    FROM salaries
),
cte2 AS (
select s.emp_no, max(s.salary) AS f_highest_salary
FROM salaries s
JOIN employees e ON e.emp_no=s.emp_no and e.gender='F'
group by s.emp_no
)
SELECT
    SUM(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN 1 ELSE 0 END) AS f_highest_salaries_above_avg,
    COUNT(e.emp_no) AS total_no_female_contracts,
	concat(ROUND((sum(CASE when c2.f_highest_salary >  c1.avg_salary then 1 else 0 end)/count(e.emp_no))*100/2),'%') AS '%percentage'
FROM employees e
JOIN
    cte2 c2 ON c2.emp_no = e.emp_no
CROSS JOIN cte1 c1;

-- Using Multiple Subclauses in a WITH Clause-Exercise
-- Exercise #1:

-- Use two common table expressions and a SUM() function in the SELECT statement of a query to obtain the 
-- number of male employees whose highest salaries have been below the all-time average.
WITH cte1 AS (

SELECT AVG(salary) AS avg_salary FROM salaries

),

cte2 AS (

SELECT s.emp_no, MAX(s.salary) AS max_salary

FROM salaries s

JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'

GROUP BY s.emp_no

)

SELECT

SUM(CASE WHEN c2.max_salary < c1.avg_salary THEN 1 ELSE 0 END) AS highest_salaries_below_avg

FROM employees e

JOIN cte2 c2 ON c2.emp_no = e.emp_no

JOIN cte1 c1;

-- Exercise #2:

-- Use two common table expressions and a COUNT() function in the SELECT statement of a query to obtain the
--  number of male employees whose highest salaries have been below the all-time average.
WITH cte_avg_salary AS (

SELECT AVG(salary) AS avg_salary FROM salaries

),

cte_m_highest_salary AS (

SELECT s.emp_no, MAX(s.salary) AS max_salary

FROM salaries s JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'

GROUP BY s.emp_no

)

SELECT

COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS max_salary

FROM employees e

JOIN cte_m_highest_salary c2 ON c2.emp_no = e.emp_no

JOIN cte_avg_salary c1;


-- Exercise #3:

-- Does the result from the previous exercise change if you used the Common Table Expression (CTE) for the
--  male employees' highest salaries in a FROM clause, as opposed to in a join?
WITH cte_avg_salary AS (

SELECT AVG(salary) AS avg_salary FROM salaries

),

cte_m_highest_salary AS (

SELECT s.emp_no, MAX(s.salary) AS max_salary

FROM salaries s JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'

GROUP BY s.emp_no

)

SELECT

COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS max_salary

FROM cte_m_highest_salary c2

JOIN cte_avg_salary c1;

-- Using Multiple Subclauses in a WITH Clause - Exercise #1
-- Considering the salary contracts signed by female employees in the company, how many have been signed for a
--  value below the average? Store the output in a column named no_f_salaries_below_avg. 
--  In a second column named total_no_of_salary_contracts, provide the total number of contracts signed by 
--  all employees in the company.

-- Use the salary column from the salaries table and the gender column from the employees table. 
-- Match the two tables on the employee number column (emp_no).
WITH cte AS (
    SELECT AVG(salary) AS avg_salary FROM salaries
),
cte2 AS (
    SELECT COUNT(salary) AS total_no_of_salary_contracts FROM salaries
)
SELECT
    SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_f_salaries_below_avg,
    (SELECT total_no_of_salary_contracts FROM cte2) AS total_no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
JOIN cte c;

-- Using Multiple Subclauses in a WITH Clause - Exercise #2
-- Considering the salary contracts signed by male employees in the company, how many have been 
-- signed for a value above the average? Store the output in a column named no_m_salaries_above_avg.
--  In a second column named total_no_of_salary_contracts, provide the total number of contracts signed by all 
--  employees in the company.

-- Use the salary column from the salaries table and the gender column from the employees table. 
-- Match the two tables on the employee number column (emp_no).
WITH cte AS (
    SELECT AVG(salary) AS avg_salary FROM salaries
),
cte2 AS (
    SELECT COUNT(salary) AS total_no_of_salary_contracts FROM salaries
)
SELECT
    SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_m_salaries_above_avg,
    (SELECT total_no_of_salary_contracts FROM cte2) AS total_no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
JOIN cte c;

-- Using Multiple Subclauses in a WITH Clause - Exercise #3
-- How many women (employees.gender = 'F') in the company have their highest salary contract below the 
-- company average?  Store your output in a column named highest_f_salaries_below_total_avg.

-- Use the salary column from the salaries table and the gender column from the employees table. 
-- Match the two tables on the employee number column (emp_no).
WITH cte_avg_salary AS (
SELECT AVG(salary) AS avg_salary FROM salaries
),
cte_m_highest_salary AS (
SELECT s.emp_no, MAX(s.salary) AS max_salary
FROM salaries s 
JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
GROUP BY s.emp_no
)
SELECT 
SUM(CASE WHEN c2.max_salary < c1.avg_salary THEN 1 ELSE 0 END) AS highest_f_salaries_below_total_avg
FROM employees e
JOIN cte_m_highest_salary c2 ON c2.emp_no = e.emp_no
JOIN cte_avg_salary c1;

-- OR
WITH cte_avg_salary AS (
SELECT AVG(salary) AS avg_salary FROM salaries
),
cte_m_highest_salary AS (
SELECT s.emp_no, MAX(s.salary) AS max_salary
FROM salaries s JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
GROUP BY s.emp_no
)
SELECT
COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS highest_f_salaries_below_total_avg
FROM employees e
JOIN cte_m_highest_salary c2 ON c2.emp_no = e.emp_no
JOIN cte_avg_salary c1;
-- OR

WITH cte_avg_salary AS (
SELECT AVG(salary) AS avg_salary FROM salaries
),
cte_m_highest_salary AS (
SELECT s.emp_no, MAX(s.salary) AS max_salary
FROM salaries s JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
GROUP BY s.emp_no
)
SELECT
COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS highest_f_salaries_below_total_avg
FROM cte_m_highest_salary c2
JOIN cte_avg_salary c1;

