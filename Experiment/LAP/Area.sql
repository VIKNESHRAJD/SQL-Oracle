/*===============================================
  EXPERIMENT 5 - SIMPLE PL/SQL PROGRAMS
  IV. Area.sql - Calculate Area of Circle
===============================================*/

-- This program calculates the area of a circle for radius values from 3 to 7
-- and stores the radius and calculated area in the Area_values table
-- Formula: Area = π * r²

SET SERVEROUTPUT ON;

-- First, create the Area_values table if it doesn't exist
DECLARE
BEGIN
    BEGIN
        CREATE TABLE Area_values (
            Radius    NUMBER(5, 2),
            Area      NUMBER(10, 4),
            CreatedOn DATE DEFAULT SYSDATE
        );
        DBMS_OUTPUT.PUT_LINE('Table Area_values created successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -955 THEN
                DBMS_OUTPUT.PUT_LINE('Table Area_values already exists. Proceeding with insertion...');
            ELSE
                RAISE;
            END IF;
    END;
END;
/

-- Main program to calculate and insert area values
DECLARE
    v_radius      NUMBER(5, 2);
    v_area        NUMBER(10, 4);
    v_pi          CONSTANT NUMBER(10, 8) := 3.14159265;
    v_total_area  NUMBER(10, 4) := 0;
    v_avg_area    NUMBER(10, 4);
    v_count       NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('==========================================================');
    DBMS_OUTPUT.PUT_LINE('CIRCLE AREA CALCULATION FOR RADIUS 3 TO 7');
    DBMS_OUTPUT.PUT_LINE('==========================================================');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Formula: Area = π * r²  where π = 3.14159265');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Radius(cm)  |  Area(cm²)');
    DBMS_OUTPUT.PUT_LINE('------------|----------');
    
    -- Clear existing data before insertion (optional)
    DELETE FROM Area_values;
    COMMIT;
    
    -- Loop through radius values from 3 to 7
    FOR v_radius IN 3 .. 7 LOOP
        -- Calculate area using formula: A = π * r²
        v_area := v_pi * (v_radius * v_radius);
        v_total_area := v_total_area + v_area;
        v_count := v_count + 1;
        
        -- Insert into Area_values table
        INSERT INTO Area_values (Radius, Area)
        VALUES (v_radius, v_area);
        
        -- Display in formatted output
        DBMS_OUTPUT.PUT_LINE(LPAD(v_radius, 8) || '    |  ' || LPAD(ROUND(v_area, 4), 10));
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('------------|----------');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Calculate and display statistics
    IF v_count > 0 THEN
        v_avg_area := v_total_area / v_count;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('STATISTICS');
    DBMS_OUTPUT.PUT_LINE('-----------');
    DBMS_OUTPUT.PUT_LINE('Total Records Inserted  : ' || v_count);
    DBMS_OUTPUT.PUT_LINE('Total Area              : ' || ROUND(v_total_area, 4) || ' cm²');
    DBMS_OUTPUT.PUT_LINE('Average Area            : ' || ROUND(v_avg_area, 4) || ' cm²');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Commit the transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('✓ Data successfully inserted into Area_values table!');
    DBMS_OUTPUT.PUT_LINE('==========================================================');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/

-- Display the contents of Area_values table
DBMS_OUTPUT.PUT_LINE('');
DBMS_OUTPUT.PUT_LINE('Contents of Area_values table:');
DBMS_OUTPUT.PUT_LINE('');

SELECT Radius, 
       Area, 
       CreatedOn
FROM Area_values
ORDER BY Radius;
