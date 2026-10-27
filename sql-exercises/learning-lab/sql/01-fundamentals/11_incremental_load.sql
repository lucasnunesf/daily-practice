-- 11 · Incremental load: insert new rows and update changed rows (upsert)

DROP TABLE IF EXISTS stg_products;
DROP TABLE IF EXISTS tgt_products;

-- Target table: what is already in the warehouse
CREATE TABLE tgt_products (
    product_id   INTEGER PRIMARY KEY,
    product_name VARCHAR(100),
    unit_price   DECIMAL(10,2),
    updated_at   DATE
);

INSERT INTO tgt_products VALUES
(1, 'Steel bracket',   45.00,  '2025-01-01'),
(2, 'Aluminium panel', 120.00, '2025-01-01'),
(3, 'Machine guard',   850.00, '2025-01-01');

-- Staging table: today's extract from the source system
CREATE TABLE stg_products (
    product_id   INTEGER,
    product_name VARCHAR(100),
    unit_price   DECIMAL(10,2)
);

INSERT INTO stg_products VALUES
(2, 'Aluminium panel', 135.00),   -- price changed
(3, 'Machine guard',   850.00),   -- no change
(4, 'Bent U-profile',  65.00);    -- new product

-- Q1. Which rows are new?
SELECT s.*
FROM stg_products s
LEFT JOIN tgt_products t ON t.product_id = s.product_id
WHERE t.product_id IS NULL;

-- Q2. Which rows changed?
SELECT s.product_id,
       t.unit_price AS old_price,
       s.unit_price AS new_price
FROM stg_products s
JOIN tgt_products t ON t.product_id = s.product_id
WHERE s.unit_price <> t.unit_price
   OR s.product_name <> t.product_name;

-- Q3. Upsert: insert new rows and update changed rows in one statement
INSERT INTO tgt_products (product_id, product_name, unit_price, updated_at)
SELECT product_id, product_name, unit_price, '2025-02-01'
FROM stg_products
WHERE true
ON CONFLICT (product_id) DO UPDATE
SET product_name = excluded.product_name,
    unit_price   = excluded.unit_price,
    updated_at   = excluded.updated_at
WHERE tgt_products.unit_price   <> excluded.unit_price
   OR tgt_products.product_name <> excluded.product_name;

-- Q4. Check the result
SELECT *
FROM tgt_products
ORDER BY product_id;

-- Q5. Clean the staging table for the next load
DELETE FROM stg_products;
