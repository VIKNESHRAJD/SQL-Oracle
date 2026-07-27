
--1. Make TYPE column NOT NULL
ALTER TABLE Product_Info
MODIFY Type VARCHAR2(2) NOT NULL;

--2. Set Default Value for SPEED
ALTER TABLE PC
MODIFY Speed DEFAULT 2;


--3. Create Primary Key
--Primary Key for Product_Info
ALTER TABLE Product_Info
ADD CONSTRAINT pk_product
PRIMARY KEY(Model_No);

--Primary Key for PC
ALTER TABLE PC
ADD CONSTRAINT pk_pc
PRIMARY KEY(Model_No);

--Primary Key for Laptop
ALTER TABLE Laptop
ADD CONSTRAINT pk_laptop
PRIMARY KEY(Model_No);

--Primary Key for Printer
ALTER TABLE Printer
ADD CONSTRAINT pk_printer
PRIMARY KEY(Model_No);

--Check Primary Keys

SELECT Constraint_Name,
       Constraint_Type,
       Table_Name
FROM User_Constraints
WHERE Constraint_Type='P';


--4. Create Foreign Keys
--Foreign Key for PC

ALTER TABLE PC
ADD CONSTRAINT fk_pc
FOREIGN KEY(Model_No)
REFERENCES Product_Info(Model_No)
ON DELETE CASCADE;

--Foreign Key for Laptop

ALTER TABLE Laptop
ADD CONSTRAINT fk_laptop
FOREIGN KEY(Model_No)
REFERENCES Product_Info(Model_No)
ON DELETE CASCADE;

--Foreign Key for Printer

ALTER TABLE Printer
ADD CONSTRAINT fk_printer
FOREIGN KEY(Model_No)
REFERENCES Product_Info(Model_No)
ON DELETE CASCADE;


--Check Foreign Keys
SELECT Constraint_Name,
       Constraint_Type,
       Table_Name
FROM User_Constraints
WHERE Constraint_Type='R';


--Demonstrate ON DELETE CASCADE

DELETE FROM Product_Info
WHERE Model_No='PC112';

SELECT * FROM PC;


--5(a). Check Constraint for TYPE

ALTER TABLE Product_Info
ADD CONSTRAINT chk_type
CHECK(Type IN ('PC','LP','PR'));



--5(b). Check Constraint for Positive Price


ALTER TABLE PC
ADD CONSTRAINT chk_pc_price
CHECK(Price>0);

ALTER TABLE Laptop
ADD CONSTRAINT chk_laptop_price
CHECK(Price>0);

ALTER TABLE Printer
ADD CONSTRAINT chk_printer_price
CHECK(Price>0);


--Check Check Constraints

SELECT Constraint_Name,
       Constraint_Type,
       Table_Name
FROM User_Constraints
WHERE Constraint_Type='C';


--6. Display Constraint Types

SELECT DISTINCT Constraint_Type
FROM User_Constraints;



--7. Create TYPE_INFO Table

CREATE TABLE Type_Info AS
SELECT Model_No,
       Type
FROM Product_Info
WHERE 1=0;


--Initially No Rows

SELECT * FROM Type_Info;


--Insert Records

INSERT INTO Type_Info(Model_No,Type)
SELECT Model_No,
       Type
FROM Product_Info;


--8. Add PrinterCode Column


ALTER TABLE Printer
ADD PrinterCode VARCHAR2(10);



--9. Add UNIQUE Constraint

ALTER TABLE Printer
ADD CONSTRAINT uk_printercode
UNIQUE(PrinterCode);


--Check UNIQUE Constraint

SELECT Constraint_Name,
       Constraint_Type
FROM User_Constraints
WHERE Constraint_Type='U';


--10. Increase Width of PrinterCode
ALTER TABLE Printer
MODIFY PrinterCode VARCHAR2(12);



--11. Remove All Rows from TYPE_INFO

TRUNCATE TABLE Type_Info;


--12. Drop TYPE_INFO Table

DROP TABLE Type_Info;