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