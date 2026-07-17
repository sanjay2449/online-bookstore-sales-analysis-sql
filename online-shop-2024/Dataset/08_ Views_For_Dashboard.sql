-- -----------------------------------------------------------------
-- 🔹 Views (Dashboard Preparation)
-- -----------------------------------------------------------------
-- View 1: Customer Lifetime Value
-- -- Display:
-- -- Customer ID
-- -- Customer Name
-- -- Total Orders
-- -- Total Spending
-- -- Average Order Value

CREATE OR REPLACE VIEW  customer_lifetime_view AS
SELECT 
	c.customer_id AS customer_id,
	CONCAT(c.first_name,' ',c.last_name) AS customer_name,
	COUNT(DISTINCT (o.order_id)) AS total_order,
	SUM(oi.quantity * oi.price_at_purchase) AS total_spending,
	ROUND(SUM(oi.quantity * oi.price_at_purchase) / COUNT(DISTINCT(oi.order_id)),2) AS avg_order_value
FROM 
order_items AS oi
JOIN
orders AS o
ON oi.order_id = o.order_id
JOIN
customers AS c
ON o.customer_id = c.customer_id
GROUP BY
	c.customer_id,
	customer_name;


SELECT *
FROM customer_lifetime_view
ORDER BY total_spending DESC;


-- -----------------------------------------------------------------
-- View 2: Product Sales Summary
-- -- Display:
-- -- Product ID
-- -- Product Name
-- -- Category
-- -- Quantity Sold
-- -- Revenue Generated

CREATE OR REPLACE VIEW product_sales_summary AS
SELECT 
	p.product_id AS product_id,
	p.product_name AS product_name,
	p.category AS category,
	SUM(oi.quantity) AS quantity_sold,
	SUM(oi.quantity * oi.price_at_purchase) AS total_revenue
FROM 
order_items AS oi
JOIN
products AS p
ON oi.product_id = p.product_id
GROUP BY 
	p.product_id,
	p.product_name;


SELECT * FROM product_sales_summary
ORDER BY total_revenue DESC;

-- -----------------------------------------------------------------
-- View 3: Monthly Sales Dashboard
-- -- Display:
-- -- Month
-- -- Total Orders
-- -- Revenue


CREATE OR REPLACE VIEW monthly_sales_report AS
SELECT
	TO_CHAR(o.order_date, 'YYYY-MM') AS Months,
	COUNT(DISTINCT(o.order_id)) AS total_orders,
	SUM(oi.quantity * oi.price_at_purchase) AS revenue
FROM
orders AS o
JOIN
order_items AS oi
ON o.order_id = oi.order_id
GROUP BY TO_CHAR(o.order_date, 'YYYY-MM');

SELECT *
FROM monthly_sales_report
ORDER BY months;


-- -----------------------------------------------------------------
-- View 4: Category Sales Summary
-- -- Display:
-- -- Category
-- -- Total Products
-- -- Quantity Sold
-- -- Revenue Generated

CREATE OR REPLACE VIEW category_sales_summary AS
SELECT
	p.category AS category,
	COUNT(DISTINCT(oi.product_id)) AS total_products,
	SUM(oi.quantity) AS Quantity_sold,
	SUM(oi.quantity * oi.price_at_purchase) AS revenue_generated
FROM
order_items AS oi
JOIN
products AS p
ON oi.product_id = p.product_id
GROUP BY p.category;

SELECT * FROM category_sales_summary
ORDER BY revenue_generated DESC;


-- -----------------------------------------------------------------
-- View 5: Transaction Summary
-- -- Display:
-- -- Transaction Status
-- -- Total Transactions
-- -- Total Amount
-- -- Average Transaction Amount
-- -- Transaction Percentage (%)


CREATE OR REPLACE VIEW transaction_summary AS
SELECT 
	transaction_status,
	COUNT(*) total_transactions,
	SUM(amount) total_amount,
	ROUND(AVG(amount),2) AS avg_transaction_amount,
	ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM payments),
2) AS transaction_percentage
FROM 
payments
GROUP BY transaction_status;


SELECT * FROM transaction_summary
ORDER BY transaction_status;
-- -----------------------------------------------------------------