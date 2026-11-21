-- 18 · NULL handling: COALESCE, NULLIF, IS NULL (run dataset/schema_and_data.sql first)

-- Q1. Customers without a city
SELECT customer_name
FROM customers
WHERE city IS NULL;

-- Q2. Replace NULL city with a default value
SELECT customer_name,
       COALESCE(city, 'Not informed') AS city
FROM customers;

-- Q3. COUNT(*) vs COUNT(column)
SELECT COUNT(*)    AS total_rows,
       COUNT(city) AS rows_with_city
FROM customers;

-- Q4. Avoid division by zero with NULLIF
SELECT product_name,
       unit_price,
       unit_cost,
       ROUND(100.0 * (unit_price - unit_cost) / NULLIF(unit_price, 0), 1) AS margin_pct
FROM products;
