-- Procedure to Reserve Tickets
CREATE OR REPLACE PROCEDURE ReserveTicket(
    p_train_number IN INT,
    p_seats IN INT
) AS
    v_available_seats INT;
BEGIN
    -- Check available seats
    SELECT Seats INTO v_available_seats
    FROM Train
    WHERE TNO = p_train_number;

    IF v_available_seats >= p_seats THEN
        -- Sufficient seats available, update the seat count
        UPDATE Train
        SET Seats = Seats - p_seats
        WHERE TNO = p_train_number;
        
        -- Commit the transaction
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE(p_seats || ' seat(s) reserved successfully.');
    ELSE
        -- Insufficient seats available
        DBMS_OUTPUT.PUT_LINE('There are not enough seats available.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('INVALID TRAIN NUMBER');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END ReserveTicket;
/

-- Procedure to Cancel Tickets
CREATE OR REPLACE PROCEDURE CancelTicket(
    p_train_number IN INT,
    p_seats_cancel IN INT
) AS
    v_rows_updated INT;
BEGIN
    -- Update seat count
    UPDATE Train
    SET Seats = Seats + p_seats_cancel
    WHERE TNO = p_train_number;

    
        -- Commit the transaction
        COMMIT;
        DBMS_OUTPUT.PUT_LINE(p_seats_cancel || ' seat(s) cancelled successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('INVALID TRAIN NUMBER');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END CancelTicket;
/

-- Display menu
BEGIN
    DBMS_OUTPUT.PUT_LINE('1. TICKET RESERVATION 2. TICKET CANCELLATION');
END;
/

-- Block to Execute Procedures Based on User Input
DECLARE
    train_no INT := &train_number;
    seat_need INT := &seats;
    ch INT := &choice;
BEGIN
    IF ch = 1 THEN
        ReserveTicket(train_no, seat_need);
    ELSIF ch = 2 THEN
        CancelTicket(train_no, seat_need);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid choice. Please select 1 or 2.');
    END IF;
END;
/
