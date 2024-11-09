CREATE TABLE EMPLOYEE (
    ename VARCHAR2(100),
    designation VARCHAR2(50),
    salary DECIMAL(10, 2)
);

CREATE TABLE ErrorInSal (
    ename VARCHAR2(100),
    designation VARCHAR2(50),
    salary DECIMAL(10, 2)
);

CREATE OR REPLACE PROCEDURE CheckAndInsertErrorSalaries AS
BEGIN
    -- Check the EMPLOYEE table and insert the problematic records into the ErrorInSal table
    FOR emp IN (
        SELECT ename, designation, salary
        FROM EMPLOYEE
        WHERE 
            (designation = 'des1' AND salary > 10000) OR
            (designation = 'des2' AND salary > 7000) OR
            (designation = 'des3' AND salary > 2000)
    ) LOOP
        -- Insert the records into the ErrorInSal table
        INSERT INTO ErrorInSal (ename, designation, salary)
        VALUES (emp.ename, emp.designation, emp.salary);
    END LOOP;
    
    -- Commit the changes to the ErrorInSal table
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Procedure executed successfully. Records inserted into ErrorInSal table.');
EXCEPTION
    WHEN OTHERS THEN
        -- Exception handling
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/
