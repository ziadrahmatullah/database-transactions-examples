-- Isolation Demo - Demo NON-REPEATABLE READ
-- PostgreSQL default ISOLATION LEVEL is READ COMMITTED
----------------------------------

INSERT INTO accounts (account_name, balance) VALUES ('Charlie', 3000);

-- A.) Charlie created a new account
-- 1)
\c transaction_example;

-- 2)
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- 3)
DELETE FROM accounts WHERE account_name = 'Charlie';

-- 7)
COMMIT;

-- B.) Admin is getting report of all accounts balance
-- 4)
\c transaction_example;

-- 5)
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- 6)
SELECT SUM(balance) FROM accounts;

-- pause here...

-- 8)
SELECT SUM(balance) FROM accounts;

--- 9)
COMMIT;
