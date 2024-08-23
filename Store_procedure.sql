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
DELIMITER //
DELIMITER //

DELIMITER //

CREATE FUNCTION f_emp_avg_salary (p_emp_no INT) 
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE v_avg_salary DECIMAL(10,2);
    
    SELECT AVG(s.salary)
    INTO v_avg_salary
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.emp_no = p_emp_no;
    
    RETURN v_avg_salary;
END //

DELIMITER ;

SELECT f_emp_avg_salary(11300);

-- Error Code: 1418. This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA 
-- in its declaration and binary logging is enabled…

-- 1.Let’s begin by saying that a log is a software component where you can save information about some events or errors that happened during the execution of a certain application. A log is preserved for traceability or debugging reasons and this is how it is used in MySQL as well.

-- Consequently, a Binary Log is a log that contains database changes. This type of logging affects the way in which we need to structure our code when creating MySQL functions.

-- When the Binary Log has been enabled, it will always check whether a function is changing the data in the database and what is the result to be produced. The situation can be described like this.

-- Unless we specify what the exact behavior of our function should be, our code will lead to an error. This error is with code 1418 and states that the function has none of the following characteristics in its declaration: DETERMINISTIC, NO SQL, or READS SQL DATA.

-- To solve this error, we must include one (or more) of these characteristics in our code in the way shown in the previous video. They must be placed right after we ‘ve specified the return type of the function. Here’s the syntax to use:

-- create function <function name> <function parameters> returns <type> <characteristics> …

-- Let’s check the meaning of these characteristics:

-- · DETERMINISTIC – it states that the function will always return identical result given the same input

-- · NO SQL – means that the code in our function does not contain SQL (rarely the case)

-- · READS SQL DATA – this is usually when a simple SELECT statement is present



-- When none of those is present in our code, MySQL assumes that our function is non deterministic and that it changes data. This might not be the case, but still, in the end, an error is raised just because MySQL cannot know a priori what our function will do. Adding one of those to our code will prevent this error of showing up.

-- That said, there is another way to stop the error - by disabling the binary log when creating functions. And we can achieve this by executing the following command:

-- SET @@global.log_bin_trust_function_creators := 1;

-- Technically speaking, this operation isn’t the safest one out there. Nevertheless, for the purposes of this course, it is the one that will solve the potential problems regardless of the version of MySQL.

-- In conclusion, remember that sometimes the Binary Log may be disabled anyway and you don’t have to take any of the above actions. In that case, we simply hope you’ve enjoyed reading this article! Thank you!

-- 2.User-defined functions in MySQL - exercise
-- Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee.

-- Hint: In the BEGIN-END block of this program, you need to declare and use two variables – v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.

-- Finally, select this function.
use employees;
DELIMITER // 
DELIMITER //



CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)

DETERMINISTIC NO SQL READS SQL DATA

BEGIN



                DECLARE v_max_from_date date;



    DECLARE v_salary decimal(10,2);



SELECT 
    MAX(from_date)
INTO v_max_from_date FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;



SELECT 
    s.salary
INTO v_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;

       

                RETURN v_salary;



END//



DELIMITER ;



SELECT EMP_INFO('Aruna', 'Journel');




