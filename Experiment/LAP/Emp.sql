/*===============================================
  EXPERIMENT 5 - SIMPLE PL/SQL PROGRAMS
  I. Emp.sql - Retrieve Employee Details
===============================================*/

-- This program retrieves employee details for a given employee number
-- The employee number is input by the user

SET SERVEROUTPUT ON;

DECLARE
    v_emp_id    EMPLOYEES.EMPLOYEE_ID%TYPE;
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_last_name  EMPLOYEES.LAST_NAME%TYPE;
    v_job_id     EMPLOYEES.JOB_ID%TYPE;
    v_salary     EMPLOYEES.SALARY%TYPE;
    v_dept_id    EMPLOYEES.DEPARTMENT_ID%TYPE;
BEGIN
    -- Accept employee number from user
    v_emp_id := &Enter_Employee_ID;
    
    -- Retrieve employee details
    SELECT FIRST_NAME,
           LAST_NAME,
           JOB_ID,
           SALARY,
           DEPARTMENT_ID
    INTO v_first_name,
         v_last_name,
         v_job_id,
         v_salary,
         v_dept_id
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = v_emp_id;
    
    -- Display employee details
    DBMS_OUTPUT.PUT_LINE('================= EMPLOYEE DETAILS =================');
    DBMS_OUTPUT.PUT_LINE('Employee ID    : ' || v_emp_id);
    DBMS_OUTPUT.PUT_LINE('First Name     : ' || v_first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name      : ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('Job ID         : ' || v_job_id);
    DBMS_OUTPUT.PUT_LINE('Salary         : ' || v_salary);
    DBMS_OUTPUT.PUT_LINE('Department ID  : ' || v_dept_id);
    DBMS_OUTPUT.PUT_LINE('=====================================================');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Employee ID ' || v_emp_id || ' not found!');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Multiple records found for Employee ID ' || v_emp_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/
