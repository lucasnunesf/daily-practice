-- 32 · Gaps between orders (run dataset/schema_and_data.sql first)

-- Q1. Days between consecutive orders of each customer
WITH ordered AS (
    SELECT customer_id,
           order_id,
           order_date,
           LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_date
    FROM orders
)
SELECT customer_id,
       order_id,
       order_date,
       CAST(julianday(order_date) - julianday(prev_date) AS INTEGER) AS days_since_prev
FROM ordered
WHERE prev_date IS NOT NULL
ORDER BY customer_id, order_date;

-- Q2. Average purchase interval per customer
WITH ordered AS (
    SELECT customer_id,
           order_date,
           LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_date
    FROM orders
)
SELECT customer_id,
       ROUND(AVG(julianday(order_date) - julianday(prev_date)), 1) AS avg_days_between
FROM ordered
WHERE prev_date IS NOT NULL
GROUP BY customer_id;
