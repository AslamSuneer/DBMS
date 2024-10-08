CREATE OR REPLACE PACKAGE BODY Employee_Package AS

    -- Add an employee
    PROCEDURE Add_Employee(p_Eid IN INT, p_Ename IN VARCHAR2, p_Eaddress IN VARCHAR2, p_Esalary IN DECIMAL) AS
    BEGIN
        INSERT INTO Employee (Eid, Ename, Eaddress, Esalary)
        VALUES (p_Eid, p_Ename, p_Eaddress, p_Esalary);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Employee ' || p_Ename || ' added successfully with ID ' || p_Eid || '.');
    END Add_Employee;

    -- Delete an employee
    PROCEDURE Delete_Employee(p_Eid IN INT) AS
    BEGIN
        DELETE FROM Employee WHERE Eid = p_Eid;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Employee with ID ' || p_Eid || ' deleted successfully.');
    END Delete_Employee;

    -- List all employees
    PROCEDURE List_Employees AS
        CURSOR emp_cursor IS
            SELECT Eid, Ename, Eaddress, Esalary FROM Employee;
        v_emp emp_cursor%ROWTYPE;
    BEGIN
        OPEN emp_cursor;
        LOOP
            FETCH emp_cursor INTO v_emp;
            EXIT WHEN emp_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp.Eid || ', Name: ' || v_emp.Ename || ', Address: ' || v_emp.Eaddress || ', Salary: ' || v_emp.Esalary);
        END LOOP;
        CLOSE emp_cursor;
    END List_Employees;

    -- Get salary of an employee
    FUNCTION Get_Salary(p_Eid IN INT) RETURN DECIMAL AS
        v_salary DECIMAL(10, 2);
    BEGIN
        SELECT Esalary INTO v_salary FROM Employee WHERE Eid = p_Eid;
        RETURN v_salary;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Employee with ID ' || p_Eid || ' not found.');
            RETURN NULL;
    END Get_Salary;

END Employee_Package;
/

------------------------
------------------------
EmployeePackageMain.sql
------------------------

SET SERVEROUTPUT ON;

DECLARE
    v_salary DECIMAL(10, 2);
    v_emp_id_for_salary INT := &employee_id_for_salary;  -- Prompt for employee ID to get salary
    v_emp_id_for_deletion INT := &employee_id_for_deletion;  -- Prompt for employee ID to delete
BEGIN
    -- Add employees
    Employee_Package.Add_Employee(1, 'Alice Johnson', '101 Maple St', 55000);
    Employee_Package.Add_Employee(2, 'Bob Smith', '202 Oak St', 60000);
    Employee_Package.Add_Employee(3, 'Charlie Brown', '303 Pine St', 50000);
    
    -- List all employees
    Employee_Package.List_Employees;
    
    -- Get salary of an employee
    v_salary := Employee_Package.Get_Salary(v_emp_id_for_salary);  -- Get salary for user-specified employee ID
    IF v_salary IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Salary of Employee ID ' || v_emp_id_for_salary || ': ' || v_salary);
    END IF;
    
    -- Delete an employee
    Employee_Package.Delete_Employee(v_emp_id_for_deletion);  -- Delete employee with user-specified ID
    
    -- List employees again
    Employee_Package.List_Employees;
END;
/
