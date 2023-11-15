-- Atomicity Demo
----------------------------------
-- A.) Alice Transfer funds to Bob
-- 1)
\c transaction_example;

-- 2)
BEGIN;

-- 3)
UPDATE accounts SET balance = balance - 100.00
    WHERE account_name = 'Alice';

-- what if we rollback from here?

-- 6)
UPDATE accounts SET balance = balance + 100.00
    WHERE account_name = 'Bob';

-- 7)
COMMIT;

-- B.) To check the data
-- 4)
\c transaction_example;

-- 5)
SELECT balance FROM accounts WHERE account_name = 'Alice';

-- 8)
SELECT balance FROM accounts WHERE account_name = 'Alice';