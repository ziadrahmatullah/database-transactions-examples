-- Row-Level Lock Demo
\c transaction_example;

-- Terminal 1
BEGIN;

SELECT * FROM accounts WHERE account_name = 'Alice' FOR SHARE;

SELECT * FROM accounts WHERE account_name = 'Alice' FOR UPDATE;

ROLLBACK;

-- Terminal 2
BEGIN;

SELECT * FROM accounts WHERE account_name = 'Alice' FOR SHARE;

UPDATE accounts SET balance = balance + 100 WHERE account_name = 'David';

UPDATE accounts SET balance = balance + 100 WHERE account_name = 'Alice';

ROLLBACK;