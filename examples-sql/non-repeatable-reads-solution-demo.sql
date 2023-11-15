-- Isolation Demo - REPEATABLE READ
----------------------------------
-- A.) Alice Transfer funds to Bob
-- 1)
\c transaction_example;

-- 2)
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- 3)
UPDATE accounts SET balance = balance - 100.00
    WHERE account_name = 'Alice';

-- 4)
UPDATE accounts SET balance = balance + 100.00
    WHERE account_name = 'Bob';

-- 5)
SELECT balance FROM accounts WHERE account_name = 'Bob';

-- pause here...

-- 9)
COMMIT;

-- B.) Bob check his account balance
-- 6)
\c transaction_example;

-- 7)
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- 8)
SELECT balance FROM accounts WHERE account_name = 'Bob';

-- pause here...

-- 10) run this after Alice's transaction is COMMITTED
SELECT balance FROM accounts WHERE account_name = 'Bob';

-- 11)
COMMIT;