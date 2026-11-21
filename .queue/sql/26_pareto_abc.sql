-- 26 · Pareto / ABC analysis (run dataset/schema_and_data.sql first)

-- Q1. ABC classification of products by revenue
WITH prod AS (
    SELECT p.product_name,
           SUM(oi.quantity * p.unit_price) AS revenue
    FROM order_items oi
    JOIN orders o   ON o.order_id   = oi.order_id
    JOIN products p ON p.product_id = oi.product_id
    WHERE o.status <> 'Cancelled'
    GROUP BY p.product_name
),
cum AS (
    SELECT product_name,
           revenue,
           100.0 * SUM(revenue) OVER (ORDER BY revenue DESC) / SUM(revenue) OVER () AS cum_pct
    FROM prod
)
SELECT product_name,
       revenue,
       ROUND(cum_pct, 1) AS cum_pct,
       CASE WHEN cum_pct <= 80 THEN 'A'
            WHEN cum_pct <= 95 THEN 'B'
            ELSE 'C' END AS abc_class
FROM cum
ORDER BY revenue DESC;
