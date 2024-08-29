CREATE TABLE Students(roll_number INT,name VARCHAR(50),s1_grade INT,s2_grade INT);


SQL> desc Students;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ROLL_NUMBER                                        NUMBER(38)
 NAME                                               VARCHAR2(50)
 S1_GRADE                                           NUMBER(38)
 S2_GRADE                                           NUMBER(38)

INSERT INTO Students VALUES(101,'John Doe',9,9);
INSERT INTO Students VALUES(102,'Jane Smith',1,7);
INSERT INTO Students VALUES(103,'Alice Johnson',2,6);
INSERT INTO Students VALUES(104,'Bob Smith',7,8);
INSERT INTO Students VALUES(105,'Emma Watson',8,6);

SQL> select *from Students;

ROLL_NUMBER NAME                                                 S1_GRADE   S2_GRADE
----------- -------------------------------------------------- ---------- ----------
        101 John Doe                                                    9          9
        102 Jane Smith                                                  1          7
        103 Alice Johnson                                               2          6
        104 Bob Smith                                                   7          8
        105 Emma Watson                                                 8          6
