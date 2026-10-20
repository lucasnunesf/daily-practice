-- 09 · UNION, UNION ALL, INTERSECT, EXCEPT (run dataset/schema_and_data.sql first)

-- Q1. All cities where there are customers in Industrial OR Construction (no duplicates)
SELECT city FROM customers WHERE segment = 'Industrial'
UNION
SELECT city FROM customers WHERE segment = 'Construction';

-- Q2. Same query keeping duplicates
SELECT city FROM customers WHERE segment = 'Industrial'
UNION ALL
SELECT city FROM customers WHERE segment = 'Construction';

-- Q3. Customers who ordered in January AND in March
SELECT customer_id FROM orders WHERE order_date BETWEEN '2025-01-01' AND '2025-01-31'
INTERSECT
SELECT customer_id FROM orders WHERE order_date BETWEEN '2025-03-01' AND '2025-03-31';

-- Q4. Customers who never placed an order
SELECT customer_id FROM customers
EXCEPT
SELECT customer_id FROM orders;

-- Q5. Products that were never sold
SELECT product_id FROM products
EXCEPT
SELECT product_id FROM order_items;

-- Q6. One list with customer and product names, labeled by type
SELECT 'Customer' AS type, customer_name AS name FROM customers
UNION ALL
SELECT 'Product'  AS type, product_name  AS name FROM products
ORDER BY type, name;
