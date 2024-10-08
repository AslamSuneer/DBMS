TABLE CREATION:
Create table Train(TNO NUMBER PRIMARY KEY,Tname VARCHAR2(20),TDate DATE,Destination VARCHAR2(20),Seats NUMBER);

Table created.

SQL> CREATE SEQUENCE TrainSeq START WITH 1 INCREMENT BY 1;

Sequence created.

SQL> desc Train;
 Name										     Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 TNO										     NOT NULL NUMBER
 TNAME										      VARCHAR2(20)
 TDATE										      DATE
 DESTINATION									      VARCHAR2(20)
 SEATS										      NUMBER


INSERTION:
INSERT INTO Train(TNO,Tname, TDate, Destination, Seats)VALUES (TrainSeq.NEXTVAL,'express1',TO_DATE('15-OCT-2024','DD-MON-YYYY'), 'mumbai', 300);

INSERT INTO Train(TNO,Tname, TDate, Destination, Seats)VALUES (TrainSeq.NEXTVAL,'express2',TO_DATE('16-OCT-2024','DD-MON-YYYY'), 'chennai', 250);

INSERT INTO Train(TNO,Tname, TDate, Destination, Seats)VALUES (TrainSeq.NEXTVAL,'express3', TO_DATE('17-OCT-2024','DD-MON-YYYY'),'delhi', 100);

INSERT INTO Train(TNO,Tname, TDate, Destination, Seats)VALUES (TrainSeq.NEXTVAL,'express4', TO_DATE('19-OCT-2024','DD-MON-YYYY'),'kolkata', 100);

select*from Train;

       TNO TNAME		TDATE		   DESTINATION		     SEATS
---------- -------------------- ------------------ -------------------- ----------
	 1 express1		15-OCT-24	   mumbai		       300
	 2 express2		16-OCT-24	   chennai		       250
	 3 express3		17-OCT-24	   delhi		       100
	 4 express4		19-OCT-24	   kolkata		       100


SQL>COMMIT;

INSERT INTO Train(TNO,Tname,TDate,Destination,Seats)VALUES(TrainSeq.NEXTVAL,'express5', TO_DATE('20-OCT-2024','DD-MON-YYYY'),'goa',300);

SQL> select*from Train;

       TNO TNAME		TDATE		   DESTINATION		     SEATS
---------- -------------------- ------------------ -------------------- ----------
	 1 express1		15-OCT-24	   mumbai		       300
	 2 express2		16-OCT-24	   chennai		       250
	 3 express3		17-OCT-24	   delhi		       100
	 4 express4		19-OCT-24	   kolkata		       100
	 5 express5		20-OCT-24	   goa			       300



SQL> ROLLBACK;

Rollback complete.


SQL> select*from Train;

       TNO TNAME		TDATE		   DESTINATION		     SEATS
---------- -------------------- ------------------ -------------------- ----------
	 1 express1		15-OCT-24	   mumbai		       300
	 2 express2		16-OCT-24	   chennai		       250
	 3 express3		17-OCT-24	   delhi		       100
	 4 express4		19-OCT-24	   kolkata		       100

