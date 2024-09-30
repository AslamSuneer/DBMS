-- Create the Student table
CREATE TABLE Student (Sid INT PRIMARY KEY,name VARCHAR(50),Subj1 INT,Subj2 INT,Subj3 INT,Total INT DEFAULT 0,Avg DECIMAL(5, 2) DEFAULT 0.00
);

CREATE OR REPLACE TRIGGER calculate_total_avg
BEFORE INSERT ON Student
FOR EACH ROW
BEGIN
    -- Calculate the total of the marks for Subj1, Subj2, and Subj3
    --:NEW.Total := :NEW.Subj1 + :NEW.Subj2 + :NEW.Subj3;
    
    -- Calculate the average of the marks
   -- :NEW.Avg := :NEW.Total / 3;
    SET NEW.Total = NEW.Subj1 + NEW.Subj2 + NEW.Subj3;
    SET NEW.Avg = (NEW.Subj1 + NEW.Subj2 + NEW.Subj3) / 3;
END;

INSERT INTO Student (Sid, name, Subj1, Subj2, Subj3) 
VALUES (1, 'John Doe', 80, 90, 85);
INSERT INTO Student (Sid, name, Subj1, Subj2, Subj3) 
VALUES (2, 'Jane Smith', 70, 75, 80);
INSERT INTO Student (Sid, name, Subj1, Subj2, Subj3) 
VALUES (3, 'Alice Johnson', 85, 95, 90);

