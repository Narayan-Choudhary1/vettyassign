-- 1. Create the Transactions Table
CREATE TABLE transactions (
    buyer_id INT,
    purchase_time TIMESTAMP,
    refund_time TIMESTAMP,
    store_id VARCHAR(50),
    item_id VARCHAR(50),
    gross_transaction_value DECIMAL(10, 2)
);
