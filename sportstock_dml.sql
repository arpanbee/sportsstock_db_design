/*

TABLE: Users

Adding new user accounts (Johny, David, Frank, and Susan)

*/

INSERT INTO Users (userID, userName, email) VALUES (1, 'johnny', 'johnny@gmailcom');

INSERT INTO Users (userID, userName, email) VALUES (2, 'david', 'david@gmail.com'); 

INSERT INTO Users (userID, userName, email) VALUES (3, 'frank', 'frank@gmail.com'); 

INSERT INTO Users (userID, userName, email) VALUES (4, 'susan', 'susan@gmail.com');

/*
			 
Updating a user's email address (Frank changed his email)

*/

UPDATE Users
SET email = 'frank@yahoo.com'
WHERE userID = 3;

/*
			 
Susan deleted her account

*/

DELETE FROM Users WHERE userID = 4;

/*

TABLE: Transactions

Adding a new transaction

*/

/* Johnny makes a transaction */
INSERT INTO Transactions (tranID, tranDate, tranUsr)
VALUES (1, to_date('01-MAY-2014 15:05:00', 'dd-mon-yyyy hh24:mi:ss'), 1);

/* Frank makes a transaction at the same time */
INSERT INTO Transactions (tranID, tranDate, tranUsr)
VALUES (2, to_date('01-MAY-2014 15:05:00', 'dd-mon-yyyy hh24:mi:ss'), 3);

/* Johnny makes another transaction 5 minutes later */
INSERT INTO Transactions (tranID, tranDate, tranUsr)
VALUES (3, to_date('01-MAY-2014 15:10:00', 'dd-mon-yyyy hh24:mi:ss'), 1);

/* Frank makes another transaction */
INSERT INTO Transactions (tranID, tranDate, tranUsr)
VALUES (4, to_date('01-MAY-2014 15:11:00', 'dd-mon-yyyy hh24:mi:ss'), 3);

/* David makes a transaction at the same time*/
INSERT INTO Transactions (tranID, tranDate, tranUsr)
VALUES (5, to_date('01-MAY-2014 15:11:00', 'dd-mon-yyyy hh24:mi:ss'), 2);

/* David makes another transaction 3 seconds later */
INSERT INTO Transactions (tranID, tranDate, tranUsr)
VALUES (6, to_date('01-MAY-2014 15:11:03', 'dd-mon-yyyy hh24:mi:ss'), 2);

/* 

Transactions will never be modified or removed since they keep a log 
of all orders and account adjustments

*/

/*

TABLE: Events
Adding a few events

*/

INSERT INTO Events (eventID, dateOf, sport)
VALUES (1, to_date('01-MAY-2014 15:00:00', 'dd-mon-yyyy hh24:mi:ss'), 'YANKEES VS ORIOLES');

INSERT INTO Events (eventID, dateOf, sport)
VALUES (2, to_date('02-MAY-2014 18:00:00', 'dd-mon-yyyy hh24:mi:ss'), 'PHILLIES VS PIRATES');

INSERT INTO Events (eventID, dateOf, sport)
VALUES (3, to_date('05-MAY-2014 18:00:00', 'dd-mon-yyyy hh24:mi:ss'), 'PACKERS VS GIANTS');

INSERT INTO Events (eventID, dateOf, sport)
VALUES (4, to_date('11-MAY-2014 20:00:00', 'dd-mon-yyyy hh24:mi:ss'), 'RAIDERS VS BRONCOS');

/*

Modifying an event

*/

/* Phillies Pirates game got rained out and postponed to the following day */ 

UPDATE Events
SET dateOf = to_date('03-MAY-2014 18:00:00', 'dd-mon-yyyy hh24:mi:ss') WHERE eventID = 2;

/*

Removing an event (rare but could happen)

*/

/* There are rumors that say that the Raiders vs. Broncos game is fixed. 
We don’t want to offer any propositions on this game and we want to 
remove it from our events */

DELETE FROM Events WHERE eventID = 4;

/*

TABLE: Propositions
Adding a few propositions based on the ‘Yankees vs. Orioles’, ‘Phillies vs. Pirates’, 
and ‘Packers vs. Giants’ events

*/

/* Adding the winning team proposition to the Yankees vs. Orioles event */ 
INSERT INTO Propositions (propID, propName, event)
VALUES (1, 'WINNER', 1);

/* Adding the total score proposition to the Yankees vs. Orioles event */ 
INSERT INTO Propositions (propID, propName, event)
VALUES (2, 'TOTAL SCORE', 1);

/* Adding the total hits proposition to the Phillies vs. Pirates event */ 
INSERT INTO Propositions (propID, propName, event)
VALUES (3, 'TOTAL HITS', 2);

/* Adding the total score proposition to the Packers vs. Giants event */ 
INSERT INTO Propositions (propID, propName, event)
VALUES (4, 'TOTAL SCORE', 3);

/* Removing the ‘Total Score’ proposition for Yankees vs. Orioles */

DELETE FROM Propositions WHERE propID = 2;

/* Updating the ‘Total Score’ proposition for the Packers vs. Giants 
to ‘First to Score’ */

UPDATE Propositions
SET propName = 'FIRST TO SCORE'
WHERE propID = 4;

/*

TABLE: Contracts
Adding associated contracts based on the each proposition

*/

/* Yankees vs. Orioles Winning Team */

INSERT INTO Contracts (proposition, contractID, description, outcome) 
VALUES (1, 1, 'YANKEES WIN', 'OPEN');

INSERT INTO Contracts (proposition, contractID, description, outcome) 
VALUES (1, 2, 'ORIOLES WIN', 'OPEN');

/* Phillies vs. Pirates Total Hits */

INSERT INTO Contracts (proposition, contractID, description, outcome) 
VALUES (3, 1, 'TOTAL HITS GREATER THAN 7.5', 'OPEN');

INSERT INTO Contracts (proposition, contractID, description, outcome) 
VALUES (3, 2, 'TOTAL HITS LESS THAN 7.5', 'OPEN');

/* Packers vs. Giants First to Score */

INSERT INTO Contracts (proposition, contractID, description, outcome) 
VALUES (4, 1, 'PACKERS SCORE FIRST', 'OPEN');

INSERT INTO Contracts (proposition, contractID, description, outcome) 
VALUES (4, 2, 'GIANTS SCORE FIRST', 'OPEN');

/* 
Updating the status of a contract once there is an outcome (Yankees Won!)
*/

UPDATE Contracts
SET outcome = 'WIN' WHERE proposition = 1 AND contractID = 1;

UPDATE Contracts
SET outcome = 'LOSS' WHERE proposition = 1 AND contractID = 2;

/*

TABLE: Prices
This table stores the price of each contract. 
The price will be updated based on some algorithm.
The prices of associated contracts will always be updated at the same time. 
A record of the historical prices of each contract is needed, 
thus this table will never need any rows modified or removed.

*/

/* 
Proposition and associated contracts initially created, 5 minutes before the 
event starts.  Prices start at $1 for both contracts @ 01-MAY-2014 14:55:00 
*/
INSERT INTO Prices (proposition, contract, priceDate, value)
VALUES (1, 1, to_date('01-MAY-2014 14:55:00', 'dd-mon-yyyy hh24:mi:ss'), 1.00);

INSERT INTO Prices (proposition, contract, priceDate, value)
VALUES (1, 2, to_date('01-MAY-2014 14:55:00', 'dd-mon-yyyy hh24:mi:ss'), 1.00); 

/* Price update @ 01-MAY-2014 14:55:30 */

INSERT INTO Prices (proposition, contract, priceDate, value)
VALUES (1, 1, to_date('01-MAY-2014 14:55:30', 'dd-mon-yyyy hh24:mi:ss'), 1.30); 

INSERT INTO Prices (proposition, contract, priceDate, value)
VALUES (1, 2, to_date('01-MAY-2014 14:55:30', 'dd-mon-yyyy hh24:mi:ss'), 0.70); 

/* Price update @ 01-MAY-2014 14:56:15 */

INSERT INTO Prices (proposition, contract, priceDate, value)
VALUES (1, 1, to_date('01-MAY-2014 14:56:15', 'dd-mon-yyyy hh24:mi:ss'), 1.00); 

INSERT INTO Prices (proposition, contract, priceDate, value)
VALUES (1, 2, to_date('01-MAY-2014 14:56:15', 'dd-mon-yyyy hh24:mi:ss'), 1.00); 

/* Price update @ 01-MAY-2014 14:56:17*/

INSERT INTO Prices (proposition, contract, priceDate, value)
VALUES (1, 1, to_date('01-MAY-2014 14:56:17', 'dd-mon-yyyy hh24:mi:ss'), 0.86); 

INSERT INTO Prices (proposition, contract, priceDate, value)
VALUES (1, 2, to_date('01-MAY-2014 14:56:17', 'dd-mon-yyyy hh24:mi:ss'), 0.14);

/*

TABLE: Orders
Orders coming in on the Yankees vs. Orioles Winner Propositional Contracts

*/

/* First set of 100 orders at initial offering of $1.00 */

INSERT INTO Orders (transaction, quantity, price, proposition, contract) VALUES (1, 65, 1.00, 1, 1);

INSERT INTO Orders (transaction, quantity, price, proposition, contract) VALUES (2, 35, 1.00, 1, 2);

/* Second set of orders at new adjusted price of $1.30 and $0.70 */ 

INSERT INTO Orders (transaction, quantity, price, proposition, contract) VALUES (3, 50, 1.30, 1, 1);

INSERT INTO Orders (transaction, quantity, price, proposition, contract) VALUES (4, 50, 0.70, 1, 2);

/* Third set of orders at new adjusted price of $1.00 and $1.00 */ 

INSERT INTO Orders (transaction, quantity, price, proposition, contract) VALUES (5, 43, 1.00, 1, 1);

INSERT INTO Orders (transaction, quantity, price, proposition, contract) VALUES (6, 57, 1.00, 1, 2);

/* 
Orders won’t come in exactly at 100 contract blocks but that is what this example is showing.
There will be a max order amount per transaction per user to facilitate an elastic market price.
An order will never need to be modified or deleted since it is mapped 1 to 1 with transactions 
and all transactions are saved.
*/

/*

TABLE: Accounts
Account creation for Johnny and Frank with an initial balance of $200

*/

/* No tranID for non-transaction updates. Johnny’s account created with initial $200 balance */ 

INSERT INTO Accounts (acctUsr, acctDate, amount)
VALUES (1, to_date('01-MAY-2014 00:01:00', 'dd-mon-yyyy hh24:mi:ss'), 200.00);

/* Frank’s account created with initial $200 balance */

INSERT INTO Accounts (acctUsr, acctDate, amount)
VALUES (3, to_date('01-MAY-2014 00:01:15', 'dd-mon-yyyy hh24:mi:ss'), 200.00);

/*

Accounts will never be modified or deleted since they keep a history of the balance. Johnny and Frank 
create transactions, which creates an account update.

*/

/* Update Johnny’s account balance based on his first transaction. $200 - $65 = $135 */ 

INSERT INTO Accounts (acctUsr, acctDate, amount, transaction)
VALUES (1, to_date('01-MAY-2014 15:05:00', 'dd-mon-yyyy hh24:mi:ss'), 135.00, 1); 

/* Update Frank’s account balance based on his first transaction. $200 - $35 = $165 */ 

INSERT INTO Accounts (acctUsr, acctDate, amount, transaction)
VALUES (3, to_date('01-MAY-2014 15:05:00', 'dd-mon-yyyy hh24:mi:ss'), 165.00, 2);

/* Update Johnny’s account balance based on his second transaction. $135 - $65 = $70 */ 

INSERT INTO Accounts (acctUsr, acctDate, amount, transaction)
VALUES (1, to_date('01-MAY-2014 15:10:00', 'dd-mon-yyyy hh24:mi:ss'), 70.00, 3);

/* After the Yankees win, Johnny gets paid out on his contracts */ 

/* 
After Johnny’s transactions he owned a total of 115 contracts at an average price of $1.13. 
This allows Johnny to win $57.5 contract reward, and $130 in contract premium, totaling $187.50. 
Johnny’s last balance was $70. So his new balance will be $70 + $187.50 = $257.5 
*/

INSERT INTO Accounts (acctUsr, acctDate, amount)
VALUES (1, to_date('01-MAY-2014 18:00:00', 'dd-mon-yyyy hh24:mi:ss'), 257.50);