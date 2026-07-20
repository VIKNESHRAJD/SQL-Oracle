-- ============================================================================
-- SQL Constraints Operations - Key Constraints, Primary Keys, Foreign Keys
-- ============================================================================

-- ============================================================================
-- PREREQUISITE: CREATE THE TABLES (From previous task)
-- ============================================================================

-- Create Product_Info Master Table
CREATE TABLE Product_Info (
    Maker VARCHAR(50) NOT NULL,
    Model_No VARCHAR(20) PRIMARY KEY,
    Type CHAR(2) CHECK (Type IN ('PC', 'LP', 'PR'))
);

-- Create PC Table
CREATE TABLE PC (
    Model_No VARCHAR(20) PRIMARY KEY,
    Speed INT,
    RAM INT NOT NULL,
    HD INT NOT NULL,
    CD INT NOT NULL,
    Price INT NOT NULL,
    FOREIGN KEY (Model_No) REFERENCES Product_Info(Model_No) ON DELETE CASCADE
);

-- Create Laptop Table
CREATE TABLE Laptop (
    Model_No VARCHAR(20) PRIMARY KEY,
    Speed INT NOT NULL,
    RAM INT NOT NULL,
    HD INT NOT NULL,
    Screensize DECIMAL(3,1) NOT NULL,
    Price INT NOT NULL,
    FOREIGN KEY (Model_No) REFERENCES Product_Info(Model_No) ON DELETE CASCADE
);

-- Create Printer Table
CREATE TABLE Printer (
    Model_No VARCHAR(20) PRIMARY KEY,
    Color BOOLEAN NOT NULL,
    Type VARCHAR(20) NOT NULL,
    Price INT NOT NULL,
    FOREIGN KEY (Model_No) REFERENCES Product_Info(Model_No) ON DELETE CASCADE
);

-- ============================================================================
-- 1. ALTER TABLE PRODUCT_INFO TO MAKE TYPE COLUMN NOT NULL
-- ============================================================================

PRINT '=== TASK 1: Alter Product_Info Table to Make Type NOT NULL ===';

-- Drop the existing constraint and add a new one
ALTER TABLE Product_Info
MODIFY Type CHAR(2) NOT NULL CHECK (Type IN ('PC', 'LP', 'PR'));

-- Verify the alteration
DESC Product_Info;
PRINT 'Type column is now NOT NULL';

-- ============================================================================
-- 2. ALTER TABLE PC TO HAVE A DEFAULT SPEED OF 2
-- ============================================================================

PRINT '=== TASK 2: Alter PC Table to Add Default Speed of 2 ===';

ALTER TABLE PC
MODIFY Speed INT DEFAULT 2;

-- Verify the alteration
DESC PC;
PRINT 'Speed column now has default value of 2';

-- ============================================================================
-- 3. CREATE SUITABLE PRIMARY KEYS FOR ALL TABLES
-- ============================================================================

PRINT '=== TASK 3: Primary Keys for All Tables ===';
PRINT 'Primary Keys Already Created:';
PRINT '- Product_Info: Model_No (PK)';
PRINT '- PC: Model_No (PK)';
PRINT '- Laptop: Model_No (PK)';
PRINT '- Printer: Model_No (PK)';

-- Check Primary Keys in User_Constraints table
SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME IN ('Product_Info', 'PC', 'Laptop', 'Printer')
AND CONSTRAINT_TYPE = 'PRIMARY KEY';

PRINT '';
PRINT 'Primary Key Verification (using USER_CONSTRAINTS or INFORMATION_SCHEMA):';
SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME IN ('Product_Info', 'PC', 'Laptop', 'Printer')
AND CONSTRAINT_TYPE = 'PRIMARY KEY';

-- ============================================================================
-- 4. CREATE SUITABLE FOREIGN KEYS FOR ALL TABLES
-- ============================================================================

PRINT '=== TASK 4: Foreign Keys for All Tables ===';
PRINT 'Foreign Keys Already Created with ON DELETE CASCADE:';
PRINT '- PC.Model_No -> Product_Info.Model_No (ON DELETE CASCADE)';
PRINT '- Laptop.Model_No -> Product_Info.Model_No (ON DELETE CASCADE)';
PRINT '- Printer.Model_No -> Product_Info.Model_No (ON DELETE CASCADE)';

-- Check Foreign Keys in User_Constraints table
PRINT '';
PRINT 'Foreign Key Verification:';
SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME IN ('Product_Info', 'PC', 'Laptop', 'Printer')
AND REFERENCED_TABLE_NAME IS NOT NULL;

PRINT '';
PRINT 'Foreign Key Details with Delete Action:';
SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    REFERENCED_TABLE_NAME,
    DELETE_RULE,
    UPDATE_RULE
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
WHERE TABLE_NAME IN ('PC', 'Laptop', 'Printer');

-- ============================================================================
-- 5. DEMONSTRATE ON DELETE CASCADE
-- ============================================================================

PRINT '=== TASK 4b: Demonstrate ON DELETE CASCADE ===';

-- Insert sample data
INSERT INTO Product_Info (Maker, Model_No, Type) VALUES
('HCL', 'PC112', 'PC'),
('HCL', 'LP113', 'LP'),
('ZENITH', 'PR114', 'PR'),
('WIPRO', 'PC122', 'PC'),
('WIPRO', 'LP123', 'LP'),
('WIPRO', 'PR124', 'PR'),
('IBM', 'PC134', 'PC'),
('HCL', 'LP114', 'LP'),
('IBM', 'PC132', 'PC'),
('IBM', 'LP133', 'LP'),
('IBM', 'PR134', 'PR');

-- Insert into PC table
INSERT INTO PC (Model_No, Speed, RAM, HD, CD, Price) VALUES
('PC112', 2, 256, 60, 52, 40000),
('PC122', 2, 256, 60, 48, 42000),
('PC132', 1, 128, 100, 68, 50000),
('PC134', 1, 512, 60, 68, 80000);

-- Insert into Laptop table
INSERT INTO Laptop (Model_No, Speed, RAM, HD, Screensize, Price) VALUES
('LP113', 1, 64, 40, 14.0, 59000),
('LP123', 2, 128, 60, 16.0, 72000),
('LP133', 2, 256, 80, 17.0, 100000),
('LP114', 2, 128, 40, 17.0, 45000);

-- Insert into Printer table
INSERT INTO Printer (Model_No, Color, Type, Price) VALUES
('PR114', TRUE, 'Ink', 17000),
('PR124', FALSE, 'Dot', 12000),
('PR134', TRUE, 'Laser', 17000);

PRINT '';
PRINT 'Data inserted successfully into all tables';

-- Display data before cascade delete
PRINT '';
PRINT '=== BEFORE DELETE CASCADE ===';
PRINT 'Product_Info Table:';
SELECT * FROM Product_Info ORDER BY Model_No;

PRINT '';
PRINT 'PC Table:';
SELECT * FROM PC ORDER BY Model_No;

PRINT '';
PRINT 'Laptop Table:';
SELECT * FROM Laptop ORDER BY Model_No;

PRINT '';
PRINT 'Printer Table:';
SELECT * FROM Printer ORDER BY Model_No;

-- ============================================================================
-- DEMONSTRATE CASCADE DELETE: Delete a product from Product_Info
-- This will automatically delete related records from PC, Laptop, and Printer
-- ============================================================================

PRINT '';
PRINT '=== DEMONSTRATING ON DELETE CASCADE ===';
PRINT 'Deleting product PR114 from Product_Info table...';
DELETE FROM Product_Info WHERE Model_No = 'PR114';

PRINT '';
PRINT 'After deleting PR114 from Product_Info:';
PRINT 'Product_Info Table:';
SELECT * FROM Product_Info WHERE Model_No LIKE 'PR%' ORDER BY Model_No;

PRINT '';
PRINT 'Printer Table (PR114 should be DELETED due to CASCADE):';
SELECT * FROM Printer WHERE Model_No = 'PR114';
PRINT 'Result: No records found - CASCADE DELETE worked!';

PRINT '';
PRINT '=== SECOND CASCADE DELETE DEMONSTRATION ===';
PRINT 'Deleting product PC122 from Product_Info table...';
DELETE FROM Product_Info WHERE Model_No = 'PC122';

PRINT '';
PRINT 'After deleting PC122 from Product_Info:';
PRINT 'Product_Info Table:';
SELECT * FROM Product_Info WHERE Model_No LIKE 'PC%' ORDER BY Model_No;

PRINT '';
PRINT 'PC Table (PC122 should be DELETED due to CASCADE):';
SELECT * FROM PC WHERE Model_No = 'PC122';
PRINT 'Result: No records found - CASCADE DELETE worked!';

-- ============================================================================
-- FINAL VERIFICATION - SHOW COMPLETE STATE
-- ============================================================================

PRINT '';
PRINT '=== FINAL STATE AFTER CASCADE DELETIONS ===';

PRINT '';
PRINT 'Product_Info Table (11 - 2 = 9 records):';
SELECT COUNT(*) AS Total_Records FROM Product_Info;
SELECT * FROM Product_Info ORDER BY Model_No;

PRINT '';
PRINT 'PC Table (4 - 1 = 3 records):';
SELECT COUNT(*) AS Total_Records FROM PC;
SELECT * FROM PC ORDER BY Model_No;

PRINT '';
PRINT 'Laptop Table (4 records - unchanged):';
SELECT COUNT(*) AS Total_Records FROM Laptop;
SELECT * FROM Laptop ORDER BY Model_No;

PRINT '';
PRINT 'Printer Table (3 - 1 = 2 records):';
SELECT COUNT(*) AS Total_Records FROM Printer;
SELECT * FROM Printer ORDER BY Model_No;

-- ============================================================================
-- SUMMARY OF ALL CONSTRAINTS
-- ============================================================================

PRINT '';
PRINT '=== SUMMARY OF ALL CONSTRAINTS ===';

PRINT '';
PRINT 'PRIMARY KEYS:';
PRINT '1. Product_Info.Model_No - Uniquely identifies each product model';
PRINT '2. PC.Model_No - Uniquely identifies each PC';
PRINT '3. Laptop.Model_No - Uniquely identifies each Laptop';
PRINT '4. Printer.Model_No - Uniquely identifies each Printer';

PRINT '';
PRINT 'FOREIGN KEYS with ON DELETE CASCADE:';
PRINT '1. PC(Model_No) -> Product_Info(Model_No)';
PRINT '   - Deleting a product from Product_Info automatically deletes related PC records';
PRINT '';
PRINT '2. Laptop(Model_No) -> Product_Info(Model_No)';
PRINT '   - Deleting a product from Product_Info automatically deletes related Laptop records';
PRINT '';
PRINT '3. Printer(Model_No) -> Product_Info(Model_No)';
PRINT '   - Deleting a product from Product_Info automatically deletes related Printer records';

PRINT '';
PRINT 'ADDITIONAL CONSTRAINTS:';
PRINT '1. Product_Info.Type - NOT NULL, CHECK (Type IN (''PC'', ''LP'', ''PR''))';
PRINT '2. PC.Speed - DEFAULT 2';

PRINT '';
PRINT '=== CASCADE DELETE DEMONSTRATION COMPLETE ===';
