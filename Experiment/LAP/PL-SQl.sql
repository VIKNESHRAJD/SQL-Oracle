
SET SERVEROUTPUT ON;

--Write a program to print the numbers from 1 to 100

DECLARE
N NUMBER(3):=1;
V VARCHAR2(1000);
BEGIN
WHILE N <=100
LOOP
V:=V||''||N;
N:=N+1;
END LOOP;
DBMS_OUTPUT.PUT_LINE(V);
END;
/

COMMIT;



--3.write a program to print the even numbers from 1 to 100
DECLARE
N NUMBER(3):=0;
BEGIN
WHILE N <=100
LOOP
N:=N+2;
DBMS_OUTPUT.PUT_LINE(N);
END LOOP;
END;
/


--Write a program to print the odd numbers from 1 to 100
DECLARE
N NUMBER(3):=1;
BEGIN
WHILE N <=100
LOOP
N:=N+2;
DBMS_OUTPUT.PUT_LINE(N);
END LOOP;
END;
/




---Emp.sql - Retrieve Employee Details

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


DECLARE
    v_emp_id    employees.employee_id%TYPE;
    v_first_name employees.first_name%TYPE;
    v_last_name  employees.last_name%TYPE;
    v_job_id     employees.job_id%TYPE;
    v_salary     employees.salary%TYPE;
    v_dept_id    employees.department_id%TYPE;
BEGIN
    -- Accept employee number from user
    v_emp_id := &Enter_Employee_ID;
    
    -- Retrieve employee details
    SELECT first_name,
           last_name,
           job_id,
           salary,
           department_id
    INTO v_first_name,
         v_last_name,
         v_job_id,
         v_salary,
         v_dept_id
    FROM employees
    WHERE employee_id = v_emp_id;
    
    -- Display employee details
    DBMS_OUTPUT.PUT_LINE('Employee ID    : ' || v_emp_id);
    DBMS_OUTPUT.PUT_LINE('First Name     : ' || v_first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name      : ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('Job ID         : ' || v_job_id);
    DBMS_OUTPUT.PUT_LINE('Salary         : ' || v_salary);
    DBMS_OUTPUT.PUT_LINE('Department ID  : ' || v_dept_id);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Employee ID ' || v_emp_id || ' not found!');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Multiple records found for Employee ID ' || v_emp_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/


--Reverse.sql - Reverse a Number Using All Forms of Loops

SET SERVEROUTPUT ON;

DECLARE
    v_number         NUMBER;
    v_reversed       NUMBER := 0;
    v_temp           NUMBER;
    v_remainder      NUMBER;
    v_iterations     NUMBER := 0;
BEGIN
    -- Accept number from user
    v_number := &Enter_Number;
    v_temp := v_number;
    
    DBMS_OUTPUT.PUT_LINE('Original Number: ' || v_number);
    DBMS_OUTPUT.PUT_LINE('');

--Simple Loop 
 DBMS_OUTPUT.PUT_LINE('Method 1: Using SIMPLE LOOP');
    v_reversed := 0;
    v_temp := v_number;
    
    LOOP
        v_remainder := MOD(v_temp, 10);
        v_reversed := (v_reversed * 10) + v_remainder;
        v_temp := TRUNC(v_temp / 10);
        
        EXIT WHEN v_temp = 0;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Reversed Number: ' || v_reversed);
    DBMS_OUTPUT.PUT_LINE('');

--While LOOP
 DBMS_OUTPUT.PUT_LINE('Method 2: Using WHILE LOOP');
    v_reversed := 0;
    v_temp := v_number;
    v_iterations := 0;
    
    WHILE v_temp > 0 LOOP
        v_remainder := MOD(v_temp, 10);
        v_reversed := (v_reversed * 10) + v_remainder;
        v_temp := TRUNC(v_temp / 10);
        v_iterations := v_iterations + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Reversed Number: ' || v_reversed);
    DBMS_OUTPUT.PUT_LINE('Iterations Used: ' || v_iterations);
    DBMS_OUTPUT.PUT_LINE('');  

--FOR LOOP (Numeric)

  DBMS_OUTPUT.PUT_LINE('Method 3: Using FOR LOOP (String-based iteration)');
    
    v_reversed := 0;
    v_temp := ABS(v_number);
    
    DECLARE
        v_digit      NUMBER;
        v_num_str    VARCHAR2(20);
        v_is_negative BOOLEAN := FALSE;
    BEGIN
        IF v_number < 0 THEN
            v_is_negative := TRUE;
        END IF;
        
        v_num_str := TO_CHAR(v_temp);
        
        FOR i IN REVERSE 1 .. LENGTH(v_num_str) LOOP
            v_digit := TO_NUMBER(SUBSTR(v_num_str, i, 1));
            v_reversed := (v_reversed * 10) + v_digit;
        END LOOP;
        
        IF v_is_negative THEN
            v_reversed := v_reversed * -1;
        END IF;
    END;
    
    DBMS_OUTPUT.PUT_LINE('Reversed Number: ' || v_reversed);
    DBMS_OUTPUT.PUT_LINE('');
    
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid input. Please enter a numeric value.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/


---Sum.sql - Print Sum of 'n' Natural Numbers



SET SERVEROUTPUT ON;

DECLARE
    v_n           NUMBER;
    v_sum         NUMBER := 0;
    v_i           NUMBER;
    v_formula_sum NUMBER;
BEGIN
    -- Accept value of n from user
    v_n := &Enter_Value_of_N;
    
    -- Validate input
    IF v_n < 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Please enter a positive number!');
        RETURN;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('SUM OF FIRST ' || v_n || ' NATURAL NUMBERS');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Method 2: Using Mathematical Formula');
    DBMS_OUTPUT.PUT_LINE('Formula: Sum = n * (n + 1) / 2');
    
    v_formula_sum := v_n * (v_n + 1) / 2;
    
    DBMS_OUTPUT.PUT_LINE('Sum (Using Formula): ' || v_formula_sum);
    DBMS_OUTPUT.PUT_LINE('');
    END;
    /
    
    
    commit;
    
-- calculate the area of the circle for the values of radius varying from 3 to 7. 

CREATE TABLE Area_val ( radius NUMBER, area NUMBER );

DECLARE r NUMBER; a NUMBER; BEGIN FOR r IN 3..7 LOOP

    a := 3.14159 * r * r;

    INSERT INTO Area_val(radius, area)
    VALUES(r, a);

    DBMS_OUTPUT.PUT_LINE(
        'Radius = ' || r || '  Area = ' || a
    );

END LOOP;
END; 
/ 
SELECT * FROM Area_val;


