-- 06 · Data cleaning

DROP TABLE IF EXISTS raw_suppliers;

CREATE TABLE raw_suppliers (
    supplier_id   INTEGER,
    supplier_name VARCHAR(100),
    city          VARCHAR(50),
    phone         VARCHAR(20),
    total_spent   VARCHAR(20)
);

INSERT INTO raw_suppliers VALUES
(1, '  aco forte ltda ', 'sorocaba',  '(15) 3333-1111', '1500.50'),
(2, 'METAL SUL',         'Itu ',      '15 3333-2222',   '820'),
(2, 'METAL SUL',         'Itu ',      '15 3333-2222',   '820'),
(3, 'Chapas Brasil',     NULL,        NULL,             '2300.00'),
(4, 'Inox Prime',        'Campinas',  '(19) 3444-5555', NULL);

-- Q1. Remove extra spaces and standardize text case
SELECT supplier_id,
       UPPER(TRIM(supplier_name)) AS supplier_name,
       UPPER(TRIM(city))          AS city
FROM raw_suppliers;

-- Q2. Replace NULL with a default value
SELECT supplier_id,
       COALESCE(city, 'UNKNOWN')        AS city,
       COALESCE(phone, 'NOT INFORMED')  AS phone
FROM raw_suppliers;

-- Q3. Keep only the digits of the phone number
SELECT supplier_id,
       REPLACE(REPLACE(REPLACE(REPLACE(phone, '(', ''), ')', ''), ' ', ''), '-', '') AS phone_digits
FROM raw_suppliers;

-- Q4. Convert text to number
SELECT supplier_id,
       CAST(COALESCE(total_spent, '0') AS DECIMAL(10,2)) AS total_spent
FROM raw_suppliers;

-- Q5. Find duplicates
SELECT supplier_id, COUNT(*) AS copies
FROM raw_suppliers
GROUP BY supplier_id
HAVING COUNT(*) > 1;

-- Q6. Final clean table, without duplicates
WITH dedup AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY supplier_id ORDER BY supplier_id) AS rn
    FROM raw_suppliers
)
SELECT supplier_id,
       UPPER(TRIM(supplier_name))                        AS supplier_name,
       COALESCE(UPPER(TRIM(city)), 'UNKNOWN')            AS city,
       CAST(COALESCE(total_spent, '0') AS DECIMAL(10,2)) AS total_spent
FROM dedup
WHERE rn = 1;
