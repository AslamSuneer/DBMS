TABLE CREATION:
CREATE TABLE Train (TNO INT AUTO_INCREMENT PRIMARY KEY,Tname VARCHAR(20),TDate DATE,Destination VARCHAR(20),Seats INT);

INSERTION:
INSERT INTO Train(Tname, TDate, Destination, Seats)VALUES ('express1', '2024-04-16', 'mumbai', 300);

INSERT INTO Train(Tname, TDate, Destination, Seats)VALUES ('express2', '2024-04-16', 'chennai', 250);

INSERT INTO Train(Tname, TDate, Destination, Seats)VALUES ('express3', '2024-04-17', 'delhi', 100);

INSERT INTO Train(Tname, TDate, Destination, Seats)VALUES ('express4', '2024-04-19', 'kolkata', 100);

select*from Train;

SQL>COMMIT;

INSERT INTO Train(Tname,TDate,Destination,Seats)VALUES('express5','20-apr-2024','goa',300);
select*from Train;

SQL>ROLLBACK;
select*from Train;
