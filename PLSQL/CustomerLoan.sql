-- Create Customer Table
CREATE TABLE Customer (
    CustomerName VARCHAR2(100),
    CustomerID INT PRIMARY KEY,
    Address VARCHAR2(200),
    PhoneNumber VARCHAR2(15),
    PANCardNumber VARCHAR2(15)
);

-- Create Loan Table
CREATE TABLE Loan (
    LoanID INT PRIMARY KEY,
    LoanDate DATE,
    AmountPaid DECIMAL(10, 2),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


DECLARE
    v_customer_id INT;
    v_loan_date DATE;
    v_loan_id INT;
    v_amount_paid DECIMAL(10, 2);
    v_loan_date_loan DATE;
BEGIN
    -- Prompt user for CustomerID and LoanDate
    DBMS_OUTPUT.PUT_LINE('Enter CustomerID:');
    -- Accept user input
    v_customer_id := &customer_id;
    
    DBMS_OUTPUT.PUT_LINE('Enter Loan Date (YYYY-MM-DD):');
    -- Accept user input
    v_loan_date := TO_DATE('&loan_date', 'YYYY-MM-DD');

    -- Retrieve loan details for the specified customer and loan date
    FOR loan_record IN (
        SELECT l.LoanID, l.LoanDate, l.AmountPaid
        FROM Loan l
        WHERE l.CustomerID = v_customer_id
        AND l.LoanDate > v_loan_date
    ) LOOP
        v_loan_id := loan_record.LoanID;
        v_loan_date_loan := loan_record.LoanDate;
        v_amount_paid := loan_record.AmountPaid;

        -- Display loan details
        DBMS_OUTPUT.PUT_LINE('Loan ID: ' || v_loan_id || ', Loan Date: ' || v_loan_date_loan || ', Amount Paid: ' || v_amount_paid);
    END LOOP;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No loans found for CustomerID ' || v_customer_id || ' after ' || v_loan_date);
    END IF;
END;
/

