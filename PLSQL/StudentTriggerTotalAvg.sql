-- Create the Student table
CREATE TABLE Student (
    Sid INT PRIMARY KEY,
    name VARCHAR(50),
    Subj1 INT,
    Subj2 INT,
    Subj3 INT,
    Total INT DEFAULT 0,
    Avg DECIMAL(5, 2) DEFAULT 0.00
);

-- Create the trigger
CREATE TRIGGER calculate_total_avg
BEFORE INSERT ON Student
FOR EACH ROW
BEGIN
    SET NEW.Total = NEW.Subj1 + NEW.Subj2 + NEW.Subj3;
    SET NEW.Avg = (NEW.Subj1 + NEW.Subj2 + NEW.Subj3) / 3;
END;

-- Insert sample data
INSERT INTO Student (Sid, name, Subj1, Subj2, Subj3) 
VALUES (1, 'John Doe', 80, 90, 85);
INSERT INTO Student (Sid, name, Subj1, Subj2, Subj3) 
VALUES (2, 'Jane Smith', 70, 75, 80);
INSERT INTO Student (Sid, name, Subj1, Subj2, Subj3) 
VALUES (3, 'Alice Johnson', 85, 95, 90);

-- View the data
SELECT * FROM Student;
