-- 21 · Percent of total (run dataset/schema_and_data.sql first)

-- Q1. Share of revenue per category
WITH cat AS (
    SELECT p.category,
           SUM(oi.quantity * p.unit_price) AS revenue
    FROM order_items oi
    JOIN orders o   ON o.order_id   = oi.order_id
    JOIN products p ON p.product_id = oi.product_id
    WHERE o.status <> 'Cancelled'
    GROUP BY p.category
)
SELECT category,
       revenue,
       ROUND(100.0 * revenue / SUM(revenue) OVER (), 1) AS pct_of_total
FROM cat
ORDER BY revenue DESC;

-- Q2. Share of each customer inside its segment
WITH cust AS (
    SELECT c.segment,
           c.customer_name,
           SUM(oi.quantity * p.unit_price) AS revenue
    FROM customers c
    JOIN orders o       ON o.customer_id = c.customer_id
    JOIN order_items oi ON oi.order_id   = o.order_id
    JOIN products p     ON p.product_id  = oi.product_id
    WHERE o.status <> 'Cancelled'
    GROUP BY c.segment, c.customer_name
)
SELECT segment,
       customer_name,
       revenue,
       ROUND(100.0 * revenue / SUM(revenue) OVER (PARTITION BY segment), 1) AS pct_of_segment
FROM cust
ORDER BY segment, revenue DESC;
