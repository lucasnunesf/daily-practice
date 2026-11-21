-- 33 · NTILE and quartiles (run dataset/schema_and_data.sql first)

-- Q1. Split orders into 4 groups by revenue
WITH order_revenue AS (
    SELECT o.order_id,
           SUM(oi.quantity * p.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id  = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    GROUP BY o.order_id
)
SELECT order_id,
       revenue,
       NTILE(4) OVER (ORDER BY revenue) AS quartile
FROM order_revenue
ORDER BY revenue;

-- Q2. Min, max and count per quartile
WITH order_revenue AS (
    SELECT o.order_id,
           SUM(oi.quantity * p.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id  = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    GROUP BY o.order_id
),
q AS (
    SELECT revenue, NTILE(4) OVER (ORDER BY revenue) AS quartile
    FROM order_revenue
)
SELECT quartile,
       COUNT(*)     AS orders,
       MIN(revenue) AS min_revenue,
       MAX(revenue) AS max_revenue
FROM q
GROUP BY quartile
ORDER BY quartile;
