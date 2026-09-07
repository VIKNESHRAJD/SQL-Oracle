/*===============================================
  EXPERIMENT 5 - SIMPLE PL/SQL PROGRAMS
  III. Sum.sql - Print Sum of 'n' Natural Numbers
===============================================*/

-- This program calculates and displays the sum of first 'n' natural numbers
-- Formula: Sum = n * (n + 1) / 2

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
    
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('SUM OF FIRST ' || v_n || ' NATURAL NUMBERS');
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- =====================================
    -- METHOD 1: Using Loop
    -- =====================================
    DBMS_OUTPUT.PUT_LINE('Method 1: Using Loop');
    DBMS_OUTPUT.PUT_LINE('Natural Numbers: ');
    v_sum := 0;
    
    FOR v_i IN 1 .. v_n LOOP
        v_sum := v_sum + v_i;
        
        -- Display numbers with comma separation
        IF v_i < v_n THEN
            DBMS_OUTPUT.PUT(v_i || ', ');
        ELSE
            DBMS_OUTPUT.PUT_LINE(v_i);
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Sum (Using Loop)  : ' || v_sum);
    DBMS_OUTPUT.PUT_LINE('');
    
    -- =====================================
    -- METHOD 2: Using Mathematical Formula
    -- =====================================
    DBMS_OUTPUT.PUT_LINE('Method 2: Using Mathematical Formula');
    DBMS_OUTPUT.PUT_LINE('Formula: Sum = n * (n + 1) / 2');
    
    v_formula_sum := v_n * (v_n + 1) / 2;
    
    DBMS_OUTPUT.PUT_LINE('Sum (Using Formula): ' || v_formula_sum);
    DBMS_OUTPUT.PUT_LINE('');
    
    -- =====================================
    -- Verification
    -- =====================================
    IF v_sum = v_formula_sum THEN
        DBMS_OUTPUT.PUT_LINE('✓ Both methods produce the same result!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✗ Results do not match. Please verify.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('Final Sum of First ' || v_n || ' Natural Numbers: ' || v_sum);
    DBMS_OUTPUT.PUT_LINE('=================================================');
    
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid input. Please enter a valid number.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/
