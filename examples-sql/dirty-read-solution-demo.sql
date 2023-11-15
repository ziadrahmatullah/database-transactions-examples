-- Isolation Demo - Demo DIRTY-READ solution
-- PostgreSQL default ISOLATION LEVEL is READ COMMITTED
----------------------------------
-- A.) Alice do top-up
-- 3)
\c transaction_example;

-- 4)
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- 7)
SELECT balance FROM accounts WHERE account_name = 'Alice';

-- 8)
UPDATE accounts SET balance = balance + 1000.00
    WHERE account_name = 'Alice';

-- 9)
COMMIT;

-- B.) Alice do Payment
-- 1)
\c transaction_example;

-- 2)
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- 5)
SELECT balance FROM accounts WHERE account_name = 'Alice';

-- 6)
UPDATE accounts SET balance = 500.00
    WHERE account_name = 'Alice';

-- pause here...

-- 10)
ROLLBACK;