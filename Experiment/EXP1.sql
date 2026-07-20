---DDL
---CREATE TABLE

--Product_Info
CREATE TABLE Product_Info(Maker VARCHAR2(10),Model_No VARCHAR2(5),Product_Type VARCHAR2(20));
DESC Product_Info;

--PC
CREATE TABLE PC(Model_No VARCHAR2(10),Speed NUMBER,RAM NUMBER,HD NUMBER,CD NUMBER,Price Number);
DESC pc;

--DROP TABLE PC; --DML

--Laptop
CREATE TABLE Laptop(Model_No VARCHAR2(10),Speed NUMBER,RAM NUMBER,HD NUMBER,ScreenSize NUMBER,Price Number);

--Printer
CREATE TABLE Printer(Model_No VARCHAR2(10),Color VARCHAR2(10),Type VARCHAR2(10),Price Number);


--DML
---INSERT TABLE
--INSERT INTO Product_Info VALUES(&Maker, &Model_No, &Type); ^^^TYPE CHANGED INTO KEYWORD^^^

INSERT INTO Product_Info VALUES('HCL', 'PC112', 'PC');
INSERT INTO Product_Info VALUES('HCL', 'LP113', 'LP');
INSERT INTO Product_Info VALUES('ZENITH', 'PR114', 'PR');
INSERT INTO Product_Info VALUES('WIPRO', 'PC122', 'PC');
INSERT INTO Product_Info VALUES('WIPRO', 'LP123', 'LP');
INSERT INTO Product_Info VALUES('WIPRO', 'PR124', 'PR');
INSERT INTO Product_Info VALUES('IBM', 'PC134', 'PC');
INSERT INTO Product_Info VALUES('HCL', 'LP114', 'LP');
INSERT INTO Product_Info VALUES('IBM', 'PC132', 'PC');
INSERT INTO Product_Info VALUES('IBM', 'LP133', 'LP');
INSERT INTO Product_Info VALUES('IBM', 'PR134', 'PR');

---view data
SELECT * FROM Product_Info;
TRUNCATE TABLE Product_Info; --DDL

--- INSERT PC
INSERT INTO PC VALUES(&Model_No, &Speed, &RAM, &HD, &CD, &Price);
INSERT INTO PC VALUES('PC112', 2, 256, 60, 52, 40000);
INSERT INTO PC VALUES('PC122', 2, 256, 60, 48, 42000);
INSERT INTO PC VALUES('PC132', 1, 128, 100, 68, 50000);
INSERT INTO PC VALUES('PC134', 1, 512, 60, 68, 80000);
SELECT * FROM PC;

--- DROP
Drop table Product_Info; 

----ALTER TABLE
ALTER TABLE Product_Info MODIFY (Model_No VARCHAR2(10));

UPDATE Printer
SET price = price - 4000
WHERE modelno = 'pr124';

-- 1. Make the 'type' column in product_info NOT NULL
ALTER TABLE product_info
ALTER COLUMN type SET NOT NULL;

-- 2. Set the default value of the 'speed' column in pc to 2
ALTER TABLE pc
ALTER COLUMN speed SET DEFAULT 2;


UPDATE PC
SET ram = ram * 2,
    hdd = hdd + 10;

