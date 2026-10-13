-- =====================================================================
-- Practice dataset: a small metal parts manufacturer
-- Tables: customers, products, orders, order_items
-- Written in standard SQL: runs on PostgreSQL and SQLite
-- =====================================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id   INTEGER PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city          VARCHAR(50),
    segment       VARCHAR(30)          -- 'Industrial', 'Construction', 'Agro'
);

CREATE TABLE products (
    product_id    INTEGER PRIMARY KEY,
    product_name  VARCHAR(100) NOT NULL,
    category      VARCHAR(30),         -- 'Laser Cut', 'Welded', 'Bent'
    unit_price    DECIMAL(10,2) NOT NULL,
    unit_cost     DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
    order_id      INTEGER PRIMARY KEY,
    customer_id   INTEGER NOT NULL REFERENCES customers(customer_id),
    order_date    DATE NOT NULL,
    status        VARCHAR(20) NOT NULL -- 'Delivered', 'In Production', 'Cancelled'
);

CREATE TABLE order_items (
    order_id      INTEGER NOT NULL REFERENCES orders(order_id),
    product_id    INTEGER NOT NULL REFERENCES products(product_id),
    quantity      INTEGER NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO customers VALUES
(1, 'Alpha Machines',      'Sorocaba',   'Industrial'),
(2, 'Beta Construtora',    'Sao Paulo',  'Construction'),
(3, 'Campo Forte Agro',    'Itu',        'Agro'),
(4, 'Delta Automotive',    'Sorocaba',   'Industrial'),
(5, 'Eco Estruturas',      'Campinas',   'Construction'),
(6, 'Ferro Sul',           'Boituva',    'Industrial'),
(7, 'Gama Implementos',    'Tatui',      'Agro'),
(8, 'Horizonte Obras',     NULL,         'Construction');   -- missing city on purpose

INSERT INTO products VALUES
(1, 'Steel bracket',        'Laser Cut', 45.00,  28.00),
(2, 'Aluminium panel',      'Laser Cut', 120.00, 80.00),
(3, 'Machine guard',        'Welded',    850.00, 610.00),
(4, 'Structural frame',     'Welded',    1500.00, 1180.00),
(5, 'Bent U-profile',       'Bent',      65.00,  40.00),
(6, 'Stainless cover',      'Bent',      210.00, 150.00),
(7, 'Custom gate',          'Welded',    2300.00, 1750.00);  -- never sold

INSERT INTO orders VALUES
(101, 1, '2025-01-08', 'Delivered'),
(102, 2, '2025-01-15', 'Delivered'),
(103, 3, '2025-01-22', 'Delivered'),
(104, 1, '2025-02-03', 'Delivered'),
(105, 4, '2025-02-11', 'Cancelled'),
(106, 5, '2025-02-19', 'Delivered'),
(107, 6, '2025-03-02', 'Delivered'),
(108, 2, '2025-03-10', 'Delivered'),
(109, 1, '2025-03-18', 'Delivered'),
(110, 7, '2025-03-25', 'In Production'),
(111, 4, '2025-04-04', 'Delivered'),
(112, 3, '2025-04-12', 'In Production'),
(113, 6, '2025-04-20', 'Delivered');

INSERT INTO order_items VALUES
(101, 1, 200), (101, 3, 2),
(102, 4, 3),   (102, 5, 150),
(103, 2, 40),
(104, 1, 300), (104, 6, 20),
(105, 3, 5),
(106, 4, 2),   (106, 5, 80),
(107, 2, 60),  (107, 6, 15),
(108, 4, 4),
(109, 3, 3),   (109, 1, 100),
(110, 5, 200),
(111, 2, 25),  (111, 3, 1),
(112, 6, 30),
(113, 1, 500);
