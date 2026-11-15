-- 14 · ROW_NUMBER, RANK and DENSE_RANK (run dataset/schema_and_data.sql first)

-- Q1. Rank products by unit price
SELECT product_name,
       unit_price,
       ROW_NUMBER() OVER (ORDER BY unit_price DESC) AS row_num,
       RANK()       OVER (ORDER BY unit_price DESC) AS rnk,
       DENSE_RANK() OVER (ORDER BY unit_price DESC) AS dense_rnk
FROM products;

-- Q2. Rank products by price inside each category
SELECT category,
       product_name,
       unit_price,
       RANK() OVER (PARTITION BY category ORDER BY unit_price DESC) AS rank_in_category
FROM products;

-- Q3. Rank customers by total units bought (delivered orders only)
SELECT c.customer_name,
       SUM(oi.quantity) AS total_units,
       DENSE_RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS units_rank
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id   = o.order_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_name;
