-- Useful meta commands:
-- \l: list all databases
-- \c: connect to a database
-- \d: list all tables in a database

-- Useful query:
-- 1.) List active connections from a database
-- SELECT * FROM pg_stat_activity WHERE datname = 'transaction_example';
--
-- 2.) 
-- SET application_name = '<application_name>';

CREATE DATABASE transaction_example;

-- In this demo, we will try to simulate a simplified bank transfer logic

-- accounts table
-- notice that in balance, we put a CHECK constraint where balance should be >= 0
CREATE TABLE accounts (
    account_name VARCHAR PRIMARY KEY,
    balance DECIMAL(14,2) NOT NULL CHECK(balance >= 0)
);

INSERT INTO accounts (account_name, balance) VALUES ('Alice', 1000);
INSERT INTO accounts (account_name, balance) VALUES ('Bob', 2000);
INSERT INTO accounts (account_name, balance) VALUES ('Charlie', 3000);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR NOT NULL,
    user_email VARCHAR NOT NULL
);