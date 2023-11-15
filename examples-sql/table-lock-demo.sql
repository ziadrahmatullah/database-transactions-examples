-- Table-Level Lock Demo
\c transaction_example;

-- Terminal 1
BEGIN;
LOCK TABLE accounts IN ACCESS SHARE MODE;

ROLLBACK;

-- Terminal 2
BEGIN;

SELECT * FROM accounts;

UPDATE accounts SET balance = balance + 100 WHERE account_name = 'David';

DROP TABLE accounts;

ROLLBACK;