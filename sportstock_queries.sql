/* 

Display all open propositional contracts for each associated event:

*/

SELECT sport       AS Game, 
       propname    AS Proposition, 
       description AS Options, 
       outcome     AS Status 
FROM   contracts 
       JOIN propositions 
         ON propid = contracts.proposition 
       JOIN events 
         ON eventid = propositions.event 
WHERE  outcome = 'OPEN'; 

/*

Display the price history for a contract:

*/

SELECT c.proposition, 
       c.contractid, 
       p.value     AS Price, 
       p.pricedate AS DateTime 
FROM   contracts c, 
       prices p 
WHERE  c.contractid = p.contract 
       AND p.proposition = c.proposition 
       AND p.contract = 1 
       AND p.proposition = 1 
ORDER  BY p.pricedate; 

/* 

Display all transactions made by a specific user: Johnny 

*/

SELECT u.username, 
       o.price, 
       o.quantity, 
       c.proposition, 
       c.contractid, 
       t.trandate 
FROM   users u, 
       transactions t, 
       orders o, 
       contracts c 
WHERE  u.userid = t.tranusr 
       AND o.TRANSACTION = t.tranid 
       AND o.proposition = c.proposition 
       AND o.contract = c.contractid 
       AND u.userid = 1 
ORDER  BY t.trandate; 

/* 

Display all open contracts that a user owns: 
Lets have Frank buy some contracts for the Packers scoring first when they 
are first offered.  The following tables are updated Transactions, 
Orders, and Accounts. Frank had $165 in his account, it will be updated 
to $140 after this order

*/

INSERT INTO transactions 
            (tranid, 
             trandate, 
             tranusr) 
VALUES      (7, 
             To_date('05-MAY-2014 17:55:00', 'dd-mon-yyyy hh24:mi:ss'), 
             3); 

INSERT INTO orders 
            (TRANSACTION, 
             quantity, 
             price, 
             proposition, 
             contract) 
VALUES      (7, 
             15, 
             1.00, 
             4, 
             1); 

INSERT INTO accounts 
            (acctusr, 
             acctdate, 
             amount, 
             TRANSACTION) 
VALUES      (3, 
             To_date('05-MAY-2014 17:55:00', 'dd-mon-yyyy hh24:mi:ss'), 
             140.00, 
             7);
			 
/* 

Frank now has contracts for both the Yankees and Packers, but only the Packers 
contracts are open 
			 
*/

SELECT u.username, 
    o.price, 
    o.quantity, 
    o.proposition, 
    o.contract, 
    c.outcome 
FROM   orders o, 
    users u, 
    transactions t, 
    contracts c 
WHERE  t.tranusr = u.userid 
    AND o.TRANSACTION = t.tranid 
    AND o.proposition = c.proposition 
    AND o.contract = c.contractid 
    AND u.userid = 3 
    AND c.outcome = 'OPEN'; 
	
/* 

Display the user’s account balance by transaction
		 
*/

SELECT u.username, 
       a.acctdate, 
       a.amount             AS balance, 
       o.price, 
       o.quantity, 
       ( quantity * price ) AS debit 
FROM   accounts a, 
       users u, 
       orders o, 
       transactions t 
WHERE  a.acctusr = u.userid 
       AND o.TRANSACTION = t.tranid 
       AND t.tranusr = a.acctusr 
       AND a.TRANSACTION = t.tranid 
       AND u.userid = 1  /* u.userID = 3 for Frank’s account history */ 
ORDER  BY a.acctdate; 



