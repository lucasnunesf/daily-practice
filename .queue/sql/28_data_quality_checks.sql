-- 28 · Data quality checks (run dataset/schema_and_data.sql first)

-- Q1. Orders without items
SELECT o.order_id
FROM orders o
LEFT JOIN order_items oi ON oi.order_id = o.order_id
WHERE oi.order_id IS NULL;

-- Q2. Items pointing to a product that does not exist
SELECT oi.*
FROM order_items oi
LEFT JOIN products p ON p.product_id = oi.product_id
WHERE p.product_id IS NULL;

-- Q3. Products sold below cost (price < cost)
SELECT product_name, unit_price, unit_cost
FROM products
WHERE unit_price < unit_cost;

-- Q4. Invalid quantities
SELECT *
FROM order_items
WHERE quantity <= 0 OR quantity IS NULL;

-- Q5. Duplicated customer names
SELECT customer_name, COUNT(*) AS times
FROM customers
GROUP BY customer_name
HAVING COUNT(*) > 1;
