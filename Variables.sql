use employees;
-- LOCAL VARIABLES
-- Set the delimiter to // to handle the function definition
DELIMITER //

-- Create the function
-- Set the delimiter to // to handle the function definition
DELIMITER //

-- Create the function with necessary attributes
CREATE FUNCTION f_emp_avg_salary (p_emp_no INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_avg_salary DECIMAL(10,2);

    -- Calculate the average salary (replace with your actual query)
    SELECT AVG(salary) INTO v_avg_salary
    FROM employees
    WHERE emp_no = p_emp_no;

    RETURN v_avg_salary;
END //

-- Reset the delimiter to ;
DELIMITER ;

-- Set the delimiter to // to handle the function definition
DELIMITER //

-- Create the new function with a different name
CREATE FUNCTION f_emp_avg_salary_v2 (p_emp_no INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_avg_salary_2 DECIMAL(10,2);

    -- Begin block to include SQL logic
    BEGIN
        -- Calculate the average salary (replace with your actual query)
        SELECT AVG(salary) INTO v_avg_salary_2
        FROM employees
        WHERE emp_no = p_emp_no;
    END;

    -- Return the calculated average salary
    RETURN v_avg_salary_2;
END //

-- Reset the delimiter to ;
DELIMITER ;
-- Yes, you can declare multiple variables within the same BEGIN ... END block of a MySQL function. Each variable declaration should be separated by a semicolon, and you can declare as many variables as you need.

-- Here’s an example of how to declare and use two different variables within a MySQL function:
-- Set the delimiter to // to handle the function definition
DELIMITER //

-- Create the function with multiple variables
CREATE FUNCTION f_emp_avg_salary (p_emp_no INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    -- Declare multiple variables
    DECLARE v_avg_salary DECIMAL(10,2);
    DECLARE v_salary_sum DECIMAL(10,2);

    -- Calculate the total salary and average salary
    BEGIN
        -- Calculate the total salary
        SELECT SUM(salary) INTO v_salary_sum
        FROM employees
        WHERE emp_no = p_emp_no;

        -- Calculate the average salary
        SELECT AVG(salary) INTO v_avg_salary
        FROM employees
        WHERE emp_no = p_emp_no;
    END;

    -- Return the calculated average salary
    RETURN v_avg_salary;
END //

-- Reset the delimiter to ;
DELIMITER ;

-- Create a variable named var1 containing the text value 'Diana'. Display the value contained in var1.
SET @var1 = 'Diana'; 
 
SELECT @var1;

-- Create a variable named v_emp_no containing the integer 10004. Retrieve the employee number, first name, last name, and hire date of the
--  employee with the employee number stored in v_emp_no. To obtain the desired output, use the data from the employees table.
SET @v_emp_no = 10004; 
 
SELECT 
    emp_no,
    first_name,
    last_name,
    hire_date
FROM
    employees
WHERE
    emp_no = @v_emp_no;
