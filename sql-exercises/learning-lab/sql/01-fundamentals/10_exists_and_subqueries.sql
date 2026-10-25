-- 10 · IN, EXISTS, NOT EXISTS and correlated subqueries (run dataset/schema_and_data.sql first)

-- Q1. Customers who placed at least one order (IN)
SELECT customer_name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

-- Q2. Same result with EXISTS
SELECT c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Q3. Customers who never placed an order (NOT EXISTS)
SELECT c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Q4. Customers who bought at least one Welded product
SELECT c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    JOIN order_items oi ON oi.order_id  = o.order_id
    JOIN products p     ON p.product_id = oi.product_id
    WHERE o.customer_id = c.customer_id
      AND p.category = 'Welded'
);

-- Q5. Number of orders per customer (subquery in SELECT)
SELECT c.customer_name,
       (SELECT COUNT(*)
        FROM orders o
        WHERE o.customer_id = c.customer_id) AS total_orders
FROM customers c
ORDER BY total_orders DESC;

-- Q6. Products priced above the average of their own category (correlated subquery)
SELECT p.product_name,
       p.category,
       p.unit_price
FROM products p
WHERE p.unit_price > (
    SELECT AVG(p2.unit_price)
    FROM products p2
    WHERE p2.category = p.category
);

-- Q7. Each customer's first order date
SELECT c.customer_name,
       (SELECT MIN(o.order_date)
        FROM orders o
        WHERE o.customer_id = c.customer_id) AS first_order
FROM customers c
ORDER BY first_order;
