-- Q1.
-- Display all customer details.

SELECT * FROM customers;

-- -----------------------------------------------------------------

-- Q2.
-- Display all products with their category, price, and supplier ID.


SELECT 
	product_name,
    category,
    price,
    supplier_id
FROM products;

-- -----------------------------------------------------------------

-- Q3.
-- Find all customers whose last name starts with 'A'.

SELECT * FROM customers
WHERE last_name ILIKE 'A%';

-- -----------------------------------------------------------------

-- Q4.
-- List all products that cost more than ₹500.

SELECT * FROM products
WHERE price > 500;

-- -----------------------------------------------------------------

-- Q5.
-- Display all orders placed after 2024-01-01.

SELECT * FROM orders
WHERE order_date >= '2024-01-01';

-- -----------------------------------------------------------------

-- Q6.
-- Find the total number of customers.

SELECT COUNT(*) AS total_customer
FROM customers;


-- -----------------------------------------------------------------

-- Q7.
-- Find the average product price.

SELECT ROUND(AVG(price),2) AS avg_product_price
FROM products;

-- -----------------------------------------------------------------

-- Q8.
-- Find the highest and lowest product price.

SELECT 
	MAX(price) AS max_product_price,
	MIN(price) AS min_product_price
FROM products;

-- -----------------------------------------------------------------

-- Q9.
-- Count the number of products in each category.

SELECT 
	category,
	COUNT(product_id)  AS total_products
FROM products
GROUP BY category;


-- -----------------------------------------------------------------

-- Q10.
-- Display all successful transactions.

SELECT * FROM payments
WHERE transaction_status = 'Completed';
-- -----------------------------------------------------------------
