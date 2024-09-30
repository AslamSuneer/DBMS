TABLE CRAETION:
CREATE TABLE Student(roll_number INT,name VARCHAR(50),s1_grade INT,s2_grade INT);

SQL> desc Student;
 Name						       Null?	Type
 ----------------------------------------------------- -------- ------------------------------------
 ROLL_NUMBER							NUMBER(38)
 NAME								VARCHAR2(50)
 S1_GRADE							NUMBER(38)
 S2_GRADE							NUMBER(38)


TABLE INSERTION:
INSERT INTO Student values(101,'John doe',9,9);
INSERT INTO Student values(102,'Jone Smith',1,7);
INSERT INTO Student values(103,'Alice Johnson',2,6);
INSERT INTO Student values(104,'Bob Smith',7,8);
INSERT INTO Student values(105,'Emma Watson',8,6);

SQL> select *from Student;

ROLL_NUMBER NAME						 S1_GRADE   S2_GRADE
----------- -------------------------------------------------- ---------- ----------
	101 John doe							9	   9
	102 Jone Smith							1	   7
	103 Alice Johnson						2	   6
	104 Bob Smith							7	   8
	105 Emma Watson 						8	   6

OUTPUT:

SQL> @/home/dspl33/aslam/StudentTrigger.sql;

Trigger created.

1.SQL> insert into Student values(109,'rohan',10,20);
Operation: Insert; Action/Message: Inserting rohan

1 row created.

SQL> select*from Student;

ROLL_NUMBER NAME						 S1_GRADE   S2_GRADE
----------- -------------------------------------------------- ---------- ----------
	101 John doe							9	   9
	102 Jone Smith							1	   7
	103 Alice Johnson						2	   6
	104 Bob Smith							7	   8
	105 Emma Watson 						8	   6
	109 rohan						       10	  20

6 rows selected.

2.SQL> update Student set s1_grade=10 where roll_number=102;
Operation: Update; Action/Message: Updated name remains Jone Smith

1 row updated.

SQL> select*from Student;

ROLL_NUMBER NAME						 S1_GRADE   S2_GRADE
----------- -------------------------------------------------- ---------- ----------
	101 John doe							9	   9
	102 Jone Smith					 10	   7
	103 Alice Johnson						2	   6
	104 Bob Smith							7	   8
	105 Emma Watson 						8	   6
	109 rohan						       10	  20

6 rows selected.

3.SQL> delete from Student where roll_number=109;
Operation: Delete; Action/Message: Deleting rohan

1 row deleted.

SQL> select*from Student;

ROLL_NUMBER NAME						 S1_GRADE   S2_GRADE
----------- -------------------------------------------------- ---------- ----------
	101 John doe							9	   9
	102 Jone Smith							1	   7
	103 Alice Johnson						2	   6
	104 Bob Smith							7	   8
	105 Emma Watson 		
