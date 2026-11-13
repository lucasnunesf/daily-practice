-- 27 · Margin analysis (run dataset/schema_and_data.sql first)

-- Q1. Unit margin of each product
SELECT product_name,
       unit_price - unit_cost AS unit_margin,
       ROUND(100.0 * (unit_price - unit_cost) / unit_price, 1) AS margin_pct
FROM products
ORDER BY margin_pct DESC;

-- Q2. Gross profit per category (delivered orders)
SELECT p.category,
       SUM(oi.quantity * p.unit_price) AS revenue,
       SUM(oi.quantity * p.unit_cost)  AS cost,
       SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS gross_profit
FROM order_items oi
JOIN orders o   ON o.order_id   = oi.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
ORDER BY gross_profit DESC;

-- Q3. Most profitable customer
SELECT c.customer_name,
       SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS gross_profit
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id   = o.order_id
JOIN products p     ON p.product_id  = oi.product_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_name
ORDER BY gross_profit DESC
LIMIT 1;
