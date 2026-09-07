# SQL-Oracle  
Area.sql
CREATE TABLE Area_values
(
    radius NUMBER,
    area   NUMBER
);

-- Area.sql

SET SERVEROUTPUT ON;

DECLARE
    r NUMBER;
    a NUMBER;
BEGIN
    FOR r IN 3..7 LOOP

        a := 3.14159 * r * r;

        INSERT INTO Area_values(radius, area)
        VALUES(r, a);

        DBMS_OUTPUT.PUT_LINE(
            'Radius = ' || r || '  Area = ' || a
        );

    END LOOP;

    COMMIT;
END;
/
SELECT * FROM Area_values;
