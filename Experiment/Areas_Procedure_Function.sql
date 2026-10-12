-- ============================================================================
-- Exercise: Procedures and Functions for Geometric Calculations
-- ============================================================================
-- This file contains:
-- 1. Table Creation (Areas)
-- 2. Procedure Implementation (Calculate_Area_Volume)
-- 3. Function Implementation (Calculate_Area_Volume_Function)
-- ============================================================================

-- ============================================================================
-- STEP 1: Create the Areas Table
-- ============================================================================
CREATE TABLE Areas (
    Input_Value         NUMBER,
    Circle_Area         NUMBER,
    Square_Area         NUMBER,
    Sphere_Area         NUMBER,
    Sphere_Volume       NUMBER,
    Cube_Volume         NUMBER
);

-- Display table structure
DESC Areas;

-- ============================================================================
-- STEP 2: PROCEDURE IMPLEMENTATION
-- ============================================================================
-- Procedure Name: Calculate_Area_Volume
-- Purpose: Calculates geometric measurements based on input character and number
-- Parameters:
--    p_char: Character 'R' (radius) or 'L' (length)
--    p_number: Numeric value for calculations
-- ============================================================================

CREATE OR REPLACE PROCEDURE Calculate_Area_Volume (
    p_char      IN CHAR,
    p_number    IN NUMBER
)
IS
    v_circle_area   NUMBER := 0;
    v_square_area   NUMBER := 0;
    v_sphere_area   NUMBER := 0;
    v_sphere_volume NUMBER := 0;
    v_cube_volume   NUMBER := 0;
BEGIN
    -- Trim and convert to uppercase for case-insensitive comparison
    IF UPPER(TRIM(p_char)) = 'R' THEN
        -- Character is 'R' - Radius calculations
        DBMS_OUTPUT.PUT_LINE('Processing Radius Calculations...');
        
        -- Circle Area = π * r²
        v_circle_area := ROUND((3.14159 * (p_number * p_number)), 2);
        
        -- Sphere Surface Area = 4 * π * r²
        v_sphere_area := ROUND((4 * 3.14159 * (p_number * p_number)), 2);
        
        -- Sphere Volume = (4/3) * π * r³
        v_sphere_volume := ROUND(((4/3) * 3.14159 * (p_number * p_number * p_number)), 2);
        
        -- Insert into Areas table
        INSERT INTO Areas (Input_Value, Circle_Area, Square_Area, Sphere_Area, Sphere_Volume, Cube_Volume)
        VALUES (p_number, v_circle_area, NULL, v_sphere_area, v_sphere_volume, NULL);
        
        DBMS_OUTPUT.PUT_LINE('Radius: ' || p_number);
        DBMS_OUTPUT.PUT_LINE('Circle Area: ' || v_circle_area);
        DBMS_OUTPUT.PUT_LINE('Sphere Surface Area: ' || v_sphere_area);
        DBMS_OUTPUT.PUT_LINE('Sphere Volume: ' || v_sphere_volume);
        DBMS_OUTPUT.PUT_LINE('Data inserted successfully!');
        
    ELSIF UPPER(TRIM(p_char)) = 'L' THEN
        -- Character is 'L' - Length calculations
        DBMS_OUTPUT.PUT_LINE('Processing Length Calculations...');
        
        -- Square Area = L²
        v_square_area := ROUND((p_number * p_number), 2);
        
        -- Cube Volume = L³
        v_cube_volume := ROUND((p_number * p_number * p_number), 2);
        
        -- Insert into Areas table
        INSERT INTO Areas (Input_Value, Circle_Area, Square_Area, Sphere_Area, Sphere_Volume, Cube_Volume)
        VALUES (p_number, NULL, v_square_area, NULL, NULL, v_cube_volume);
        
        DBMS_OUTPUT.PUT_LINE('Side Length: ' || p_number);
        DBMS_OUTPUT.PUT_LINE('Square Area: ' || v_square_area);
        DBMS_OUTPUT.PUT_LINE('Cube Volume: ' || v_cube_volume);
        DBMS_OUTPUT.PUT_LINE('Data inserted successfully!');
        
    ELSE
        -- Invalid choice
        DBMS_OUTPUT.PUT_LINE('Invalid Choice! Please enter ''R'' (Radius) or ''L'' (Length).');
        
    END IF;
    
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
        
END Calculate_Area_Volume;
/

-- ============================================================================
-- STEP 3: FUNCTION IMPLEMENTATION
-- ============================================================================
-- Function Name: Calculate_Area_Volume_Function
-- Purpose: Performs same calculations as procedure but returns a result code
-- Parameters:
--    p_char: Character 'R' (radius) or 'L' (length)
--    p_number: Numeric value for calculations
-- Returns:
--    VARCHAR2: Success or error message
-- ============================================================================

CREATE OR REPLACE FUNCTION Calculate_Area_Volume_Function (
    p_char      IN CHAR,
    p_number    IN NUMBER
)
RETURN VARCHAR2
IS
    v_circle_area   NUMBER := 0;
    v_square_area   NUMBER := 0;
    v_sphere_area   NUMBER := 0;
    v_sphere_volume NUMBER := 0;
    v_cube_volume   NUMBER := 0;
    v_result_msg    VARCHAR2(500);
    
BEGIN
    -- Trim and convert to uppercase for case-insensitive comparison
    IF UPPER(TRIM(p_char)) = 'R' THEN
        -- Character is 'R' - Radius calculations
        
        -- Circle Area = π * r²
        v_circle_area := ROUND((3.14159 * (p_number * p_number)), 2);
        
        -- Sphere Surface Area = 4 * π * r²
        v_sphere_area := ROUND((4 * 3.14159 * (p_number * p_number)), 2);
        
        -- Sphere Volume = (4/3) * π * r³
        v_sphere_volume := ROUND(((4/3) * 3.14159 * (p_number * p_number * p_number)), 2);
        
        -- Insert into Areas table
        INSERT INTO Areas (Input_Value, Circle_Area, Square_Area, Sphere_Area, Sphere_Volume, Cube_Volume)
        VALUES (p_number, v_circle_area, NULL, v_sphere_area, v_sphere_volume, NULL);
        
        v_result_msg := 'SUCCESS: Radius ' || p_number || ' - Circle Area: ' || v_circle_area || 
                       ', Sphere Area: ' || v_sphere_area || ', Sphere Volume: ' || v_sphere_volume;
        
    ELSIF UPPER(TRIM(p_char)) = 'L' THEN
        -- Character is 'L' - Length calculations
        
        -- Square Area = L²
        v_square_area := ROUND((p_number * p_number), 2);
        
        -- Cube Volume = L³
        v_cube_volume := ROUND((p_number * p_number * p_number), 2);
        
        -- Insert into Areas table
        INSERT INTO Areas (Input_Value, Circle_Area, Square_Area, Sphere_Area, Sphere_Volume, Cube_Volume)
        VALUES (p_number, NULL, v_square_area, NULL, NULL, v_cube_volume);
        
        v_result_msg := 'SUCCESS: Length ' || p_number || ' - Square Area: ' || v_square_area || 
                       ', Cube Volume: ' || v_cube_volume;
        
    ELSE
        -- Invalid choice
        v_result_msg := 'ERROR: Invalid Choice! Please enter ''R'' (Radius) or ''L'' (Length).';
        
    END IF;
    
    COMMIT;
    RETURN v_result_msg;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'ERROR: ' || SQLERRM;
        ROLLBACK;
        
END Calculate_Area_Volume_Function;
/

-- ============================================================================
-- STEP 4: TEST CASES
-- ============================================================================

-- Enable output
SET SERVEROUTPUT ON;

-- Test Case 1: Procedure with Radius (R)
DBMS_OUTPUT.PUT_LINE('============================================');
DBMS_OUTPUT.PUT_LINE('TEST CASE 1: Procedure - Radius (R) = 5');
DBMS_OUTPUT.PUT_LINE('============================================');
BEGIN
    Calculate_Area_Volume('R', 5);
END;
/

-- Test Case 2: Procedure with Length (L)
DBMS_OUTPUT.PUT_LINE('============================================');
DBMS_OUTPUT.PUT_LINE('TEST CASE 2: Procedure - Length (L) = 4');
DBMS_OUTPUT.PUT_LINE('============================================');
BEGIN
    Calculate_Area_Volume('L', 4);
END;
/

-- Test Case 3: Procedure with Invalid Choice
DBMS_OUTPUT.PUT_LINE('============================================');
DBMS_OUTPUT.PUT_LINE('TEST CASE 3: Procedure - Invalid Choice');
DBMS_OUTPUT.PUT_LINE('============================================');
BEGIN
    Calculate_Area_Volume('X', 10);
END;
/

-- Test Case 4: Function with Radius (R)
DBMS_OUTPUT.PUT_LINE('============================================');
DBMS_OUTPUT.PUT_LINE('TEST CASE 4: Function - Radius (R) = 3');
DBMS_OUTPUT.PUT_LINE('============================================');
BEGIN
    DBMS_OUTPUT.PUT_LINE(Calculate_Area_Volume_Function('R', 3));
END;
/

-- Test Case 5: Function with Length (L)
DBMS_OUTPUT.PUT_LINE('============================================');
DBMS_OUTPUT.PUT_LINE('TEST CASE 5: Function - Length (L) = 6');
DBMS_OUTPUT.PUT_LINE('============================================');
BEGIN
    DBMS_OUTPUT.PUT_LINE(Calculate_Area_Volume_Function('L', 6));
END;
/

-- Test Case 6: Function with Invalid Choice
DBMS_OUTPUT.PUT_LINE('============================================');
DBMS_OUTPUT.PUT_LINE('TEST CASE 6: Function - Invalid Choice');
DBMS_OUTPUT.PUT_LINE('============================================');
BEGIN
    DBMS_OUTPUT.PUT_LINE(Calculate_Area_Volume_Function('Z', 15));
END;
/

-- ============================================================================
-- Display Results from Areas Table
-- ============================================================================
DBMS_OUTPUT.PUT_LINE('============================================');
DBMS_OUTPUT.PUT_LINE('FINAL RESULTS - Areas Table Contents');
DBMS_OUTPUT.PUT_LINE('============================================');

SELECT * FROM Areas;

-- ============================================================================
-- Clean Up (Optional - Uncomment to clear table and recreate for fresh start)
-- ============================================================================
-- TRUNCATE TABLE Areas;
-- DROP PROCEDURE Calculate_Area_Volume;
-- DROP FUNCTION Calculate_Area_Volume_Function;
-- DROP TABLE Areas;
