use employees;
-- show tables;
-- select * from emp_manager;

-- Task: From emp_manager table extract the  record data only of those employees who are managers as well.

SELECT 
  e1.*
FROM
   emp_manager e1
   JOIN
   emp_manager e2 ON e1.emp_no=e2.manager_no 
   where
   e2.emp_no IN (select
   manager_no
   FROM
   emp_manager);
select
   manager_no
   FROM
   emp_manager;  
 -- Select all rows from the emp_manager table to understand the information stored in it.

-- Execute a query containing a self-join of the emp_manager table on the employee and manager numbers, 
-- using the aliases e1 and e2. In the field list, designate all columns in the order they appear in the e2 table.  
   
   SELECT * FROM emp_manager;
 
SELECT 
    e2.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
-- Execute a query containing a self-join of the emp_manager table on the employee and manager numbers, 
-- using the aliases e1 and e2. Ensure the result set contains only unique rows. In the field list, 
-- designate all columns in the order they appear in the e1 table.
SELECT DISTINCT
    e1.emp_no,
    e1.dept_no,
    e1.manager_no
FROM
    emp_manager e1
JOIN
    emp_manager e2
ON
    e1.manager_no = e2.emp_no
    AND e1.dept_no = e2.dept_no;

-- Execute a query containing a self-join of the emp_manager table on 
-- the employee and manager numbers, using the aliases e1 and e2. 
-- Ensure -- the result set contains only unique rows. In the field lisdesignate all columns in the order they appear in the e1 table.
    SELECT DISTINCT
    e1.emp_no,
    e1.dept_no,
    e1.manager_no
FROM
    emp_manager e1
JOIN
    emp_manager e2
ON
    e1.emp_no = e2.manager_no
    AND e1.dept_no = e2.dept_no;
