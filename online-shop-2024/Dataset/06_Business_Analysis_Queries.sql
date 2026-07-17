-- Q21.
-- Find the suppliers whose products generated the highest total revenue.

SELECT
    s.supplier_id,
    s.supplier_name,
    SUM(oi.quantity * oi.price_at_purchase) AS total_revenue
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.product_id
JOIN suppliers AS s
ON p.supplier_id = s.supplier_id
GROUP BY
    s.supplier_id,
    s.supplier_name
ORDER BY total_revenue DESC
LIMIT 1;

-- -----------------------------------------------------------------

-- Q22.
-- Calculate monthly sales revenue.
-- -- Display:
-- -- Month
-- -- Revenue

SELECT
	TO_CHAR(o.order_date, 'YYYY-MM') AS month_number,
	SUM(oi.quantity * oi.price_at_purchase) AS monthly_sales_revenue
FROM 
order_items AS oi
JOIN 
orders AS o
ON oi.order_id = o.order_id
GROUP BY month_number
ORDER BY month_number

-- -----------------------------------------------------------------

-- Q23.
-- Calculate monthly order count.
-- -- Display:
-- -- Month
-- -- Number of Orders

SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month_number,
    COUNT(order_id) AS monthly_order_count
FROM orders
GROUP BY 1
ORDER BY 1;

-- -----------------------------------------------------------------

-- Q24.
-- Find customers who have never placed any order.

SELECT
 	c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    c.email
FROM
customers AS c
LEFT JOIN
orders AS o
ON c.customer_id = o.customer_id
WHERE order_id IS NULL;

-- -----------------------------------------------------------------

-- Q25.
-- Find products that have never been ordered.

SELECT
	p.product_id,
	p.product_name,
	p.category
FROM
products AS p
LEFT JOIN
order_items AS oi
ON p.product_id = oi.product_id
WHERE order_item_id IS NULL




-- -----------------------------------------------------------------

-- Q26.
-- Find shipments that have not yet been delivered.
-- (Use shipment_status.)

SELECT * FROM shipments
WHERE shipment_status != 'Delivered' 


-- -----------------------------------------------------------------

-- Q27.
-- Calculate the Average Order Value (AOV).

SELECT
	ROUND(SUM(quantity * price_at_purchase) / COUNT(DISTINCT(order_id)),2) AS avg_order_value
FROM 
order_items


SELECT
    ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
    SELECT
        order_id,
        SUM(quantity * price_at_purchase) AS order_total
    FROM order_items
    GROUP BY order_id
) AS order_summary;

-- -----------------------------------------------------------------

-- Q28.
-- Calculate the percentage of each transaction status.
-- Display:
-- -- Successful
-- -- Failed
-- -- Pending
-- -- as percentages of total transactions.


SELECT 
	transaction_status,
	COUNT(*) AS total_transactions,
	ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM payments),2) AS percentage
FROM
payments
GROUP BY transaction_status;




-- -----------------------------------------------------------------

-- Q29.
-- Find the average product rating.
-- -- Display:
-- -- Product Name
-- -- Average Rating


SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM reviews AS r
JOIN products AS p
ON r.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY avg_rating DESC;

-- -----------------------------------------------------------------

-- Q30.
-- Find the Top 10 highest-rated products.

-- (Only include products having at least 5 reviews.)

SELECT 
	r.product_id,
	p.product_name,
	ROUND(AVG(r.rating), 2) AS avg_rating,
	COUNT(*) AS review_count
FROM 
reviews AS r
JOIN
products AS p
ON r.product_id = p.product_id
GROUP BY 
	r.product_id,
	p.product_name
HAVING COUNT(*) >= 5
ORDER BY avg_rating DESC
LIMIT 10
-- -----------------------------------------------------------------