SET SERVEROUTPUT ON;
DECLARE
    CURSOR honors_cursor IS
        SELECT roll_number, 
               name, 
               GREATEST(s1_grade, s2_grade) AS highest_grade,
               CASE 
                   WHEN s1_grade > s2_grade THEN 'Semester 1'
                   WHEN s2_grade > s1_grade THEN 'Semester 2'
                   ELSE 'Both Semesters'
               END AS highest_semester
        FROM Students
        WHERE s1_grade + s2_grade > 12
        ORDER BY roll_number;

    v_roll_number Students.roll_number%TYPE;
    v_name Students.name%TYPE;
    v_highest_grade NUMBER;
    v_highest_semester VARCHAR2(20);

BEGIN
    OPEN honors_cursor;

    DBMS_OUTPUT.PUT_LINE('STUDENTS ELIGIBLE FOR HONOURS');
    DBMS_OUTPUT.PUT_LINE('Roll_number | Name | HighestGrade | HighestSemester');

    LOOP
        FETCH honors_cursor INTO v_roll_number, v_name, v_highest_grade, v_highest_semester;
        EXIT WHEN honors_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_roll_number || ' | ' || v_name || ' | ' || v_highest_grade || ' | ' || v_highest_semester);
    END LOOP;

    CLOSE honors_cursor;
END;
/

