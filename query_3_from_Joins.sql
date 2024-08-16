use employees;
select * from departments_dup;
 ALTER table departments_dup DROP COLUMN dept_manager ;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

# if you don’t currently have ‘departments_dup’ set up

DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup (
    dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

 INSERT INTO departments_dup

(

    dept_no,

    dept_name

)

SELECT * FROM  departments;

 

INSERT INTO departments_dup (dept_name)

VALUES                ('Public Relations');

 

DELETE FROM departments_dup

WHERE

    dept_no = 'd002'; 

   

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

select * from departments_dup;

-- Intro to JOINs - exercise 2
-- Create and fill in the ‘dept_manager_dup’ table, using the following code:

DROP TABLE IF EXISTS dept_manager_dup;
show tables;
CREATE TABLE dept_manager_dup (

  emp_no int(11) NOT NULL,

  dept_no char(4) NULL,

  from_date date NOT NULL,

  to_date date NULL

  );

 
INSERT INTO dept_manager_dup

select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)

VALUES                (999904, '2017-01-01'),

                                (999905, '2017-01-01'),

                               (999906, '2017-01-01'),

                               (999907, '2017-01-01');
select * from dept_manager_dup;
 
DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';
    
