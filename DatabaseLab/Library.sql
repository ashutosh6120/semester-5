CREATE TABLE PUBLISHER(
	NAME VARCHAR(20) PRIMARY KEY,
	PHONE VARCHAR(10),
	ADDRESS VARCHAR(10)
);

DESC PUBLISHER;


CREATE TABLE BOOK(
	B_ID NUMERIC PRIMARY KEY,
	TITLE VARCHAR(20),
	PUB_YEAR NUMERIC,
	PUB_NAME VARCHAR(20) REFERENCES PUBLISHER(NAME) ON DELETE CASCADE
);

DESC BOOK;

CREATE TABLE BOOK_AUTHORS(
	AUTHOR_NAME VARCHAR(20),
	B_ID NUMERIC REFERENCES BOOK(B_ID) ON DELETE CASCADE,
	PRIMARY KEY(B_ID)
);

DESC BOOK_AUTHORS;

CREATE TABLE LIBRARY_BRANCH(
	BRANCH_ID NUMERIC PRIMARY KEY,
	BRANCH_NAME VARCHAR(18),
	ADDRESS VARCHAR(15)
);

DESC LIBRARY_BRANCH;

CREATE TABLE BOOK_COPIES(
	NO_OF_COPIES INT,
	B_ID NUMERIC REFERENCES BOOK(B_ID) ON DELETE CASCADE,
	BRANCH_ID NUMERIC REFERENCES LIBRARY_BRANCH(BRANCH_ID) ON DELETE CASCADE,
	PRIMARY KEY(B_ID,BRANCH_ID)
);

DESC BOOK_COPIES;

CREATE TABLE CARD (
    CARD_NO INTEGER PRIMARY KEY);


DESC CARD;


CREATE TABLE BOOKLENDING(
	DATE_OUT date,
	DUE_DATE date,
	B_ID NUMERIC REFERENCES BOOK(B_ID) ON DELETE CASCADE,
	BRANCH_ID NUMERIC REFERENCES LIBRARY_BRANCH(BRANCH_ID) ON DELETE CASCADE,
	PRIMARY KEY(B_ID,BRANCH_ID,CARD_NO),
	CARD_NO NUMERIC

);


DESC BOOKLENDING;



INSERT INTO PUBLISHER VALUES('MCGRAW-HILL',9191919191,'BANGALORE');
INSERT INTO PUBLISHER VALUES('PEARSON',8181818181,'NEWDELHI');
INSERT INTO PUBLISHER VALUES('RANDOM HOUSE',7171717171,'HYDERABAD');
INSERT INTO PUBLISHER VALUES('LIVRE',6161616161,'CHENNAI');
INSERT INTO PUBLISHER VALUES('PLANETA',5151515151,'BANGALORE');

SELECT * FROM PUBLISHER;

+--------------+------------+-----------+
| NAME         | PHONE      | ADDRESS   |
+--------------+------------+-----------+
| LIVRE        | 6161616161 | CHENNAI   |
| MCGRAW-HILL  | 9191919191 | BANGALORE |
| PEARSON      | 8181818181 | NEWDELHI  |
| PLANETA      | 5151515151 | BANGALORE |
| RANDOM HOUSE | 7171717171 | HYDERABAD |
+--------------+------------+-----------+


INSERT INTO BOOK VALUES(1,'DBMS',2017,'MCGRAW-HILL');
INSERT INTO BOOK VALUES(2,'ADBMS',2016,'MCGRAW-HILL');
INSERT INTO BOOK VALUES(3,'CN',2016,'PEARSON');
INSERT INTO BOOK VALUES(4,'CG',2015,'PLANETA');
INSERT INTO BOOK VALUES(5,'OS',2016,'PEARSON');

SELECT * FROM BOOK;

+------+-------+----------+-------------+
| B_ID | TITLE | PUB_YEAR | PUB_NAME    |
+------+-------+----------+-------------+
|    1 | DBMS  |     2017 | MCGRAW-HILL |
|    2 | ADBMS |     2016 | MCGRAW-HILL |
|    3 | CN    |     2016 | PEARSON     |
|    4 | CG    |     2015 | PLANETA     |
|    5 | OS    |     2016 | PEARSON     |
+------+-------+----------+-------------+


INSERT INTO BOOK_AUTHORS VALUES('NAVATHE',1);
INSERT INTO BOOK_AUTHORS VALUES('NAVATHE',2);
INSERT INTO BOOK_AUTHORS VALUES('TANENBAUM',3);
INSERT INTO BOOK_AUTHORS VALUES('EDWARD ANGEL',4);
INSERT INTO BOOK_AUTHORS VALUES('GALVIN',5);

SELECT * FROM BOOK_AUTHORS;

+--------------+------+
| AUTHOR_NAME  | B_ID |
+--------------+------+
| NAVATHE      |    1 |
| NAVATHE      |    2 |
| TANENBAUM    |    3 |
| EDWARD ANGEL |    4 |
| GALVIN       |    5 |
+--------------+------+

INSERT INTO LIBRARY_BRANCH VALUES(10,'RR NAGAR','BANGALORE');
INSERT INTO LIBRARY_BRANCH VALUES(11,'RNSIT','BANGALORE');
INSERT INTO LIBRARY_BRANCH VALUES(12,'RAJAJI NAGAR','BANGALORE');
INSERT INTO LIBRARY_BRANCH VALUES(13,'NITTE','MANGALORE');
INSERT INTO LIBRARY_BRANCH VALUES(14,'MANIPAL','UDUPI');

SELECT * FROM LIBRARY_BRANCH;

+-----------+--------------+-----------+
| BRANCH_ID | BRANCH_NAME  | ADDRESS   |
+-----------+--------------+-----------+
|        10 | RR NAGAR     | BANGALORE |
|        11 | RNSIT        | BANGALORE |
|        12 | RAJAJI NAGAR | BANGALORE |
|        13 | NITTE        | MANGALORE |
|        14 | MANIPAL      | UDUPI     |
+-----------+--------------+-----------+


INSERT INTO BOOK_COPIES VALUES(10,1,10);
INSERT INTO BOOK_COPIES VALUES(5,1,11);
INSERT INTO BOOK_COPIES VALUES(2,2,12);
INSERT INTO BOOK_COPIES VALUES(5,2,13);
INSERT INTO BOOK_COPIES VALUES(7,3,14);
INSERT INTO BOOK_COPIES VALUES(1,5,10);
INSERT INTO BOOK_COPIES VALUES(3,4,11);

SELECT * FROM BOOK_COPIES;

+--------------+------+-----------+
| NO_OF_COPIES | B_ID | BRANCH_ID |
+--------------+------+-----------+
|           10 |    1 |        10 |
|            5 |    1 |        11 |
|            2 |    2 |        12 |
|            5 |    2 |        13 |
|            7 |    3 |        14 |
|            3 |    4 |        11 |
|            1 |    5 |        10 |
+--------------+------+-----------+


INSERT INTO BOOKLENDING VALUES('2017-01-01','2017-06-01',1,10,101);
INSERT INTO BOOKLENDING VALUES('2017-01-11','2017-03-11',3,14,101);
INSERT INTO BOOKLENDING VALUES('2017-02-21','2017-04-21',2,13,101);
INSERT INTO BOOKLENDING VALUES('2017-03-15','2017-07-15',4,11,101);
INSERT INTO BOOKLENDING VALUES('2017-04-12','2017-05-12',1,11,104);

SELECT * FROM BOOKLENDING;

+------------+------------+------+-----------+---------+
| DATE_OUT   | DUE_DATE   | B_ID | BRANCH_ID | CARD_NO |
+------------+------------+------+-----------+---------+
| 2017-01-01 | 2017-06-01 |    1 |        10 |     101 |
| 2017-04-12 | 2017-05-12 |    1 |        11 |     104 |
| 2017-02-21 | 2017-04-21 |    2 |        13 |     101 |
| 2017-01-11 | 2017-03-11 |    3 |        14 |     101 |
| 2017-03-15 | 2017-07-15 |    4 |        11 |     101 |
+------------+------------+------+-----------+---------+










//Queries

1) 
SELECT B.B_ID, B.TITLE, B.PUB_NAME, A.AUTHOR_NAME,C.NO_OF_COPIES,L.BRANCH_ID
FROM BOOK B, BOOK_AUTHORS A, BOOK_COPIES C,LIBRARY_BRANCH L
WHERE B.B_ID=A.B_ID
AND B.B_ID=C.B_ID
AND L.BRANCH_ID=C.BRANCH_ID;

+------+-------+-------------+--------------+--------------+-----------+
| B_ID | TITLE | PUB_NAME    | AUTHOR_NAME  | NO_OF_COPIES | BRANCH_ID |
+------+-------+-------------+--------------+--------------+-----------+
|    1 | DBMS  | MCGRAW-HILL | NAVATHE      |           10 |        10 |
|    1 | DBMS  | MCGRAW-HILL | NAVATHE      |            5 |        11 |
|    2 | ADBMS | MCGRAW-HILL | NAVATHE      |            2 |        12 |
|    2 | ADBMS | MCGRAW-HILL | NAVATHE      |            5 |        13 |
|    3 | CN    | PEARSON     | TANENBAUM    |            7 |        14 |
|    4 | CG    | PLANETA     | EDWARD ANGEL |            3 |        11 |
|    5 | OS    | PEARSON     | GALVIN       |            1 |        10 |
+------+-------+-------------+--------------+--------------+-----------+


2)
SELECT CARD_NO
FROM BOOKLENDING
WHERE DATE_OUT BETWEEN '2017-01-01' AND '2017-06-01'
GROUP BY CARD_NO
HAVING COUNT(*)> 3;

+---------+
| CARD_NO |
+---------+
|     101 |
+---------+


3)
DELETE FROM BOOK
WHERE B_ID = 3;
SELECT*FROM BOOK;

+------+-------+----------+-------------+
| B_ID | TITLE | PUB_YEAR | PUB_NAME    |
+------+-------+----------+-------------+
|    1 | DBMS  |     2017 | MCGRAW-HILL |
|    2 | ADBMS |     2016 | MCGRAW-HILL |
|    4 | CG    |     2015 | PLANETA     |
|    5 | OS    |     2016 | PEARSON     |
+------+-------+----------+-------------+


4)
CREATE VIEW VPUBLICATION AS
SELECT PUB_YEAR
FROM BOOK;
SELECT*FROM VPUBLICATION;

+----------+
| PUB_YEAR |
+----------+
|     2017 |
|     2016 |
|     2015 |
|     2016 |
+----------+


5)
CREATE VIEW VBOOKS AS
SELECT B.B_ID, B.TITLE, C.NO_OF_COPIES
FROM
BOOK B, BOOK_COPIES C, LIBRARY_BRANCH L
WHERE B.B_ID=C.B_ID
AND C.BRANCH_ID=L.BRANCH_ID;
SELECT*from VBOOKS;



+------+-------+--------------+
| B_ID | TITLE | NO_OF_COPIES |
+------+-------+--------------+
|    1 | DBMS  |           10 |
|    1 | DBMS  |            5 |
|    2 | ADBMS |            2 |
|    2 | ADBMS |            5 |
|    4 | CG    |            3 |
|    5 | OS    |            1 |
+------+-------+--------------+