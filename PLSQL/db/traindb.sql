CREATE TABLE Train(TNO INT generated.always as identity(start with 1 increment by 1)primary key,Tname VARCHAR(20),TDate DATE,Destination VARCHAR(20),Seats INT);

INSERT INTO Train(Tname,TDate,Destination,Seats)VALUES('express1','16-apr-2024','mumbai',300);
INSERT INTO Train(Tname,TDate,Destination,Seats)VALUES('express2','16-apr-2024','chennai',250);
INSERT INTO Train(Tname,TDate,Destination,Seats)VALUES('express3','17-apr-2024','delhi',100);
INSERT INTO Train(Tname,TDate,Destination,Seats)VALUES('express4','19-apr-2024','kolkata',100);


select*from Train;

SQL>COMMIT;

INSERT INTO Train(Tname,TDate,Destination,Seats)VALUES('express5','20-apr-2024','goa',300);
select*from Train;

SQL>ROLLBACK;
select*from Train;
