CREATE OR REPLACE PROCEDURE debit(p_acno IN NUMBER,
p_debit_amount IN NUMBER)AS
current_balance NUMBER;
amount_to_debited INT;
new_balance INT;
min_balance CONSTANT NUMBER=500;
BEGIN
 SELECT bal INTO current_balance FROM acc WHERE acno=p_acno;
 IF current_balance-p_debit_amount<min_balance THEN
  dbms_output.put_line('Insufficient balance to debit'||min_balance||'from the account'||p_acno);
 ELSE
  UPDATE acc SET bal=current_balance-p_debit_amount WHERE acno=p_acno;
  dbms_output.put_line('Amount has been debited');
  SELECT bal INTO new_balance FROM acc WHERE acno=p_acno;
  dbms_output.put_line('Latest Updated BANK BALANCE'||new_balance);
 ENDIF;
END;


CREATE OR REPLACE PROCEDURE credit(p_acno IN NUMBER,
p_credit_amount IN NUMBER)AS
current_balance NUMBER;
amount_to_credited INT;
new_balance INT;
min_balance CONSTANT NUMBER=30000;
BEGIN
 SELECT bal INTO current_balance FROM acc WHERE acno=p_acno;
 
 
 IF current_balance+p_credit_amount>max_balance THEN
    dbms_output.put_line('Exceeded Banking Limit of||max_balance||'from the account'||p_acno);
 ELSE
   UPDATE acc SET bal=current_balance+p_credit_amount WHERE acno=p_acno;
   dbms_output.put_line('Amount has been credited');
   SELECT bal INTO new_balance FROM acc WHERE acno=p_acno;
   dbms_output.put_line('Latest Updated BANK BALANCE after credit'||new_balance);
 ENDIF;
END;  


CREATE OR REPLACE FUNCTION dc (amount IN NUMBER)
RETURN VARCHAR2 IS
 category VARCHAR2(30);
BEGIN
 IF amount>50000 THEN
   category:='Platinum';
 ELSEIF amount>10000 AND amount<=50000 THEN
   category:='GOLD';
 ELSE 
   category:='Silver';
 ENDIF;
 RETURN category;
END;


CREATE OR REPLACE PROCEDURE show_balance(p_acno IN NUMBER)AS present_balance NUMBER;
BEGIN
  SELECT bal INTO present_balance FROM acc WHERE acno=p_acno;
  dbms_output.put_line('BANK BALANCE of the account'||p_acno||'is'||present_balance);
   dbms_output.put_line('*');
    dbms_output.put_line('Account Category:'||dc(present_balance));
END;


BEGIN
  dbms_output.put_line('1.Debit 2.Credit');
END;


DECLARE
 v_acno NUMBER:=&account;
 v_debit_amount NUMBER:=&amount;
 ch NUMBER:=&CHOICE;
BEGIN
 IF ch=1 THEN
  debit(v_acno,v_debit_amount);
  show_balance(v_acno);
 ELSIF ch=2 THEN
  credit(v_acno,v_debit_amount);
  show_balance(v_acno);
 END IF;
END;

