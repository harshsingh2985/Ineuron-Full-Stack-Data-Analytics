/* PRIMARY KEYS AND FOREIGN KEYS */

-- creating database
CREATE DATABASE KEY_PRIME_FOREIGN;
USE KEY_PRIME_FOREIGN;

-- creating table 
CREATE TABLE IF NOT EXISTS INEURON (
	COURSE_ID INT NOT NULL,
	COURSE_NAME VARCHAR(60),
	COURSE_STATUS VARCHAR(40),
	NUMBER_OF_ENROLLMENTS INT,
	PRIMARY KEY(COURSE_ID)
);

-- describing table
DESC INEURON;

-- inserting records
INSERT INTO INEURON VALUES (01, 'FSDA', 'ACTIVE', 100);
SELECT * FROM INEURON;
INSERT INTO INEURON VALUES (01, 'FSDA', 'NOT-ACTIVE', 100);

/* The above query gives error as 'Duplicate entry '1' for key 'ineuron.primary'.
In the above table, course_id is stated as primary key which should be unique and 
should have only 1 primary key in a table. But we are entering the same value '1'
for course_id column which is not possible */

-- this query will execute and enter the record into the table as it has different primary key
INSERT INTO INEURON VALUES (02, 'FSDA', 'NOT-ACTIVE', 100);


/* whenever we want to establish some relationships between 2 or more tables, 'Foreign Key' comes into picture. */
-- creating another table 
CREATE TABLE IF NOT EXISTS STUDENTS_INEURON (
	STUDENT_ID INT,
	COURSE_NAME VARCHAR(60),
	STUDENT_MAIL VARCHAR(60),
	STUDENT_STATUS VARCHAR(40),
	COURSE_ID1 INT,
	FOREIGN KEY(COURSE_ID1) REFERENCES INEURON(COURSE_ID)
);

DESC STUDENTS_INEURON;

INSERT INTO STUDENTS_INEURON VALUES(101, 'FSDA', 'TEST@GMAIL.COM', 'ACTIVE', 05);
-- error : Cannot add or update a child row, a foreign key constraint fails.
/* the above query gives error because we enter the value of 'course_id1' column as 05
and it is also referencing primary key in another table. It searches the value in 'ineuron' 
table and didn't find the same value.
The foriegn key value and primary key value should be same */

SELECT * FROM STUDENTS_INEURON;

-- the below query insert the records into table as the value are same
INSERT INTO STUDENTS_INEURON VALUES(101, 'FSDA', 'TEST@GMAIL.COM', 'ACTIVE', 01);
INSERT INTO STUDENTS_INEURON VALUES(101, 'FSDA', 'TEST@GMAIL.COM', 'ACTIVE', 01);
INSERT INTO STUDENTS_INEURON VALUES(101, 'FSDA', 'TEST@GMAIL.COM', 'ACTIVE', 01);



-- creating another table and inserting records
CREATE TABLE IF NOT EXISTS PAYMENT (
	COURSE_NAME VARCHAR(60),
	COURSE_ID INT ,
	COURSE_LIVE_STATUS VARCHAR(60),
	COURSE_LAUNCH_DATE VARCHAR(60),
	FOREIGN KEY(COURSE_ID) REFERENCES INEURON(COURSE_ID)
);

INSERT INTO PAYMENT VALUES ('FSDA',01,'NOT-ACTIVE','7TH AUG');
INSERT INTO PAYMENT VALUES ('FSDA',01,'NOT-ACTIVE','7TH AUG');
INSERT INTO PAYMENT VALUES ('FSDA',01,'NOT-ACTIVE','7TH AUG');

SELECT * FROM PAYMENT;


-- creating another table 
-- use 'course_id' column as both 'Primary and Foreign key'
CREATE TABLE IF NOT EXISTS CLASS (
	COURSE_ID INT ,
	CLASS_NAME VARCHAR(60),
	CLASS_TOPIC VARCHAR(60),
	CLASS_DURATION INT ,
	PRIMARY KEY(COURSE_ID),
	FOREIGN KEY(COURSE_ID) REFERENCES INEURON(COURSE_ID)
);

/* Here, 'course_id' column acts as both primary and foreign key 
Why Primary Key? -- so that duplicate entries are not allowed
Why Foreign Key? -- so that we can establish a relationship between class table abd ineuron table based on 'course_id' column
*/


/* What happens when we want to have 2 primary keys in a table? */
ALTER TABLE INEURON ADD CONSTRAINT TEST_PRIM
PRIMARY KEY(COURSE_ID, COURSE_NAME); 
-- error : Multiple primary key defined

ALTER TABLE INEURON ADD CONSTRAINT TEST_PRIM
PRIMARY KEY(COURSE_STATUS, COURSE_NAME); 
-- error : Multiple primary key defined
-- in table, there should be only 1 primary key. no multiple primary keys are allowed


ALTER TABLE INEURON 
DROP PRIMARY KEY;
-- error : cannot drop 'primary', needed in a foreign key constraint

DROP TABLE INEURON;
-- error: cannot drop 'ineuron', referenced by a foreign key constraint

DROP TABLE CLASS;
-- it will drop class table

/* when we want to drop primary key, it will give error as it has some relationship with another table.
Instead, if we drop the table where the relationship has, then the table will be dropped and then we can drop primary key */



CREATE TABLE IF NOT EXISTS TEST (
	ID INT NOT NULL,
	NAME VARCHAR(60),
	EMAIL_ID VARCHAR(60),
	MOBILE_NO VARCHAR(9),
	ADDRESS VARCHAR(50)
);
DESC TEST;

-- adding primary key
ALTER TABLE TEST ADD PRIMARY KEY(ID);

-- If we want to add 2 or more columns as a primary key, then 1st delete the existing primary key and then create it.
ALTER TABLE TEST DROP PRIMARY KEY;
ALTER TABLE TEST ADD PRIMARY KEY(ID,EMAIL_ID);


-- Examples

-- creating tables 
CREATE TABLE PARENT (
	ID INT NOT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE CHILD (
	ID INT,
	PARENT_ID INT,
	FOREIGN KEY(PARENT_ID) REFERENCES PARENT(ID)
);

-- inserting values
INSERT INTO PARENT 
VALUES(1);
SELECT * FROM PARENT;

INSERT INTO CHILD
VALUES(1,1);
SELECT * FROM CHILD;

-- The below query gives error : cannot add or update a child row, a foreign key constraint fails.
-- We can't insert the record because the value '2' in 'child' table is not present in 'parent' table.
INSERT INTO CHILD
VALUES(2,2);

-- The below query also gives error : cannot delete or update parent row, a foreign key constraint fails.
-- We can't delete the record also in parent table because it has some relationship with the 'child' table.
DELETE FROM PARENT WHERE ID=1;

/* Q. How to delete the record from parent table ? */
-- 1st method

-- first delete the record from child table then from the parent table
DELETE FROM CHILD WHERE ID = 1;
DELETE FROM PARENT WHERE ID = 1;

-- 2nd method using 'ON DELETE CASCADE'

-- first drop the child table
DROP TABLE CHILD;
-- again create the child table with 'ON DELETE CASCADE'
CREATE TABLE CHILD (
	ID INT,
	PARENT_ID INT,
	FOREIGN KEY(PARENT_ID) REFERENCES PARENT(ID) ON DELETE CASCADE
);

-- now, insert the records into both the tables
INSERT INTO PARENT VALUES(2);
INSERT INTO CHILD VALUES (1,1),(1,2),(3,2),(2,2);

-- if we want to delete the record from parent table, it will be deleted.
-- also, on deleting the record from parent table, automatically the value from child table is also deleted.
DELETE FROM PARENT WHERE ID=1;

SELECT * FROM PARENT;
SELECT * FROM CHILD;
-- 'ON DELETE CASCADE' is used to specify whether we want rows to be 'deleted from child table' when corresponding rows 'deleted in parent table'.



-- The below query gives error : Can't update or delete a parent row
/* the error shown because there is a relationship of parent table with child table 
to update the table, we will use 'ON UPDATE CASCADE' */
UPDATE PARENT
SET ID = 3
WHERE ID = 2;

-- first, drop the child table if it exists
DROP TABLE CHILD;
-- again create the child table with 'ON UPDATE CASCADE'
CREATE TABLE CHILD (
	ID INT,
	PARENT_ID INT,
	FOREIGN KEY(PARENT_ID) REFERENCES PARENT(ID) ON UPDATE CASCADE
);

-- now, insert the records into both the tables
INSERT INTO PARENT VALUES(3);
INSERT INTO CHILD VALUES (1,1),(1,2),(3,2),(2,2);

-- if we want to update the record from parent table, it will be updated.
-- also, on updating the record from parent table, automatically the value from child table is also updated.
UPDATE PARENT
SET ID = 3
WHERE ID = 2;

SELECT * FROM PARENT;
SELECT * FROM CHILD;
-- 'ON UPDATE CASCADE' is used to specify whether we want rows to be 'updated from child table' when corresponding rows 'updated in parent table'.

