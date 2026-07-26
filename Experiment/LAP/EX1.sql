--Create the Tables
--PRODUCT_INFO
CREATE TABLE Product_Info (Maker VARCHAR2(20),Model_No VARCHAR2(10),Type VARCHAR2(2));
desc Laptop;

CREATE TABLE PC (
    Model_No VARCHAR2(10),
    Speed NUMBER,
    RAM NUMBER,
    HD NUMBER,
    CD NUMBER,
    Price NUMBER
);

-----
CREATE TABLE Laptop (
    Model_No VARCHAR2(10),
    Speed NUMBER,
    RAM NUMBER,
    HD NUMBER,
    ScreenSize NUMBER,
    Price NUMBER
);



--------------------

CREATE TABLE Printer (
    Model_No VARCHAR2(10),
    Color VARCHAR2(5),
    Type VARCHAR2(10),
    Price NUMBER
);


SELECT * FROM TAB;


--Insert Data into PRODUCT_INFO
INSERT INTO Product_Info VALUES ('HCL','PC112','PC');
INSERT INTO Product_Info VALUES ('HCL','LP113','LP');
INSERT INTO Product_Info VALUES ('ZENITH','PR114','PR');
INSERT INTO Product_Info VALUES ('WIPRO','PC122','PC');
INSERT INTO Product_Info VALUES ('WIPRO','LP123','LP');
INSERT INTO Product_Info VALUES ('WIPRO','PR124','PR');
INSERT INTO Product_Info VALUES ('IBM','PC134','PC');
INSERT INTO Product_Info VALUES ('HCL','LP114','LP');
INSERT INTO Product_Info VALUES ('IBM','PC132','PC');
INSERT INTO Product_Info VALUES ('IBM','LP133','LP');
INSERT INTO Product_Info VALUES ('IBM','PR134','PR');

Select * from Product_Info;

--Insert Data into PC
INSERT INTO PC VALUES ('PC112',2,256,60,52,40000);
INSERT INTO PC VALUES ('PC122',2,256,60,48,42000);
INSERT INTO PC VALUES ('PC132',1,128,100,68,50000);
INSERT INTO PC VALUES ('PC134',1,512,60,68,80000);

-- Insert Data into LAPTOP

INSERT INTO Laptop VALUES ('LP113',1,64,40,14,59000);
INSERT INTO Laptop VALUES ('LP123',2,128,60,16,72000);
INSERT INTO Laptop VALUES ('LP133',2,256,80,17,100000);
INSERT INTO Laptop VALUES ('LP114',2,128,40,17,45000);

--Insert Data into PRINTER
INSERT INTO Printer VALUES ('PR114','TRUE','INK',17000);
INSERT INTO Printer VALUES ('PR124','FALSE','DOT',12000);
INSERT INTO Printer VALUES ('PR134','TRUE','LASER',17000);


--Insert New PC (PC100)
--First insert into Product_Info
INSERT INTO Product_Info VALUES ('HCL','PC100','PC');

INSERT INTO PC VALUES ('PC100',3,256,40,52,50000);

--Delete PCs with CD Speed Less Than 50
DELETE FROM PC WHERE CD < 50;

Commit;

--IBM Buys HCL
UPDATE Product_Info
SET Maker='IBM'
WHERE Maker='HCL';

Select * From PC;


-- Double RAM and Add 10GB HDD
UPDATE PC SET RAM = RAM*2, HD = HD+10;
Select * From PC;

--Reduce Printer Price 
UPDATE Printer
SET Price = Price-4000
WHERE Model_No='PR124';
