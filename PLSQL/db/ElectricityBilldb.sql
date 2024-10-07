CREATE TABLE electricity_charge (unit_consumed VARCHAR(10) NOT NULL PRIMARY KEY,charge NUMBER(10));

SQL> desc electricity_charge;
 Name			 Null?	  Type
 ----------------------- -------- ----------------
 UNIT_CONSUMED		 NOT NULL VARCHAR2(10)
 CHARGE 			  NUMBER(10)


insert into electricity_charge values('1-100', 5);
insert into electricity_charge values('101-300', 7.5);
insert into electricity_charge values('301-500', 15);
insert into electricity_charge values('>501', 22.5);

SQL> select *from electricity_charge;

UNIT_CONSU     CHARGE
---------- ----------
1-100		    5
101-300 	    8
301-500 	   15
>501		   23


create table bill_user(user_id NUMBER(5) NOT NULL PRIMARY KEY,user_name VARCHAR(30),unit_consumed NUMBER(10));

SQL> desc bill_user;
 Name			 Null?	  Type
 ----------------------- -------- ----------------
 USER_ID		 NOT NULL NUMBER(5)
 USER_NAME			  VARCHAR2(30)
 UNIT_CONSUMED			  NUMBER(10)

INSERTION:
insert into bill_user values(101, 'Alan',146);
insert into bill_user values(102, 'Henry', 565);
insert into bill_user values(103, 'John', 145);
insert into bill_user values(104, 'Evan', 77);
insert into bill_user values (105, 'Marco', 57);
insert into bill_user values (106, 'Greek', 132);
insert into bill_user values (107, 'Bro', 801);
insert into bill_user values (108, 'Ivan', 99);
insert into bill_user values (303, 'Jill', 222);
insert into bill_user values (305, 'Kelvin', 399); 
insert into bill_user values (310, 'Calvin', 499);

SQL>  select*from bill_user;

   USER_ID USER_NAME			  UNIT_CONSUMED
---------- ------------------------------ -------------
       101 Alan 				    146
       102 Henry				    565
       103 John 				    145
       104 Evan 				     77
       105 Marco				     57
       106 Greek				    132
       107 Bro					    801
       108 Ivan 				     99
       303 Jill 				    222
       305 Kelvin				    399
       310 Calvin				    499

11 rows selected.
