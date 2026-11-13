-- 15 · Running totals and moving averages (run dataset/schema_and_data.sql first)

-- Q1. Revenue per order
WITH order_revenue AS (
    SELECT o.order_id,
           o.order_date,
           SUM(oi.quantity * p.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id  = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    WHERE o.status <> 'Cancelled'
    GROUP BY o.order_id, o.order_date
)
-- Q2. Running total of revenue over time
SELECT order_id,
       order_date,
       revenue,
       SUM(revenue) OVER (ORDER BY order_date) AS running_revenue
FROM order_revenue
ORDER BY order_date;

-- Q3. Moving average of the last 3 orders
WITH order_revenue AS (
    SELECT o.order_id,
           o.order_date,
           SUM(oi.quantity * p.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id  = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    WHERE o.status <> 'Cancelled'
    GROUP BY o.order_id, o.order_date
)
SELECT order_id,
       order_date,
       revenue,
       ROUND(AVG(revenue) OVER (ORDER BY order_date
                                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg_3
FROM order_revenue
ORDER BY order_date;
