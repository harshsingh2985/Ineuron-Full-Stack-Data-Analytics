/* WINDOW FUNCTIONS */

CREATE DATABASE WIN_FUN;
USE WIN_FUN;

-- creating table
CREATE TABLE INEURON_STUDENTS (
	STUDENT_ID INT,
	STUDENT_BATCH VARCHAR(40),
	STUDENT_NAME VARCHAR(40),
	STUDENT_STREAM VARCHAR(30),
	STUDENT_MARKS INT,
	STUDENT_MAIL_ID VARCHAR(50)
);

-- inserting records
INSERT INTO INEURON_STUDENTS
VALUES(101, 'FSDA', 'SAURABH', 'CS', 80, 'SAURABH@GMAIL.COM');

SELECT * FROM INEURON_STUDENTS;

INSERT INTO INEURON_STUDENTS VALUES
(100 ,'FSDA' , 'SAURABH','CS',80,'SAURABH@GMAIL.COM'),
(102 ,'FSDA' , 'SANKET','CS',81,'SANKET@GMAIL.COM'),
(103 ,'FSDA' , 'SHYAM','CS',80,'SHYAM@GMAIL.COM'),
(104 ,'FSDA' , 'SANKET','CS',82,'SANKET@GMAIL.COM'),
(105 ,'FSDA' , 'SHYAM','ME',67,'SHYAM@GMAIL.COM'),
(106 ,'FSDS' , 'AJAY','ME',45,'AJAY@GMAIL.COM'),
(106 ,'FSDS' , 'AJAY','ME',78,'AJAY@GMAIL.COM'),
(108 ,'FSDS' , 'SNEHAL','CI',89,'SNEHAL@GMAIL.COM'),
(109 ,'FSDS' , 'MANISHA','CI',34,'MANISHA@GMAIL.COM'),
(110 ,'FSDS' , 'RAKESH','CI',45,'RAKESH@GMAIL.COM'),
(111 ,'FSDE' , 'ANUJ','CI',43,'ANUJ@GMAIL.COM'),
(112 ,'FSDE' , 'MOHIT','EE',67,'MOHIT@GMAIL.COM'),
(113 ,'FSDE' , 'VIVEK','EE',23,'VIVEK@GMAIL.COM'),
(114 ,'FSDE' , 'GAURAV','EE',45,'GAURAV@GMAIL.COM'),
(115 ,'FSDE' , 'PRATEEK','EE',89,'PRATEEK@GMAIL.COM'),
(116 ,'FSDE' , 'MITHUN','ECE',23,'MITHUN@GMAIL.COM'),
(117 ,'FSBC' , 'CHAITRA','ECE',23,'CHAITRA@GMAIL.COM'),
(118 ,'FSBC' , 'PRANAY','ECE',45,'PRANAY@GMAIL.COM'),
(119 ,'FSBC' , 'SANDEEP','ECE',65,'SANDEEP@GMAIL.COM');

/* 2 types of Window functions 
1. Aggregation based window functions
2. Analytical based window functions
*/

/* 1. Aggregation based window functions
A. SUM
B. MIN
C. MAX
D. AVG
E. COUNT
*/

-- use of 'aggregation' functions
SELECT STUDENT_BATCH, SUM(STUDENT_MARKS) FROM INEURON_STUDENTS GROUP BY STUDENT_BATCH;
SELECT STUDENT_BATCH, MIN(STUDENT_MARKS) FROM INEURON_STUDENTS GROUP BY STUDENT_BATCH;
SELECT STUDENT_BATCH, MAX(STUDENT_MARKS) FROM INEURON_STUDENTS GROUP BY STUDENT_BATCH;
SELECT STUDENT_BATCH, AVG(STUDENT_MARKS) FROM INEURON_STUDENTS GROUP BY STUDENT_BATCH;
SELECT COUNT(STUDENT_BATCH) FROM INEURON_STUDENTS;
SELECT COUNT(DISTINCT STUDENT_BATCH) FROM INEURON_STUDENTS;

-- Count the no. of students batch wise
SELECT STUDENT_BATCH, COUNT(*) 
FROM INEURON_STUDENTS 
GROUP BY STUDENT_BATCH;

-- Q. Who have received the highest marks in 'fsda' batch ?
SELECT STUDENT_NAME, STUDENT_BATCH, MAX(STUDENT_MARKS) FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA';
-- above query gives saurabh from fsda batch who have recieved highest marks (82) but if we see the table, sanket got highest mark in fsda batch.

/* The 'student_name', 'student_batch' is picking by the query but only show the maximum of 'student_marks) is showing.
It is not showing the name of the student based on marks. Here, we have to use 'subquery'. */

SELECT STUDENT_NAME, STUDENT_BATCH, MAX(STUDENT_MARKS) 
FROM INEURON_STUDENTS 
WHERE STUDENT_MARKS = ( SELECT MAX(STUDENT_MARKS) 
						FROM INEURON_STUDENTS 
                        WHERE STUDENT_BATCH = 'FSDA'
					);


-- Use of 'LIMIT'
SELECT * FROM INEURON_STUDENTS 
WHERE STUDENT_BATCH = 'FSDA' 
ORDER BY STUDENT_MARKS DESC;

-- fetch the record who have received the 2nd highest mark
SELECT * FROM INEURON_STUDENTS 
WHERE STUDENT_BATCH = 'FSDA' 
ORDER BY STUDENT_MARKS DESC LIMIT 1,1;

-- we can use limit to get the 'nth record' i.e., 4th highest, 3rd lowest etc.
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 2,1;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 3,1;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 4,1;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 5,1;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 6,1;


-- to show the top n records or from particular row, show n records
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 1,2;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 1,3;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 1,4;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 3,2;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 3,3;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH = 'FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 1,6;

/* In previous query, we are writing limit 3,3 or limit 3 because we know the dataset already. 
So, we know how many records are there and get the 3rd highest mark. 
What if we don't know  how many records are there ? 
Also, we want to get the nth highest mark. Then we can use 'Analytical Window functions'.
*/


/* 2. Analytical based window functions 
A. ROW_NUMBER()
B. RANK()
C. DENSE_RANK()
*/

-- A. ROW_NUMBER()

-- below query assigns the 'row_num' column as 1,2,3,.....
SELECT 
	STUDENT_ID, 
	STUDENT_BATCH,
    STUDENT_STREAM,
    STUDENT_MARKS,
	ROW_NUMBER() OVER(ORDER BY STUDENT_MARKS) AS ROW_NUM 
FROM INEURON_STUDENTS;

-- use 'partition by' in over clause
SELECT 
	STUDENT_ID,
    STUDENT_BATCH,
    STUDENT_STREAM,
    STUDENT_MARKS,
	ROW_NUMBER() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS) AS ROW_NUM 
FROM INEURON_STUDENTS;

/* Here, partition by creates windows like groups. Windows(groups) are created according to student batch
and row_number is assigned according to student_marks in ascending order. 
First, batches are grouped then in each group, student_marks are put in ascending order then ro_number
is assigned in increasing order of marks  */


-- Q. Display the topper's name from every batches.
SELECT 
	* 
FROM(
		SELECT 
			STUDENT_ID,
            STUDENT_BATCH,
            STUDENT_STREAM,
            STUDENT_MARKS,
			ROW_NUMBER() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_NUM
		FROM 
			INEURON_STUDENTS ) AS TEST 
WHERE 
	ROW_NUM = 1;

-- But if in table, in same batch, a student got same mark then how will we get the topper's name
-- as row_number will assign number differently to each student i.e., 
INSERT INTO INEURON_STUDENTS VALUES(119 ,'FSBC' , 'SANDEEP','ECE',65,'SANDEEP@GMAIL.COM');
SELECT * FROM INEURON_STUDENTS;


/* By executing the below query, we will get the same result but we are expecting the other record of 
fsbc batch i.e., (119 ,'FSBC' , 'SANDEEP','ECE',65,'SANDEEP@GMAIL.COM').
Here the records are shown based on row_num = 1, but the other record what we want is at row_num = 2 
*/
SELECT 
	* 
FROM(
		SELECT 
			STUDENT_ID,
            STUDENT_BATCH,
            STUDENT_STREAM,
            STUDENT_MARKS,
			ROW_NUMBER() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_NUM
		FROM 
			INEURON_STUDENTS ) AS TEST 
WHERE 
	ROW_NUM = 1;


-- To solve the above problem, we will use 'RANK()'

-- B. RANK()
SELECT 
	STUDENT_ID,
    STUDENT_BATCH,
    STUDENT_STREAM,
    STUDENT_MARKS,
	RANK() OVER(ORDER BY STUDENT_MARKS DESC) AS ROW_RANK
FROM INEURON_STUDENTS;

-- The above query gives the same student_mark as same row_rank i.e., there are 2 '89' mark and row_rank will assign same rank to both of them. 


-- It is different from row_number as row_number shows serially from 1,2,3.....
-- Irrespective of marks, row_num gives different number to same marks but row_rank gives same number to same mark
SELECT 
	STUDENT_ID,
    STUDENT_BATCH,
    STUDENT_STREAM,
    STUDENT_MARKS,
	ROW_NUMBER() OVER(ORDER BY STUDENT_MARKS DESC) AS ROW_NUM,
	RANK() OVER(ORDER BY STUDENT_MARKS DESC) AS ROW_RANK
FROM INEURON_STUDENTS;


-- If we create window or partition the data based on batch, then each batch is grouped with rannking on it.
-- After one batch over, the next batch again starts from 1 because of 'partition by'.
SELECT 
	STUDENT_ID,
    STUDENT_BATCH,
    STUDENT_STREAM,
    STUDENT_MARKS,
	ROW_NUMBER() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_NUM,
	RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_RANK
FROM INEURON_STUDENTS;

-- Here, multiple groups are created based on batch then row_num & row_rank are alloted accordingly.


-- Solution to the above question
-- Q. Display the topper's name from every batches
SELECT 
	* 
FROM(
		SELECT 
			STUDENT_ID,
            STUDENT_BATCH,
            STUDENT_STREAM,
            STUDENT_MARKS,
			RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_RANK
		FROM 
			INEURON_STUDENTS 
	) AS TEST 
WHERE 
	ROW_RANK = 1;

-- The above query gives topper's name from every batches based on row_rank = 1 


-- But if we want to get the 2nd highest or 3rd highest from the table, then we can't get the result using 'rank()' function. Here, we can use 'DENSE_RANK()'.

-- C. DENSE_RANK()
SELECT 
	* 
FROM (
		SELECT 
			STUDENT_ID,
            STUDENT_BATCH,
            STUDENT_STREAM,
            STUDENT_MARKS,
			DENSE_RANK() OVER(ORDER BY STUDENT_MARKS DESC) AS ROW_DENSE_RANK
		FROM 
			INEURON_STUDENTS
	) AS TEST 
WHERE 
	ROW_DENSE_RANK = 2;


-- comparing all the three window functions in 1 statement.
-- To get the 2nd highest from every batches, use 'partition by'
SELECT 
	* 
FROM (
		SELECT 
			STUDENT_ID,
            STUDENT_BATCH,
            STUDENT_STREAM,
            STUDENT_MARKS,
			ROW_NUMBER() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_NUM,
			RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_RANK,
			DENSE_RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_DENSE_RANK
		FROM 
			INEURON_STUDENTS
	) AS TEST 
WHERE 
	ROW_DENSE_RANK = 2;
    
    
    
-- Q. Display the top 3 rankers from every batch.   
SELECT 
	* 
FROM (
		SELECT 
			STUDENT_ID,
            STUDENT_BATCH,
            STUDENT_STREAM,
            STUDENT_MARKS,
			ROW_NUMBER() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_NUM,
			RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_RANK,
			DENSE_RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS ROW_DENSE_RANK
		FROM 
			INEURON_STUDENTS
	) AS TEST 
WHERE 
	ROW_DENSE_RANK <= 3;
