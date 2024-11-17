-----------------------------------------------------------------
TABLE CREATION:
CREATE TABLE BOOKS (
    BookID INT PRIMARY KEY,
    Title VARCHAR2(255) NOT NULL,
    Author VARCHAR2(255),
    TotalCopies INT NOT NULL,
    AvailableCopies INT NOT NULL
);
CREATE TABLE MEMBERS (
    MemberID INT PRIMARY KEY,
    Name VARCHAR2(255) NOT NULL,
    MembershipDate DATE NOT NULL
);
CREATE TABLE BORROW (
    BorrowID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE,
    FINE NUMBER(6, 2) DEFAULT 0,
    FOREIGN KEY (BookID) REFERENCES BOOKS (BookID),
    FOREIGN KEY (MemberID) REFERENCES MEMBERS (MemberID)
);
-----------------------------------------------------------------------
INSERTION:
INSERT INTO BOOKS (BookID, Title, Author, TotalCopies, AvailableCopies) 
VALUES (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 5, 5);

INSERT INTO BOOKS (BookID, Title, Author, TotalCopies, AvailableCopies) 
VALUES (2, '1984', 'George Orwell', 3, 3);

INSERT INTO BOOKS (BookID, Title, Author, TotalCopies, AvailableCopies) 
VALUES (3, 'To Kill a Mockingbird', 'Harper Lee', 4, 4);

INSERT INTO BOOKS (BookID, Title, Author, TotalCopies, AvailableCopies) 
VALUES (4, 'Moby Dick', 'Herman Melville', 2, 2);

INSERT INTO BOOKS (BookID, Title, Author, TotalCopies, AvailableCopies) 
VALUES (5, 'Pride and Prejudice', 'Jane Austen', 6, 6);


INSERT INTO MEMBERS (MemberID, Name, MembershipDate) 
VALUES (1, 'Alice Johnson', TO_DATE('2023-05-15', 'YYYY-MM-DD'));

INSERT INTO MEMBERS (MemberID, Name, MembershipDate) 
VALUES (2, 'Bob Smith', TO_DATE('2024-01-22', 'YYYY-MM-DD'));

INSERT INTO MEMBERS (MemberID, Name, MembershipDate) 
VALUES (3, 'Charlie Brown', TO_DATE('2022-11-30', 'YYYY-MM-DD'));
-----------------------------------------------------------------------------------------------------------------
SQL> select*from books;

    BOOKID TITLE                                          AUTHOR                                            TOTALCOPIES AVAILABLECOPIES
----------------------------------------------------------------------------------------------------- ---------------------------------
         1 The Great Gatsby                              F. Scott Fitzgerald                                     5               5
         2 1984                                          George Orwell                                           3               3
         3 To Kill a Mockingbird                         Harper Lee                                              4               4
         4 Moby Dick                                     Herman Melville                                         2               2
         5 Pride and Prejudice                           Jane Austen                                             6               6

-----------------------------------------------------------------------------------------------------------------------------------------
SQL> ed c:\plsql\borrowtrigger.sql;

CREATE OR REPLACE TRIGGER CheckAvailableCopies
AFTER INSERT ON BORROW
FOR EACH ROW
DECLARE
  v_available_copies NUMBER;
BEGIN
  -- Get the available copies for the borrowed book
  SELECT AvailableCopies INTO v_available_copies
  FROM BOOKS
  WHERE BookID = :NEW.BookID;
  
  -- Check if available copies are greater than zero
  IF v_available_copies > 0 THEN
    -- Decrement the available copies in the BOOKS table
    UPDATE BOOKS
    SET AvailableCopies = AvailableCopies - 1
    WHERE BookID = :NEW.BookID;
  ELSE
    -- Raise an exception if there are no available copies
    RAISE_APPLICATION_ERROR(-20001, 'No available copies for this book');
  END IF;
END;
/

------------------------------------------------------------------------------------------------------------
INSERT INTO BORROW (BorrowID, BookID, MemberID, BorrowDate, ReturnDate)
VALUES (1, 1, 1, TO_DATE('2024-10-10', 'YYYY-MM-DD'), TO_DATE('2024-10-15', 'YYYY-MM-DD'));

INSERT INTO BORROW (BorrowID, BookID, MemberID, BorrowDate, ReturnDate)
VALUES (2, 2, 2, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-06', 'YYYY-MM-DD'));

INSERT INTO BORROW (BorrowID, BookID, MemberID, BorrowDate, ReturnDate)
VALUES (3, 3, 3, TO_DATE('2024-09-20', 'YYYY-MM-DD'), TO_DATE('2024-10-05', 'YYYY-MM-DD'));

INSERT INTO BORROW (BorrowID, BookID, MemberID, BorrowDate, ReturnDate)
VALUES (4, 4, 1, TO_DATE('2024-10-05', 'YYYY-MM-DD'), TO_DATE('2024-10-15', 'YYYY-MM-DD'));

INSERT INTO BORROW (BorrowID, BookID, MemberID, BorrowDate, ReturnDate)
VALUES (5, 5, 2, TO_DATE('2024-09-10', 'YYYY-MM-DD'), TO_DATE('2024-09-20', 'YYYY-MM-DD'));
------------------------------------------------------------------------------------------------------------------------------

SQL> select*from books;

    BOOKID TITLE                           AUTHOR                               TOTALCOPIES AVAILABLECOPIES
---------- -------------------------------------------------------------------------------------------------
         1 The Great Gatsby                F. Scott Fitzgerald                      5               4
         2 1984                            George Orwell                            3               2
         3 To Kill a Mockingbird           Harper Lee                               4               3
         4 Moby Dick                       Herman Melville                          2               1
         5 Pride and Prejudice             Jane Austen                              6               5

------------------------------------------------------------------------------------------------------------------------------
borrow.sql
CREATE OR REPLACE PROCEDURE CheckOverdueBooks IS
  CURSOR overdue_books_cursor IS
    SELECT BorrowID, BookID, ReturnDate
    FROM BORROW
    WHERE ReturnDate < SYSDATE AND ReturnDate IS NOT NULL;
  
  v_fine NUMBER;
BEGIN
  FOR overdue_record IN overdue_books_cursor LOOP
    -- Calculate the fine: $2 per day past the due date
    v_fine := (SYSDATE - overdue_record.ReturnDate) * 2;
    
    -- Update the fine for the overdue book in the BORROW table
    UPDATE BORROW
    SET FINE = v_fine
    WHERE BorrowID = overdue_record.BorrowID;
    
    COMMIT; -- Commit the changes after each update
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('Overdue books fines updated successfully.');
END;
/
-------------------------------------------------------------------------------------

SQL> ed c:\plsql\borrow.sql;
SQL> exec CheckOverdueBooks
Overdue books fines updated successfully.
PL/SQL procedure successfully completed.
SQL> @c:\plsql\borrow.sql;
Procedure created.
SQL> SELECT * FROM BORROW;

  BORROWID     BOOKID   MEMBERID BORROWDAT RETURNDAT       FINE
---------- ---------- ---------- --------- --------- ----------
         1          1          1 10-OCT-24 15-OCT-24      65.25
         2          2          2 01-NOV-24 06-NOV-24      21.25
         3          3          3 20-SEP-24 05-OCT-24      85.25
         4          4          1 05-OCT-24 15-OCT-24      65.25
         5          5          2 10-SEP-24 20-SEP-24     115.25


-------------------------------------------------------------------------------------------

SQL_QUERIES:

(i) Count the Total Number of Books Borrowed by Each Member:
SELECT MemberID, COUNT(*) AS TotalBooksBorrowed
FROM BORROW
GROUP BY MemberID;
(ii) List All Books with Less Than 5 Available Copies:
SELECT BookID, Title, AvailableCopies
FROM BOOKS
WHERE AvailableCopies < 5;
(iii) Find the Top 3 Members with the Highest Total Fines:
SELECT MemberID, SUM(FINE) AS TotalFines
FROM BORROW
GROUP BY MemberID
ORDER BY TotalFines DESC
FETCH FIRST 3 ROWS ONLY;
