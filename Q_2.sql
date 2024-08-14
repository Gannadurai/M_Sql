use new_sample;
show tables;
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4, 2)
);

INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidore', 'Moscow', 200, 5007),
(3001, 'Brad Guzan', 'London', 100, 5005);


CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760.0, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003);


select * from customer;

select * from salesman;

select * from orders;

select * from departments;
drop table reegan










CREATE TABLE employees (
    emp_no      INT             NOT NULL,  -- UNSIGNED AUTO_INCREMENT??
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,  -- Enumeration of either 'M' or 'F'  
    hire_date   DATE            NOT NULL,
    PRIMARY KEY (emp_no)                   -- Index built automatically on primary-key column
                                           -- INDEX (first_name)
                                           -- INDEX (last_name)
);



Create table reegan(Cgpa Decimal(65,2));
insert into reegan values(33333331.4)
select * from reegan;
Drop table reegan;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT,
    order_date DATE,
    order_info_id INT,
    order_value INT,
    order_currency VARCHAR(10),
    PRIMARY KEY (order_id),
    );
ALTER TABLE order_info ENGINE=InnoDB;


CREATE TABLE order_info (
    order_info_id INT AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    product_quantity INT,
    PRIMARY KEY (order_info_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE order_info (
    order_info_id INT AUTO_INCREMENT PRIMARY KEY,
    
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    order_info_id INT,
    order_value INT,
    order_currency VARCHAR(10),
    FOREIGN KEY (order_info_id) REFERENCES order_info(order_info_id)
);
create table departments_dup(dept_no int(50),dept_name varchar(50));
drop table orders;
drop table order_info;
show tables