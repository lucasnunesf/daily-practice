-- 12 · String functions (run dataset/schema_and_data.sql first)

-- Q1. Upper case, lower case and length
SELECT customer_name,
       UPPER(customer_name)  AS upper_name,
       LOWER(customer_name)  AS lower_name,
       LENGTH(customer_name) AS name_length
FROM customers;

-- Q2. Concatenate columns
SELECT customer_name || ' - ' || COALESCE(city, 'UNKNOWN') AS customer_label
FROM customers;

-- Q3. First 3 letters of the category as a short code
SELECT product_name,
       category,
       UPPER(SUBSTR(category, 1, 3)) AS category_code
FROM products;

-- Q4. Replace part of a text
SELECT product_name,
       REPLACE(product_name, 'Steel', 'Carbon steel') AS new_name
FROM products
WHERE product_name LIKE '%Steel%';

-- Q5. Build a product SKU: category code + product id
SELECT product_id,
       product_name,
       UPPER(SUBSTR(category, 1, 3)) || '-' || CAST(product_id AS VARCHAR(10)) AS sku
FROM products;

-- Q6. Customers whose name starts with a letter between A and D
SELECT customer_name
FROM customers
WHERE UPPER(SUBSTR(customer_name, 1, 1)) BETWEEN 'A' AND 'D'
ORDER BY customer_name;
