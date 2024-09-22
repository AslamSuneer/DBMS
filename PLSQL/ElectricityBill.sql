SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to calculate the charge for the units consumed
    CURSOR unit_charge_cur IS
        SELECT CASE 
                WHEN v_units_consumed BETWEEN 1 AND 100 THEN v_units_consumed * 5
                WHEN v_units_consumed BETWEEN 101 AND 300 THEN (100 * 5) + ((v_units_consumed - 100) * 7.5)
                WHEN v_units_consumed BETWEEN 301 AND 500 THEN (100 * 5) + (200 * 7.5) + ((v_units_consumed - 300) * 15)
                ELSE (100 * 5) + (200 * 7.5) + (200 * 15) + ((v_units_consumed - 500) * 22.5)
              END AS total_charge
        FROM dual;

    -- Variables for input and output
    v_consumer_no     NUMBER;
    v_past_reading    NUMBER;
    v_present_reading NUMBER;
    v_units_consumed  NUMBER;
    v_total_charge    NUMBER;

BEGIN
    -- Accepting inputs from the user
    v_consumer_no := &Enter_Consumer_Number;
    v_past_reading := &Enter_Past_Reading;
    v_present_reading := &Enter_Present_Reading;

    -- Calculate the total units consumed
    v_units_consumed := v_present_reading - v_past_reading;

    -- Check if units consumed is valid
    IF v_units_consumed < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid readings: Past reading cannot be greater than present reading.');
    ELSE
        -- Open the cursor and fetch the charge for the units consumed
        OPEN unit_charge_cur;
        FETCH unit_charge_cur INTO v_total_charge;

        -- Display the consumer details and the bill amount
        DBMS_OUTPUT.PUT_LINE('CONSUMER ELECTRICITY BILL');
        DBMS_OUTPUT.PUT_LINE('Consumer Number | Units Consumed | Total Charge');
        DBMS_OUTPUT.PUT_LINE(v_consumer_no || ' | ' || v_units_consumed || ' | Rs. ' || v_total_charge);

        -- Close the cursor
        CLOSE unit_charge_cur;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
