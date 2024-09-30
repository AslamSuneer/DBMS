CREATE OR REPLACE TRIGGER StudentTrigger
AFTER INSERT OR DELETE OR UPDATE ON Student
FOR EACH ROW
DECLARE
    v_action_msg VARCHAR(100);
BEGIN
    IF INSERTING THEN
        v_action_msg := 'Inserting ' || :NEW.name;
    ELSIF DELETING THEN
        v_action_msg := 'Deleting ' || :OLD.name;
    ELSIF UPDATING THEN
        IF :OLD.name != :NEW.name THEN
            v_action_msg := 'Updated to ' || :NEW.name;
        ELSE
            v_action_msg := 'Updated name remains ' || :NEW.name;
        END IF;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Operation: ' || CASE 
        WHEN INSERTING THEN 'Insert'
        WHEN DELETING THEN 'Delete'
        WHEN UPDATING THEN 'Update'
    END || '; Action/Message: ' || v_action_msg);
END;
/


