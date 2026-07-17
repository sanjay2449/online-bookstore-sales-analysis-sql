-- Table Creation

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
	customer_id	INT PRIMARY KEY,
	first_name	VARCHAR(50),
	last_name VARCHAR(50),
	address VARCHAR(75),
	email VARCHAR(50),
	phone_number VARCHAR(20)
);




DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items(
	order_item_id INT PRIMARY KEY,
	order_id	INT,
	product_id INT,
	quantity INT,
	price_at_purchase NUMERIC(10,2)
);




DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	order_date	DATE,
	customer_id INT,
	total_price NUMERIC(10,2)
);



DROP TABLE IF EXISTS payments;
CREATE TABLE payments(
	payment_id INT PRIMARY KEY,
	order_id INT,
	payment_method VARCHAR(20),
	amount NUMERIC(10,2),
	transaction_status VARCHAR(30)
);




DROP TABLE IF EXISTS products;
CREATE TABLE products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50),
	category VARCHAR(50),
	price NUMERIC(10,2),
	supplier_id INT
);



DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews(
	review_id INT PRIMARY KEY,
	product_id INT,
	customer_id INT,
	rating INT,
	review_text TEXT,
	review_date DATE
);




DROP TABLE IF EXISTS shipments;
CREATE TABLE shipments(
	shipment_id INT PRIMARY KEY,
	order_id INT,
	shipment_date DATE,
	carrier VARCHAR(30),
	tracking_number VARCHAR(50),
	delivery_date DATE,
	shipment_status VARCHAR(50)
);




DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers(
	supplier_id INT PRIMARY KEY,
	supplier_name VARCHAR(50),
	contact_name VARCHAR(50),
	address VARCHAR(100),
	phone_number VARCHAR(20),
	email VARCHAR(100)
);






SELECT * FROM customers

SELECT * FROM orders

SELECT * FROM order_items

SELECT * FROM payments

SELECT * FROM products

SELECT * FROM reviews

SELECT * FROM shipments

SELECT * FROM suppliers
