-- Create schema
CREATE SCHEMA IF NOT EXISTS olist;
SET search_path TO olist;

-- Orders
DROP TABLE IF EXISTS orders CASCADE;
CREATE TABLE orders (
  order_id TEXT PRIMARY KEY,
  customer_id TEXT NOT NULL,
  order_status TEXT NOT NULL,
  order_purchase_timestamp TIMESTAMP NOT NULL,
  order_approved_at TIMESTAMP NULL,
  order_delivered_carrier_date TIMESTAMP NULL,
  order_delivered_customer_date TIMESTAMP NULL,
  order_estimated_delivery_date TIMESTAMP NOT NULL
);

-- Order Items
DROP TABLE IF EXISTS order_items CASCADE;
CREATE TABLE order_items (
  order_id TEXT NOT NULL,
  order_item_id INT NOT NULL,
  product_id TEXT NOT NULL,
  seller_id TEXT NOT NULL,
  shipping_limit_date TIMESTAMP NOT NULL,
  price NUMERIC(12,2) NOT NULL,
  freight_value NUMERIC(12,2) NOT NULL,
  PRIMARY KEY (order_id, order_item_id)
);

-- Payments
DROP TABLE IF EXISTS payments CASCADE;
CREATE TABLE payments (
  order_id TEXT NOT NULL,
  payment_sequential INT NOT NULL,
  payment_type TEXT NOT NULL,
  payment_installments INT NOT NULL,
  payment_value NUMERIC(12,2) NOT NULL,
  PRIMARY KEY (order_id, payment_sequential)
);

-- Customers
DROP TABLE IF EXISTS customers CASCADE;
CREATE TABLE customers (
  customer_id TEXT PRIMARY KEY,
  customer_unique_id TEXT NOT NULL,
  customer_zip_code_prefix INT,
  customer_city TEXT,
  customer_state TEXT
);

-- Products
DROP TABLE IF EXISTS products CASCADE;
CREATE TABLE products (
  product_id TEXT PRIMARY KEY,
  product_category_name TEXT,
  product_name_lenght INT,
  product_description_lenght INT,
  product_photos_qty INT,
  product_weight_g INT,
  product_length_cm INT,
  product_height_cm INT,
  product_width_cm INT,
  product_category_name_english TEXT
);

-- Sellers
DROP TABLE IF EXISTS sellers CASCADE;
CREATE TABLE sellers (
  seller_id TEXT PRIMARY KEY,
  seller_zip_code_prefix INT,
  seller_city TEXT,
  seller_state TEXT
);

-- Reviews
DROP TABLE IF EXISTS reviews CASCADE;
CREATE TABLE reviews (
  review_id TEXT PRIMARY KEY,
  order_id TEXT NOT NULL,
  review_score INT,
  review_comment_title TEXT,
  review_comment_message TEXT,
  review_creation_date TIMESTAMP,
  review_answer_timestamp TIMESTAMP
);