-- =====================================================================
-- 01 · SELECT, WHERE, ORDER BY, DISTINCT, NULL
-- Goal: read data and filter only what matters
-- =====================================================================

-- Q1. List all products, from the most expensive to the cheapest.
SELECT product_name, category, unit_price
FROM products
ORDER BY unit_price DESC;

-- Q2. Which customers are in Sorocaba?
SELECT customer_name, segment
FROM customers
WHERE city = 'Sorocaba';

-- Q3. Which product categories exist? (no duplicates)
SELECT DISTINCT category
FROM products
ORDER BY category;

-- Q4. Orders placed in the first quarter of 2025 that were not cancelled.
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE order_date BETWEEN '2025-01-01' AND '2025-03-31'
  AND status <> 'Cancelled'
ORDER BY order_date;

-- Q5. Customers with no city registered.
-- Note: "= NULL" never works. NULL means "unknown", so we use IS NULL.
SELECT customer_id, customer_name
FROM customers
WHERE city IS NULL;

-- Q6. Products whose name contains "Steel" or "Stainless".
SELECT product_name
FROM products
WHERE product_name LIKE '%Steel%'
   OR product_name LIKE '%Stainless%';

-- Q7. Gross margin per unit of each product (a calculated column).
SELECT product_name,
       unit_price,
       unit_cost,
       unit_price - unit_cost AS unit_margin
FROM products
ORDER BY unit_margin DESC;
