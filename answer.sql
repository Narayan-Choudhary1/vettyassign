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

