-- 29 · Indexes and EXPLAIN (run dataset/schema_and_data.sql first)

-- Q1. Query plan before the index
EXPLAIN QUERY PLAN            -- PostgreSQL: EXPLAIN
SELECT * FROM orders WHERE customer_id = 1;

-- Q2. Create indexes on the columns used in joins and filters
CREATE INDEX IF NOT EXISTS idx_orders_customer ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_items_product   ON order_items(product_id);

-- Q3. Query plan after the index (now it uses idx_orders_customer)
EXPLAIN QUERY PLAN
SELECT * FROM orders WHERE customer_id = 1;

-- Q4. Clean up
DROP INDEX IF EXISTS idx_orders_customer;
DROP INDEX IF EXISTS idx_items_product;
