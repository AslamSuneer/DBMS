---------------------------------------
TABLE CREATION:
CREATE TABLE GUEST (
    Name VARCHAR2(100),
    Address VARCHAR2(200),
    RoomNo NUMBER,
    Check_in_date DATE,
    Check_out_date DATE
);

CREATE TABLE BILL (
    Name VARCHAR2(100),
    BillAmount NUMBER
);

CREATE TABLE ROOM (
    RoomNo NUMBER,
    Charge_per_day NUMBER
);

CREATE TABLE HISTORY (
    Name VARCHAR2(100),
    Check_out_date DATE
);
-----------------------------------------
INSERTION:
INSERT INTO GUEST (Name, Address, RoomNo, Check_in_date, Check_out_date)
VALUES ('John Doe', '123 Main St, Springfield', 101, TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_DATE('2024-11-20', 'YYYY-MM-DD'));

INSERT INTO GUEST (Name, Address, RoomNo, Check_in_date, Check_out_date)
VALUES ('Jane Smith', '456 Elm St, Gotham', 102, TO_DATE('2024-11-16', 'YYYY-MM-DD'), TO_DATE('2024-11-18', 'YYYY-MM-DD'));

INSERT INTO GUEST (Name, Address, RoomNo, Check_in_date, Check_out_date)
VALUES ('Alice Johnson', '789 Oak St, Metropolis', 103, TO_DATE('2024-11-14', 'YYYY-MM-DD'), TO_DATE('2024-11-19', 'YYYY-MM-DD'));

INSERT INTO ROOM (RoomNo, Charge_per_day)
VALUES (101, 1500);

INSERT INTO ROOM (RoomNo, Charge_per_day)
VALUES (102, 2000);

INSERT INTO ROOM (RoomNo, Charge_per_day)
VALUES (103, 2500);
-----------------------------------------------------------------------------------------------------------------------------------------------
room.sql:
CREATE OR REPLACE PROCEDURE GenerateBillAndReport IS
    v_BillAmount NUMBER;
    v_TotalRevenue NUMBER := 0;
    v_UniqueGuests NUMBER;
BEGIN
    -- Cursor to calculate bills
    FOR guest_rec IN (SELECT g.Name, g.RoomNo, g.Check_in_date, g.Check_out_date, r.Charge_per_day
                      FROM GUEST g
                      JOIN ROOM r ON g.RoomNo = r.RoomNo) LOOP
        DBMS_OUTPUT.PUT_LINE('Processing guest: ' || guest_rec.Name);
        
        -- Calculate the bill amount
        v_BillAmount := (guest_rec.Check_out_date - guest_rec.Check_in_date) * guest_rec.Charge_per_day;
        DBMS_OUTPUT.PUT_LINE('Calculated bill for ' || guest_rec.Name || ': ' || v_BillAmount);
        
        -- Insert into the BILL table
        INSERT INTO BILL (Name, BillAmount)
        VALUES (guest_rec.Name, v_BillAmount);
        
        -- Insert into the HISTORY table
        INSERT INTO HISTORY (Name, Check_out_date)
        VALUES (guest_rec.Name, guest_rec.Check_out_date);

        -- Increment total revenue
        v_TotalRevenue := v_TotalRevenue + v_BillAmount;
    END LOOP;

    -- Calculate unique guests checked out for the current month
    SELECT COUNT(DISTINCT Name)
    INTO v_UniqueGuests
    FROM HISTORY
    WHERE EXTRACT(MONTH FROM Check_out_date) = EXTRACT(MONTH FROM SYSDATE)
      AND EXTRACT(YEAR FROM Check_out_date) = EXTRACT(YEAR FROM SYSDATE);

    -- Display the monthly report
    DBMS_OUTPUT.PUT_LINE('Total Revenue for the Current Month: ' || v_TotalRevenue);
    DBMS_OUTPUT.PUT_LINE('Number of Unique Guests Checked Out: ' || v_UniqueGuests);

    -- Commit the changes
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SQL> @c:\plsql\room.sql
Procedure created.
--------------------------------------------------------------------------------------
    OUTPUT:-
--------------------------------------------------------------------------------------

SQL> SET SERVEROUTPUT ON;
SQL> EXEC GenerateBillAndReport;
Processing guest: John Doe
Calculated bill for John Doe: 7500
Processing guest: Jane Smith
Calculated bill for Jane Smith: 4000
Processing guest: Alice Johnson
Calculated bill for Alice Johnson: 12500
Total Revenue for the Current Month: 24000
Number of Unique Guests Checked Out: 3
PL/SQL procedure successfully completed.

SQL> select *from history;

NAME                                                                             CHECK_OUT
-------------------------------------------------------------------------------- ---------
John Doe                                                                         20-NOV-24
Jane Smith                                                                       18-NOV-24
Alice Johnson                                                                    19-NOV-24
John Doe                                                                         20-NOV-24
Jane Smith                                                                       18-NOV-24
Alice Johnson                                                                    19-NOV-24

6 rows selected.

SQL> select *from bill;

NAME                                                                                                 BILLAMOUNT
---------------------------------------------------------------------------------------------------- ----------
John Doe                                                                                                   7500
Jane Smith                                                                                                 4000
Alice Johnson                                                                                             12500
John Doe                                                                                                   7500
Jane Smith                                                                                                 4000
Alice Johnson                                                                                             12500

6 rows selected.


SQL_QUERIES:
(i) Find all guests who stayed in rooms with a daily charge greater than a specified amount (e.g., 1000):
SQL>SELECT G.Name
FROM GUEST G
JOIN ROOM R ON G.RoomNo = R.RoomNo
WHERE R.CHARGE_PER_DAY > 1000;
(ii) Find the room number with the maximum average bill amount:
SQL>SELECT ROOMNO FROM (
    SELECT G.RoomNo, AVG(B.Billamount) AS avg_bill
    FROM GUEST G
    JOIN BILL B ON G.Name = B.Name
    GROUP BY G.RoomNo
    ORDER BY avg_bill DESC
)
WHERE ROWNUM = 1;
(iii) List rooms that have not been occupied in the last three months:
SQL>SELECT R.RoomNo
FROM ROOM R
WHERE R.RoomNo NOT IN (
    SELECT G.RoomNo
    FROM GUEST G
    WHERE G.check_in_date > ADD_MONTHS(SYSDATE, -3)
);
