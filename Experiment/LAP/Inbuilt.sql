--1. Find the difference between the highest and lowest price from Laptop.
SELECT MAX(Price) AS Highest_Price,
       MIN(Price) AS Lowest_Price,
       MAX(Price)-MIN(Price) AS Difference
FROM Laptop;


--2. Find the Standard Deviation and Variance of Price in PC table.
SELECT STDDEV(Price) AS Std_Deviation,
       VARIANCE(Price) AS Variance
FROM PC;


--3. Display the Worker name and Age in the format:
--   JACK ADAMS      --21
SELECT Name AS WorkerName,
       LPAD(Age,4,'--') AS Age
FROM Worker;


--4(a). Increase the price of all PCs by 12.33%.
UPDATE PC
SET Price = Price * 1.1233;


--4(b). Display the PC model in lowercase and price rounded to hundredths.
SELECT LOWER(Model_No) AS Model,
       ROUND(Price,2) AS Price
FROM PC;


--5. List the names in ascending order of the length of names.
SELECT Name,
       LENGTH(Name) AS Name_Length
FROM Worker
ORDER BY LENGTH(Name);


--6. Display only the phone number (without area code).
SELECT SUBSTR(Phone,9) AS Phone_Number
FROM WorkerSkill;


--7. Find the location of letter 'A' in employee names.
SELECT Name,
       INSTR(Name,'A') AS Position
FROM WorkerSkill;


--8. Find the city sounding like 'SIDNEY'.
SELECT *
FROM WorkerSkill
WHERE SOUNDEX(City)=SOUNDEX('SIDNEY');


--9. List only the last name from WORKERSKILL.
SELECT SUBSTR(Name,INSTR(Name,' ')+1) AS Last_Name
FROM WorkerSkill;


--10(a). Last name first using CONCAT().
SELECT CONCAT(SUBSTR(Name,INSTR(Name,' ')+1),
       CONCAT(' ',SUBSTR(Name,1,INSTR(Name,' ')-1))) AS Employee_Name
FROM WorkerSkill;


--10(b). Last name first using || operator.
SELECT SUBSTR(Name,INSTR(Name,' ')+1) || ' ' ||
       SUBSTR(Name,1,INSTR(Name,' ')-1) AS Employee_Name
FROM WorkerSkill;


--10(c). Last name first without CONCAT() and ||.
SELECT REPLACE(Name,
       SUBSTR(Name,1,INSTR(Name,' ')),
       '') || ' ' ||
       SUBSTR(Name,1,INSTR(Name,' ')-1) AS Employee_Name
FROM WorkerSkill;


--11(a). Add Date_of_Joining column.
ALTER TABLE WorkerSkill
ADD Date_Of_Joining DATE;


--11(b). Update Date_of_Joining.
UPDATE WorkerSkill
SET Date_Of_Joining='01-JAN-2020';


--11(c). Display experience in years and months.
SELECT Name,
       TRUNC(MONTHS_BETWEEN(SYSDATE,Date_Of_Joining)/12) AS Years,
       MOD(TRUNC(MONTHS_BETWEEN(SYSDATE,Date_Of_Joining)),12) AS Months
FROM WorkerSkill;


--12(a). Display date as Sep-2006.
SELECT TO_CHAR(SYSDATE,'MON-YYYY')
FROM DUAL;


--12(b). Display date as September 12 2006.
SELECT TO_CHAR(SYSDATE,'MONTH DD YYYY')
FROM DUAL;


--12(c). Display date as 12-09-06 12:11:10.
SELECT TO_CHAR(SYSDATE,'DD-MM-YY HH24:MI:SS')
FROM DUAL;


--13. Display GMT and EST.
SELECT CURRENT_TIMESTAMP AT TIME ZONE 'GMT' AS GMT_Time,
       CURRENT_TIMESTAMP AT TIME ZONE 'US/Eastern' AS EST_Time
FROM DUAL;


--14(a). REPLACE example.
SELECT REPLACE(Name,'ICK','EAN')
FROM WorkerSkill;


--14(b). DECODE example.
SELECT Maker,
       Model_No,
       DECODE(Type,
              'PC','PERSONAL COMPUTER',
              'LP','LAPTOP',
              'PR','PRINTER')
FROM Product_Info;


--14(c). TRANSLATE example.
SELECT TRANSLATE(Name,'IC','#*')
FROM Worker;


--15. Display Printer Price as Rs.50,000 and $50,000.
SELECT TO_CHAR(Price,'"Rs."99,999') AS Rupees,
       TO_CHAR(Price,'$99,999') AS Dollars
FROM Printer;
