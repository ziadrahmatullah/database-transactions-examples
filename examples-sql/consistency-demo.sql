-- Consistency Demo
----------------------------------
-- A.) Alice Transfer funds to Bob
-- 0)
\c transaction_example;

-- 1)
BEGIN;

-- 2) somehow our application does not validate the deducted balance
UPDATE accounts SET balance = balance - 10000
    WHERE account_name = 'Alice';

-- 3) we cannot continue here, the PostgreSQL won't let us
UPDATE accounts SET balance = balance + 10100
    WHERE account_name = 'Alice';

-- 4)
COMMIT;

-- 5) To check the data
SELECT balance FROM accounts WHERE account_name = 'Alice';
