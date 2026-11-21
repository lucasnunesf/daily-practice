-- 22 · Top N per group (run dataset/schema_and_data.sql first)

-- Q1. Best-selling product (units) in each category
WITH sales AS (
    SELECT p.category,
           p.product_name,
           SUM(oi.quantity) AS units,
           ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity) DESC) AS rn
    FROM order_items oi
    JOIN products p ON p.product_id = oi.product_id
    GROUP BY p.category, p.product_name
)
SELECT category, product_name, units
FROM sales
WHERE rn = 1;

-- Q2. Last 2 orders of each customer
WITH ranked AS (
    SELECT customer_id,
           order_id,
           order_date,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM orders
)
SELECT customer_id, order_id, order_date
FROM ranked
WHERE rn <= 2
ORDER BY customer_id, order_date DESC;
