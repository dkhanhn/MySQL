/* 
Name: Khanh Nguyen
Date: 06/04/2022
Title: School Ranking Analysis
Description: The data analyst of a hospital wants to store the patient diagnosis reports with the details of the doctors and the patients for good medical practice and continuity of care.
Objective: The database design helps to retrieve, update, and modify the patient’s details to keep track of the patient's health care routine. */

-- Task to be performed:

/* Write a query to create a patients table with the fields such as date, patient id, patient name, 
age, weight, gender, location, phone number, disease, doctor name, and doctor id. */

CREATE DATABASE functions;
SHOW DATABASES;
USE functions;

DROP TABLE IF EXISTS patients;
CREATE TABLE patients(
	date DATE,
    p_id VARCHAR(25) NOT NULL,
    p_name VARCHAR(255) NOT NULL,
    age INT,
    weight FLOAT,
    gender VARCHAR(10),
    location VARCHAR(25),
    phone_no INT,
    disease VARCHAR(225),
    doctor_name VARCHAR(225) NOT NULL,
    doctor_id INT NOT NULL);

DESCRIBE patients;
    
-- Write a query to insert values into the patients table.
INSERT INTO patients VALUES
('2019-06-15','AP2021','Sarath',67,76,'Male','chennai',5462829,'Cardiac','Mohan',21),
('2019-02-13','AP2022','John',62,80,'Male','banglore',1234731,'Cancer','Suraj',22),
('2018-08-01','AP2023','Henry',43,65,'Male','Kerala',9028320,'Liver','Mehta',23),
('2020-04-02','AP2024','Carl',56,72,'Female','Mumbai',9293829,'Asthma','Karthik',24),
('2017-09-15','AP2025','Shikar',55,71,'Male','Delhi',7821281,'Cardiac','Mohan',21),
('2018-07-22','AP2026','Piysuh',47,59,'Male','Haryana',8912819,'Cancer','Suraj',22),
('2017-03-25','AP2027','Stephen',69,55,'Male','Gujarat',8888211,'Liver','Mehta',23),
('2019-04-22','AP2028','Aaron',75,53,'Male','Banglore',9012192,'Asthma','Karthik',24);

SELECT * FROM patients;


-- Write a query to display the total number of patients in the table.
SELECT COUNT(p_id) FROM patients;


-- Write a query to display the patient id, patient name, gender, and disease of the patient whose age is maximum.
SELECT p_id, p_name, gender, disease, max(age) as max_age 
FROM patients;


-- Write a query to display the old patient’s name and new patient's name in uppercase.
SELECT p_name, UPPER(p_name) AS new_p_name
FROM patients;


-- Write a query to display the patient’s name along with the length of their name.
SELECT p_name, LENGTH(p_name) AS length_p_name
FROM patients;


-- Write a query to display the patient’s name, and the gender of the patient must be mentioned as M or F.
SELECT p_name, LEFT(gender,1) as gender
FROM patients;


-- Write a query to combine the names of the patient and the doctor in a new column. 
SELECT p_name, doctor_name, CONCAT(p_name, '_', doctor_name) AS p_name_doctor_name 
FROM patients;


-- Write a query to display the patients’ age along with the logarithmic value (base 10) of their age.
SELECT age, LOG10(age) AS log10_age
FROM patients;

-- Write a query to extract the year from the given date in a separate column.
SELECT date, YEAR(date) AS Year
FROM patients;


-- Write a query to return NULL if the patient’s name and doctor’s name are similar else return the patient’s name.
SELECT IFNULL(p_name, doctor_name) FROM patients;


-- Write a query to return Yes if the patient’s age is greater than 40 else return No.
SELECT age, IF(age > 40, 'Yes', 'No') AS age_over_40
FROM patients;


-- Write a query to display the doctor’s duplicate name from the table.
SELECT doctor_name, COUNT(doctor_name) FROM patients
GROUP BY doctor_name
HAVING COUNT(doctor_name) > 1;