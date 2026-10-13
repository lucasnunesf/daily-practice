-- =====================================================================
-- 02 · COUNT, SUM, AVG, GROUP BY, HAVING
-- Goal: summarize many rows into business numbers
-- =====================================================================

-- Q1. How many orders are there in each status?
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;

-- Q2. How many customers per segment?
SELECT segment, COUNT(*) AS total_customers
FROM customers
GROUP BY segment;

-- Q3. Average, minimum and maximum price per product category.
SELECT category,
       COUNT(*)                  AS products,
       ROUND(AVG(unit_price), 2) AS avg_price,
       MIN(unit_price)           AS min_price,
       MAX(unit_price)           AS max_price
FROM products
GROUP BY category;

-- Q4. Total quantity sold per product (only products that were sold).
SELECT product_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id
ORDER BY total_quantity DESC;

-- Q5. Customers with more than one order.
-- WHERE filters rows BEFORE grouping, HAVING filters groups AFTER grouping.
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Q6. COUNT(*) vs COUNT(column): COUNT(column) ignores NULLs.
SELECT COUNT(*)    AS all_customers,
       COUNT(city) AS customers_with_city
FROM customers;
