-- =====================================================================
-- 05 · Window functions: ROW_NUMBER, RANK, SUM OVER, LAG
-- Goal: calculate across rows WITHOUT collapsing them (unlike GROUP BY)
-- =====================================================================

-- Q1. Rank products by price inside each category.
SELECT category,
       product_name,
       unit_price,
       RANK() OVER (PARTITION BY category ORDER BY unit_price DESC) AS price_rank
FROM products;

-- Q2. Each customer's most recent order (ROW_NUMBER + filter).
-- Very common pattern in data engineering to keep the "latest" record.
WITH ranked AS (
    SELECT customer_id,
           order_id,
           order_date,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM orders
)
SELECT customer_id, order_id, order_date
FROM ranked
WHERE rn = 1;

-- Q3. Monthly revenue and running total (cumulative SUM).
-- SUBSTR(order_date, 1, 7) turns '2025-03-18' into '2025-03'.
WITH monthly AS (
    SELECT SUBSTR(CAST(o.order_date AS VARCHAR(10)), 1, 7) AS month,
           SUM(oi.quantity * p.unit_price)                 AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id  = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    WHERE o.status <> 'Cancelled'
    GROUP BY SUBSTR(CAST(o.order_date AS VARCHAR(10)), 1, 7)
)
SELECT month,
       revenue,
       SUM(revenue) OVER (ORDER BY month) AS running_total
FROM monthly
ORDER BY month;

-- Q4. Month-over-month change (LAG looks at the previous row).
WITH monthly AS (
    SELECT SUBSTR(CAST(o.order_date AS VARCHAR(10)), 1, 7) AS month,
           SUM(oi.quantity * p.unit_price)                 AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id  = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    WHERE o.status <> 'Cancelled'
    GROUP BY SUBSTR(CAST(o.order_date AS VARCHAR(10)), 1, 7)
)
SELECT month,
       revenue,
       LAG(revenue) OVER (ORDER BY month)           AS previous_month,
       revenue - LAG(revenue) OVER (ORDER BY month) AS change
FROM monthly
ORDER BY month;
