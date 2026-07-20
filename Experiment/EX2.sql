--2.Key Constraints, Arithmetic, Logical, Set Operations & Sorting.

--1.Alter the table product_info to make the type column NOT NULL.
ALTER TABLE Product_Info MODIFY Product_Type NOT NULL;
DESC PC;

--2.Alter the table pc to have a default speed of 2
ALTER TABLE PC MODIFY Speed DEFAULT 2;
SELECT * FROM PC;

--3.Create suitable primary keys for all the tables of the above database schema
--a)Check if the primary keys are created successfully (User_Constraints table)

ALTER TABLE Product_Info ADD PRIMARY KEY (Model_No);
ALTER TABLE PC ADD PRIMARY KEY (Model_No); --EXTRA PK
ALTER TABLE Laptop ADD PRIMARY KEY (Model_No);
ALTER TABLE Printer ADD PRIMARY KEY (Model_No);


--CHECKING
SELECT CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('PRODUCT_INFO', 'PC', 'LAPTOP', 'PRINTER')
AND CONSTRAINT_TYPE = 'P' ORDER BY TABLE_NAME;


--4.Create suitable foreign keys for all the tables of the above database schema
--a.Check if the foreign keys are created successfully (User_Constraints table)
--b.Demonstrate the usage of On delete cascade

ALTER TABLE PC ADD CONSTRAINT FK_PC_ProductInfo FOREIGN KEY (Model_No) 
REFERENCES Product_Info(Model_No) ON DELETE CASCADE ON UPDATE CASCADE;



