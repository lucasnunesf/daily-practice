-- 20 · CROSS JOIN and missing combinations (run dataset/schema_and_data.sql first)

-- Q1. Every customer x category combination
SELECT c.customer_name, cat.category
FROM customers c
CROSS JOIN (SELECT DISTINCT category FROM products) cat
ORDER BY c.customer_name, cat.category;

-- Q2. Categories each customer has never bought
SELECT c.customer_name, cat.category
FROM customers c
CROSS JOIN (SELECT DISTINCT category FROM products) cat
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    JOIN order_items oi ON oi.order_id  = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    WHERE o.customer_id = c.customer_id
      AND p.category    = cat.category
)
ORDER BY c.customer_name;
