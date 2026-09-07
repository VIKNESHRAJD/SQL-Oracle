/*===============================================
  CREATE EMPLOYEE TABLE AND INSERT SAMPLE DATA
===============================================*/

SET SERVEROUTPUT ON;

-- Create EMPLOYEES table
CREATE TABLE EMPLOYEES (
    EMPLOYEE_ID     NUMBER(6) PRIMARY KEY,
    FIRST_NAME      VARCHAR2(20),
    LAST_NAME       VARCHAR2(25),
    EMAIL           VARCHAR2(25),
    PHONE_NUMBER    VARCHAR2(20),
    HIRE_DATE       DATE,
    JOB_ID          VARCHAR2(10),
    SALARY          NUMBER(8,2),
    COMMISSION_PCT  NUMBER(2,2),
    MANAGER_ID      NUMBER(6),
    DEPARTMENT_ID   NUMBER(4)
);

-- Insert sample employee data
INSERT INTO EMPLOYEES VALUES (100, 'Steven', 'King', 'sking@example.com', '515.1234567', TO_DATE('17-JUN-1987', 'DD-MON-YYYY'), 'AD_PRES', 24000, NULL, NULL, 90);
INSERT INTO EMPLOYEES VALUES (101, 'Neena', 'Kochhar', 'nkochhar@example.com', '515.1234568', TO_DATE('21-SEP-1989', 'DD-MON-YYYY'), 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO EMPLOYEES VALUES (102, 'Lex', 'De Haan', 'ldehaan@example.com', '515.1234569', TO_DATE('13-JAN-1993', 'DD-MON-YYYY'), 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO EMPLOYEES VALUES (103, 'Alexander', 'Hunold', 'ahunold@example.com', '590.1234567', TO_DATE('03-JAN-1990', 'DD-MON-YYYY'), 'IT_PROG', 9000, NULL, 102, 60);
INSERT INTO EMPLOYEES VALUES (104, 'Bruce', 'Ernst', 'bernst@example.com', '590.1234568', TO_DATE('21-MAY-1991', 'DD-MON-YYYY'), 'IT_PROG', 6000, NULL, 103, 60);
INSERT INTO EMPLOYEES VALUES (105, 'David', 'Austin', 'daustin@example.com', '590.1234569', TO_DATE('25-JUN-1997', 'DD-MON-YYYY'), 'IT_PROG', 4800, NULL, 103, 60);
INSERT INTO EMPLOYEES VALUES (106, 'Valli', 'Pataballa', 'vpatabal@example.com', '590.1234570', TO_DATE('05-FEB-1998', 'DD-MON-YYYY'), 'IT_PROG', 4800, NULL, 103, 60);
INSERT INTO EMPLOYEES VALUES (107, 'Diana', 'Lorentz', 'dlorentz@example.com', '590.1234571', TO_DATE('07-FEB-1999', 'DD-MON-YYYY'), 'IT_PROG', 4200, NULL, 103, 60);
INSERT INTO EMPLOYEES VALUES (108, 'Nancy', 'Greenberg', 'ngreenbe@example.com', '515.1234569', TO_DATE('17-AUG-1994', 'DD-MON-YYYY'), 'FI_MGR', 12008, NULL, 101, 100);
INSERT INTO EMPLOYEES VALUES (109, 'Daniel', 'Faviet', 'dfaviet@example.com', '515.1234570', TO_DATE('16-AUG-2002', 'DD-MON-YYYY'), 'FI_ACCOUNT', 9000, NULL, 108, 100);

COMMIT;

DBMS_OUTPUT.PUT_LINE('✓ EMPLOYEES table created successfully!');
DBMS_OUTPUT.PUT_LINE('✓ Sample data inserted!');
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE('Total employees inserted: 10');

-- Display the created table structure
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE('Table Structure: EMPLOYEES');
DBMS_OUTPUT.PUT_LINE('================================');
