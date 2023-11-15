-- Lost Update Problem
----------------------
-- A.) Alice Top Up 1000 to her account
-- 3)
\c transaction_example;

-- 4)
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- 6)
SELECT balance FROM accounts WHERE account_name = 'Alice';

-- assume that our application stores the Alice's balance in 'X' variable

-- 7) X is increased by 1000, X becomes 2000
UPDATE accounts SET balance = 2000
    WHERE account_name = 'Alice';

-- 8)
COMMIT;

-- B.) Bob transfers to Alice
-- 1)
\c transaction_example;

-- 2)
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- 5)
SELECT balance FROM accounts WHERE account_name = 'Alice';

-- assume that our application stores the Alice's balance in 'Y' variable

-- 9) Y is deducted by 500, Y becomes 500
UPDATE accounts SET balance = 500
    WHERE account_name = 'Alice';

-- 10)
COMMIT;

-- Check the balance after updates
SELECT * FROM accounts WHERE account_name = 'Alice';