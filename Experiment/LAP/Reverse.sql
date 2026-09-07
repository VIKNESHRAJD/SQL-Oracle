/*===============================================
  EXPERIMENT 5 - SIMPLE PL/SQL PROGRAMS
  II. Reverse.sql - Reverse a Number Using All Forms of Loops
===============================================*/

-- This program demonstrates reversing a number using different loop constructs:
-- 1. Simple LOOP
-- 2. WHILE LOOP
-- 3. FOR LOOP

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
    
    -- =====================================
    -- METHOD 1: Using SIMPLE LOOP
    -- =====================================
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
    
    -- =====================================
    -- METHOD 2: Using WHILE LOOP
    -- =====================================
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
    
    -- =====================================
    -- METHOD 3: Using FOR LOOP (Numeric)
    -- =====================================
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
    DBMS_OUTPUT.PUT_LINE('========== ALL METHODS COMPLETED SUCCESSFULLY ==========');
    
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid input. Please enter a numeric value.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/
