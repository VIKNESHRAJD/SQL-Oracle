/*
RAVEN — ORACLE RDBMS LAB EXAM QUESTION BANK
Experiments 1–9 | SQL and PL/SQL practice

IMPORTANT:
1. This is a study/reference script. Run only the sections you need.
2. Some examples assume the tables/columns stated in comments exist.
3. CREATE TABLE statements may fail if the tables already exist.
4. Sample employee names, IDs, dates and values are illustrative.
5. Oracle SQL/PLSQL syntax is used. Enable DBMS_OUTPUT in your client.
*/

SET SERVEROUTPUT ON;

/* ============================================================
   EXPERIMENT 1 — DDL, DML AND BASIC QUERIES
   ============================================================ */

/* Q1. Create the four core tables.
   Note: This is a basic schema; add detail-table PK/FK constraints
   in Experiment 2 if required by your lab manual. */
CREATE TABLE PRODUCT_INFO (
    MAKER VARCHAR2(20),
    MODEL_NO VARCHAR2(10) PRIMARY KEY,
    TYPE VARCHAR2(10)
);

CREATE TABLE PC (
    MODEL_NO VARCHAR2(10),
    SPEED NUMBER,
    RAM NUMBER,
    HD NUMBER,
    CD NUMBER,
    PRICE NUMBER
);

CREATE TABLE LAPTOP (
    MODEL_NO VARCHAR2(10),
    SPEED NUMBER,
    RAM NUMBER,
    HD NUMBER,
    SCREENSIZE NUMBER,
    PRICE NUMBER
);

CREATE TABLE PRINTER (
    MODEL_NO VARCHAR2(10),
    COLOR VARCHAR2(5),
    TYPE VARCHAR2(20),
    PRICE NUMBER
);

/* Q2. Verify table creation. */
SELECT * FROM TAB;

SELECT TNAME
FROM TAB
WHERE TNAME IN ('PRODUCT_INFO', 'PC', 'LAPTOP', 'PRINTER');

/* Q3. Insert PC100 and its master record. */
INSERT INTO PC (MODEL_NO, SPEED, RAM, HD, CD, PRICE)
VALUES ('PC100', 3, 512, 1000, 52, 55000);

INSERT INTO PRODUCT_INFO (MAKER, MODEL_NO, TYPE)
VALUES ('HCL', 'PC100', 'PC');

/* Q4. Delete PCs with CD speed below 50. */
DELETE FROM PC
WHERE CD < 50;

/* Q5. Transfer HCL products to IBM. */
UPDATE PRODUCT_INFO
SET MAKER = 'IBM'
WHERE MAKER = 'HCL';

/* Q6. Double RAM and add 100 to HD for all PCs. */
UPDATE PC
SET RAM = RAM * 2,
    HD = HD + 100;

/* Q7. Discount printers costing more than 6000 by 500. */
UPDATE PRINTER
SET PRICE = PRICE - 500
WHERE PRICE > 6000;


/* ============================================================
   EXPERIMENT 2 — CONSTRAINTS, OPERATORS AND BUILT-IN FUNCTIONS
   ============================================================ */

/* Q8. Add a primary key and foreign key to PC.
   Requires PRODUCT_INFO.MODEL_NO to be a PK/UNIQUE key and all
   PC.MODEL_NO values to have matching parent rows. */
ALTER TABLE PC
ADD CONSTRAINT PK_PC PRIMARY KEY (MODEL_NO);

ALTER TABLE PC
ADD CONSTRAINT FK_PC_PRODUCT
FOREIGN KEY (MODEL_NO)
REFERENCES PRODUCT_INFO (MODEL_NO);

/* Q9. Restrict types and require positive prices. */
ALTER TABLE PRODUCT_INFO
ADD CONSTRAINT CK_PRODUCT_TYPE
CHECK (TYPE IN ('PC', 'LP', 'PR'));

ALTER TABLE PC
ADD CONSTRAINT CK_PC_PRICE CHECK (PRICE > 0);

ALTER TABLE LAPTOP
ADD CONSTRAINT CK_LAPTOP_PRICE CHECK (PRICE > 0);

ALTER TABLE PRINTER
ADD CONSTRAINT CK_PRINTER_PRICE CHECK (PRICE > 0);

/* Q10. Inspect current-user constraints.
   Constraint types: P=Primary, R=Foreign, U=Unique, C=Check/Not Null,
   V=View check option, O=View read-only. */
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
ORDER BY TABLE_NAME;

/* Q11. CTAS: copy PCs costing more than 40000. */
CREATE TABLE EXPENSIVE_PC AS
SELECT *
FROM PC
WHERE PRICE > 40000;

/* Q12. Remove rows but keep the table structure. */
TRUNCATE TABLE EXPENSIVE_PC;

/* Q12b. Drop the table structure itself (run only if wanted). */
-- DROP TABLE EXPENSIVE_PC;

/* Q13. PCs between 30000 and 60000, highest price first. */
SELECT MODEL_NO, PRICE
FROM PC
WHERE PRICE BETWEEN 30000 AND 60000
ORDER BY PRICE DESC;

/* Q14. Show unique RAM values with a 10% increased displayed price.
   This query does not modify stored prices. */
SELECT DISTINCT RAM,
       PRICE * 1.10 AS INCREASED_PRICE
FROM PC;

/* Q15. Set operators. Each paired SELECT must return compatible columns. */
-- Models present in both tables
SELECT MODEL_NO FROM PC
INTERSECT
SELECT MODEL_NO FROM LAPTOP;

-- Models in PC but not LAPTOP
SELECT MODEL_NO FROM PC
MINUS
SELECT MODEL_NO FROM LAPTOP;

-- Combine and remove duplicates
SELECT MODEL_NO FROM PC
UNION
SELECT MODEL_NO FROM LAPTOP;

-- Combine and retain duplicates
SELECT MODEL_NO FROM PC
UNION ALL
SELECT MODEL_NO FROM LAPTOP;

/* Q16. Price range, standard deviation and variance. */
SELECT MAX(PRICE) - MIN(PRICE) AS PRICE_RANGE,
       STDDEV(PRICE) AS PRICE_STDDEV,
       VARIANCE(PRICE) AS PRICE_VARIANCE
FROM PC;

/* Q17. Lowercase model numbers and round prices to 2 decimals. */
SELECT LOWER(MODEL_NO) AS MODEL,
       ROUND(PRICE, 2) AS PRICE
FROM PC;

/* Q18. Sort workers by name length.
   Assumes WORKERSKILL has NAME. */
SELECT NAME, LENGTH(NAME) AS NAME_LENGTH
FROM WORKERSKILL
ORDER BY LENGTH(NAME);

/* Q18b. Extract the portion after the second hyphen from a phone string.
   Assumes PHONE format such as 91-0437-123456 and a PHONE column exists. */
SELECT SUBSTR(PHONE, INSTR(PHONE, '-', 1, 2) + 1) AS PHONE_NUMBER
FROM WORKERSKILL;

/* Q19. Phonetic match for cities sounding like Madurai. */
SELECT NAME, CITY
FROM WORKERSKILL
WHERE SOUNDEX(CITY) = SOUNDEX('Madurai');

/* Q20. Display LASTNAME, FIRSTNAME.
   Assumes NAME has exactly one space separating first and last names. */
SELECT SUBSTR(NAME, INSTR(NAME, ' ') + 1)
       || ', ' ||
       SUBSTR(NAME, 1, INSTR(NAME, ' ') - 1) AS DISPLAY_NAME
FROM WORKERSKILL;

/* Q21. REPLACE, DECODE and TRANSLATE. */
SELECT REPLACE('DATABASE LAB', 'LAB', 'PRACTICAL') AS RESULT
FROM DUAL;

SELECT DECODE(TYPE,
              'PC', 'Computer',
              'LP', 'Laptop',
              'PR', 'Printer',
              'Other') AS TYPE_NAME
FROM PRODUCT_INFO;

SELECT TRANSLATE('12345', '123', 'ABC') AS RESULT
FROM DUAL;

/* Q22. Currency formatting examples. */
SELECT TO_CHAR(PRICE, 'L999G999G990D00') AS LOCAL_AMOUNT
FROM PC;

SELECT '$' || TO_CHAR(PRICE, 'FM999G999G990D00') AS USD_AMOUNT
FROM PC;

SELECT 'Rs. ' || TO_CHAR(PRICE, 'FM999G999G990D00') AS RUPEE_AMOUNT
FROM PC;


/* ============================================================
   EXPERIMENT 2 CONTINUED — DATE AND TIME FUNCTIONS
   ============================================================ */

/* Q23. Add joining date. */
ALTER TABLE WORKERSKILL
ADD DATEOFJOINING DATE;

/* Example updates — replace names/dates with actual lab data. */
UPDATE WORKERSKILL
SET DATEOFJOINING = TO_DATE('12-09-2006', 'DD-MM-YYYY')
WHERE NAME = 'RAVI';

UPDATE WORKERSKILL
SET DATEOFJOINING = TO_DATE('15-06-2010', 'DD-MM-YYYY')
WHERE NAME = 'KUMAR';

/* Q24. Three date formats. */
SELECT TO_CHAR(DATEOFJOINING, 'Mon-YYYY') AS FORMAT1,
       TO_CHAR(DATEOFJOINING, 'FMMonth DD YYYY') AS FORMAT2,
       TO_CHAR(DATEOFJOINING, 'DD-MM-RR HH24:MI:SS') AS FORMAT3
FROM WORKERSKILL;

/* Q25. Completed years and remaining months of service. */
SELECT NAME,
       TRUNC(MONTHS_BETWEEN(SYSDATE, DATEOFJOINING) / 12) AS YEARS,
       MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, DATEOFJOINING)), 12) AS MONTHS
FROM WORKERSKILL;

/* Q26. Last day of joining month and next Monday. */
SELECT NAME,
       LAST_DAY(DATEOFJOINING) AS MONTH_END,
       NEXT_DAY(DATEOFJOINING, 'MONDAY') AS NEXT_MONDAY
FROM WORKERSKILL;

/* Q27. UTC and New York time. */
SELECT SYS_EXTRACT_UTC(SYSTIMESTAMP) AS UTC_TIME,
       SYSTIMESTAMP AT TIME ZONE 'America/New_York' AS NEW_YORK_TIME
FROM DUAL;


/* ============================================================
   EXPERIMENT 3 — ADVANCED QUERIES AND JOINS
   ============================================================ */

/* Q28. PCs costing more than average PC price. */
SELECT MODEL_NO, PRICE
FROM PC
WHERE PRICE > (SELECT AVG(PRICE) FROM PC);

/* Q29. PCs costing more than every printer. */
SELECT MODEL_NO, PRICE
FROM PC
WHERE PRICE > ALL (SELECT PRICE FROM PRINTER);

/* Alternative without ALL; assumes at least one non-null printer price. */
SELECT MODEL_NO, PRICE
FROM PC
WHERE PRICE > (SELECT MAX(PRICE) FROM PRINTER);

/* Q30. Workers earning more than their own department average.
   Assumes EMP(EMP_ID, NAME, DEPT_ID, SALARY). */
SELECT E1.NAME, E1.SALARY, E1.DEPT_ID
FROM EMP E1
WHERE E1.SALARY > (
    SELECT AVG(E2.SALARY)
    FROM EMP E2
    WHERE E2.DEPT_ID = E1.DEPT_ID
);

/* Q31. Count PCs by RAM, retaining groups with more than 2 PCs. */
SELECT RAM, COUNT(*) AS TOTAL
FROM PC
GROUP BY RAM
HAVING COUNT(*) > 2
ORDER BY TOTAL DESC;

/* Q32. Cheapest and most expensive PCs (ties included). */
SELECT *
FROM PC
WHERE PRICE = (SELECT MAX(PRICE) FROM PC)
   OR PRICE = (SELECT MIN(PRICE) FROM PC);

/* Q33. Equi-join product information and PC details. */
SELECT P.MAKER, C.MODEL_NO, C.SPEED, C.PRICE
FROM PRODUCT_INFO P
JOIN PC C ON P.MODEL_NO = C.MODEL_NO;

/* Q34. Show all products, including those without PC rows. */
SELECT P.MODEL_NO, P.MAKER, C.PRICE
FROM PRODUCT_INFO P
LEFT OUTER JOIN PC C ON P.MODEL_NO = C.MODEL_NO;

/* Q34b. Replace missing PC prices with zero. */
SELECT P.MODEL_NO, P.MAKER, NVL(C.PRICE, 0) AS PRICE
FROM PRODUCT_INFO P
LEFT JOIN PC C ON P.MODEL_NO = C.MODEL_NO;

/* Q35. PC pairs with equal RAM, no self-pairs or reversed duplicates. */
SELECT A.MODEL_NO, B.MODEL_NO, A.RAM
FROM PC A
JOIN PC B ON A.RAM = B.RAM
WHERE A.MODEL_NO < B.MODEL_NO;

/* Q36. Increase HCL/IBM laptop prices by 12.33%.
   Uses EXISTS to match each laptop to its maker. */
UPDATE LAPTOP L
SET PRICE = PRICE * 1.1233
WHERE EXISTS (
    SELECT 1
    FROM PRODUCT_INFO P
    WHERE P.MODEL_NO = L.MODEL_NO
      AND P.MAKER IN ('HCL', 'IBM')
);


/* ============================================================
   EXPERIMENT 4 — VIEWS, MATERIALIZED VIEWS, SEQUENCES, INDEXES,
   SYNONYMS
   ============================================================ */

/* Q37. Read-only printer view. */
CREATE VIEW PRICE6000 AS
SELECT MODEL_NO, TYPE, PRICE
FROM PRINTER
WHERE PRICE > 6000
WITH READ ONLY;

/* Q38. View allows DML only if rows continue to satisfy condition. */
CREATE VIEW PRICE_CHECK AS
SELECT MODEL_NO, TYPE, PRICE
FROM PRINTER
WHERE PRICE > 6000
WITH CHECK OPTION;

/* Q39. Materialized average PC price by RAM, then refresh. */
CREATE MATERIALIZED VIEW PC_RAM_AVG AS
SELECT RAM, AVG(PRICE) AS AVG_PRICE
FROM PC
GROUP BY RAM;

BEGIN
    DBMS_MVIEW.REFRESH('PC_RAM_AVG');
END;
/

/* Q40. Unique index on worker names. */
CREATE UNIQUE INDEX IDX_WORKER_NAME
ON WORKER(NAME);

/* Q41. Bitmap index and function-based index. */
CREATE BITMAP INDEX IDX_SKILL
ON WORKERSKILL(SKILL);

CREATE INDEX IDX_CITY_UPPER
ON WORKERSKILL(UPPER(CITY));

/* Q42. Ascending and descending sequences. */
CREATE SEQUENCE SEQ_UP
START WITH 100
INCREMENT BY 1;

CREATE SEQUENCE SEQ_DOWN
START WITH 100
INCREMENT BY -1
MAXVALUE 100
MINVALUE 1;

/* Q43. NEXTVAL and CURRVAL.
   Run NEXTVAL first in this session before CURRVAL. */
SELECT SEQ_UP.NEXTVAL FROM DUAL;
SELECT SEQ_UP.CURRVAL FROM DUAL;

/* Local synonym for WORKERSKILL. */
CREATE SYNONYM G20K FOR WORKERSKILL;


/* ============================================================
   EXPERIMENT 5 — SIMPLE PL/SQL
   ============================================================ */

/* Q44. Retrieve an employee using a SQL*Plus-style substitution variable.
   Assumes EMP(EMP_ID, NAME, SALARY). */
DECLARE
    V_NAME EMP.NAME%TYPE;
BEGIN
    SELECT NAME
    INTO V_NAME
    FROM EMP
    WHERE EMP_ID = &EMP_ID;

    DBMS_OUTPUT.PUT_LINE('Name: ' || V_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found');
END;
/

/* Q45. Print n down to 1 with a reverse FOR loop. */
DECLARE
    N NUMBER := 5;
BEGIN
    FOR I IN REVERSE 1..N LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

/* Q46. Sum the first n natural numbers. */
DECLARE
    N NUMBER := 10;
    S NUMBER := 0;
BEGIN
    FOR I IN 1..N LOOP
        S := S + I;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Sum = ' || S);
END;
/

/* Q47. Calculate circle areas for radii 1..5 and store.
   Requires CIRCLE_AREA(RADIUS, AREA). */
DECLARE
    A NUMBER;
BEGIN
    FOR R IN 1..5 LOOP
        A := 3.14159 * R * R;

        INSERT INTO CIRCLE_AREA(RADIUS, AREA)
        VALUES (R, A);
    END LOOP;

    COMMIT;
END;
/


/* ============================================================
   EXPERIMENT 6 — PROCEDURES AND FUNCTIONS
   ============================================================ */

/* Q48. Table for shape results. */
CREATE TABLE SHAPE_RESULT (
    SHAPE VARCHAR2(20),
    DIMENSION1 NUMBER,
    AREA NUMBER,
    VOLUME NUMBER
);

/* Q49. Procedure calculates circle/square area or sphere volume. */
CREATE OR REPLACE PROCEDURE CALC_SHAPE (
    P_TYPE IN VARCHAR2,
    P_R IN NUMBER
)
IS
    V_AREA NUMBER := NULL;
    V_VOLUME NUMBER := NULL;
BEGIN
    IF UPPER(P_TYPE) = 'CIRCLE' THEN
        V_AREA := 3.14159 * P_R * P_R;
    ELSIF UPPER(P_TYPE) = 'SQUARE' THEN
        V_AREA := P_R * P_R;
    ELSIF UPPER(P_TYPE) = 'SPHERE' THEN
        V_VOLUME := (4/3) * 3.14159 * P_R * P_R * P_R;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Invalid shape');
    END IF;

    INSERT INTO SHAPE_RESULT
        (SHAPE, DIMENSION1, AREA, VOLUME)
    VALUES
        (UPPER(P_TYPE), P_R, V_AREA, V_VOLUME);
END;
/

/* Example procedure call. */
BEGIN
    CALC_SHAPE('CIRCLE', 5);
END;
/

/* Q50. Function returns a circle's area. */
CREATE OR REPLACE FUNCTION CIRCLE_AREA (
    P_R IN NUMBER
)
RETURN NUMBER
IS
BEGIN
    RETURN 3.14159 * P_R * P_R;
END;
/

/* Example function call. */
SELECT CIRCLE_AREA(5) AS AREA
FROM DUAL;


/* ============================================================
   EXPERIMENT 7 — IMPLICIT AND EXPLICIT CURSORS
   ============================================================ */

/* Q51. Implicit cursor: count rows updated. */
BEGIN
    UPDATE EMP
    SET SALARY = SALARY * 1.10
    WHERE DEPT_ID = 10;

    DBMS_OUTPUT.PUT_LINE('Rows updated: ' || SQL%ROWCOUNT);
END;
/

/* Q52. Explicit cursor using %ROWTYPE.
   Requires SHAPE_INPUT(SHAPE, VALUE1) and SHAPE_RESULT. */
DECLARE
    CURSOR C IS
        SELECT SHAPE, VALUE1
        FROM SHAPE_INPUT;

    V_ROW C%ROWTYPE;
    V_AREA NUMBER;
    V_VOLUME NUMBER;
BEGIN
    OPEN C;

    LOOP
        FETCH C INTO V_ROW;
        EXIT WHEN C%NOTFOUND;

        V_AREA := NULL;
        V_VOLUME := NULL;

        IF UPPER(V_ROW.SHAPE) = 'CIRCLE' THEN
            V_AREA := 3.14159 * V_ROW.VALUE1 * V_ROW.VALUE1;
        ELSIF UPPER(V_ROW.SHAPE) = 'SQUARE' THEN
            V_AREA := V_ROW.VALUE1 * V_ROW.VALUE1;
        ELSIF UPPER(V_ROW.SHAPE) = 'SPHERE' THEN
            V_VOLUME := (4/3) * 3.14159 *
                        V_ROW.VALUE1 * V_ROW.VALUE1 * V_ROW.VALUE1;
        END IF;

        INSERT INTO SHAPE_RESULT
            (SHAPE, DIMENSION1, AREA, VOLUME)
        VALUES
            (V_ROW.SHAPE, V_ROW.VALUE1, V_AREA, V_VOLUME);
    END LOOP;

    CLOSE C;
END;
/

/* Cursor attributes: C%FOUND, C%NOTFOUND, C%ROWCOUNT, C%ISOPEN. */


/* ============================================================
   EXPERIMENT 8 — TRIGGERS
   Requires SALES_TRANSACTION(TRANS_ID, AMOUNT) and
   GST_CALCULATION(TRANS_ID, GST_AMOUNT).
   ============================================================ */

/* Q54. Insert matching GST row after transaction insertion. */
CREATE OR REPLACE TRIGGER ADD_GST
AFTER INSERT ON SALES_TRANSACTION
FOR EACH ROW
BEGIN
    INSERT INTO GST_CALCULATION (TRANS_ID, GST_AMOUNT)
    VALUES (:NEW.TRANS_ID, :NEW.AMOUNT * 0.18);
END;
/

/* Q55. Recalculate GST after transaction amount update. */
CREATE OR REPLACE TRIGGER UPDATE_GST
AFTER UPDATE OF AMOUNT ON SALES_TRANSACTION
FOR EACH ROW
BEGIN
    UPDATE GST_CALCULATION
    SET GST_AMOUNT = :NEW.AMOUNT * 0.18
    WHERE TRANS_ID = :NEW.TRANS_ID;
END;
/

/* Q56. Delete matching GST row after transaction deletion. */
CREATE OR REPLACE TRIGGER DELETE_GST
AFTER DELETE ON SALES_TRANSACTION
FOR EACH ROW
BEGIN
    DELETE FROM GST_CALCULATION
    WHERE TRANS_ID = :OLD.TRANS_ID;
END;
/


/* ============================================================
   EXPERIMENT 9 — EXCEPTION HANDLING
   ============================================================ */

/* Q57. Retrieve salary and handle missing/multiple rows. */
DECLARE
    V_SALARY EMP.SALARY%TYPE;
BEGIN
    SELECT SALARY
    INTO V_SALARY
    FROM EMP
    WHERE EMP_ID = 101;

    DBMS_OUTPUT.PUT_LINE('Salary: ' || V_SALARY);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one employee found');
END;
/

/* Q58. Handle division by zero. */
DECLARE
    A NUMBER := 20;
    B NUMBER := 0;
    RESULT NUMBER;
BEGIN
    RESULT := A / B;
    DBMS_OUTPUT.PUT_LINE('Result: ' || RESULT);
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Cannot divide by zero');
END;
/

/* Q59. Raise a custom application error for negative salary. */
DECLARE
    V_SALARY NUMBER := -5000;
BEGIN
    IF V_SALARY < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be negative');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Valid salary');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

/* END OF QUESTION BANK

Reminder:
- Run sections selectively; many statements modify or create objects.
- Object names may need changing if they already exist.
- Table and column assumptions are noted beside examples.
- Commit or rollback DML according to the instructions in your lab.
*/
