-- 25 · Customer segmentation (RFM style) (run dataset/schema_and_data.sql first)

-- Q1. Recency, frequency and monetary value per customer
-- Reference date: 2025-04-30
WITH base AS (
    SELECT c.customer_name,
           MAX(o.order_date)               AS last_order,
           COUNT(DISTINCT o.order_id)      AS frequency,
           SUM(oi.quantity * p.unit_price) AS monetary
    FROM customers c
    JOIN orders o       ON o.customer_id = c.customer_id
    JOIN order_items oi ON oi.order_id   = o.order_id
    JOIN products p     ON p.product_id  = oi.product_id
    WHERE o.status <> 'Cancelled'
    GROUP BY c.customer_name
)
SELECT customer_name,
       CAST(julianday('2025-04-30') - julianday(last_order) AS INTEGER) AS recency_days,
       frequency,
       monetary,
       CASE
           WHEN frequency >= 3                 THEN 'Loyal'
           WHEN monetary  >= 5000              THEN 'High value'
           WHEN julianday('2025-04-30') - julianday(last_order) > 60 THEN 'At risk'
           ELSE 'Regular'
       END AS segment
FROM base
ORDER BY monetary DESC;
