/* ------------PARTITIONING-------------*/

/* 
Partitioning is dividing of stored database objects (tables, indexes, views) into separate parts. 
Partitioning is used to increase controllability, performance and availability of large database objects. 
In some cases, partitioning improves performance when accessing the partitioned tables. 
*/

-- creating database
CREATE DATABASE INEURON_PARTITION;
USE INEURON_PARTITION;

-- creating table
CREATE TABLE INEURON_COURSES (
	COURSE_NAME VARCHAR(50),
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(60),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT
);

SELECT * FROM INEURON_COURSES;

-- inserting data to table
INSERT INTO INEURON_COURSES VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 101 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('DLCVNLP' , 101 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('AWS CLOUD' , 101 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('BLOCKCHAIN' , 101 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('RL' , 101 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('DL' , 101 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('INTERVIEW PREP' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('BIG DATA' , 101 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('DATA ANALYTICS' , 101 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FSDS' , 101 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('FSDA' , 101 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FABE' , 101 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('JAVA' , 101 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('MERN' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);

SELECT * FROM INEURON_COURSES WHERE COURSE_LAUNCH_YEAR = 2020;
/* The above query will go line by line and search for course_launch_year that matches with 2020 and gives the result
but if we do the partition based on course_launch_year then it will directly match the required records based on the given condition. */


/* TYPES OF PARTITIONING */
-- 1. RANGE PARTITIONING
/*
This type of partitioning assigns rows to partitions based on column values falling within a given range.
*/

-- create table with 'range partition' 
CREATE TABLE INEURON_COURSES1 (
	COURSE_NAME VARCHAR(50),
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(60),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT
)
PARTITION BY RANGE(COURSE_LAUNCH_YEAR) (
	PARTITION P0 VALUES LESS THAN (2019),
	PARTITION P1 VALUES LESS THAN (2020),
	PARTITION P2 VALUES LESS THAN (2021),
	PARTITION P3 VALUES LESS THAN (2022),
	PARTITION P4 VALUES LESS THAN (2023)
);

INSERT INTO INEURON_COURSES1 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 101 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('DLCVNLP' , 101 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('AWS CLOUD' , 101 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('BLOCKCHAIN' , 101 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('RL' , 101 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('DL' , 101 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('INTERVIEW PREP' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('BIG DATA' , 101 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('DATA ANALYTICS' , 101 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FSDS' , 101 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('FSDA' , 101 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FABE' , 101 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('JAVA' , 101 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('MERN' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);

SELECT * FROM INEURON_COURSES1;
SELECT * FROM INEURON_COURSES WHERE COURSE_LAUNCH_YEAR = 2020;
SELECT * FROM INEURON_COURSES1 WHERE COURSE_LAUNCH_YEAR = 2020;

/*After executing the above two queries, we will find that the execution time of 2nd query is less than the 1st query (because of using partition).
While using partitioning, the execution time decreases as it creates partitions based on ranges. 
So, while searching the value, it takes less time as compared to 1st query. */


SELECT 
	PARTITION_NAME, 
    TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES1';
-- The above query shows the number of rows each partition has. 

-- Partitioning used to split or partition the rows of a table into separate tables like tables inside a table.
/* Benifits of partitioning
1. Optimizes the query performance
2. When we query on the table, it scans only the portion of a table that will satisfy the particular statement. */


-- 2. HASH PARTITIONING : 
/* 
It is used to ensure an even distribution of data among a predetermined number of partitions
In range partitioning, we have to explicitly specify which partition a given column value should 
be stored in but in 'hash partitioning', it automatically assigns which partition the value will set
i.e., we have to specify a column value based on a column value to be hashed and the number of partitions 
into which the parittioned table is to be divided.
*/

--  create table with 'hash partition' 
CREATE TABLE INEURON_COURSES2 (
	COURSE_NAME VARCHAR(50),
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(60),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT )
PARTITION BY HASH(COURSE_LAUNCH_YEAR)
PARTITIONS 5; 

INSERT INTO INEURON_COURSES2 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 102 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('AWS CLOUD' , 104 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('BLOCKCHAIN' , 105, 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('RL' , 106 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('INTERVIEW PREP' , 108 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('BIG DATA' , 109 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('DATA ANALYTICS' , 110 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FSDS' , 1011 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('FSDA' , 1012 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FABE' , 1013 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('JAVA' , 1014 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('MERN' , 1015 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);

SELECT 
	PARTITION_NAME, 
    TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES2';
-- The above query will show automatically 5 partitions and based on 'course_launch_year' it will show the number of rows 
-- to the respective partitions.


-- create table with 10 hash partitions
CREATE TABLE INEURON_COURSES3 (
	COURSE_NAME VARCHAR(50),
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(60),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT )
PARTITION BY HASH(COURSE_LAUNCH_YEAR)
PARTITIONS 10; 


INSERT INTO INEURON_COURSES3 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 102 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('AWS CLOUD' , 104 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('BLOCKCHAIN' , 105, 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('RL' , 106 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('INTERVIEW PREP' , 108 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('BIG DATA' , 109 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('DATA ANALYTICS' , 110 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FSDS' , 1011 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('FSDA' , 1012 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FABE' , 1013 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('JAVA' , 1014 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('MERN' , 1015 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);

SELECT 
	PARTITION_NAME, 
    TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES3';



-- 3. KEY PARTITIONING
/* 
The key partitioning happens based on the key(primary key) defined in the create table statement.
Key takes either zero or more column names.
Any columns used as the partitioning key must be the table's primary key.
*/

CREATE TABLE INEURON_COURSES4 (
	COURSE_NAME VARCHAR(50),
	COURSE_ID INT PRIMARY KEY,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(60),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT )
PARTITION BY KEY()
PARTITIONS 10; 

INSERT INTO INEURON_COURSES4 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 102 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('AWS CLOUD' , 104 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('BLOCKCHAIN' , 105, 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('RL' , 106 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('INTERVIEW PREP' , 108 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('BIG DATA' , 109 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('DATA ANALYTICS' , 110 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FSDS' , 111 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('FSDA' , 112 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FABE' , 113 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('JAVA' , 114 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('MERN' , 115 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);

SELECT 
	PARTITION_NAME, 
    TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES4';


-- If there is no primary key but there is a unique key, then the unique key is used for the partitioning key.
-- We can't use 2 keys during key partitioning.
CREATE TABLE INEURON_COURSES5 (
	COURSE_NAME VARCHAR(50) UNIQUE KEY NOT NULL,
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(60),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT )
PARTITION BY KEY()
PARTITIONS 10; 

INSERT INTO INEURON_COURSES5 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 102 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('AWS CLOUD' , 104 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('BLOCKCHAIN' , 105, 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('RL' , 106 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('INTERVIEW PREP' , 108 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('BIG DATA' , 109 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('DATA ANALYTICS' , 110 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FSDS' , 111 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('FSDA' , 112 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FABE' , 113 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('JAVA' , 114 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('MERN' , 115 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);

SELECT 
	PARTITION_NAME, 
    TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES5';



-- 4. List Partitioning
/*  In list partitioning, each partition is defined and selected based on the membership of a column  
value in one of a set of value lists, rather than in one of a set of contiguous ranges of values. 
It only allows integer values. Unlike the case with partitions defined by range, list partitions 
do not need to be declared in any particular order. 
*/

CREATE TABLE INEURON_COURSES6 (
	COURSE_NAME VARCHAR(50),
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(60),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT )
PARTITION BY LIST(COURSE_LAUNCH_YEAR) (
	PARTITION P0 VALUES IN (2019,2020),
	PARTITION P1 VALUES IN (2021,2022)
);

INSERT INTO INEURON_COURSES6 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 102 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('AWS CLOUD' , 104 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('BLOCKCHAIN' , 105, 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('RL' , 106 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('INTERVIEW PREP' , 108 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('BIG DATA' , 109 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('DATA ANALYTICS' , 110 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FSDS' , 111 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('FSDA' , 112 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FABE' , 113 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('JAVA' , 114 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('MERN' , 115 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);

SELECT 
	PARTITION_NAME, 
	TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES6';


-- 5. COLUMNS PARTITIONING
-- A. LIST COLUMN PARTITIONING
/* 
It enables the use of multiple columns as partition keys, and for columns of data types other than integer types 
to be used as partitioning columns; you can use string types, DATE, and DATETIME columns.
*/

CREATE TABLE INEURON_COURSES7 (
	COURSE_NAME VARCHAR(50),
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(60),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT 
)
PARTITION BY LIST COLUMNS(COURSE_NAME) (
	PARTITION FULL_STACK VALUES IN ('FSDS','FSDA'),
	PARTITION DEEP_LEARNING VALUES IN ('DL','DLCVNLP')
);


-- In list partitioning, only the records having similar to the ones which we have written during create statement should be inserted.
INSERT INTO INEURON_COURSES7 VALUES
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020),
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022),
('FSDS' , 111 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022),
('FSDA' , 112 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021),
('FSDA' , 113 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022);

SELECT 
	PARTITION_NAME, 
    TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES7';


-- If we want to insert other records which we have not mentioned in create statement, problem occurs.
INSERT INTO INEURON_COURSES7 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019),
('AIOPS' , 102 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019),
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020),
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022),
('FSDS' , 111 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022),
('FSDA' , 112 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021),
('FSDA' , 113 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022);


-- To solve the error, write 'insert ignore' in insert statement.
CREATE TABLE INEURON_COURSES8 (
	COURSE_NAME VARCHAR(50),
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(60),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT 
)
PARTITION BY LIST COLUMNS(COURSE_NAME) (
	PARTITION FULL_STACK VALUES IN ('FSDS','FSDA'),
	PARTITION DEEP_LEARNING VALUES IN ('DL','DLCVNLP')
);


INSERT IGNORE INTO INEURON_COURSES8 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 102 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019),
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020),
('AWS CLOUD' , 104 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020),
('BLOCKCHAIN' , 105, 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021),
('RL' , 106 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022),
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022),
('INTERVIEW PREP' , 108 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019),
('BIG DATA' , 109 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020),
('DATA ANALYTICS' , 110 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021),
('FSDS' , 111 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022),
('FSDA' , 112 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021),
('FABE' , 113 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022),
('JAVA' , 114 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020),
('MERN' , 115 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);

SELECT 
	PARTITION_NAME, 
    TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES8';



CREATE TABLE INEURON_COURSES9 (
	COURSE_NAME VARCHAR(50),
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(80),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT
)
PARTITION BY LIST COLUMNS(COURSE_NAME) (
	PARTITION P0 VALUES  IN('AIOPS','DATA ANALYTICS','DL','RL'),
	PARTITION P1 VALUES  IN('FSDS' ,'BIG DATA','BLOCKCHAIN'),
	PARTITION P2 VALUES  IN('MERN','JAVA','INTERVIEW PREP','FSDA')
);

INSERT IGNORE INTO INEURON_COURSES9 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 102 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('AWS CLOUD' , 104 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('BLOCKCHAIN' , 105, 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('RL' , 106 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('INTERVIEW PREP' , 108 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('BIG DATA' , 109 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('DATA ANALYTICS' , 110 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FSDS' , 111 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('FSDA' , 112 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FABE' , 113 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('JAVA' , 114 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('MERN' , 115 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);


SELECT 
	PARTITION_NAME, 
    TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES9';



-- B. RANGE COLUMN PARTITIONING
/* 
Range columns partitioning is similar to range partitioning, but enables you to define partitions using ranges based on multiple column values. 
In addition, you can define the ranges using columns of types other than integer types.

RANGE COLUMNS partitioning differs significantly from RANGE partitioning in the following ways:
-> RANGE COLUMNS does not accept expressions, only names of columns.
-> RANGE COLUMNS accepts a list of one or more columns.
-> RANGE COLUMNS partitioning columns are not restricted to integer columns; string, DATE and DATETIME columns can also be used as partitioning columns. 
*/

CREATE TABLE INEURON_COURSES10 (
	COURSE_NAME VARCHAR(50) ,
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(80),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT
)
PARTITION BY RANGE COLUMNS(COURSE_NAME ,COURSE_ID,COURSE_LAUNCH_YEAR) (
	PARTITION P0 VALUES LESS THAN ('AIOPS',105,2019),
	PARTITION P1 VALUES LESS THAN ('FSDS' ,110,2021),
	PARTITION P2 VALUES LESS THAN ('MERN',116,2023)
);

INSERT IGNORE INTO INEURON_COURSES10 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 102 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('AWS CLOUD' , 104 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('BLOCKCHAIN' , 105, 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('RL' , 106 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('INTERVIEW PREP' , 108 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('BIG DATA' , 109 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('DATA ANALYTICS' , 110 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FSDS' , 111 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('FSDA' , 112 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FABE' , 113 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('JAVA' , 114 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('MERN' , 115 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);

SELECT 
	PARTITION_NAME, 
	TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES10';


-- 6. SUB-PARTITIONING
/*
Subpartitioning—also known as composite partitioning is the further division of each partition in a partitioned table.
*/

CREATE TABLE INEURON_COURSES11 (
	COURSE_NAME VARCHAR(50),
	COURSE_ID INT,
	COURSE_TITLE VARCHAR(60),
	COURSE_DESC VARCHAR(80),
	LAUNCH_DATE DATE,
	COURSE_FEE INT,
	COURSE_MENTOR VARCHAR(60),
	COURSE_LAUNCH_YEAR INT
)
PARTITION BY RANGE(COURSE_LAUNCH_YEAR)
SUBPARTITION BY HASH(COURSE_LAUNCH_YEAR)
SUBPARTITIONS 5 (
	PARTITION P0 VALUES LESS THAN (2019),
	PARTITION P1 VALUES LESS THAN (2020),
	PARTITION P2 VALUES LESS THAN (2021),
	PARTITION P3 VALUES LESS THAN (2022) 
);

INSERT IGNORE INTO INEURON_COURSES11 VALUES
('MACHINE_LEARNING' , 101 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('AIOPS' , 102 , 'ML', "THIS IS AIOPS COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('DLCVNLP' , 103 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('AWS CLOUD' , 104 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('BLOCKCHAIN' , 105, 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('RL' , 106 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('DL' , 107 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('INTERVIEW PREP' , 108 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019) ,
('BIG DATA' , 109 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('DATA ANALYTICS' , 110 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FSDS' , 111 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('FSDA' , 112 , 'ML', "THIS IS ML COURSE" ,'2021-07-07',3540,'SUDHANSHU',2021) ,
('FABE' , 113 , 'ML', "THIS IS ML COURSE" ,'2022-07-07',3540,'SUDHANSHU',2022) ,
('JAVA' , 114 , 'ML', "THIS IS ML COURSE" ,'2020-07-07',3540,'SUDHANSHU',2020) ,
('MERN' , 115 , 'ML', "THIS IS ML COURSE" ,'2019-07-07',3540,'SUDHANSHU',2019);

SELECT 
	PARTITION_NAME, 
    TABLE_NAME, 
    TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'INEURON_COURSES11';
