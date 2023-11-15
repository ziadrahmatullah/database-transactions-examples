-- Isolation Demo - Phantom Read Solution Demo
----------------------------------------------
-- A.) Alice A register a new user
-- 1)
\c transaction_example;

-- 2)
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- 3) Checking whether user with alice email already exists
SELECT 1 FROM users WHERE user_email = 'alice@example.com' FOR UPDATE;

-- 7)
INSERT INTO users
(user_name, user_email)
VALUES
('Alice A', 'alice@example.com');

-- 8)
COMMIT;

-- B.) Alice B register a new user
-- 4)
\c transaction_example;

-- 5)
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- 6) Checking whether user with alice email already exists
SELECT 1 FROM users WHERE user_email = 'alice@example.com';

-- 9)
INSERT INTO users
(user_name, user_email)
VALUES
('Alice B', 'alice@example.com');

-- 10)
COMMIT;

-- Check the users data, if we done it in above sequence, there should be two users with email of 'alice@example.com'
SELECT * FROM users;