SET SERVEROUTPUT ON

DECLARE
    avg_marks NUMBER(10);
    cdate DATE;
    cweek varchar2(10); 

BEGIN
    SELECT AVG(MARKS) INTO avg_marks FROM STUDENTS;
    DBMS_OUTPUT.PUT_LINE('Average Marks : '||avg_marks);
    if avg_marks<40 then
        dbms_output.put_line('Need Improvement ');
    else
        dbms_output.put_line('Good Average Marks');
    END if;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE(' CURRENT DATE AND DAY:');
  DBMS_OUTPUT.PUT_LINE(SYSDATE || ' ' || TO_CHAR(SYSDATE, 'Day'));
END;
/
