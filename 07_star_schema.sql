-- 07 · Star schema (run dataset/schema_and_data.sql first)

DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_date;

-- Q1. Customer dimension
CREATE TABLE dim_customer AS
SELECT customer_id,
       customer_name,
       COALESCE(city, 'UNKNOWN') AS city,
       segment
FROM customers;

-- Q2. Product dimension
CREATE TABLE dim_product AS
SELECT product_id,
       product_name,
       category
FROM products;

-- Q3. Date dimension
CREATE TABLE dim_date AS
SELECT DISTINCT
       order_date,
       CAST(SUBSTR(CAST(order_date AS VARCHAR(10)), 1, 4) AS INTEGER) AS year,
       CAST(SUBSTR(CAST(order_date AS VARCHAR(10)), 6, 2) AS INTEGER) AS month
FROM orders;

-- Q4. Fact table: one row per product sold in each order
CREATE TABLE fact_sales AS
SELECT o.order_id,
       o.order_date,
       o.customer_id,
       oi.product_id,
       oi.quantity,
       oi.quantity * p.unit_price AS revenue,
       oi.quantity * p.unit_cost  AS cost
FROM orders o
JOIN order_items oi ON oi.order_id  = o.order_id
JOIN products p     ON p.product_id = oi.product_id
WHERE o.status <> 'Cancelled';

-- Q5. Revenue by segment and month
SELECT c.segment,
       d.month,
       SUM(f.revenue) AS revenue
FROM fact_sales f
JOIN dim_customer c ON c.customer_id = f.customer_id
JOIN dim_date d     ON d.order_date  = f.order_date
GROUP BY c.segment, d.month
ORDER BY d.month, c.segment;

-- Q6. Profit by product category
SELECT p.category,
       SUM(f.revenue)          AS revenue,
       SUM(f.revenue - f.cost) AS profit
FROM fact_sales f
JOIN dim_product p ON p.product_id = f.product_id
GROUP BY p.category
ORDER BY profit DESC;
