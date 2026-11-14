-- 13 · Date functions (run dataset/schema_and_data.sql first)

-- Q1. Year and month of each order
SELECT order_id,
       order_date,
       SUBSTR(CAST(order_date AS VARCHAR(10)), 1, 4) AS order_year,
       SUBSTR(CAST(order_date AS VARCHAR(10)), 6, 2) AS order_month
FROM orders;

-- Q2. Number of orders per month
SELECT SUBSTR(CAST(order_date AS VARCHAR(10)), 1, 7) AS year_month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY SUBSTR(CAST(order_date AS VARCHAR(10)), 1, 7)
ORDER BY year_month;

-- Q3. Orders placed in the first quarter of 2025
SELECT order_id, order_date
FROM orders
WHERE order_date BETWEEN '2025-01-01' AND '2025-03-31';

-- Q4. Days since the first order of the dataset
-- SQLite: julianday | PostgreSQL: order_date - DATE '2025-01-08'
SELECT order_id,
       order_date,
       CAST(julianday(order_date) - julianday('2025-01-08') AS INTEGER) AS days_since_start
FROM orders
ORDER BY order_date;
