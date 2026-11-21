-- 16 · LAG and LEAD (month over month) (run dataset/schema_and_data.sql first)

-- Q1. Monthly revenue with the previous month next to it
WITH monthly AS (
    SELECT SUBSTR(CAST(o.order_date AS VARCHAR(10)), 1, 7) AS year_month,
           SUM(oi.quantity * p.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id  = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    WHERE o.status <> 'Cancelled'
    GROUP BY SUBSTR(CAST(o.order_date AS VARCHAR(10)), 1, 7)
)
SELECT year_month,
       revenue,
       LAG(revenue) OVER (ORDER BY year_month) AS prev_month,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY year_month))
             / LAG(revenue) OVER (ORDER BY year_month), 1) AS growth_pct
FROM monthly;

-- Q2. Next order date of each customer
SELECT customer_id,
       order_id,
       order_date,
       LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_order_date
FROM orders
ORDER BY customer_id, order_date;
