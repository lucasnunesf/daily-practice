-- 19 · Self join (run dataset/schema_and_data.sql first)

-- Q1. Pairs of customers in the same city
SELECT a.customer_name AS customer_a,
       b.customer_name AS customer_b,
       a.city
FROM customers a
JOIN customers b
  ON a.city = b.city
 AND a.customer_id < b.customer_id;

-- Q2. Products more expensive than the steel bracket
SELECT p.product_name, p.unit_price
FROM products p
JOIN products ref ON ref.product_name = 'Steel bracket'
WHERE p.unit_price > ref.unit_price;

-- Q3. Orders from the same customer placed later
SELECT o1.customer_id,
       o1.order_id AS first_order,
       o2.order_id AS later_order
FROM orders o1
JOIN orders o2
  ON o1.customer_id = o2.customer_id
 AND o2.order_date > o1.order_date
ORDER BY o1.customer_id, o1.order_id;
