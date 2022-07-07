/* 
Name: Khanh Nguyen
Date: 06/04/2022
Title: School Ranking Analysis
Description: Consider an institution that wants to store the students’ details and their marks records to track their progress. 
The database would contain the students’ information, marks of the students with the rank that can be viewed, updated, and evaluated for the performance evaluation.
Objective: The design of the database helps to easily retrieve thousands of student records. */

-- Task to be performed:

/* Write a query to create a students table with appropriate data types for student id, student first name, student last name, class, and age 
where the student last name, student first name, and student id should be a NOT NULL constraint, and the student id should be in a primary key. */

CREATE DATABASE operators;
SHOW DATABASES;
USE operators;

DROP TABLE IF EXISTS students;
CREATE TABLE students(
	s_id int NOT NULL,
    s_firstname varchar(50) NOT NULL,
    s_lastname varchar(50) NOT NULL,
    class int,
    age int,
    PRIMARY KEY (s_id)
);

DESCRIBE students;

-- Write a query to create a marksheet table that includes score, year, ranking, class, and student id.
DROP TABLE IF EXISTS marksheet;
CREATE TABLE marksheet(
	score int,
    year int,
    ranking int,
    class int,
    s_id int NOT NULL
);

DESCRIBE marksheet;

-- Write a query to insert values in students and marksheet tables.
INSERT INTO students VALUES
(1,'krishna','gee',10,18),
(2,'Stephen','Christ',10,17),
(3,'Kailash','kumar',10,18),
(4,'ashish','jain',10,16),
(5,'khusbu','jain',10,17),
(6,'madhan','lal',10,16),
(7,'saurab','kothari',10,15),
(8,'vinesh','roy',10,14),
(9,'rishika','r',10,15),
(10,'sara','rayan',10,16),
(11,'rosy','kumar',10,16);

SELECT * FROM students;

INSERT INTO marksheet VALUES
(989,2014,10,1,1),
(454,2014,10,10,2),
(880,2014,10,4,3),
(870,2014,10,5,4),
(720,2014,10,7,5),
(670,2014,10,8,6),
(900,2014,10,3,7),
(540,2014,10,9,8),
(801,2014,10,6,9),
(420,2014,10,11,10),
(970,2014,10,2,11),
(720,2014,10,12,12);

SELECT * FROM marksheet;

-- Write a query to display student id and student first name from the student table if the age is greater than or equal to 16 and the student's last name is Kumar.
SELECT s_id, s_firstname FROM students
WHERE age >= 16 AND s_lastname = 'Kumar';


-- Write a query to display all the details from the marksheet table if the score is between 800 and 1000.
SELECT * FROM marksheet
WHERE score BETWEEN 800 AND 1000;

-- Write a query to display the marksheet details from the marksheet table by adding 5 to the score and by naming the column as new score.
SELECT *, score + 5 AS new_score FROM marksheet;

-- Write a query to display the marksheet table in descending order of the  score.
SELECT * FROM marksheet
ORDER BY score DESC;

-- Write a query to display details of the students whose first name starts with a.
SELECT * FROM students
WHERE s_firstname like 'a%';
