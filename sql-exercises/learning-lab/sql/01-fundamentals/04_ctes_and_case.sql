-- =====================================================================
-- 04 · CASE WHEN, subqueries, CTEs (WITH)
-- Goal: write longer queries in readable steps
-- =====================================================================

-- Q1. Classify products by price range (CASE WHEN).
SELECT product_name,
       unit_price,
       CASE
           WHEN unit_price < 100  THEN 'Low'
           WHEN unit_price < 1000 THEN 'Medium'
           ELSE 'High'
       END AS price_range
FROM products;

-- Q2. Products more expensive than the average price (subquery).
SELECT product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products);

-- Q3. Order value per order, then the average order value (CTE).
-- A CTE is a named temporary result: it reads top to bottom, like steps.
WITH order_value AS (
    SELECT oi.order_id,
           SUM(oi.quantity * p.unit_price) AS order_total
    FROM order_items oi
    JOIN products p ON p.product_id = oi.product_id
    GROUP BY oi.order_id
)
SELECT ROUND(AVG(order_total), 2) AS avg_order_value
FROM order_value;

-- Q4. Revenue, cost and margin % per category (two chained CTEs).
WITH valid_items AS (
    SELECT oi.product_id, oi.quantity
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
    WHERE o.status <> 'Cancelled'
),
category_totals AS (
    SELECT p.category,
           SUM(v.quantity * p.unit_price) AS revenue,
           SUM(v.quantity * p.unit_cost)  AS cost
    FROM valid_items v
    JOIN products p ON p.product_id = v.product_id
    GROUP BY p.category
)
SELECT category,
       revenue,
       cost,
       ROUND(100.0 * (revenue - cost) / revenue, 1) AS margin_pct
FROM category_totals
ORDER BY margin_pct DESC;

-- Q5. Count orders by status in one row (conditional aggregation).
SELECT
    SUM(CASE WHEN status = 'Delivered'     THEN 1 ELSE 0 END) AS delivered,
    SUM(CASE WHEN status = 'In Production' THEN 1 ELSE 0 END) AS in_production,
    SUM(CASE WHEN status = 'Cancelled'     THEN 1 ELSE 0 END) AS cancelled
FROM orders;
