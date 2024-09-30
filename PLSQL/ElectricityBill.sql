SET SERVEROUTPUT ON;

DECLARE
    user_id_input NUMBER; 
    CURSOR user_cursor IS
        SELECT user_id, user_name, unit_consumed
        FROM bill_user
        WHERE user_id = user_id_input;
    
    user_record user_cursor%ROWTYPE;
    charge_rate NUMBER(10, 2);
    total_bill NUMBER(10, 2);

BEGIN
    user_id_input := &user_id; 

    OPEN user_cursor;
    LOOP
        FETCH user_cursor INTO user_record;
        EXIT WHEN user_cursor%NOTFOUND;

        BEGIN
            SELECT charge INTO charge_rate
            FROM electricity_charge
            WHERE 
                (user_record.unit_consumed BETWEEN 1 AND 100 AND unit_consumed = '1-100') OR
                (user_record.unit_consumed BETWEEN 101 AND 300 AND unit_consumed = '101-300') OR
                (user_record.unit_consumed BETWEEN 301 AND 500 AND unit_consumed = '301-500') OR
                (user_record.unit_consumed > 500 AND unit_consumed = '>501');

            total_bill := user_record.unit_consumed * charge_rate;

            DBMS_OUTPUT.PUT_LINE('User ID: ' || user_record.user_id);
            DBMS_OUTPUT.PUT_LINE('Name: ' || user_record.user_name);
            DBMS_OUTPUT.PUT_LINE('Units Consumed: ' || user_record.unit_consumed);
            DBMS_OUTPUT.PUT_LINE('Total Bill: ' || total_bill);
            DBMS_OUTPUT.PUT_LINE('---------------------------');

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('User ID: ' || user_record.user_id || ', Name: ' || user_record.user_name || ' has no applicable charge rate.');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('User ID: ' || user_record.user_id || ', Name: ' || user_record.user_name || ' encountered an error: ' || SQLERRM);
        END;

    END LOOP;
    CLOSE user_cursor;
END;
/

