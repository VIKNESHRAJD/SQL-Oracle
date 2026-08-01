
--1.Alter the table product_info to make the type column NOT NULL
ALTER TABLE Product_Info MODIFY Type VARCHAR2(2) NOT NULL;


--2.Alter the table pc to have a default speed of 2.
ALTER TABLE PC MODIFY Speed DEFAULT 2;


/*SELECT column_name, data_default 
FROM user_tab_cols 
WHERE table_name = 'PC' AND column_name = 'SPEED';
*/

DESC PRINTER;
select * FROM  PRODUCT_INFO;

--3. Create Primary Key
--Primary Key for Product_Info
ALTER TABLE Product_Info ADD CONSTRAINT pk_product PRIMARY KEY(Model_No);

--Primary Key for PC
ALTER TABLE PC ADD CONSTRAINT pk_pc PRIMARY KEY(Model_No);


--Primary Key for Laptop
ALTER TABLE Laptop ADD CONSTRAINT pk_laptop PRIMARY KEY(Model_No);

--Primary Key for Printer
ALTER TABLE Printer ADD CONSTRAINT pk_printer PRIMARY KEY(Model_No);

--Check Primary Keys

SELECT Constraint_Name,
       Constraint_Type,
       Table_Name
FROM User_Constraints
WHERE Constraint_Type = 'P'
AND Table_Name IN ('PRODUCT_INFO','PC','LAPTOP','PRINTER');



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
WHERE Constraint_Type='R' AND Table_Name IN ('PRODUCT_INFO','PC','LAPTOP','PRINTER');



--Demonstrate ON DELETE CASCADE

DELETE FROM Product_Info
WHERE Model_No='PC112';


/*

SELECT * FROM pc;

SELECT * FROM Product_Info
WHERE Model_No='PC112';
*/
--5(a). Check Constraint for TYPE

ALTER TABLE Product_Info
ADD CONSTRAINT chk_type
CHECK(Type IN ('PC','LP','PR'));

DESC PRODUCT_INFO;

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
WHERE Constraint_Type='C' AND Table_Name IN ('PRODUCT_INFO','PC','LAPTOP','PRINTER');


--6. Display Constraint Types
SELECT DISTINCT Constraint_Type
FROM User_Constraints;


--7. Create TYPE_INFO Table

CREATE TABLE Type_Info AS
SELECT Model_No,
       Type
FROM Product_Info
WHERE 1=0;

commit;
--Initially No Rows
desc type_info;

SELECT * FROM Type_Info;

commit;

--Insert Records

INSERT INTO Type_Info(Model_No,Type)
SELECT Model_No,
       Type
FROM Product_Info;


--8. Add PrinterCode Column


ALTER TABLE Printer
ADD PrinterCode VARCHAR2(10);
desc printer;
select * from Printer;


--9. Add UNIQUE Constraint

ALTER TABLE Printer ADD CONSTRAINT uk_printercode
UNIQUE(PrinterCode);


--Check UNIQUE Constraint

SELECT Constraint_Name,Constraint_Type FROM User_Constraints WHERE Constraint_Type='U';
SELECT Constraint_Name, Constraint_Type, Table_Name FROM User_Constraints WHERE Table_Name='PRINTER' AND Constraint_Type='U';

--10. Increase Width of PrinterCode
ALTER TABLE Printer
MODIFY PrinterCode VARCHAR2(12);

desc printer;



--11. Remove All Rows from TYPE_INFO

TRUNCATE TABLE Type_Info;

select * from Type_info;
--12. Drop TYPE_INFO Table

DROP TABLE Type_Info;



commit;
