/* 
Name: Khanh Nguyen
Date: 06/18/2022
Title: Payroll Calculation
Description:An HR of the company wants to analyze the performance of the employees and calculate their salary.
Objective: The database design helps to retrieve the employees’ details based on certain criteria which are listed below. */

-- Task to be performed:

-- Write a query to create an employee table and a department table.
CREATE DATABASE triggers;
SHOW DATABASES;
USE triggers;

DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
	emp_id INT NOT NULL,
    f_name VARCHAR(50) NOT NULL,
    l_name 	VARCHAR(50) NOT NULL,
    job_id VARCHAR(15),
    salary INT,
    manager_id INT,
    dept_id INT
);

DESCRIBE employee;

SELECT * FROM employee;

DROP TABLE IF EXISTS department;
CREATE TABLE department (
	dept_id INT,
    dept_name VARCHAR(50),
    location VARCHAR(50),
    manager_id INT,
    elocation_id INT
);

DESCRIBE department;

SELECT * FROM department;

-- Write a query to insert values in the employee and department tables.
-- Already imported using Import csv files into Table feature


 -- Write a query to create a view of the employee and department tables.
DROP VIEW IF EXISTS v_emp_dept;
CREATE VIEW v_emp_dept AS
SELECT emp_id, f_name, l_name, salary, dept_name
FROM employee e, department d
ORDER BY e.emp_id;

SELECT * FROM v_emp_dept;
 
 
 -- Write a query to display first name and last name of the employees from the employee table and an SQL basics view table if the employee’s salary in the SQL basics table is greater than the salary in the employee table.
 SELECT e.f_name, e.l_name, e.salary AS e_salary, v.salary AS v_salary
 FROM employee e, v_emp_dept v
 WHERE e.salary > v.salary
 ORDER BY e.emp_id;

 
 -- Write a query to change the delimiter to //.
 DELIMITER //
 
 
 -- Write a query to create a stored procedure using an employee table if the salary is greater than or equal to 250000.
SELECT * FROM employee //
 DELIMITER &&
 CREATE PROCEDURE great_salary()
 BEGIN
	SELECT * FROM employee WHERE salary >= 250000 //
END && 
DELIMITER //
 
 
 -- Write a query to execute the stored procedure.
 CALL great_salary() //
 
 
 -- Write a query to create a stored procedure with one parameter using ORDER BY salary in descending order, and execute the stored procedure.
 DELIMITER ;
 SELECT * FROM employee;
  DROP PROCEDURE IF EXISTS desc_salary;
 DELIMITER &&
 CREATE PROCEDURE desc_salary(IN Lim INT)
 BEGIN
	SELECT * FROM employee
    ORDER BY salary DESC LIMIT Lim;
END &&
 DELIMITER ;;
 
 CALL desc_salary(3);
 

