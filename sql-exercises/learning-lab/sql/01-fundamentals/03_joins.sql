-- =====================================================================
-- 03 · INNER JOIN, LEFT JOIN, anti-join
-- Goal: combine tables using their keys
-- =====================================================================

-- Q1. Each order with the customer name (INNER JOIN: only matching rows).
SELECT o.order_id, o.order_date, c.customer_name, o.status
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_date;

-- Q2. Order lines with product name and line revenue (3 tables).
SELECT oi.order_id,
       p.product_name,
       oi.quantity,
       p.unit_price,
       oi.quantity * p.unit_price AS line_revenue
FROM order_items oi
INNER JOIN products p ON p.product_id = oi.product_id
ORDER BY oi.order_id;

-- Q3. Revenue per customer, excluding cancelled orders (4 tables).
SELECT c.customer_name,
       SUM(oi.quantity * p.unit_price) AS revenue
FROM customers c
INNER JOIN orders o       ON o.customer_id = c.customer_id
INNER JOIN order_items oi ON oi.order_id   = o.order_id
INNER JOIN products p     ON p.product_id  = oi.product_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_name
ORDER BY revenue DESC;

-- Q4. All customers, including those who never ordered (LEFT JOIN).
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_orders;

-- Q5. Products that were never sold (anti-join: LEFT JOIN + IS NULL).
SELECT p.product_name
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;
