-- 08 · INSERT, UPDATE, DELETE and VIEW (run dataset/schema_and_data.sql first)

-- Q1. Add a new customer
INSERT INTO customers (customer_id, customer_name, city, segment)
VALUES (9, 'Iron Valley', 'Sorocaba', 'Industrial');

-- Q2. Add a new order with two items
INSERT INTO orders (order_id, customer_id, order_date, status)
VALUES (114, 9, '2025-04-28', 'In Production');

INSERT INTO order_items (order_id, product_id, quantity)
VALUES (114, 1, 150),
       (114, 5, 60);

-- Q3. Fill in the missing city
UPDATE customers
SET city = 'Sao Paulo'
WHERE customer_id = 8;

-- Q4. Raise the price of Laser Cut products by 10%
UPDATE products
SET unit_price = unit_price * 1.10
WHERE category = 'Laser Cut';

-- Q5. Mark the new order as delivered
UPDATE orders
SET status = 'Delivered'
WHERE order_id = 114;

-- Q6. Delete the cancelled order (items first, because they reference the order)
DELETE FROM order_items
WHERE order_id IN (SELECT order_id FROM orders WHERE status = 'Cancelled');

DELETE FROM orders
WHERE status = 'Cancelled';

-- Q7. Save a query as a VIEW
DROP VIEW IF EXISTS vw_customer_revenue;

CREATE VIEW vw_customer_revenue AS
SELECT c.customer_name,
       COUNT(DISTINCT o.order_id)      AS total_orders,
       ROUND(SUM(oi.quantity * p.unit_price), 2) AS revenue
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id   = o.order_id
JOIN products p     ON p.product_id  = oi.product_id
GROUP BY c.customer_name;

-- Q8. Use the VIEW like a table
SELECT *
FROM vw_customer_revenue
ORDER BY revenue DESC;
