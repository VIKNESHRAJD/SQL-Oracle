/*=========================================================
  EXPERIMENT 3
  DATABASE QUERYING
=========================================================*/

--=========================================================
--1. Display Printer Details whose price is equal to any
--   one of the printers manufactured by IBM
--=========================================================

SELECT *
FROM Printer
WHERE Price = ANY
(
    SELECT p.Price
    FROM Printer p, Product_Info pi
    WHERE p.Model_No = pi.Model_No
    AND pi.Maker='IBM'
);


--=========================================================
--2. Display Laptop Details whose Screen Size is equal
--   to LP114
--=========================================================

SELECT *
FROM Laptop
WHERE ScreenSize =
(
    SELECT ScreenSize
    FROM Laptop
    WHERE Model_No='LP114'
);


--=========================================================
--3. Correlated Sub Query
--   Display PCs having Maximum Price
--=========================================================

SELECT *
FROM PC p1
WHERE Price =
(
    SELECT MAX(Price)
    FROM PC p2
    WHERE p1.Model_No=p2.Model_No
);


--=========================================================
--4. Display Printer with Highest Price
--   (Using ALL)
--=========================================================

SELECT *
FROM Printer
WHERE Price >= ALL
(
    SELECT Price
    FROM Printer
);


--=========================================================
--5. Highest Price without ANY or ALL
--=========================================================

SELECT *
FROM Printer
WHERE Price=
(
    SELECT MAX(Price)
    FROM Printer
);


--=========================================================
--6. Number of PCs for each RAM Size
--=========================================================

SELECT RAM,
COUNT(*) AS Total_PC
FROM PC
GROUP BY RAM;


--=========================================================
--7. Number of PCs for each HD Size
--=========================================================

SELECT HD,
COUNT(*) AS Total_PC
FROM PC
GROUP BY HD;


--=========================================================
--8. HD Values having more than 2 PCs
--=========================================================

SELECT HD,
COUNT(*) AS Total_PC
FROM PC
GROUP BY HD
HAVING COUNT(*)>2;


--=========================================================
--9. Senior Most and Junior Most Worker
--=========================================================

--Senior Most

SELECT *
FROM Worker
WHERE Age=
(
SELECT MAX(Age)
FROM Worker
);

--Junior Most

SELECT *
FROM Worker
WHERE Age=
(
SELECT MIN(Age)
FROM Worker
);




/*=========================================================
            UPDATE OPERATIONS
=========================================================*/


--=========================================================
--1. Increase Printer Price
--=========================================================

--Ink Printer +12%

UPDATE Printer
SET Price=Price*1.12
WHERE Type='INK';

--Dot Printer +14%

UPDATE Printer
SET Price=Price*1.14
WHERE Type='DOT';

--Laser Printer +10%

UPDATE Printer
SET Price=Price*1.10
WHERE Type='LASER';


--=========================================================
--Single UPDATE Statement
--=========================================================

UPDATE Printer
SET Price=
CASE
WHEN Type='INK' THEN Price*1.12
WHEN Type='DOT' THEN Price*1.14
WHEN Type='LASER' THEN Price*1.10
END;


--=========================================================
--2. Increase Laptop Price by 12.33%
--Only IBM and HCL
--=========================================================

UPDATE Laptop
SET Price=Price*1.1233
WHERE Speed>=2
AND Model_No IN
(
SELECT Model_No
FROM Product_Info
WHERE Maker IN ('IBM','HCL')
);


--=========================================================
--3. Insert PC Records into Laptop
--=========================================================

INSERT INTO Laptop
(Model_No,Speed,RAM,HD,ScreenSize,Price)

SELECT
REPLACE(Model_No,'PC','LP'),
Speed,
RAM,
HD,
17,
Price
FROM PC
WHERE Price>15000;


--=========================================================
--4. Single INSERT Statement
--=========================================================

INSERT INTO Laptop
SELECT
REPLACE(Model_No,'PC','LP'),
Speed,
RAM,
HD,
17,
Price
FROM PC
WHERE Price>15000;


--=========================================================
--5. Update Using Built-in Function
--=========================================================

UPDATE PC
SET Price=ROUND(Price*1.10,2);



/*=========================================================
                    JOINS
=========================================================*/


--=========================================================
--1. Cartesian Join
--=========================================================

SELECT *
FROM Worker, WorkerSkill;


--=========================================================
--2. Cartesian Join with 3 Tables
--=========================================================

SELECT *
FROM Worker,
WorkerSkill,
PC;


--=========================================================
--3. Equi Join
--=========================================================

SELECT w.Name,
       w.Age,
       ws.Skill
FROM Worker w
JOIN WorkerSkill ws
ON w.Name=ws.Name
WHERE Age>30;


--=========================================================
--4. Non-Equi Join
--=========================================================

SELECT w.Name,
       w.Age,
       p.Price
FROM Worker w,
     PC p
WHERE w.Age<p.Price;


--=========================================================
--5. Self Join
--=========================================================

SELECT DISTINCT
A.Model_No,
B.Model_No,
A.HD
FROM PC A,
     PC B
WHERE A.HD=B.HD
AND A.Model_No<>B.Model_No;


--=========================================================
--6. Inner Join
--=========================================================

SELECT pi.Maker,
       pc.Model_No,
       pc.Price
FROM Product_Info pi
JOIN PC pc
ON pi.Model_No=pc.Model_No;


--=========================================================
--7. Laptop-PC Same Price
--=========================================================

SELECT l.Model_No,
       p.Model_No,
       l.Price
FROM Laptop l
JOIN PC p
ON l.Price=p.Price;


--=========================================================
--8. Left Outer Join
--=========================================================

SELECT *
FROM Product_Info
LEFT OUTER JOIN PC
ON Product_Info.Model_No=PC.Model_No;


--=========================================================
--Right Outer Join
--=========================================================

SELECT *
FROM Product_Info
RIGHT OUTER JOIN PC
ON Product_Info.Model_No=PC.Model_No;


--=========================================================
--Full Outer Join
--=========================================================

SELECT *
FROM Product_Info
FULL OUTER JOIN PC
ON Product_Info.Model_No=PC.Model_No;


--=========================================================
--9. NVL with Outer Join
--=========================================================

SELECT
Product_Info.Model_No,
NVL(PC.Price,0) AS Price
FROM Product_Info
LEFT OUTER JOIN PC
ON Product_Info.Model_No=PC.Model_No;