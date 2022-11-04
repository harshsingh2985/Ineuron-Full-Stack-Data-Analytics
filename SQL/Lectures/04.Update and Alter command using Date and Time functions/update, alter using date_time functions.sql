-- create database
CREATE DATABASE SALES1;
SHOW DATABASES;
USE SALES1;

-- create table 
CREATE TABLE SALES1(
	ORDER_ID VARCHAR(15) NOT NULL, 
	ORDER_DATE VARCHAR(15) NOT NULL, 
	SHIP_DATE VARCHAR(15) NOT NULL, 
	SHIP_MODE VARCHAR(14) NOT NULL, 
	CUSTOMER_NAME VARCHAR(22) NOT NULL, 
	SEGMENT VARCHAR(11) NOT NULL, 
	STATE VARCHAR(36) NOT NULL, 
	COUNTRY VARCHAR(32) NOT NULL, 
	MARKET VARCHAR(6) NOT NULL, 
	REGION VARCHAR(14) NOT NULL, 
	PRODUCT_ID VARCHAR(16) NOT NULL, 
	CATEGORY VARCHAR(15) NOT NULL, 
	SUB_CATEGORY VARCHAR(11) NOT NULL, 
	PRODUCT_NAME VARCHAR(127) NOT NULL, 
	SALES DECIMAL(38, 0) NOT NULL, 
	QUANTITY DECIMAL(38, 0) NOT NULL, 
	DISCOUNT DECIMAL(38, 3) NOT NULL, 
	PROFIT DECIMAL(38, 5) NOT NULL, 
	SHIPPING_COST DECIMAL(38, 2) NOT NULL, 
	ORDER_PRIORITY VARCHAR(8) NOT NULL, 
	`YEAR` DECIMAL(38, 0) NOT NULL
);

SELECT * FROM SALES1;

SET SESSION SQL_MODE='';

-- It is used to disable the safe mode option so that we can execute update or delete statements.
SET SQL_SAFE_UPDATES = 0;

-- load data to the table 
LOAD DATA INFILE
'F:/INEURON_SQL/UPDATE_ALTER/SALES_DATA_FINAL.CSV'
INTO TABLE SALES1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- change both the date that are having datatype 'varchar' to 'date' format
SELECT STR_TO_DATE(ORDER_DATE,'%M/%D/%Y') FROM SALES1;

-- order_date_new 
-- create an extra column 'order_date_new' into existing table after 'order_date' column
ALTER TABLE SALES1
ADD COLUMN ORDER_DATE_NEW DATE AFTER ORDER_DATE;

-- change the 'order_date_new' datatype to date 
UPDATE SALES1
SET ORDER_DATE_NEW = STR_TO_DATE(ORDER_DATE,'%M/%D/%Y');


-- ship_date_new
-- create an extra column 'ship_date_new' into existing table after 'ship_date' column
ALTER TABLE SALES1
ADD COLUMN SHIP_DATE_NEW DATE AFTER SHIP_DATE;

-- change the 'ship_date_new' datatype to date 
UPDATE SALES1
SET SHIP_DATE_NEW = STR_TO_DATE(SHIP_DATE,'%M/%D/%Y');

-- filter out all data where shipping date is 2011-01-05
SELECT * FROM SALES1
WHERE SHIP_DATE_NEW = '2011-01-05';

-- filter out what sales shipment happened between 4th month and 5th month
SELECT * FROM SALES1
WHERE SHIP_DATE_NEW BETWEEN '2011-01-04' AND '2011-05-30';

/* Date and Time Functions */
-- -------------------------
-- current date and time
SELECT NOW();

-- current date
SELECT CURDATE();

-- current time
SELECT CURTIME();

-- subtract the time interval from a date i.e, it shows last week date
SELECT DATE_SUB(NOW(), INTERVAL 1 WEEK);

-- filter out all the sales happened last week
SELECT * FROM SALES1
WHERE SHIP_DATE_NEW < DATE_SUB(NOW(), INTERVAL 1 WEEK);

-- current year
SELECT YEAR(NOW());

-- current dayname
SELECT DAYNAME(NOW());

-- current dayname
SELECT DAYNAME('2022-08-11 11:05:23');

SELECT * FROM SALES1;

-- create a new column 'currnent_date' after specific column and insert current date as records in it.
ALTER TABLE SALES1
ADD COLUMN `CURRENT_DATE` DATE AFTER ORDER_ID;

-- now() gives both date and time results but in alter command 'current_date' datatype is date. So, output gives only date.
UPDATE SALES1
SET `CURRENT_DATE` = NOW();

-- change the datatype of the column decimal to date
ALTER TABLE SALES1
MODIFY COLUMN `YEAR` DATE;

/* Q. Suppose we want to create 3 new columns i.e., year, month, day and 
store the individual value of 'order_date_new' column into these 3 new columns */
ALTER TABLE SALES1
ADD COLUMN YEAR_NEW INT AFTER ORDER_DATE_NEW;

ALTER TABLE SALES1
ADD COLUMN MONTH_NEW INT AFTER YEAR_NEW;

ALTER TABLE SALES1
ADD COLUMN DAY_NEW INT AFTER MONTH_NEW;

SELECT * FROM SALES1;
SET SQL_SAFE_UPDATES = 0;

UPDATE SALES1
SET YEAR_NEW = YEAR(ORDER_DATE_NEW);

UPDATE SALES1
SET MONTH_NEW = MONTH(ORDER_DATE_NEW);

UPDATE SALES1
SET DAY_NEW = DAY(ORDER_DATE_NEW);


-- average sales yearwise along with group by
-- (whether my sales increased in years or not)
SELECT 
	YEAR_NEW, 
	AVG(SALES) 
FROM SALES1
GROUP BY YEAR_NEW;

-- total sales yearwise
SELECT 
	YEAR_NEW, 
	SUM(SALES) 
FROM SALES1
GROUP BY YEAR_NEW;

-- what is the quantity that you have sold every year
SELECT 
	YEAR_NEW, 
	SUM(QUANTITY) 
FROM SALES1
GROUP BY YEAR_NEW;

SELECT (SALES * DISCOUNT + SHIPPING_COST) AS CTC
FROM SALES1;

-- use of 'if condition'
SELECT 
	ORDER_ID, 
	DISCOUNT, 
    IF(DISCOUNT > 0, 'YES', 'NO') AS DISCOUNT_FLAG 
FROM SALES1;

-- count no. of items with discount available and discount not available
SELECT * FROM SALES1;

ALTER TABLE SALES1
ADD COLUMN DISCOUNT_FLAG VARCHAR(30) AFTER DISCOUNT;

UPDATE SALES1
SET DISCOUNT_FLAG = IF(DISCOUNT > 0, 'YES', 'NO');
 
SELECT 
	DISCOUNT_FLAG, 
    COUNT(*) 
FROM SALES1 
GROUP BY DISCOUNT_FLAG;
-- or --
SELECT 
	COUNT(*) AS COUNT_ITEMS_DISCOUNT 
FROM SALES1
WHERE DISCOUNT > 0;
