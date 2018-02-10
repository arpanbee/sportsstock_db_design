CREATE TABLE users 
  ( 
     userid   NUMBER(8) CONSTRAINT user_pk PRIMARY KEY, 
     username VARCHAR2(12) CONSTRAINT user_nn_usrname NOT NULL CONSTRAINT 
     user_uq_username UNIQUE, 
     email    VARCHAR2(20) CONSTRAINT user_nn_email NOT NULL CONSTRAINT 
     user_ck_email 
     CHECK (email LIKE ( 
     '%@%')) 
  ) 

CREATE TABLE transactions 
  ( 
     tranid   NUMBER(8) CONSTRAINT tran_pk PRIMARY KEY, 
     trandate DATE CONSTRAINT tran_nn_date NOT NULL, 
     tranusr  NUMBER(8) CONSTRAINT tran_nn_user NOT NULL CONSTRAINT tran_fk_user 
     REFERENCES users(userid 
     ) 
  ) 

CREATE TABLE events 
  ( 
     eventid NUMBER(8) CONSTRAINT events_pk PRIMARY KEY, 
     dateof  DATE CONSTRAINT events_nn_date NOT NULL, 
     sport   VARCHAR2(140) CONSTRAINT events_nn_sport NOT NULL 
  ) 

CREATE TABLE propositions 
  ( 
     propid   NUMBER(8) CONSTRAINT prop_pk PRIMARY KEY, 
     propname VARCHAR2(140) CONSTRAINT prop_nn_name NOT NULL, 
     event    NUMBER(8) CONSTRAINT prop_nn_event NOT NULL CONSTRAINT 
     prop_fk_event 
     REFERENCES events( 
     eventid) 
  ) 

CREATE TABLE contracts 
  ( 
     proposition NUMBER(8) CONSTRAINT contract_fk_prop REFERENCES propositions( 
     propid 
     ), 
     contractid  NUMBER(8), 
          CONSTRAINT contract_pk PRIMARY KEY (proposition, contractid), 
          description VARCHAR2(140) CONSTRAINT contract_nn_desc NOT NULL, 
          outcome     VARCHAR2(24) CONSTRAINT contract_nn_outcome NOT NULL, 
     CONSTRAINT contract_ck_outcome CHECK (outcome IN ('WIN', 'LOSS', 'OPEN')) 
  ) 

CREATE TABLE prices 
  ( 
     proposition NUMBER(8), 
     contract    NUMBER(8), 
     pricedate   DATE, 
          CONSTRAINT price_pk PRIMARY KEY (proposition, contract, pricedate), 
          CONSTRAINT price_fk_contract FOREIGN KEY (proposition, contract) 
     REFERENCES 
          contracts(proposition, contractid), 
     value       NUMBER(3, 2) CONSTRAINT price_nn_price NOT NULL CONSTRAINT 
     price_ck_value 
     CHECK (value 
     BETWEEN 0.01 AND 1.99) 
  ) 

CREATE TABLE orders 
  ( 
     TRANSACTION NUMBER(8) CONSTRAINT order_fk_tran REFERENCES transactions( 
     tranid) 
     CONSTRAINT 
     order_pk_tran PRIMARY KEY, 
     quantity    NUMBER(2) CONSTRAINT order_nn_quantity NOT NULL, 
     price       NUMBER(3, 2) CONSTRAINT order_nn_price NOT NULL CONSTRAINT 
     order_ck_price 
     CHECK (price 
     BETWEEN 0.01 AND 1.99), 
     proposition NUMBER(8) CONSTRAINT order_nn_prop NOT NULL, 
     contract    NUMBER(8) CONSTRAINT order_nn_contract NOT NULL, 
     CONSTRAINT order_fk_contract FOREIGN KEY (proposition, contract) REFERENCES 
     contracts(proposition, contractid) 
  ) 

CREATE TABLE accounts 
  ( 
     acctusr     NUMBER(8) CONSTRAINT account_fk_user REFERENCES users(userid), 
     acctdate    DATE, 
          CONSTRAINT account_pk PRIMARY KEY (acctusr, acctdate), 
     amount      NUMBER(5, 2) CONSTRAINT account_nn_amt NOT NULL, 
     TRANSACTION NUMBER(8) CONSTRAINT account_fk_tran REFERENCES transactions( 
     tranid) 
  ) 