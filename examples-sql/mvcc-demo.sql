-- MVCC Demo
-- ctid is the combination of "block" and index of the tuple
-- it refers to the location of the tuple
-- it is used to refer different versions of tuple in PostgreSQL
----------------------------------
-- A.) Alice Transfer funds to Bob
-- 0)
\c transaction_example;

-- 1)
BEGIN;

-- 2)
UPDATE accounts SET balance = balance - 100
    WHERE account_name = 'Alice';

-- 3)
SELECT ctid FROM accounts WHERE account_name = 'Alice';

-- 4)
UPDATE accounts SET balance = balance + 100
    WHERE account_name = 'Bob';

-- pause here

-- 5)
COMMIT;

-- B.) Another user check Alice's data
BEGIN;

SELECT ctid, balance FROM accounts WHERE account_name = 'Alice';
