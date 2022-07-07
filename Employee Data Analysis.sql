/* 
Name: Khanh Nguyen
Date: 06/10/2022
Title: School Ranking Analysis
Description: An HR of the company wants to extract, update, and delete employee details to maintain their records.
Objective: The database design helps to calculate the monthly payroll of each employee efficiently. */

-- Task to be performed:

-- Write a query to create an employee table with the fields employee id, first name, last name, job id, salary, manager id, and department id.
CREATE DATABASE subqueries;
SHOW DATABASES;
USE subqueries;

DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
	emp_id INT NOT NULL,
    f_name VARCHAR(50) NOT NULL,
    l_name VARCHAR(50) NOT NULL,
    job_id 	VARCHAR(50),
    salary INT,
    manager_id INT,
    dept_id VARCHAR(50));

DESCRIBE employee;


-- Write a query to insert values into the employee table.
INSERT INTO employee VALUES
(101,'ankit','jain','HP124',200000,2,24),
(102,'sarvesh','patel','HP123',150000,2,24),
(103,'krishna','gee','HP125',500000,5,44),
(104,'rana','gee','HP122',250000,3,54),
(105,'soniya','jain','HP121',400000,1,22),
(106,'nithin','kumar','HP120',300000,4,34),
(107,'karan','patel','HP126',300001,2,34),
(108,'shilpa','jain','HP127',300001,5,24),
(109,'mukesh','singh','HP128',300001,4,44); 

SELECT * FROM employee;

-- Write a query to find the first name and salary of the employee whose salary is higher than the employee with the last name Kumar from the employee table.
SELECT f_name, salary FROM employee
WHERE salary > (SELECT salary FROM employee WHERE l_name = 'kumar');


-- Write a query to display the employee id and last name of the employee whose salary is greater than the average salary from the employee table.
SELECT emp_id, l_name FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);


/* Write a query to display the employee id, first name, and salary of the employees who earn a salary that is higher than the salary of all the shipping clerks 
(JOB_ID = HP122). Sort the results of the salary in ascending order. */
SELECT emp_id, f_name, salary FROM employee
WHERE salary > ALL (SELECT salary FROM employee WHERE job_id = 'HP122')
ORDER BY salary;


-- Write a query to display the first name, employee id, and salary of the first three employees with highest salaries.
SELECT DISTINCT f_name, emp_id, salary FROM employee a
WHERE  3 >= (SELECT COUNT(DISTINCT salary) FROM employee b WHERE b.salary >= a.salary)
ORDER BY a.salary DESC;
