-- 17 · Pivot with CASE WHEN (run dataset/schema_and_data.sql first)

-- Q1. Units sold per customer and category in columns
SELECT c.customer_name,
       SUM(CASE WHEN p.category = 'Laser Cut' THEN oi.quantity ELSE 0 END) AS laser_cut,
       SUM(CASE WHEN p.category = 'Welded'    THEN oi.quantity ELSE 0 END) AS welded,
       SUM(CASE WHEN p.category = 'Bent'      THEN oi.quantity ELSE 0 END) AS bent
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id   = o.order_id
JOIN products p     ON p.product_id  = oi.product_id
GROUP BY c.customer_name
ORDER BY c.customer_name;

-- Q2. Orders per status in one row
SELECT COUNT(CASE WHEN status = 'Delivered'     THEN 1 END) AS delivered,
       COUNT(CASE WHEN status = 'In Production' THEN 1 END) AS in_production,
       COUNT(CASE WHEN status = 'Cancelled'     THEN 1 END) AS cancelled
FROM orders;
