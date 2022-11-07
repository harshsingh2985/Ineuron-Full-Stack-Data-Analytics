/* FUNCTIONS */
-- SQL have its own in-built functions. Also, we can write our customised functions i.e, User Defined Functions.

SHOW DATABASES;
USE SALES;
SHOW TABLES;
SELECT * FROM SALES1;

-- create a user defined function to calculate the value of b
DELIMITER $$
CREATE FUNCTION ADD_TO_COL()
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE A INT;
    DECLARE B INT;
    SET A = 20;
	SET B = A + 10;
	RETURN B;
END $$

-- calling function
SELECT ADD_TO_COL1();

-- If we want to pass a parameter to the function
DELIMITER $$
CREATE FUNCTION ADD_TO_COL(A INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE B INT;
	SET B = A + 10;
	RETURN B;
END $$

-- while calling the function, pass a parameter to it
SELECT ADD_TO_COL(20);

-- we can use alias while calling the function
SELECT ADD_TO_COL(20) AS RESULT;

-- we can use the same function to the 'sales1' dataset.
-- If we want to add 10 to each value in 'quantity' column
SELECT QUANTITY, ADD_TO_COL(QUANTITY) FROM SALES1;

==============================================================================
-- Write a function to calculate the final profit in sales1 table
DELIMITER $$
CREATE FUNCTION CALC_PROFITS(PROFIT DECIMAL(20,6), DISCOUNT DECIMAL(20,6), SALES DECIMAL(20,6))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE FINAL_PROFIT INT;
	SET FINAL_PROFIT = PROFIT - SALES * DISCOUNT;
	RETURN FINAL_PROFIT;
END$$

SELECT PROFIT, DISCOUNT, SALES, CALC_PROFITS(PROFIT, DISCOUNT, SALES) AS FINAL_PROFIT_MADE FROM SALES1;

=======================================================================
-- Write a function to convert int to string(varchar)
DELIMITER $$
CREATE FUNCTION INT_TO_STR(A INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE B VARCHAR(20);
    SET B = A;
    RETURN B;
END $$

SELECT INT_TO_STR(45)

SELECT QUANTITY, INT_TO_STR(QUANTITY) FROM SALES1;

======================================================================
/* IF-ELSE */

/* write a function based on following conditions in sales1 table 
1 - 100 -> super affordable
100 - 200 -> affordable
300 - 600 -> moderate
600+ -> expensive */

DELIMITER $$
CREATE FUNCTION SALES_CONDITIONS(SALES INT)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	DECLARE FLAG_SALES VARCHAR(30);
    IF SALES <= 100 
    THEN 
		SET FLAG_SALES = 'SUPER_AFFORDABLE';
    ELSEIF SALES > 100 AND SALES < 300
    THEN 
		SET FLAG_SALES = 'AFFORDABLE';
	ELSEIF SALES > 300 AND SALES < 600
    THEN 
		SET FLAG_SALES = 'MODERATE';
	ELSE
		SET FLAG_SALES = 'EXPENSIVE';
	END IF;
    RETURN FLAG_SALES;
END $$

-- check if the result is 'super_affordable' or not
SELECT SALES_CONDITIONS(100)

-- print out the sales based on above following conditions
SELECT SALES, SALES_CONDITIONS(SALES) FROM SALES1

====================================================================================================
/* LOOPS */

-- write a procedure to print the number from 10 to 100
DROP TABLE IF EXISTS LOOP_TABLE;
CREATE TABLE IF NOT EXISTS LOOP_TABLE(VAL INT);

DELIMITER $$
CREATE PROCEDURE INSERT_DATA()
BEGIN
	SET @VAR = 10;
	GENERATE_DATA : LOOP
		INSERT INTO LOOP_TABLE VALUES (@VAR);
		SET @VAR = @VAR + 1;
		IF @VAR = 100 THEN 
			LEAVE GENERATE_DATA;
		END IF;
	END  LOOP GENERATE_DATA;
END $$

-- calling the procedure
CALL INSERT_DATA();

-- check if data is inserted into loop_table
SELECT * FROM LOOP_TABLE;

==============================================================================
-- write a procedure to print the numbers between 10 to 100 which are divisible by 3

DROP TABLE IF EXISTS DIVISIBLE_BY_3;
CREATE TABLE IF NOT EXISTS DIVISIBLE_BY_3(VAL INT);
DROP PROCEDURE IF EXISTS INSERT_DATA1;

DELIMITER $$
CREATE PROCEDURE INSERT_DATA1()
BEGIN 
	SET @VAR = 10;
	GENERATE_DATA : LOOP
		IF @VAR = 100 THEN
		LEAVE GENERATE_DATA;
		END IF; 
		SET @VAR = @VAR + 1;
		IF (@VAR MOD 3) THEN
		ITERATE GENERATE_DATA;
		ELSE
		INSERT INTO DIVISIBLE_BY_3 VALUES(@VAR);
		END IF;
	END LOOP GENERATE_DATA;
END $$

CALL INSERT_DATA1();
SELECT * FROM DIVISIBLE_BY_3;


/* TASKS */

/* 1. Create a procedure (using loop) to insert the records into the table for 2 columns.
In first column, insert the data ranging from 1 to 10 and in 2nd column, insert the square
of the corresponding values of the first column */

DROP TABLE IF EXISTS NUM_SQUARE;
CREATE TABLE IF NOT EXISTS NUM_SQUARE(NUMBERS INT, SQUARES INT)
DROP PROCEDURE IF EXISTS LOOPDEMO;

DELIMITER &&
CREATE PROCEDURE LOOPDEMO()
BEGIN
	SET @VAR = 1;
    GENERATE_DATA : LOOP
		INSERT INTO NUM_SQUARE VALUES(@VAR, @VAR * @VAR);
        SET @VAR = @VAR + 1;
        IF @VAR > 10 THEN
			LEAVE GENERATE_DATA;
		END IF;
	END LOOP GENERATE_DATA;
END &&

CALL LOOPDEMO();

SELECT * FROM NUM_SQUARE;

/* 2. Create a user defined function to find out a date differences in number of days */
DELIMITER &&
CREATE FUNCTION DATE_DIFFERENCE(DATE1 DATETIME, DATE2 DATETIME)
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN DATEDIFF(DATE1, DATE2);
END &&

SELECT DATE_DIFFERENCE('2003-01-13', '2003-01-06') AS DATE_DIFF


/* 3. Create a function to find out a log base 10 of any given number */
DELIMITER &&
CREATE FUNCTION LOG_NUMBER(NUM INT)
RETURNS DECIMAL(10,5)
DETERMINISTIC
BEGIN
	RETURN LOG10(NUM);
END &&

SELECT LOG_NUMBER(5.4);

/* 4. Create a function which will be able to check total number of records available in the table */
DELIMITER &&
CREATE FUNCTION COUNT_RECORDS()
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE COUNT_NUM INT;
    SET COUNT_NUM = (SELECT COUNT(*) FROM CUSTOMERS);
    RETURN COUNT_NUM;
END &&

SELECT COUNT_RECORDS();


/* 5. create a procedure to find out 5th highest profit in your sales table you dont have to use rank and window function */
DELIMITER &&
CREATE PROCEDURE 5TH_HIGHEST()
BEGIN
	SELECT CUSTOMER_NAME, PROFIT FROM SALES1
	ORDER BY PROFIT DESC
	LIMIT 4,1;
END &&

CALL 5TH_HIGHEST();
