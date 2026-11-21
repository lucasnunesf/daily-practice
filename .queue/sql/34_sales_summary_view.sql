-- 34 · Reporting view for a dashboard (run dataset/schema_and_data.sql first)

-- Q1. One view with everything a sales dashboard needs
DROP VIEW IF EXISTS vw_sales;
CREATE VIEW vw_sales AS
SELECT o.order_id,
       o.order_date,
       SUBSTR(CAST(o.order_date AS VARCHAR(10)), 1, 7) AS year_month,
       o.status,
       c.customer_name,
       c.segment,
       COALESCE(c.city, 'UNKNOWN') AS city,
       p.product_name,
       p.category,
       oi.quantity,
       oi.quantity * p.unit_price AS revenue,
       oi.quantity * (p.unit_price - p.unit_cost) AS gross_profit
FROM orders o
JOIN customers c    ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id   = o.order_id
JOIN products p     ON p.product_id  = oi.product_id;

-- Q2. KPIs from the view
SELECT COUNT(DISTINCT order_id)      AS orders,
       SUM(revenue)                  AS revenue,
       SUM(gross_profit)             AS gross_profit,
       ROUND(SUM(revenue) / COUNT(DISTINCT order_id), 2) AS avg_ticket
FROM vw_sales
WHERE status <> 'Cancelled';

-- Q3. Revenue by segment and month
SELECT segment, year_month, SUM(revenue) AS revenue
FROM vw_sales
WHERE status <> 'Cancelled'
GROUP BY segment, year_month
ORDER BY segment, year_month;
