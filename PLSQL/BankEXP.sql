SET SERVEROUTPUT ON
DECLARE
    balance Number(10);
    PROCEDURE categorize_customer (ID IN NUMBER, bal IN NUMBER) IS
    BEGIN        
        IF bal <= 10000 THEN
            update customerbank set Category = 'Silver' where ID = categorize_customer.ID;
        ELSIF bal <= 50000 THEN
            update customerbank set Category= 'Gold' where ID = categorize_customer.ID;
        ELSE
            update customerbank set Category= 'Platinum' where ID = categorize_customer.ID;
        END IF;
    END;
BEGIN
    FOR customer_rec IN (SELECT ID, bal FROM customerbank) LOOP
        categorize_customer(customer_rec.ID, customer_rec.bal);
    END LOOP;

    FOR customer_rec IN (SELECT ID, bal, Category FROM customerbank) loop
        DBMS_OUTPUT.PUT_LINE('CustomerID: ' || customer_rec.ID ||', Balance: '||customer_rec.bal ||', Category: ' || customer_rec.Category);
    END LOOP;
END;
/

