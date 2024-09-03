CREATE TABLE customerbank(ID NUMBER(5) NOT NULL PRIMARY KEY,bal NUMBER(10));

INSERT INTO customerbank VALUES (11, 19000);
INSERT INTO customerbank VALUES (14, 5500);
INSERT INTO customerbank VALUES (16, 65000);
INSERT INTO customerbank VALUES (18, 39000);
INSERT INTO customerbank VALUES (22, 500);

ALTER TABLE customerbank ADD Category VARCHAR(20);
