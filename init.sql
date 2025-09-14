-- Create the ecommerce database
CREATE DATABASE ecommerce;

-- Connect to the ecommerce database
\c ecommerce

-- Create the inventory table with the desired schema
CREATE TABLE inventory (
    product_id UUID     DEFAULT gen_random_uuid() PRIMARY KEY,
    product_name        VARCHAR(255) NOT NULL,
    category            VARCHAR(100),
    stock_level         INT NOT NULL CHECK (stock_level BETWEEN 0 AND 1000),
    price               DECIMAL(10, 2) NOT NULL CHECK (price BETWEEN 1.00 AND 500.00),
    last_updated        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data with random values within constraints, will generate data later
INSERT INTO inventory (product_name, category, stock_level, price, last_updated) VALUES
    ('Laptop', 'electronics', 150, 999.99, CURRENT_TIMESTAMP),
    ('T-Shirt', 'clothing', 300, 19.99, '2025-09-14 08:59:00'),
    ('Smartphone', 'electronics', 75, 499.00, CURRENT_TIMESTAMP),
    ('Bread', 'food', 500, 3.50, '2025-09-13 14:30:00');

-- Enable logical replication for CDC with Debezium
ALTER TABLE inventory REPLICA IDENTITY FULL;