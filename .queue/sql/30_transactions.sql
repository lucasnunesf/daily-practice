-- 30 · Transactions: BEGIN, COMMIT, ROLLBACK (run dataset/schema_and_data.sql first)

-- Q1. Cancel an order and roll back the change
BEGIN;
UPDATE orders SET status = 'Cancelled' WHERE order_id = 113;
SELECT order_id, status FROM orders WHERE order_id = 113;   -- Cancelled
ROLLBACK;
SELECT order_id, status FROM orders WHERE order_id = 113;   -- Delivered again

-- Q2. Insert an order with its items as one unit of work
BEGIN;
INSERT INTO orders VALUES (114, 5, '2025-04-28', 'In Production');
INSERT INTO order_items VALUES (114, 1, 50), (114, 5, 30);
COMMIT;

-- Q3. Check and undo the test data
SELECT * FROM order_items WHERE order_id = 114;
DELETE FROM order_items WHERE order_id = 114;
DELETE FROM orders      WHERE order_id = 114;
