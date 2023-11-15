-- Deadlock Demo
----------------------
-- A.) Alice attempts to locks Alice's and Bob's accounts before doing something
-- 1)
\c transaction_example;

-- 2)
BEGIN;

-- 3)
SELECT balance FROM accounts WHERE account_name = 'Alice' FOR UPDATE;

-- 8)
SELECT balance FROM accounts WHERE account_name = 'Bob' FOR UPDATE;

-- 9)
COMMIT;

-- B.) Bob attempts to locks Alice's and Bob's accounts before doing something
-- 4)
\c transaction_example;

-- 5)
BEGIN;

-- 6)
SELECT balance FROM accounts WHERE account_name = 'Bob' FOR UPDATE;

-- 7)
SELECT balance FROM accounts WHERE account_name = 'Alice' FOR UPDATE;

-- 10)
COMMIT;
