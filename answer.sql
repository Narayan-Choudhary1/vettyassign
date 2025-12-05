-- 1. Create the Transactions Table
CREATE TABLE transactions (
    buyer_id INT,
    purchase_time TIMESTAMP,
    refund_time TIMESTAMP,
    store_id VARCHAR(50),
    item_id VARCHAR(50),
    gross_transaction_value DECIMAL(10, 2)
);

-- 2. Create the Items Table
CREATE TABLE items (
    store_id VARCHAR(50),
    item_id VARCHAR(50),
    item_category VARCHAR(50),
    item_name VARCHAR(100)
);

-- 3. Insert Data into Items Table 
INSERT INTO items (store_id, item_id, item_category, item_name) VALUES
('a', 'a1', 'pants', 'denim pants'),
('a', 'a2', 'tops', 'blouse'),
('f', 'f1', 'table', 'coffee table'),
('f', 'f5', 'chair', 'lounge chair'),
('f', 'f6', 'chair', 'armchair'),
('d', 'd2', 'jewelry', 'bracelet'),
('b', 'b4', 'earphone', 'airpods');

-- 4. Insert Data into Transactions Table
INSERT INTO transactions (buyer_id, purchase_time, refund_time, store_id, item_id, gross_transaction_value) VALUES
(3, '2019-09-19 21:19:06.544', NULL, 'a', 'a1', 58.00),
(12, '2019-12-10 20:10:14.324', NULL, 'b', 'b4', 475.00),
(3, '2020-09-01 23:59:46.561', NULL, 'd', 'd3', 33.00),
(2, '2020-04-30 21:19:06.544', NULL, 'd', 'd2', 250.00),
(1, '2020-10-22 22:20:06.531', NULL, 'f', 'f1', 91.00),
(8, '2020-04-16 21:10:22.214', NULL, 'e', 'e7', 24.00),
(5, '2019-09-23 12:09:35.542', '2019-09-27 02:55:02.114', 'g', 'g1', 61.00),
--  EXTRA TEST DATA 
(100, '2020-01-10 10:00:00', '2020-01-11 10:00:00', 'a', 'a1', 58.00),
(101, '2020-10-01 10:00:00', NULL, 'a', 'a1', 58.00),
(102, '2020-10-02 11:00:00', NULL, 'a', 'a2', 25.00),
(103, '2020-10-03 12:00:00', NULL, 'a', 'a1', 58.00),
(104, '2020-10-04 13:00:00', NULL, 'a', 'a2', 25.00),
(105, '2020-10-05 14:00:00', NULL, 'a', 'a1', 58.00);


-- Q1: What is the count of purchases per month (excluding refunded purchases)?
-- Approach: Filter out rows where refund_time exists, then group by the formatted Year-Month of the purchase_time.
SELECT 
    EXTRACT(YEAR FROM purchase_time) AS purchase_year,
    EXTRACT(MONTH FROM purchase_time) AS purchase_month,
    COUNT(*) AS purchase_count
FROM transactions
WHERE refund_time IS NULL
GROUP BY 1, 2
ORDER BY 1, 2;

--Output:
-- '2019','9','1'
-- '2019','12','1'
-- '2020','4','2'
-- '2020','9','1'
-- '2020','10','6'

-- Q2: How many stores receive at least 5 orders/transactions in October 2020?
-- Approach: Filter transactions specifically for Oct 2020. Group by store_id and count transactions.
-- Then, use a subquery or HAVING clause to filter groups >= 5 and count the resulting stores.
SELECT COUNT(*) AS number_of_stores
FROM (
    SELECT store_id
    FROM transactions
    WHERE purchase_time >= '2020-10-01 00:00:00' 
      AND purchase_time <= '2020-10-31 23:59:59'
    GROUP BY store_id
    HAVING COUNT(*) >= 5
) AS qualifying_stores;

--Output:
--1

-- Q3: For each store, what is the shortest interval (in min) from purchase to refund time?
-- Approach: Calculate the difference between refund and purchase time in minutes. Find the MIN value per store.
-- Note: Logic assumes we only look at transactions that actually had a refund (refund_time is not null).
SELECT 
    store_id,
    MIN(TIMESTAMPDIFF(MINUTE, purchase_time, refund_time)) AS shortest_refund_interval_min
FROM transactions
WHERE refund_time IS NOT NULL
GROUP BY store_id;

--Output:
-- 'g','5205'
-- 'a','1440'


-- Q4: What is the gross_transaction_value of every store's first order?
-- Approach: Use ROW_NUMBER() partitioned by store_id to order transactions chronologically. Select Rank 1.
WITH StoreOrders AS (
    SELECT 
        store_id,
        gross_transaction_value,
        ROW_NUMBER() OVER (PARTITION BY store_id ORDER BY purchase_time ASC) as rn
    FROM transactions
)
SELECT store_id, gross_transaction_value
FROM StoreOrders
WHERE rn = 1;

--Output:
-- 'a','58.00'
-- 'b','475.00'
-- 'd','250.00'
-- 'e','24.00'
-- 'f','91.00'
-- 'g','61.00'


