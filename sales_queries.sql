-- ============================================
-- SQL Sales Analysis Project
-- Author: Om Rawal
-- Description: Practice project covering table creation,
-- joins, aggregate functions, subqueries, and views
-- ============================================

-- 1. CREATE TABLES
-- ============================================

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    sale_date DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

-- 2. INSERT DATA
-- ============================================

INSERT INTO department (dept_id, dept_name) VALUES
(1, 'Electronics'),
(2, 'Groceries'),
(3, 'Clothing');

INSERT INTO sales (sale_id, product_name, quantity, price, sale_date, dept_id) VALUES
(101, 'Laptop', 2, 55000.00, '2026-06-01', 1),
(102, 'Rice Bag', 10, 500.00, '2026-06-02', 2),
(103, 'T-Shirt', 5, 400.00, '2026-06-03', 3),
(104, 'Headphones', 3, 1500.00, '2026-06-04', 1),
(105, 'Milk', 20, 50.00, '2026-06-05', 2);

-- 3. BASIC SELECT
-- ============================================

SELECT * FROM sales;

SELECT product_name, price FROM sales;

-- 4. WHERE CLAUSE
-- ============================================

SELECT * FROM sales
WHERE price > 1000;

SELECT * FROM sales
WHERE dept_id = 1;

-- 5. JOIN (Sales with Department names)
-- ============================================

SELECT s.sale_id, s.product_name, s.price, d.dept_name
FROM sales s
JOIN department d ON s.dept_id = d.dept_id;

-- LEFT JOIN example
SELECT d.dept_name, s.product_name
FROM department d
LEFT JOIN sales s ON d.dept_id = s.dept_id;

-- 6. GROUP BY with Aggregate Functions
-- ============================================

SELECT dept_id, SUM(price * quantity) AS total_sales
FROM sales
GROUP BY dept_id;

SELECT dept_id, COUNT(*) AS total_orders, AVG(price) AS avg_price
FROM sales
GROUP BY dept_id;

-- 7. HAVING (filter after grouping)
-- ============================================

SELECT dept_id, SUM(price * quantity) AS total_sales
FROM sales
GROUP BY dept_id
HAVING SUM(price * quantity) > 5000;

-- 8. ORDER BY
-- ============================================

SELECT * FROM sales
ORDER BY price DESC;

SELECT product_name, price FROM sales
ORDER BY price ASC;

-- 9. VIEW (saved query as virtual table)
-- ============================================

CREATE VIEW sales_summary AS
SELECT s.sale_id, s.product_name, d.dept_name, s.price, s.quantity
FROM sales s
JOIN department d ON s.dept_id = d.dept_id;

SELECT * FROM sales_summary;

-- 10. TRANSACTION (COMMIT / ROLLBACK)
-- ============================================

START TRANSACTION;

UPDATE sales
SET price = price * 1.10
WHERE dept_id = 1;

-- If satisfied with changes:
COMMIT;

-- If not satisfied, use instead:
-- ROLLBACK;
