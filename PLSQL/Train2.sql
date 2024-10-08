procedure1
------------
CREATE OR REPLACE PROCEDURE ReserveTicket (
    P_train_number IN INT,
    p_seats_needed IN INT
) AS
    v_available_seats INT;
BEGIN
    -- Check available seats for the specified train number
    SELECT Seats INTO v_available_seats
    FROM Train
    WHERE TNO = P_train_number;

    -- If seats are available, reserve them
    IF v_available_seats >= p_seats_needed THEN
        UPDATE Train
        SET Seats = Seats - p_seats_needed
        WHERE TNO = P_train_number;
        
        COMMIT;

        DBMS_OUTPUT.PUT_LINE(p_seats_needed || ' seats reserved successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sorry, not enough seats available.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid train number');
END ReserveTicket;
/
procedure 2
--------------------------
CREATE OR REPLACE PROCEDURE CancelTicket (
    p_train_number IN INT,
    p_seats_cancel IN INT
) AS
BEGIN
    -- Update the Seats column by adding the cancelled seats
    UPDATE Train
    SET Seats = Seats + p_seats_cancel
    WHERE TNO = p_train_number;

    -- Check if any rows were updated
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid train number');
    ELSE
        COMMIT;  -- Commit the changes only if the update was successful
        DBMS_OUTPUT.PUT_LINE(p_seats_cancel || ' seats cancelled successfully');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END CancelTicket;
/

main program(Separate file)
-----------------------
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('1. TICKET RESERVATION');
    DBMS_OUTPUT.PUT_LINE('2. TICKET CANCELLATION');
END;
/

DECLARE
    train_no INT := &train_number;   -- Prompt for train number
    seat_need INT := &seats_needed;   -- Prompt for seats needed
    ch INT := &choice;                -- Prompt for choice
BEGIN
    IF ch = 1 THEN
        ReserveTicket(train_no, seat_need);
    ELSIF ch = 2 THEN
        CancelTicket(train_no, seat_need);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid choice. Please enter 1 for reservation or 2 for cancellation.');
    END IF;
END;
/


TABLES CREATION:
----------

CREATE TABLE Train (
    TNO INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    Tname VARCHAR(20),
    TDate DATE,
    Destination VARCHAR(20),
    Seats INT
);


-- Insert some sample train records with default Oracle date format
INSERT INTO Train (Tname, TDate, Destination, Seats)
VALUES ('Express1', '15-OCT-2024', 'City A', 200);

INSERT INTO Train (Tname, TDate, Destination, Seats)
VALUES ('Express2', '01-NOV-2024', 'City B', 150);

INSERT INTO Train (Tname, TDate, Destination, Seats)
VALUES ('Express3', '05-DEC-2024', 'Mountain Town', 120);

INSERT INTO Train (Tname, TDate, Destination, Seats)
VALUES ('Express4', '20-OCT-2024', 'Coastal City', 180);

INSERT INTO Train (Tname, TDate, Destination, Seats)
VALUES ('Express5', '15-NOV-2024', 'City C', 250);
