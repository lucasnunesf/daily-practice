-- 31 · UPSERT with ON CONFLICT (run dataset/schema_and_data.sql first)

-- Q1. Insert a new product, or update the price if the id already exists
INSERT INTO products (product_id, product_name, category, unit_price, unit_cost)
VALUES (1, 'Steel bracket', 'Laser Cut', 48.00, 28.00)
ON CONFLICT (product_id) DO UPDATE
SET unit_price = excluded.unit_price;

SELECT product_id, product_name, unit_price FROM products WHERE product_id = 1;

-- Q2. Ignore duplicates instead of failing
INSERT INTO customers VALUES (1, 'Alpha Machines', 'Sorocaba', 'Industrial')
ON CONFLICT (customer_id) DO NOTHING;

-- Q3. Restore the original price
UPDATE products SET unit_price = 45.00 WHERE product_id = 1;
