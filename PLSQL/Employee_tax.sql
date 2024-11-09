-- Assuming the EMP_TABLE has empid, name, deptid, salary columns
CREATE OR REPLACE TRIGGER trg_insert_tax
AFTER INSERT ON EMP_TABLE
FOR EACH ROW
DECLARE
    calculated_tax DECIMAL(10, 2);
BEGIN
    -- Calculate tax based on salary
    IF :NEW.salary <= 5000 THEN
        calculated_tax := :NEW.salary * 0.10; -- 10% tax
    ELSIF :NEW.salary > 5000 AND :NEW.salary <= 10000 THEN
        calculated_tax := :NEW.salary * 0.20; -- 20% tax
    ELSIF :NEW.salary > 10000 AND :NEW.salary <= 15000 THEN
        calculated_tax := :NEW.salary * 0.30; -- 30% tax
    ELSE
        calculated_tax := 0; -- If salary is above 15000, no tax is calculated.
    END IF;

    -- Insert the calculated tax into TAX_TABLE
    INSERT INTO TAX_TABLE (eid, deptid, tax) 
    VALUES (:NEW.empid, :NEW.deptid, calculated_tax);
    
    DBMS_OUTPUT.PUT_LINE('Tax for Employee ID ' || :NEW.empid || ' is: ' || calculated_tax);
END;
/
