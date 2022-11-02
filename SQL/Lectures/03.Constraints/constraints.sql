/* CONSTRAINTS */

/* 1. auto_increment */ 
-- It automatically insert the number like 1,2,3... etc from system side while we are inserting new record. 
--  while using auto_increment, the column must be set as primary key also. */
CREATE TABLE IF NOT EXISTS TEST (
	TEST_ID INT AUTO_INCREMENT,
	TEST_NAME VARCHAR(30),
	TEST_MAILID VARCHAR(30),
	TEST_ADDRESS VARCHAR(30),
	PRIMARY KEY(TEST_ID)
);

SELECT * FROM TEST;

-- while inserting the values, do not insert values for 'test_id' column as system will autofill the values for it (as it is auto_incremented).
INSERT INTO TEST(TEST_NAME, TEST_MAILID, TEST_ADDRESS) VALUES 
('SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE'),
('KRISH', 'KRISHNAIK@INEURON.AI', 'BANGALORE'),
('HITESH', 'HITESH@INEURON.AI', 'JAIPUR');
        
/* 2. check */
-- This constraint always check if the condition is satisfied or not and if it is not satisfied, it will not allow to enter the record. 
CREATE TABLE IF NOT EXISTS TEST2 (
	TEST_ID INT, 
	TEST_NAME VARCHAR(30),
	TEST_MAILID VARCHAR(30),
	TEST_ADDRESS VARCHAR(30),
	TEST_SALARY INT CHECK (TEST_SALARY > 10000)
);

SELECT * FROM TEST2;

/* 
INSERT INTO TEST2 VALUES 
(1,'SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE',5000);

above code gives error as 5000 is not greater than 10000. so the above record will not entered into test2 table. 
*/

INSERT INTO TEST2 VALUES 
(1,'SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE',50000);

-- multiple check constrainsts can be written 
CREATE TABLE IF NOT EXISTS TEST3(
TEST_ID INT,
TEST_NAME VARCHAR(30),
TEST_MAILID VARCHAR(30),
TEST_ADDRESS VARCHAR(30) CHECK(TEST_ADDRESS ='BANGALORE'),
TEST_SALARY INT CHECK(TEST_SALARY > 10000));

INSERT INTO TEST3
VALUES (1,'SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE',50000),
		(2,'KRISH', 'KRISHNAIK@INEURON.AI', 'BANGALORE',11000),
        (3,'HITESH', 'HITESH@INEURON.AI', 'BANGALORE',20000);

SELECT * FROM TEST3;

-- we can add constraint to the existing column using 'ALTER' command.
ALTER TABLE TEST3 ADD CHECK(TEST_ID > 0);


/* 3. not null */
-- The column having not null constraint cannot accept any NULL values. 
CREATE TABLE IF NOT EXISTS TEST4 (
	TEST_ID INT NOT NULL,
	TEST_NAME VARCHAR(30),
	TEST_MAILID VARCHAR(30),
	TEST_ADDRESS VARCHAR(30),
	TEST_SALARY INT
);

/*
INSERT INTO TEST4(TEST_NAME, TEST_MAILID, TEST_ADDRESS, TEST_SALARY)
VALUES('SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE',50000);

-- above code gives error as any value is not passed to the 'test_id' column.
*/

-- either pass any value to the test_id column while writing insert statement or write auto_increment in create syntax  
INSERT INTO TEST4(TEST_ID, TEST_NAME, TEST_MAILID, TEST_ADDRESS, TEST_SALARY) VALUES
(1, 'SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE',50000);

-- or --

CREATE TABLE IF NOT EXISTS TEST4 (
	TEST_ID INT NOT NULL AUTO_INCREMENT,
	TEST_NAME VARCHAR(30),
	TEST_MAILID VARCHAR(30),
	TEST_ADDRESS VARCHAR(30),
	TEST_SALARY INT
);


/* 4. default */
-- It adds a default value to the column. The default value is added, if no other value is specified.
CREATE TABLE IF NOT EXISTS TEST5 (
	TEST_ID INT NOT NULL DEFAULT 0,
	TEST_NAME VARCHAR(30),
	TEST_MAILID VARCHAR(30),
	TEST_ADDRESS VARCHAR(30),
	TEST_SALARY INT
);

-- 'test_id' value is not inserted but result gives '0' value because of default constraint
INSERT INTO TEST5(TEST_NAME, TEST_MAILID, TEST_ADDRESS, TEST_SALARY) VALUES
('SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE',50000);

-- if default constraint is used along with a value is inserted in 'test_id' column, then the inserted value is reflected rather than default value.
INSERT INTO TEST5(TEST_ID, TEST_NAME, TEST_MAILID, TEST_ADDRESS, TEST_SALARY) VALUES
(104, 'SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE',50000);


/* unique */
-- the unique constraint demands only unique values only present in the specified column.
CREATE TABLE IF NOT EXISTS TEST6 (
	TEST_ID INT NOT NULL DEFAULT 0,
	TEST_NAME VARCHAR(30),
	TEST_MAILID VARCHAR(30) UNIQUE,
	TEST_ADDRESS VARCHAR(30),
	TEST_SALARY INT
);

-- record inserted
INSERT INTO TEST6(TEST_NAME, TEST_MAILID, TEST_ADDRESS, TEST_SALARY) VALUES
('SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE',50000);

-- below code will give error as duplicate entry for 'test_mailid'
INSERT INTO TEST6(TEST_NAME, TEST_MAILID, TEST_ADDRESS, TEST_SALARY) VALUES
('SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE',50000);


/* query where all constraints are used */
CREATE TABLE IF NOT EXISTS TEST7 (
	TEST_ID INT NOT NULL AUTO_INCREMENT,
	TEST_NAME VARCHAR(30) NOT NULL DEFAULT 'UNKNOWN',
	TEST_MAILID VARCHAR(30) UNIQUE NOT NULL,
	TEST_ADDRESS VARCHAR(30) CHECK(TEST_ADDRESS = 'BANGALORE') NOT NULL,
	TEST_SALARY INT CHECK(TEST_SALARY > 10000) NOT NULL,
    PRIMARY KEY(TEST_ID)
);

-- insert records
INSERT INTO TEST7(TEST_ID, TEST_NAME, TEST_MAILID, TEST_ADDRESS, TEST_SALARY) VALUES
(101, 'SUDHANSHU', 'SUDHANSHU@INEURON.AI', 'BANGALORE',50000);
INSERT INTO TEST7(TEST_NAME, TEST_MAILID, TEST_ADDRESS, TEST_SALARY) VALUES
('KRISH', 'KRISH@INEURON.AI', 'BANGALORE',70000);