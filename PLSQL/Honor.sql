SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to select students eligible for honors
    CURSOR honors_cursor IS
        SELECT roll_number, name, GREATEST(s1_grade, s2_grade) AS highest_grade
        FROM Students
        WHERE s1_grade + s2_grade > 12
        ORDER BY roll_number;

    -- Variables to hold data fetched from the cursor
    v_roll_number Students.roll_number%TYPE;
    v_name Students.name%TYPE;
    v_highest_grade NUMBER;

BEGIN
    -- Open the cursor
    OPEN honors_cursor;

    -- Output the header for the result
    DBMS_OUTPUT.PUT_LINE('STUDENTS ELIGIBLE FOR HONOURS');
    DBMS_OUTPUT.PUT_LINE('Roll_number | Name | HighestGrade');

    -- Loop through the cursor results
    LOOP
        FETCH honors_cursor INTO v_roll_number, v_name, v_highest_grade;
        EXIT WHEN honors_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_roll_number || ' | ' || v_name || ' | ' || v_highest_grade);
        --  DBMS_OUTPUT.PUT_LINE(''|| v_roll_number||''|| v_name||''||v_highest_grade);
    END LOOP;

    -- Close the cursor
    CLOSE honors_cursor;
END;
/
