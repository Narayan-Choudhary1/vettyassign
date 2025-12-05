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