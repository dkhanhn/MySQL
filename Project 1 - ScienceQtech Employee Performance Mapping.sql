/* 
Name: Khanh Nguyen
Date: 06/18/2022

Title: Project 1 - ScienceQtech Employee Performance Mapping

Description: ScienceQtech is a startup that works in the Data Science field. ScienceQtech has worked on fraud detection, market basket, self-driving cars, supply chain, 
algorithmic early detection of lung cancer, customer sentiment, and the drug discovery field. With the annual appraisal cycle around the corner, 
the HR department has asked you (Junior Database Administrator) to generate reports on employee details, their performance, and on the project that the employees have undertaken, 
to analyze the employee database and extract specific data based on different requirements.

Objective: To facilitate a better understanding, managers have provided ratings for each employee which will help the HR department to finalize the employee performance mapping. 
As a DBA, you should find the maximum salary of the employees and ensure that all jobs are meeting the organization's profile standard. 
You also need to calculate bonuses to find extra cost for expenses. This will raise the overall performance of the organization by ensuring that all required employees receive training. */

-- The task to be performed: 
-- 1. Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources.
-- Dataset description:

CREATE DATABASE employee;
USE employee;

DROP TABLE IF EXISTS emp_record_table;
CREATE TABLE emp_record_table (
EMP_ID VARCHAR(10) NOT NULL,			-- ID of the employee
FIRST_NAME VARCHAR(50) DEFAULT NULL,	-- First name of the employee
LAST_NAME VARCHAR(50) DEFAULT NULL,		-- Last name of the employee
GENDER VARCHAR(1) DEFAULT NULL,			-- Gender of the employee
ROLE VARCHAR(50) DEFAULT NULL, 			-- Post of the employee
DEPT VARCHAR(50) DEFAULT NULL,			-- Field of the employee
EXP INT DEFAULT NULL,					-- Years of experience the employee has
COUNTRY VARCHAR(50) DEFAULT NULL,		-- Country in which the employee is presently living
CONTINENT VARCHAR(50) DEFAULT NULL,		-- Continent in which the country is
SALARY INT DEFAULT NULL, 				-- Salary of the employee
EMP_RATING INT DEFAULT NULL,			-- Performance rating of the employee
MANAGER_ID VARCHAR(10) DEFAULT NULL,	-- The manager under which the employee is assigned 
PROJ_ID VARCHAR(10) DEFAULT NULL, 		-- The project on which the employee is working or has worked on

PRIMARY KEY (EMP_ID)
);

DESCRIBE emp_record_table;
SELECT * FROM emp_record_table;			-- Import from emp_record_table.csv


DROP TABLE IF EXISTS proj_table;
CREATE TABLE proj_table (
PROJECT_ID VARCHAR(10) NOT NULL, 		-- ID for the project
PROJ_Name VARCHAR(50) DEFAULT NULL,		-- Name of the project
DOMAIN VARCHAR(50) DEFAULT NULL,		-- Field of the project
START_DATE DATE DEFAULT NULL,			-- Day the project began
CLOSURE_DATE DATE DEFAULT NULL,			-- Day the project was or will be completed
DEV_QTR VARCHAR(2) DEFAULT NULL,		-- Quarter in which the project was scheduled
STATUS VARCHAR(50) DEFAULT NULL		-- Status of the project currently
);

DESCRIBE proj_table;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/employee/1643891559_performance_mapping_datasets/proj_table.csv' 
INTO TABLE proj_table   
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"'  
LINES TERMINATED BY '\n'   
IGNORE 1 ROWS
(DOMAIN, @DATE, @DATE, DEV_QTR)
SET START_DATE = STR_TO_DATE(@DATE, '%m/%d/%Y'), CLOSURE_DATE = STR_TO_DATE(@Date, '%m/%d/%Y');  

SELECT *  FROM proj_table;




CREATE TABLE data_science_team (
EMP_ID VARCHAR(10) NOT NULL,			-- ID of the employee
FIRST_NAME VARCHAR(50) DEFAULT NULL, 	-- First name of the employee
LAST_NAME VARCHAR(50) DEFAULT NULL,		-- Last name of the employee
GENDER VARCHAR(1) DEFAULT NULL,			-- Gender of the employee
ROLE VARCHAR(50) DEFAULT NULL,			-- Post of the employee
DEPT VARCHAR(50) DEFAULT NULL,			-- Field of the employee
EXP INT DEFAULT NULL,					-- Years of experience the employee has
COUNTRY VARCHAR(50) DEFAULT NULL,		-- Country in which the employee is presently living
CONTINENT VARCHAR(50) DEFAULT NULL,		-- Continent in which the country is
PRIMARY KEY (EMP_ID)
);

DESCRIBE data_science_team;
SELECT * FROM data_science_team;


-- 2. Create an ER diagram for the given employee database.


-- 3. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table;


-- 4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: less than two, greater than four, between two and four
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING > 4;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING BETWEEN 2 AND 4
ORDER BY EMP_RATING;


-- 5. Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'Finance';


-- 6. Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).
SELECT EMP_ID, CONCAT(FIRST_NAME, " ", LAST_NAME) AS NAME, ROLE, MANAGER_ID, COUNT(EMP_ID) AS Total_direct_reports
FROM emp_record_table
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
ORDER BY COUNT(EMP_ID);


-- 7. Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.
SELECT FIRST_NAME, LAST_NAME, DEPT
FROM emp_record_table e
WHERE DEPT = 'HEALTHCARE' OR DEPT = 'FINANCE'
UNION
SELECT FIRST_NAME, LAST_NAME, DEPT
FROM data_science_team
WHERE DEPT = 'HEALTHCARE' OR DEPT = 'FINANCE'
ORDER BY DEPT;


/* 8. Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. 
Also include the respective employee rating along with the max emp rating for the department. */

SELECT a.EMP_ID, a.FIRST_NAME, a.LAST_NAME, a.ROLE, a.DEPT, a.EMP_RATING
FROM emp_record_table a 
INNER JOIN
(SELECT DEPT, MAX(EMP_RATING) AS max_emp FROM emp_record_table GROUP BY DEPT) b
ON a.DEPT = b.DEPT AND a.EMP_RATING = b.max_emp;


-- 9. Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.
(SELECT a.EMP_ID, a.FIRST_NAME, a.LAST_NAME, a.ROLE, a.SALARY, CONCAT('Max Salary in ', a.ROLE) AS SALARY_RANK
FROM emp_record_table a
JOIN
(SELECT ROLE, MAX(SALARY) as max_salary FROM emp_record_table b GROUP BY ROLE) b
ON a.ROLE = b.ROLE AND a.SALARY = b.max_salary)
UNION ALL
(SELECT a.EMP_ID, a.FIRST_NAME, a.LAST_NAME, a.ROLE, a.SALARY, CONCAT('Min Salary in ', a.ROLE) AS SALARY_RANK
FROM emp_record_table a
JOIN
(SELECT ROLE, MIN(SALARY) as min_salary FROM emp_record_table b GROUP BY ROLE) b
ON a.ROLE = b.ROLE AND a.SALARY = b.min_salary)
ORDER BY ROLE;


-- 10. Write a query to assign ranks to each employee based on their experience. Take data from the employee record table
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, DENSE_RANK() OVER (ORDER BY EXP) EXP_RANK
FROM emp_record_table;


-- 11. Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.
DROP VIEW IF EXISTS high_salary_emp;
CREATE VIEW high_salary_emp AS
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, COUNTRY, SALARY
FROM emp_record_table
WHERE SALARY > 6000
ORDER BY COUNTRY DESC, SALARY DESC;

SELECT * FROM high_salary_emp;


-- 12. Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM emp_record_table
WHERE EXP IN (SELECT EXP FROM emp_record_table b WHERE EXP > 10)
ORDER BY EXP;

-- 13. Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.
DROP PROCEDURE IF EXISTS get_exp_emp;
DELIMITER &&
CREATE PROCEDURE get_exp_emp()
BEGIN 
	SELECT * FROM emp_record_table WHERE EXP > 3 ORDER BY EXP;
END &&
DELIMITER ;

CALL get_exp_emp();


/* 14. Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.
The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.
*/

DROP FUNCTION IF EXISTS job_profile;
DELIMITER &&
CREATE FUNCTION job_profile (
EXP INT
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN 
	DECLARE job_profile VARCHAR(100);
    IF EXP <= 2 THEN SET job_profile = 'JUNIOR DATA SCIENTIST';
	ELSEIF EXP BETWEEN 2 AND 5 THEN SET job_profile = 'ASSOCIATE DATA SCIENTIST'; -- (EXP > 2 AND EXP <= 5)
    ELSEIF EXP BETWEEN 5 AND 10 THEN SET job_profile = 'SENIOR DATA SCIENTIST'; -- (EXP > 5 AND EXP <= 10) 
    ELSEIF (EXP > 10 AND EXP <= 12) THEN SET job_profile = 'LEAD DATA SCIENTIST';
    ELSEIF (EXP > 12 AND EXP <= 16) THEN SET job_profile = 'MANAGER';
    END IF;
    
RETURN (job_profile);
END &&
DELIMITER ;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, job_profile(EXP)
FROM emp_record_table ORDER BY EXP;


-- 15. Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
CREATE INDEX FIRST_NAME ON emp_record_table(FIRST_NAME);
EXPLAIN SELECT EMP_ID, FIRST_NAME, LAST_NAME FROM emp_record_table WHERE FIRST_NAME = 'Eric';
SHOW INDEXES FROM emp_record_table;
 


-- 16. Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EMP_RATING, SALARY, SALARY*0.05*EMP_RATING AS BONUS
FROM emp_record_table;


-- 17. Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.
SELECT CONTINENT, COUNTRY, CAST(AVG(SALARY) AS DECIMAL(10,2)) AS AVERAGE_SALARY_DISTRBUTION
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY
ORDER BY CONTINENT, COUNTRY;





