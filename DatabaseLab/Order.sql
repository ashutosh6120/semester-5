CREATE TABLE SALESMAN(
    SALESMAN_ID INT,
    NAME VARCHAR(20),
    CITY VARCHAR(20),
    COMMISSION VARCHAR(20),
    PRIMARY KEY (SALESMAN_ID)
);



DESC SALESMAN;


+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| SALESMAN_ID | int(11)     | NO   | PRI | NULL    |       |
| NAME        | varchar(20) | YES  |     | NULL    |       |
| CITY        | varchar(20) | YES  |     | NULL    |       |
| COMMISSION  | varchar(20) | YES  |     | NULL    |       |
+-------------+-------------+------+-----+---------+-------+



CREATE TABLE CUSTOMER(
    CUSTOMER_ID INT,
    CUST_NAME VARCHAR(20),
    CITY VARCHAR(20),
    GRADE INT(3),
    PRIMARY KEY (CUSTOMER_ID),
    SALESMAN_ID INT REFERENCES SALESMAN(SALESMAN_ID) ON DELETE SET NULL);



DESC CUSTOMER;


+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| CUSTOMER_ID | int(11)     | NO   | PRI | NULL    |       |
| CUST_NAME   | varchar(20) | YES  |     | NULL    |       |
| CITY        | varchar(20) | YES  |     | NULL    |       |
| GRADE       | int(3)      | YES  |     | NULL    |       |
| SALESMAN_ID | int(11)     | YES  |     | NULL    |       |
+-------------+-------------+------+-----+---------+-------+



CREATE TABLE ORDERS(
    ORD_NO INT(5),
    PURCHASE_AMT NUMERIC(10,2),
    ORD_DATE DATE,
    PRIMARY KEY (ORD_NO),
    CUSTOMER_ID INT REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE,
    SALESMAN_ID INT REFERENCES SALESMAN(SALESMAN_ID) ON DELETE CASCADE);


DESC ORDERS;

+--------------+---------------+------+-----+---------+-------+
| Field        | Type          | Null | Key | Default | Extra |
+--------------+---------------+------+-----+---------+-------+
| ORD_NO       | int(5)        | NO   | PRI | NULL    |       |
| PURCHASE_AMT | decimal(10,2) | YES  |     | NULL    |       |
| ORD_DATE     | date          | YES  |     | NULL    |       |
| CUSTOMER_ID  | int(11)       | YES  |     | NULL    |       |
| SALESMAN_ID  | int(11)       | YES  |     | NULL    |       |
+--------------+---------------+------+-----+---------+-------+




//INSERTION

INSERT INTO SALESMAN VALUES(1000,'JOHN','BANGALORE','25%');
INSERT INTO SALESMAN VALUES(2000,'RAVI','BANGALORE','20%');
INSERT INTO SALESMAN VALUES(3000,'KUMAR','MYSORE','15%');
INSERT INTO SALESMAN VALUES(4000,'SMITH','DELHI','30%');
INSERT INTO SALESMAN VALUES(5000,'HARSHA','HYDERABAD','15%');


SELECT * FROM SALESMAN;

+-------------+--------+-----------+------------+
| SALESMAN_ID | NAME   | CITY      | COMMISSION |
+-------------+--------+-----------+------------+
|        1000 | JOHN   | BANGALORE | 25%        |
|        2000 | RAVI   | BANGALORE | 20%        |
|        3000 | KUMAR  | MYSORE    | 15%        |
|        4000 | SMITH  | DELHI     | 30%        |
|        5000 | HARSHA | HYDERABAD | 15%        |
+-------------+--------+-----------+------------+




INSERT INTO CUSTOMER VALUES(10,'PREETHI','BANGALORE',100,1000);
INSERT INTO CUSTOMER VALUES(11,'VIVEK','MANGALORE',300,1000);
INSERT INTO CUSTOMER VALUES(12,'BHASKAR','CHENNAI',400,2000);
INSERT INTO CUSTOMER VALUES(13,'CHETHAN','BANGALORE',200,2000);
INSERT INTO CUSTOMER VALUES(14,'MAMATHA','BANGALORE',400,3000);



+-------------+-----------+-----------+-------+-------------+
| CUSTOMER_ID | CUST_NAME | CITY      | GRADE | SALESMAN_ID |
+-------------+-----------+-----------+-------+-------------+
|          10 | PREETHI   | BANGALORE |   100 |        1000 |
|          11 | VIVEK     | MANGALORE |   300 |        1000 |
|          12 | BHASKAR   | CHENNAI   |   400 |        2000 |
|          13 | CHETHAN   | BANGALORE |   200 |        2000 |
|          14 | MAMATHA   | BANGALORE |   400 |        3000 |
+-------------+-----------+-----------+-------+-------------+




INSERT INTO ORDERS VALUES (50, 5000, '2017-05-04', 10, 1000);
INSERT INTO ORDERS VALUES (51, 450, '2017-01-20', 10, 2000);
INSERT INTO ORDERS VALUES (52, 1000, '2017-02-24', 13, 2000);
INSERT INTO ORDERS VALUES (53, 3500, '2017-04-13', 14, 3000);
INSERT INTO ORDERS VALUES (54, 550, '2017-03-09', 12, 2000);



+--------+--------------+------------+-------------+-------------+
| ORD_NO | PURCHASE_AMT | ORD_DATE   | CUSTOMER_ID | SALESMAN_ID |
+--------+--------------+------------+-------------+-------------+
|     50 |      5000.00 | 2017-05-04 |          10 |        1000 |
|     51 |       450.00 | 2017-01-20 |          10 |        2000 |
|     52 |      1000.00 | 2017-02-24 |          13 |        2000 |
|     53 |      3500.00 | 2017-04-13 |          14 |        3000 |
|     54 |       550.00 | 2017-03-09 |          12 |        2000 |
+--------+--------------+------------+-------------+-------------+





//QUERIES

1)
SELECT GRADE,COUNT(DISTINCT CUSTOMER_ID)
FROM CUSTOMER
GROUP BY GRADE
HAVING GRADE > (SELECT AVG(GRADE)
FROM CUSTOMER
WHERE CITY='BANGALORE');


+-------+-----------------------------+
| GRADE | COUNT(DISTINCT CUSTOMER_ID) |
+-------+-----------------------------+
|   300 |                           1 |
|   400 |                           2 |
+-------+-----------------------------+



2)
SELECT SALESMAN_ID,NAME
FROM SALESMAN A
WHERE 1 < (SELECT COUNT(*)
FROM CUSTOMER
WHERE SALESMAN_ID=A.SALESMAN_ID);

+-------------+------+
| SALESMAN_ID | NAME |
+-------------+------+
|        1000 | JOHN |
|        2000 | RAVI |
+-------------+------+



3)
SELECT SALESMAN.SALESMAN_ID,NAME,CUST_NAME,COMMISSION
FROM SALESMAN,CUSTOMER
WHERE SALESMAN.CITY=CUSTOMER.CITY
UNION
SELECT SALESMAN_ID,NAME,'NO MATCH',COMMISSION
FROM SALESMAN
WHERE NOT CITY = ANY
(SELECT CITY
FROM CUSTOMER)
ORDER BY 2 DESC;



+-------------+--------+-----------+------------+
| SALESMAN_ID | NAME   | CUST_NAME | COMMISSION |
+-------------+--------+-----------+------------+
|        4000 | SMITH  | NO MATCH  | 30%        |
|        2000 | RAVI   | CHETHAN   | 20%        |
|        2000 | RAVI   | PREETHI   | 20%        |
|        2000 | RAVI   | MAMATHA   | 20%        |
|        3000 | KUMAR  | NO MATCH  | 15%        |
|        1000 | JOHN   | PREETHI   | 25%        |
|        1000 | JOHN   | MAMATHA   | 25%        |
|        1000 | JOHN   | CHETHAN   | 25%        |
|        5000 | HARSHA | NO MATCH  | 15%        |
+-------------+--------+-----------+------------+





4)
CREATE VIEW ELITSALESMAN AS
SELECT B.ORD_DATE,A.SALESMAN_ID,A.NAME
FROM SALESMAN A,ORDERS B
WHERE A.SALESMAN_ID=B.SALESMAN_ID
AND B.PURCHASE_AMT=(SELECT MAX(PURCHASE_AMT)
FROM ORDERS C
WHERE C.ORD_DATE=B.ORD_DATE);



SELECT * FROM ELITSALESMAN;



+------------+-------------+-------+
| ORD_DATE   | SALESMAN_ID | NAME  |
+------------+-------------+-------+
| 2017-05-04 |        1000 | JOHN  |
| 2017-01-20 |        2000 | RAVI  |
| 2017-02-24 |        2000 | RAVI  |
| 2017-04-13 |        3000 | KUMAR |
| 2017-03-09 |        2000 | RAVI  |
+------------+-------------+-------+



5)
DELETE FROM SALESMAN
WHERE SALESMAN_ID=1000;


SELECT * FROM SALESMAN;



+-------------+--------+-----------+------------+
| SALESMAN_ID | NAME   | CITY      | COMMISSION |
+-------------+--------+-----------+------------+
|        2000 | RAVI   | BANGALORE | 20%        |
|        3000 | KUMAR  | MYSORE    | 15%        |
|        4000 | SMITH  | DELHI     | 30%        |
|        5000 | HARSHA | HYDERABAD | 15%        |
+-------------+--------+-----------+------------+
