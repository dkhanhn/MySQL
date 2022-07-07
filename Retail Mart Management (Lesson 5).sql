/* 
Name: Khanh Nguyen
Date: 06/04/2022
Title: Retail Mart Management
Description: A data analyst of a retail shop, Happy Mart, wants to store the product details, the customer details, 
and the order details to provide unparalleled insights about customer behavior and product stock details daily.
Objective: The design of the database helps to easily evaluate and identify the performance of the shop to increase the daily sales.*/

-- Task to be performed:
-- Write a query to create a database named SQL basics.
CREATE DATABASE basics;
SHOW DATABASES;

-- Write a query to select the database SQL basics.
USE basics;

/* Write a query to create a product table with fields as product code, product name, price, stock and category, 
customer table with the fields as customer id, customer name, customer location, and customer phone number and, 
sales table with the fields as date, order number, product code, product name, quantity, and price.*/

DROP TABLE IF EXISTS product;
CREATE TABLE product(
	Product_code int NOT NULL,
    Product_name varchar(50) NOT NULL,
    Price float NOT NULL,
    Stock int NOT NULL,
    Category varchar(50) NOT NULL
);

DESCRIBE product;

DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
	Customer_ID int NOT NULL,
    Customer_name varchar(100) NOT NULL,
    Customer_location varchar(100) NOT NULL,
    Customer_phone_number int NOT NULL
);

DESCRIBE customer;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales(
	Date date NOT NULL,
    Order_number varchar(10) NOT NULL,
    Customer_ID int NOT NULL,
	Customer_name varchar(100) NOT NULL,
    Product_code int NOT NULL,
    Product_name varchar(50) NOT NULL,
    Quantity int NOT NULL,
    Price float NOT NULL
);

DESCRIBE sales;


-- Write a query to insert values into the tables.
INSERT INTO customer VALUES
(1111,'Nisha','kerala',8392320),
(1212,'Oliver','kerala',4353891),
(1216,'Nila','delhi',3323242),
(1246,'Vignesh','chennai',1111212),
(1313,'shiny','Maharastra',5454543),
(1910,'Mohan','mumbai',9023941),
(2123,'Biyush','Bombay',1253358),
(3452,'Alexander','WestBengal',1212134),
(3921,'Mukesh','Manipur',4232321),
(5334,'Christy','pakistan',2311111),
(9021,'Rithika','Kashmir',1121344),
(9212,'Jessica','banglore',1233435),
(9875,'Stephen','chennai',1212133);

SELECT * FROM customer;


INSERT INTO product VALUES
(1,'tulip',198,5,'perfume'),
(2,'cornoto',50,21,'icecream'),
(3,'Pen',10,52,'Stationary'),
(4,'Lays',10,20,'snacks'),
(5,'mayanoise',90,10,'dip'),
(7,'shampoo',5,90,'hair product'),
(8,'axe',210,4,'perfume'),
(9,'park avenue',901,2,'perfume'),
(10,'wattagirl',201,3,'perfume'),
(11,'pencil',4,10,'Stationary'),
(12,'sharpener',5,90,'Stationary'),
(13,'sketch pen',30,10,'Stationary'),
(14,'tape',15,30,'Stationary'),
(16,'chocolate',25,50,'snacks'),
(17,'biscuts',60,26,'snacks'),
(18,'mango',100,21,'fruits'),
(19,'apple',120,9,'fruits'),
(20,'kiwi',140,4,'fruits'),
(21,'carrot',35,12,'vegetable'),
(22,'onion',22,38,'vegetable'),
(23,'tomato',21,15,'vegetable'),
(24,'serum',90,4,'hair product'),
(25,'conditioner',200,5,'hair product'),
(26,'oil bottle',40,2,'kitchen utensil');

SELECT * FROM product;

INSERT INTO sales VALUES
('2016-07-24', 'HM06', 9212, 'Jessica', 11, 'pencil', 3, 30),
('2016-10-19', 'HM09', 3921, 'Mukesh', 17, 'biscuits', 10, 600),
('2016-10-30', 'HM10', 9875, 'Stephen', 2, 'cornoto', 10, 500),
('2018-12-04', 'HM03', 1212, 'Oliver', 20, 'kiwi', 3, 420),
('2018-02-05', 'HM05', 1910, 'Mohan', 20, 'kiwi', 2, 280),
('2018-09-20', 'HM08', 5334, 'Chirsty', 16, 'chocolate', 2, 50),
('2019-11-01', 'HM07', 1246, 'Vignesh', 19, 'apple', 5, 600),
('2019-03-15', 'HM01', 1910, 'Mohan', 5, 'mayanoise', 4, 360),
('2021-10-02', 'HM04', 1111, 'Nisha', 25, 'conditioner', 5, 1000),
('2021-12-02', 'HM02', 2123, 'Biyush', 3, 'Pen', 2, 20);

SELECT * FROM sales;


-- Write a query to add two new columns such as S_no and category to the sales table.
ALTER TABLE sales
	ADD COLUMN S_no int NOT NULL AFTER Order_number,
    ADD COLUMN category varchar(50) NOT NULL AFTER Product_Name;
    
DESCRIBE sales;


-- Write a query to change the column type of stock in the product table to varchar.
ALTER TABLE product
	MODIFY COLUMN Stock varchar(10);

DESCRIBE product;

-- Write a query to change the table name from customer-to-customer details.
ALTER TABLE customer
	RENAME TO customer_details;
    
SHOW TABLES;


-- Write a query to drop the columns S_no and category from the sales table.
ALTER TABLE sales
	DROP COLUMN S_no,
    DROP COLUMN category;

DESCRIBE sales;

-- Write a query to display order id, customer id, order date, price, and quantity from the sales table.
SELECT Order_number, Customer_ID, Date, Price, Quantity
FROM sales;


-- Write a query to display all the details in the product table if the category is stationary.
SELECT * FROM product
WHERE Category = 'Stationary';


-- Write a query to display a unique category from the product table.
SELECT DISTINCT category
FROM product;


-- Write a query to display the sales details if quantity is greater than 2 and price is lesser than 500 from the sales table.
SELECT * FROM sales
WHERE Quantity > 2 AND Price < 500;


-- Write a query to display the customer’s name if the name ends with a.
SELECT Customer_name FROM customer
WHERE Customer_name lIKE '%a';


-- Write a query to display the product details in descending order of the price.
SELECT * FROM product
ORDER BY price DESC;


-- Write a query to display the product code and category from similar categories that are greater than or equal to 2.
SELECT Product_code, Category
FROM product
GROUP BY Category
HAVING COUNT(Category) >= 2;


-- Write a query to display the order number and the customer name to combine the results of the order and the customer tables including duplicate rows.
SELECT Order_number, Customer_name
FROM sales
LEFT JOIN product ON sales.Product_code = product.Product_code
UNION ALL
SELECT Order_number, Customer_name
FROM sales
RIGHT JOIN product ON sales.Product_code = product.Product_code;





