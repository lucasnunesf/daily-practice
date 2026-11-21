-- 24 · First purchase and cohorts (run dataset/schema_and_data.sql first)

-- Q1. First order date of each customer
SELECT customer_id,
       MIN(order_date) AS first_order
FROM orders
GROUP BY customer_id;

-- Q2. New customers per month (cohort size)
WITH first_order AS (
    SELECT customer_id, MIN(order_date) AS first_order
    FROM orders
    GROUP BY customer_id
)
SELECT SUBSTR(CAST(first_order AS VARCHAR(10)), 1, 7) AS cohort_month,
       COUNT(*) AS new_customers
FROM first_order
GROUP BY SUBSTR(CAST(first_order AS VARCHAR(10)), 1, 7)
ORDER BY cohort_month;

-- Q3. Customers who came back (more than one order)
SELECT customer_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;
