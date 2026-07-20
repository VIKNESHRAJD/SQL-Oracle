---DDL
---CREATE TABLE

--Product_Info
CREATE TABLE Product_Info(Maker VARCHAR2(10),Model_No VARCHAR2(5),Product_Type VARCHAR2(20));
DESC Product_Info;

--PC
CREATE TABLE PC(Model_No VARCHAR2(10),Speed NUMBER,RAM NUMBER,HD NUMBER,CD NUMBER,Price Number);

--DROP TABLE PC; --DML

--Laptop
CREATE TABLE Laptop(Model_No VARCHAR2(10),Speed NUMBER,RAM NUMBER,HD NUMBER,ScreenSize NUMBER,Price Number);

--Printer
CREATE TABLE Printer(Model_No VARCHAR2(10),Color VARCHAR2(10),Type VARCHAR2(10),Price Number);


--DML
---INSERT TABLE
--INSERT INTO Product_Info VALUES(&Maker, &Model_No, &Product_Type); ^^^TYPE CHANGED INTO KEYWORD^^^

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


---INSERT LAPTOP
--INSERT INTO Laptop VALUES(&Model_No, &Speed, &RAM, &HD, &ScreenSize,&Price);
INSERT INTO Laptop VALUES('IP113', 1, 64, 40, 14, 59000);
INSERT INTO Laptop VALUES('IP123', 2, 128, 60, 16, 72000);
INSERT INTO Laptop VALUES('IP133', 2, 256, 80, 17, 100000);
INSERT INTO Laptop VALUES('IP114', 2, 128, 40, 17, 45000);

---INSERT printer
INSERT INTO Printer VALUES('PR114', 'True', 'INK', 17000);
INSERT INTO Printer VALUES('PR124', 'False', 'INK', 17000);
INSERT INTO Printer VALUES('PR134', 'True', 'INK', 17000);
COMMIT;

--- DROP
Drop table Product_Info; 
----ALTER TABLE
ALTER TABLE Product_Info MODIFY (Model_No VARCHAR2(10));


--6.Insert a tuple such that the model value is PC100, 

INSERT INTO PC VALUES(&Model_No, &Speed, &RAM, &HD, &CD, &Price);

--7. Delete all PC's with less than 50 CD Speed

DELETE FROM PC WHERE CD < 50; --2 rows Deleted
SELECT * FROM PC;

--8.Manufacturer IBM buys manufacture HCL.  
--Change all products made by HCL so they are now made by IBM.

UPDATE Product_Info SET MAKER = 'IBM' WHERE MAKER = 'HCL'; --3 rows UPDATED
SELECT * FROM Product_Info;

--9.For each PC double the amount of RAM and add 10 gb to the HDD.
UPDATE PC SET RAM = RAM * 2, HD = HD + 10; --4 rows UPDATED
SELECT * FROM PC;

--10.For the printer whose modelno=pr124 subtract Rs. 4000 from the price.
UPDATE Printer SET Price = Price - 4000 WHERE Model_No = 'PR124';
SELECT * FROM Printer;


