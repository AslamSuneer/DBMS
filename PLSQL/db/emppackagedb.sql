TABLE CREATION:

CREATE TABLE Employee (Eid INT PRIMARY KEY,Ename VARCHAR(50),Eaddress VARCHAR(100),Esalary DECIMAL(10, 2));

SQL> desc Employee;
 Name										     Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 EID										     NOT NULL NUMBER(38)
 ENAME											      VARCHAR2(50)
 EADDRESS										      VARCHAR2(100)
 ESALARY										      NUMBER(10,2)
 

CREATE OR REPLACE PACKAGE Employee_Package AS
    PROCEDURE Add_Employee(p_Eid IN INT, p_Ename IN VARCHAR2, p_Eaddress IN VARCHAR2, p_Esalary IN DECIMAL);
    PROCEDURE Delete_Employee(p_Eid IN INT);
    PROCEDURE List_Employees;
    FUNCTION Get_Salary(p_Eid IN INT) RETURN DECIMAL;
END Employee_Package;
/
Package created.




