-- 23 · Recursive CTE (calendar table) (run dataset/schema_and_data.sql first)

-- Q1. Generate the numbers 1 to 10
WITH RECURSIVE nums(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM nums WHERE n < 10
)
SELECT n FROM nums;

-- Q2. Calendar of months from Jan to Jun 2025 with order count (months without orders show 0)
WITH RECURSIVE months(m) AS (
    SELECT 1
    UNION ALL
    SELECT m + 1 FROM months WHERE m < 6
)
SELECT m AS month_number,
       COUNT(o.order_id) AS total_orders
FROM months
LEFT JOIN orders o
       ON CAST(SUBSTR(CAST(o.order_date AS VARCHAR(10)), 6, 2) AS INTEGER) = m
GROUP BY m
ORDER BY m;
