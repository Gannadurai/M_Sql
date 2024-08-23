use employees;

select * from employees;
drop procedure if exists select_employees;
-- Change the delimiter to avoid confusion with the default delimiter
DELIMITER //


    
END //
-- Reset the delimiter to the default
DELIMITER ;
CALL select_employees();
DELIMITER //

CREATE PROCEDURE select_employees()
BEGIN
    SELECT *
    FROM Employees
    Limit 1000;
END //

DELIMITER ;
call employees.select_employees();
call select_employees;
-- Create a procedure that will provide the average salary of all employees.

-- Then, call the procedure.
-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS avg_salary;

-- Create the procedure to calculate average salary
DELIMITER //

CREATE PROCEDURE avg_salary()
BEGIN
    SELECT AVG(salary) AS average_salary FROM salaries;
END //

DELIMITER ;
CALL avg_salary();

select* from employees;
select* from salaries;

drop procedure if exists emp_avg_salary;

DELIMITER //

USE employees //

CREATE PROCEDURE emp_avg_salary (IN p_emp_no INT)
BEGIN
    SELECT e.first_name, e.last_name, AVG(s.salary) AS avg_salary
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.emp_no = p_emp_no;
    
END //

DELIMITER ;

drop procedure if exists emp_avg_salary_out;

DELIMITER //
CREATE PROCEDURE emp_avg_salary_out (IN p_emp_no INT,p_avg_salary decimal(10,2))
BEGIN
    SELECT  AVG(s.salary) 
    INTO p_avg_salary 
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.emp_no = p_emp_no;
    
END //
DELIMITER emp_avg_salary_out;

-- Create a procedure called ‘emp_info’ that uses as parameters the 
-- first and the last name of an individual, and returns their employee number.
DELIMITER //
Create procedure emp_info(IN p_first_name varchar(255),p_last_name varchar(255),OUT p_emp_no INT)
BEGIN
 SELECT
                                e.emp_no
                INTO p_emp_no FROM
                                employees e
                WHERE
                                e.first_name = p_first_name
                                                AND e.last_name = p_last_name;

END//

DELIMITER ;

-- Variables
set @v_avg_salary=0;
call employees.emp_avg_salary_out(11300,@v_avg_salary);
select @v_avg_salary;

-- Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise.

-- Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively.

-- Finally, select the obtained output.
SET @v_emp_no = 0;

CALL emp_info('Aruna', 'Journel', @v_emp_no);

SELECT @v_emp_no;

-- user define functions.


